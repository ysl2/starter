return {
  {
    "Saghen/blink.cmp",
    -- NOTE: brew install rustup; rustup toolchain install nightly
    build = "http_proxy=127.0.0.1:7890 https_proxy=127.0.0.1:7890 cargo build --release",
    opts = {
      completion = {
        menu = { border = "single" },
        documentation = { window = { border = "single" } },
      },
      signature = {
        enabled = false, -- Use lsp_signature instead now, because signature cannot show when in snippet.
        window = { border = "single" }
      },
      keymap = {
        ["<Tab>"] = {
          LazyVim.cmp.map({ "snippet_forward" }),
          "fallback",
        }
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
        float = {
          border = "single",
        },
        update_in_insert = true,
      }
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = ev.buf,
          callback = function()
            vim.diagnostic.open_float(nil, {
              focusable = false,
              close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              source = "always",
              prefix = " ",
              scope = "cursor",
            })
          end
        })
        end
      })
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function() -- Ref: https://github.com/ray-x/lsp_signature.nvim/issues/341#issuecomment-2466260487
      require("lsp_signature").on_attach({
        bind = true,
        hint_enable = false,
        handler_opts = {
          border = "single"
        }
      })
    end,
  },
}
