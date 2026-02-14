require "nvchad.mappings"

-- Buffers
vim.api.nvim_create_user_command("BufCurOnly", "%bdelete|edit#|bdelete#", { force = true })

local map = vim.keymap.set
local silence_opts = { silent = true, noremap = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- NvimTreeToggle
map("n", "<C-t>", "<cmd>NvimTreeToggle<cr>")
-- Telescope
map("n", "<C-p>", "<cmd>Telescope find_files<cr>")
map("n", "<C-b>", "<cmd>Telescope buffers initial_mode=insert<cr>")
map("n", "<C-f>", "<cmd>Telescope current_buffer_fuzy_find initial_mode=insert<cr>")

map("n", "Q", "<cmd>x<CR>")

-- Buffers
map("n", "<S-n>", "<cmd>bn<cr>")
map("n", "<S-m>", "<cmd>bp<cr>")
map("n","<C-b>d", "<cmd>bd<cr>")
map("n","<C-b>c", "<cmd>BufCurOnly<cr>")

--- Fugitive
-- Status
map("n", "ss", "<cmd>G<cr>", silence_opts)
-- Do commit
map("n", "cc", "<cmd>Git commit<cr>", silence_opts)
-- Do push
map("n", "<leader>gp", "<cmd>Git push<cr>", silence_opts)
-- Do pull
map("n", "<leader>gl", "<cmd>Git pull<cr>", silence_opts)


-- Fold
map("n", "<F3>", "<cmd>set foldmethod=marker<cr>")
