-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Buffers
vim.api.nvim_create_user_command("BufCurOnly", "%bdelete|edit#|bdelete#", { force = true })

local map = vim.keymap.set
-- local del = vim.keymap.del

-- local silence_opts = { silent = true, noremap = true }

-- disable / delete LazyVim ones
-- del({ "i", "x", "n", "s" }, "<C-s>")

-- one key stroke less
map("n", ";", ":", { desc = "CMD enter command mode" })

-- quit
map("n", "Q", "<cmd>x<CR>")

-- Buffers
map("n", "<S-n>", "<cmd>bn<cr>")
map("n", "<S-m>", "<cmd>bp<cr>")
map("n", "<C-b>d", "<cmd>bd<cr>")
map("n", "<C-b>c", "<cmd>BufCurOnly<cr>")

-- Tab
map("n", "]t", "<cmd>tabnext<cr>")
map("n", "[t", "<cmd>tabprevious<cr>")
map("n", "<leader>n", "<cmd>tabnew<cr>", { desc = "New Tab" })

-- Fold
map("n", "<F3>", "<cmd>set foldmethod=marker<cr>")

-- Spell
map("n", "<F7>", "<cmd>ToggleSpell<cr>")

-- Toggle list chars
map("n", "<F5>", "<cmd>set list! list?<cr>")

-- Lines
-- Visual linewise up and down by default (and use gj gk to go quicker)
map("n", "<Up>", "gj")
map("n", "<Down>", "gj")
map("n", "j", "gj")
map("n", "k", "gk")

-- Customs {{{

map("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- rename
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename (LSP)" })

-- grug-far: search word under cursor
local function grug_far_cword()
  require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") }, startInInsertMode = false })
end
map("n", "<leader>sx", grug_far_cword, { desc = "Search word under cursor (grug-far)" })
map("n", "<leader>rr", grug_far_cword, { desc = "Search word under cursor (grug-far)" })
-- }}}
