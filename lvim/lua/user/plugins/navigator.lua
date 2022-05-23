-- Navigator between nvim and tmux splits
vim.keymap.set('n', "<C-h>", '<CMD>NavigatorLeft<CR>', { noremap = true })
vim.keymap.set('n', "<C-l>", '<CMD>NavigatorRight<CR>', { noremap = true })
vim.keymap.set('n', "<C-k>", '<CMD>NavigatorUp<CR>', { noremap = true })
vim.keymap.set('n', "<C-j>", '<CMD>NavigatorDown<CR>', { noremap = true })
