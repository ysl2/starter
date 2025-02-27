-- bootstrap lazy.nvim, LazyVim and your plugins
pcall(require, "localhost.pre")
require("config.lazy")
pcall(require, "localhost.post")
