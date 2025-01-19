return {
  { "folke/lazy.nvim", version = false },
  {
    "LazyVim/LazyVim",
    version = false,
    opts = {
      colorscheme = (function()
        if not not vim.g.started_by_firenvim or "leetcode.nvim" == vim.fn.argv(0, -1) then
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
  { import = "lazyvim.plugins.extras.ai.copilot-chat" },
  { import = "lazyvim.plugins.extras.ai.copilot" },
  { import = "lazyvim.plugins.extras.ai.tabnine" },
  { import = "lazyvim.plugins.extras.coding.neogen" },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.editor.inc-rename" },
  { import = "lazyvim.plugins.extras.editor.navic" },
  { import = "lazyvim.plugins.extras.editor.outline" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.lang.git" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.sql" },
  { import = "lazyvim.plugins.extras.lang.tex" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.ui.indent-blankline" },
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  { import = "lazyvim.plugins.extras.util.project" },

  { "folke/noice.nvim", enabled = false },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { additional_vim_regex_highlighting = { "python" } },
      indent = { disable = { "python" } },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local parsers = require("nvim-treesitter.parsers").get_parser_configs()
      for _, p in pairs(parsers) do
        p.install_info.url = p.install_info.url:gsub("https://github.com/", "https://mirror.ghproxy.com/https://github.com/")
      end
    end,
  },
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
    keys = {
      -- Switch `<leader>e` and `<leader>E`
      { "<leader>e", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      { "<leader>E", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
    },
    opts = {
      window = {
        width = "20%",
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
    "folke/snacks.nvim",
    opts = {
      notifier = { enabled = false },
      dashboard = { enabled = false },
      words = {
        debounce = 0, -- time in ms to wait before updating
      }
    }
  },
  {
    "glacambre/firenvim",
    build = function() vim.fn["firenvim#install"](0) end,
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    opts = function()
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
    "folke/persistence.nvim",
    lazy = false,
    opts = function()
      -- Auto restore session
      vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        callback = function()
          local persistence = require("persistence")
          if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
            persistence.load()
          else
            persistence.stop()
          end
        end,
      })
      -- Auto delete [No Name] buffers.
      vim.api.nvim_create_autocmd("BufLeave", {
        callback = function()
          local buffers = vim.fn.filter(vim.fn.range(1, vim.fn.bufnr("$")),
            'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
          local next = next
          if next(buffers) == nil then return end
          local cmdstr = ":silent! bw!"
          for _, v in pairs(buffers) do
            cmdstr = cmdstr .. " " .. v
          end
          vim.cmd(cmdstr)
        end
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
        show_close_icon = false,
      }
    }
  },
  { "folke/flash.nvim", enabled = false },
  {
    "kylechui/nvim-surround",
    -- version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {
      -- Configuration here, or leave empty to use defaults
      keymaps = {
        insert = "<A-g>s",
        insert_line = "<A-g>S",
      }
    },
  },
  {
    "smoka7/hop.nvim",
    -- version = "*",
    event = "VeryLazy",
    keys = {
      { "s", "<CMD>silent! HopChar1MW<CR>", mode = { "n", "o", "x" }, silent = true },
      -- { "<LEADER><LEADER>", "<CMD>silent! HopPatternMW<CR>", mode = { "n", "o", "x" }, silent = true }
    },
    opts = {}
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
      { "<C-0>", "<leader>aa", desc = "Toggle (CopilotChat)", mode = { "n", "v" }, remap = true },
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
  {
    "kawre/leetcode.nvim",
    lazy = "leetcode.nvim" ~= vim.fn.argv(0, -1),
    cmd = "Leet",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- TODO: Try to add image support but failed.
      -- {
      --   "3rd/image.nvim",
      --   opts = {
      --    backend = "ueberzug" -- brew install jstkdng/programs/ueberzugpp
      --   }
      -- }
    },
    opts = {
      -- configuration goes here
      lang = "python3",
      cn = { -- leetcode.cn
          enabled = true,
          translator = false,
      },
      -- image_support = true,
      plugins = {
          non_standalone = true,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" }
      },
    }
  },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    opts = {
      manual_mode = false,
      patterns = { "._", ".git"  },
    },
  },
  {
    "hedyhli/outline.nvim",
    opts = {
      outline_window = {
        width = 20,
      },
    },
  },
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python"
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = {
        border = "single",
        preview = {
          border = "single",
          hidden = true,
          vertical = "down:15,border-top",
          layout = "vertical",
        },
      },
      keymap = {
        builtin = {
          true,
          ["<C-r>"] = "toggle-preview",
        },
        fzf = {
          true,
          ["ctrl-r"] = "toggle-preview",
        },
      },
      actions = {
        files = {
          true,
          ["ctrl-t"] = require("fzf-lua").actions.file_tabedit,
        },
      },
      grep = {
        winopts = {
          preview = {
            hidden = false,
          },
        },
      },
      lsp = {
        winopts = {
          preview = {
            hidden = false,
          },
        },
      },
    },
  },
}
