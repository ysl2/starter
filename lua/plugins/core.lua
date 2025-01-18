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
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 30
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
      indent = {
        scope = { enabled = false },
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
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["<C-s>"] = "open_split",
          ["<C-v>"] = "open_vsplit",
        }
      }
    }
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
}
