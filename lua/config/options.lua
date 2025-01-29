-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ===
-- === Set by myself
-- ===
pcall(vim.cmd, "autocmd! nvim_swapfile")
vim.opt.lazyredraw = true

-- ==
-- == Set by LazyVim, and modified by myself
-- ==
vim.opt.clipboard = ""
vim.opt.confirm = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.conceallevel = 0

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end
})

vim.g.autoformat = false
vim.g.snacks_animate = false
vim.g.ai_cmp = false
vim.g.lazyvim_blink_main = true
vim.g.autowrite = false
vim.g.lazyvim_cmp = "nvim-cmp"
vim.g.root_spec = { "cwd" }
