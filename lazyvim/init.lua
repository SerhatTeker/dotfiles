-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Load custom user commands
require("config.commands")

-- Load custom user private setting
pcall(require, "config.private")
