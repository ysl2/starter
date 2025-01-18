return {
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
  }
}
