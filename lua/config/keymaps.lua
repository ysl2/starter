-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del("n", "H")
vim.keymap.del("n", "L")

vim.keymap.del("v", "<")
vim.keymap.del("v", ">")

vim.keymap.set("n", "<leader>ba", function() Snacks.bufdelete.all() end, { desc = "Delete All Buffers" })
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
vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], { silent = true })
vim.keymap.set("n", "<C-w>z", "<C-w>|<C-w>_", { silent = true })
