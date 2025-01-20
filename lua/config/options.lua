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
vim.opt.guicursor = ""
vim.opt.clipboard = ""
vim.opt.confirm = false
vim.opt.laststatus = 2

vim.g.autoformat = false
vim.g.snacks_animate = false
vim.g.ai_cmp = false
vim.g.lazyvim_blink_main = true
vim.g.autowrite = false
