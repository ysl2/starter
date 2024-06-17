return {
  { "folke/lazy.nvim", version = false },
  {
    "LazyVim/LazyVim",
    version = false,
    opts = {
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
    opts = function(_, opts)
      local parsers = require("nvim-treesitter.parsers").get_parser_configs()
      for _, p in pairs(parsers) do
        p.install_info.url =
          p.install_info.url:gsub("https://github.com/", "https://mirror.ghproxy.com/https://github.com/")
      end
    end,
  },
  { "Exafunction/codeium.nvim", enabled = false },
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<S-h>", false },
      { "<S-l>", false },
    },
  },
  {
    'csexton/trailertrash.vim',
    event = 'VeryLazy',
    config = function()
      vim.cmd('hi link UnwantedTrailerTrash NONE')
      vim.api.nvim_create_autocmd('BufWritePre', {
        command = 'TrailerTrim'
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
  }
}
