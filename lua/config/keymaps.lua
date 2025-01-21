-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del("n", "H")
vim.keymap.del("n", "L")

vim.keymap.del("v", "<")
vim.keymap.del("v", ">")

vim.keymap.set("n", "<leader>ba", function() Snacks.bufdelete.all() end, { desc = "Delete All Buffers" })
vim.keymap.set("x", "<esc>", function()
  vim.cmd("noh")
  LazyVim.cmp.actions.snippet_stop()
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })
vim.keymap.set({ "i", "n", "s", "x" }, "<C-c>", "<esc>", { remap = true, desc = "Escape and Clear hlsearch" })
vim.cmd([[
	" start of line
	:cnoremap <C-A>		<Home>
	" back one character
	:cnoremap <C-B>		<Left>
	" delete character under cursor
	:cnoremap <C-D>		<Del>
	" end of line
  :cnoremap <C-E>		<End>
	" forward one character
	:cnoremap <C-F>		<Right>
	" recall newer command-line
	:cnoremap <C-N>		<Down>
	" recall previous (older) command-line
	:cnoremap <C-P>		<Up>
	" back one word
	:cnoremap <Esc><C-B>	<S-Left>
	" forward one word
	:cnoremap <Esc><C-F>	<S-Right>
]])
vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], { silent = true, desc = "Back to normal mode in terminal" })
vim.keymap.set("n", "<C-w>z", "<C-w>|<C-w>_", { silent = true, desc = "Maximize current window" })

-- Move buffers.
local function check_no_name_buffer(cmdstr)
  if vim.fn.empty(vim.fn.bufname(vim.fn.bufnr())) == 1 then
    return
  end
  vim.cmd(cmdstr)
end
vim.keymap.set("n", "<C-w><C-h>", function() return check_no_name_buffer("bel vs | silent! b# | winc p") end, { silent = true, desc = "Move current buffer to left" })
vim.keymap.set("n", "<C-w><C-j>", function() return check_no_name_buffer("abo sp | silent! b# | winc p") end, { silent = true, desc = "Move current buffer to down" })
vim.keymap.set("n", "<C-w><C-k>", function() return check_no_name_buffer("bel sp | silent! b# | winc p") end, { silent = true, desc = "Move current buffer to up" })
vim.keymap.set("n", "<C-w><C-l>", function() return check_no_name_buffer("abo vs | silent! b# | winc p") end, { silent = true, desc = "Move current buffer to right" })
