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
vim.opt.autowrite = false
vim.opt.conceallevel = 0
vim.opt.list = false
-- Ref: https://www.reddit.com/r/vim/comments/s9gqgr/smartindent_messing_with_comment_indents
-- Ref: https://www.reddit.com/r/vim/wiki/vimrctips/#wiki_do_not_use_smartindent
vim.opt.smartindent = false

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
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
-- vim.g.lazyvim_cmp = vim.system({ "which", "cargo" }):wait().code == 0 and vim.g.lazyvim_cmp or "nvim-cmp"
vim.g.root_spec = { "cwd" }
vim.g.lazyvim_python_lsp = "jedi_language_server"
