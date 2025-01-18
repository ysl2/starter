return {
  { "folke/lazy.nvim", version = false },
  {
    "LazyVim/LazyVim",
    version = false,
    opts = {
      colorscheme = (function()
        if not not vim.g.started_by_firenvim then
          return "default"
        end
        vim.api.nvim_create_autocmd("ColorScheme", {
          callback = function()
            vim.api.nvim_set_hl(0, 'Visual', { reverse = true })

            local fg_conceal = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Conceal")), "fg", "gui")
            vim.api.nvim_set_hl(0, "CursorLineNr", { fg = fg_conceal })
            vim.api.nvim_set_hl(0, "LineNr", { fg = fg_conceal })
            vim.api.nvim_set_hl(0, "LineNrAbove", { fg = fg_conceal })
            vim.api.nvim_set_hl(0, "LineNrBelow", { fg = fg_conceal })
            vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = fg_conceal })
          end
        })
        return "tokyonight"
      end)(),
      news = {
        lazyvim = false,
      },
    },
  },
  { import = "lazyvim.plugins.extras.ui.indent-blankline" },
  { import = "lazyvim.plugins.extras.ai.copilot" },
  { import = "lazyvim.plugins.extras.ai.copilot-chat" },

  { "folke/noice.nvim", enabled = false },
  {
    "williamboman/mason.nvim",
    opts = {
      github = {
        download_url_template = "https://mirror.ghproxy.com/https://github.com/%s/releases/download/%s/%s",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local parsers = require("nvim-treesitter.parsers").get_parser_configs()
      for _, p in pairs(parsers) do
        p.install_info.url =
          p.install_info.url:gsub("https://github.com/", "https://mirror.ghproxy.com/https://github.com/")
      end
    end,
  },
  { "Exafunction/codeium.nvim", enabled = false },
  {
    "csexton/trailertrash.vim",
    event = "VeryLazy",
    config = function()
      vim.cmd("hi link UnwantedTrailerTrash NONE")
      vim.api.nvim_create_autocmd("BufWritePre", {
        command = "TrailerTrim"
      })
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      experimental = {
        ghost_text = false,
      }
    }
  },
  {
    "s1n7ax/nvim-window-picker",
    keys = {
      {
        "<C-w><C-w>",
        function()
          local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        mode = "n",
        silent = true,
        desc = "Pick a window"
      }
    },
    opts = {
      show_prompt = false,
      filter_rules = {
        bo = {
          filetype = { "notify" }
        }
      }
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = "s1n7ax/nvim-window-picker",
    opts = {
      window = {
        width = 30,
        mappings = {
          ["<C-s>"] = "split_with_window_picker",
          ["<C-v>"] = "vsplit_with_window_picker",
          ["<C-t>"] = "open_tab_drop",
          ["<C-h>"] = "close_all_subnodes",
          ["<C-c>"] = "revert_preview",
          ["I"] = "toggle_hidden"
        }
      }
    }
  },
  {
    "Saghen/blink.cmp",
    build = "cargo build --release"
  },
  {
    "folke/snacks.nvim",
    opts = {
      notifier = { enabled = false },
      dashboard = { enabled = false },
    }
  },
  {
    "glacambre/firenvim",
    build = function() vim.fn["firenvim#install"](0) end,
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    config = function()
      vim.cmd("set guifont=FiraCode\\ Nerd\\ Font:h25")
      vim.cmd("set laststatus=0")
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "github.com_*.txt", "gitee.com_*.txt" },
        command = "set filetype=markdown"
      })
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "leetcode.com_*.txt", "leetcode.cn_*.txt" },
        command = "set filetype=python"
      })
      vim.g.firenvim_config = {
        localSettings = {
          -- ["https?://[^/]+\\.zhihu\\.com/*"] = { priority = 1, takeover = "never" },
          -- ["https?://www\\.notion\\.so/*"] = { priority = 1, takeover = "never" },
          -- ["https?://leetcode\\.com.*playground.*shared"] = { priority = 1, takeover = "never" },
          -- ["https?://github1s\\.com/*"] = { priority = 1, takeover = "never" },
          -- ["https?://docs\\.qq\\.com/*"] = { priority = 1, takeover = "never" },
          -- [".*"] = { priority = 0 },
          [".*"] = { priority = 1, takeover = "never" },
        }
      }
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "*"; -- Highlight all files, but customize some others.
          "!neo-tree"; -- Exclude vim from highlighting.
        -- Exclusion Only makes sense if "*" is specified!
        },
      })
    end,
  },
  {
    "folke/persistence.nvim",
    lazy = false,
    -- dependencies = "folke/noice.nvim",
    config = function(_, opts)
      local persistence = require("persistence")
      persistence.setup(opts)
      vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        callback = function()
          -- Auto delete [No Name] buffers.
          local function _my_custom_del_no_name_buf()
            if not vim.g.vscode then
              vim.api.nvim_create_autocmd("BufLeave", {
                callback = function()
                  local buffers = vim.fn.filter(vim.fn.range(1, vim.fn.bufnr("$")),
                    'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
                  local next = next
                  if next(buffers) == nil then
                    return
                  end
                  local cmdstr = ":silent! bw!"
                  for _, v in pairs(buffers) do
                    cmdstr = cmdstr .. " " .. v
                  end
                  vim.cmd(cmdstr)
                end
              })
            end
          end

          if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
            persistence.load()
          else
            persistence.stop()
          end
          _my_custom_del_no_name_buf()
        end,
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame_opts = {
        delay = 0,
      },
    }
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
      }
    }
  },
  { "folke/flash.nvim", enabled = false },
  {
    "kylechui/nvim-surround",
    -- version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
        keymaps = {
          insert = "<A-g>s",
          insert_line = "<A-g>S",
        }
      })
    end
  },
  {
    "smoka7/hop.nvim",
    -- version = "*",
    event = "VeryLazy",
    keys = {
      { "s", "<CMD>silent! HopChar1MW<CR>", mode = { "n", "o", "x" }, silent = true },
      -- { "<LEADER><LEADER>", "<CMD>silent! HopPatternMW<CR>", mode = { "n", "o", "x" }, silent = true }
    },
    config = function()
      require("hop").setup()
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = { enabled = false },
    },
  },
  {
    'kevinhwang91/nvim-hlslens',
    keys = {
      { "/" },
      { "?" },
      { "n", function ()
        vim.cmd("normal! " .. vim.v.count1 .. "n")
        require("hlslens").start()
      end, mode = { "n", "v" }, silent = true },
      { "N", function ()
        vim.cmd("normal! " .. vim.v.count1 .. "N")
        require("hlslens").start()
      end, mode = { "n", "v" }, silent = true },
      { "*", [[*<CMD>lua require('hlslens').start()<CR>]], mode = { "n", "v" }, silent = true },
      { "#", [[#<CMD>lua require('hlslens').start()<CR>]], mode = { "n", "v" }, silent = true },
      { "g*", [[g*<CMD>lua require('hlslens').start()<CR>]], mode = { "n", "v" }, silent = true },
      { "g#", [[g#<CMD>lua require('hlslens').start()<CR>]], mode = { "n", "v" }, silent = true },
    },
    opts = {
      calm_down = true,
      nearest_float_when = "never",
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cond = not vim.g.started_by_firenvim and "leetcode.nvim" ~= vim.fn.argv(0, -1),
    opts = {
      suggestion = {
        keymap = {
          accept = "<C-g>",
          accept_word = "<C-g>",
          accept_line = "<C-g>"
        },
      }
    }
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    keys = {
      { "<C-0>", "<CMD>CopilotChatToggle<CR>", mode = { "n" }, silent = true },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- model = "o1",
      window = {
        layout = "float",
        width = 0.8, -- fractional width of parent, or absolute width in columns when > 1
        height = 0.8, -- fractional height of parent, or absolute height in rows when > 1
      },
      mappings = {
        complete = {
          insert = "<C-g>",
        },
        close = {
          normal = "<C-0>",
          insert = "<C-0>",
        },
        submit_prompt = {
          insert = "<C-CR>",
        },
      }
    },
  },
}
