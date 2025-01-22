-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local function clean_dangling_tmux_sessions(args)
  local tmux = os.getenv("MYTMUX")
  tmux = tmux ~= "" and tmux or "tmux"

  -- Get all tmux sessions that have a name starting with "nvim-".
  local stdout = vim.system({ tmux, "ls", "-F", '"#{session_name}"' }, { text = true }):wait().stdout
  if not stdout then
    return
  end
  local tmux_sessions = {}
  for line in stdout:gmatch("[^\r\n]+") do
    line = line:match('"(nvim%-.*)"')
    table.insert(tmux_sessions, line)
  end

  -- If VimEnter and VimLeave, clear the tmux sessions that have no corresponding nvim process.
  for _, line in ipairs(tmux_sessions) do
    local pid = line:match("nvim%-([%w]+)")
    local pname = vim.system({ "ps", "-p", pid, "-o", "args=" }, { text = true }):wait().stdout
    if not pname or not pname:find("nvim%s+%-%-embed") then
      vim.system({ tmux, "kill-session", "-t", line }, { text = true })
    end
  end

  -- If VimLeave, clear the tmux session that corresponds to the current nvim process.
  if args.event == "VimLeave" then
    local pid = vim.loop.os_getpid()
    local pname = vim.system({ "ps", "-p", pid, "-o", "args=" }, { text = true }):wait().stdout
    if pname and pname:find("nvim%s+%-%-embed") then
      vim.system({ tmux, "kill-session", "-t", "nvim-" .. pid }, { text = true })
    end
  end
end

-- TODO: No effect on VimEnter, so disable it for now. Need to further investigate.
-- vim.api.nvim_create_autocmd({ "VimEnter", "VimLeave" }, {
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function(args)
    clean_dangling_tmux_sessions(args)
  end,
})
