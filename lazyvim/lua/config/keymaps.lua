-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Buffers
vim.api.nvim_create_user_command("BufCurOnly", "%bdelete|edit#|bdelete#", { force = true })

local map = vim.keymap.set
local silence_opts = { silent = true, noremap = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Telescope
map("n", "<C-p>", "<cmd>Telescope find_files<cr>")
map("n", "<C-b>", "<cmd>Telescope buffers initial_mode=insert<cr>")
map("n", "<C-f>", "<cmd>Telescope current_buffer_fuzy_find initial_mode=insert<cr>")

map("n", "Q", "<cmd>x<CR>")

-- Buffers
map("n", "<S-n>", "<cmd>bn<cr>")
map("n", "<S-m>", "<cmd>bp<cr>")
map("n", "<C-b>d", "<cmd>bd<cr>")
map("n", "<C-b>c", "<cmd>BufCurOnly<cr>")

-- Fold
map("n", "<F3>", "<cmd>set foldmethod=marker<cr>")
