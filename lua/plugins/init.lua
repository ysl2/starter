return {
  -- Imports
  { import = "lazyvim.plugins.extras.ai.copilot-chat", cond = not vim.g.started_by_firenvim and "leetcode.nvim" ~= vim.fn.argv(0, -1) },
  { import = "lazyvim.plugins.extras.ai.copilot", cond = not vim.g.started_by_firenvim and "leetcode.nvim" ~= vim.fn.argv(0, -1) },
  { import = "lazyvim.plugins.extras.ai.tabnine", cond = not vim.g.started_by_firenvim and "leetcode.nvim" ~= vim.fn.argv(0, -1) },
  { import = "lazyvim.plugins.extras.coding.neogen" },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.editor.inc-rename" },
  { import = "lazyvim.plugins.extras.editor.outline" },
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

  -- Colorschemes
  { "Mofiqul/vscode.nvim", cond = not not vim.g.started_by_firenvim or "leetcode.nvim" == vim.fn.argv(0, -1) },
  -- { "folke/tokyonight.nvim", cond = not vim.g.started_by_firenvim and "leetcode.nvim" ~= vim.fn.argv(0, -1) },
  { "thesimonho/kanagawa-paper.nvim",
    cond = not vim.g.started_by_firenvim and "leetcode.nvim" ~= vim.fn.argv(0, -1),
    opts = {
      dimInactive = false,
      -- Ref: https://github.com/thesimonho/kanagawa-paper.nvim?tab=readme-ov-file#common-customizations
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
          FloatTitle = { bg = "NONE" },

          -- Save a hlgroup with dark background and dimmed foreground
          -- so that you can use it where you still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          StatusLine = { bg = theme.ui.bg_p1 },
          StatusLineNC = { bg = theme.ui.bg_p1 },
        }
      end,
    },
  },

  -- Others
  { "folke/lazy.nvim", version = "*" },
  {
    "LazyVim/LazyVim",
    version = "*",
    opts = {
      colorscheme = (function()
        vim.api.nvim_create_autocmd("ColorScheme", {
          callback = function()
            vim.api.nvim_set_hl(0, "Visual", { reverse = true })
            vim.api.nvim_set_hl(0, "IncSearch", { reverse = true })
            vim.api.nvim_set_hl(0, "Search", { reverse = true })

            local opts = { underline = true, bold = true }
            vim.api.nvim_set_hl(0, "DiffAdd", opts)
            vim.api.nvim_set_hl(0, "DiffChange", opts)
            vim.api.nvim_set_hl(0, "DiffDelete", { reverse = true })
            local fg_incsearch = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('IncSearch')), 'bg', 'gui')
            vim.api.nvim_set_hl(0, 'DiffText', { reverse = true, bold = true , fg = fg_incsearch })

            local fg_conceal = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Conceal")), "fg", "gui")
            vim.api.nvim_set_hl(0, "CursorLineNr", { fg = fg_conceal })
            vim.api.nvim_set_hl(0, "LineNr", { fg = fg_conceal })
            vim.api.nvim_set_hl(0, "LineNrAbove", { fg = fg_conceal })
            vim.api.nvim_set_hl(0, "LineNrBelow", { fg = fg_conceal })
            vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = fg_conceal })
            vim.api.nvim_set_hl(0, 'WinSeparator', { fg = fg_conceal })
          end
        })
        if not not vim.g.started_by_firenvim or "leetcode.nvim" == vim.fn.argv(0, -1) then
          return "vscode"
        end
        -- return "tokyonight"
        return "kanagawa-paper"
      end)(),
      news = {
        lazyvim = false,
      },
      icons = {
        diagnostics = {
          Error = " ",
          Warn  = " ",
          Hint  = " ",
          Info  = " ",
        },
        git = {
          added = "+",
          modified = "~",
          removed = "-",
        }
      },
    },
  },
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
          ["t"] = "open_tab_drop_and_close_tree",
          ["<C-h>"] = "close_all_subnodes",
          ["<C-c>"] = "revert_preview",
          ["I"] = "toggle_hidden"
        }
      },
      commands = {
        open_tab_drop_and_close_tree = function(state, toggle_directory)
          local node = state.tree:get_node()
          if node.type == "directory" or node.type == "message" or node.type == "terminal" then
            return
          end
          require("neo-tree.sources.common.commands").open_tab_drop(state, toggle_directory)
          local winid = state.winid
          if winid and vim.api.nvim_win_is_valid(winid) then
              vim.api.nvim_win_close(winid, true)
          end
        end,
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      notifier = { enabled = false },
      dashboard = { enabled = false },
      words = {
        debounce = 0, -- time in ms to wait before updating
      },
      lazygit = {
        win = {
          style = "float",
          border = "single",
          height = 0.83,
          width = 0.83,
        },
      },
      terminal = {
        win = {
          style = "float",
          border = "single",
          height = 0.83,
          width = 0.83,
        },
      },
    }
  },
  {
    "glacambre/firenvim",
    build = function() vim.fn["firenvim#install"](0) end,
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    config = function()
      vim.api.nvim_create_autocmd("UIEnter", {
        callback = function()
          local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
          if client and client.name == "Firenvim" then
            vim.cmd("set guifont=FiraCode\\ Nerd\\ Font:h25")
            vim.opt.laststatus = 0
            vim.opt.swapfile = false
          end
        end
      })
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
    cond = not vim.g.started_by_firenvim,
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" }
      },
      sections = {
        lualine_z = {
          function()
            local date = vim.loop.os_uname().sysname == "Darwin" and "gdate" or "date"
            return " " .. vim.system({ date, "+%H:%M:%S.%3N" }, { text = true }):wait().stdout:gsub("\n", "")
          end,
        }
      }
    }
  },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    opts = {
      manual_mode = false,
      detection_methods = { "pattern" },
      patterns = { "._", ".git" },
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
    keys = {
      { "<leader><leader>", "<leader>fF", desc = "Find Files (cwd)", remap = true },
      { "<leader>/", "<leader>sG", desc = "Grep (cwd)", remap = true },
    },
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
          ["<C-u>"] = "preview-page-up",
          ["<C-d>"] = "preview-page-down",
        },
        fzf = {
          true,
          ["ctrl-r"] = "toggle-preview",
          ["ctrl-u"] = "preview-page-up",
          ["ctrl-d"] = "preview-page-down",
        },
      },
      actions = {
        files = {
          true,
          ["ctrl-t"] = require("fzf-lua").actions.file_tabedit,
        },
      },
      files = {
        actions = {
          ["alt-h"] = false,
          ["alt-i"] = false,
          ["ctrl-g"] = false,
          ["ctrl-h"] = require("fzf-lua").actions.toggle_hidden,
          ["ctrl-l"] = require("fzf-lua").actions.toggle_ignore
        },
      },
      grep = {
        actions = {
          ["alt-h"] = false,
          ["alt-i"] = false,
          ["ctrl-h"] = require("fzf-lua").actions.toggle_hidden,
          ["ctrl-l"] = require("fzf-lua").actions.toggle_ignore
        },
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
  {
    "ibhagwan/fzf-lua",
    opts = function()
      local config = require("fzf-lua").config
      config.defaults.keymap.fzf["ctrl-f"] = nil
      config.defaults.keymap.fzf["ctrl-b"] = nil
      config.defaults.keymap.builtin["<c-f>"] = nil
      config.defaults.keymap.builtin["<c-b>"] = nil
    end
  },
  {
    "tpope/vim-rsi",
    event = "InsertEnter"
  },
  {
    "gbprod/yanky.nvim",
    opts = {
      highlight = {
        on_put = false,
        timer = vim.highlight.priorities.user,
      },
      preserve_cursor_position = {
        enabled = false,
      },
    },
  },
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
  {
    "lervag/vimtex",
    opts = function()
      if not LazyVim.is_win() then
        vim.g.vimtex_view_method = "zathura"
      end
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_view_zathura_use_synctex = 0
    end
  },
}
