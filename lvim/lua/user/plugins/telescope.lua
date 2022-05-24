-- Telescope
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
    },
    -- for normal mode
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
    },
}

local opts = { noremap = true, silent = true }

-- Core
vim.api.nvim_set_keymap("n", "<C-p>", "<CMD>Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-f>", "<CMD>Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-b>", "<CMD>Telescope buffers<CR>", opts)

-- Git
vim.api.nvim_set_keymap("n", "<leader>gb", "<CMD>Telescope git_branches<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gc", "<CMD>Telescope git_commits<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gcb", "<CMD>Telescope git_bcommits<CR>", opts)

-- Which key
-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["t"] = {
    name = "Telescope",
    p = { "<CMD>Telescope find_files<CR>", "Files" },
    f = { "<CMD>Telescope live_grep<CR>", "Find" },
    b = { "<CMD>Telescope buffers<CR>", "Buffers" },
    d = { "<CMD>Telescope diagnostics<CR>", "Diagnostics" },
    ld = { "<CMD>Telescope lsp_definitions<CR>", "LSP Definitions" },
    lr = { "<CMD>Telescope lsp_references<CR>", "LSP Refences" },
    li = { "<CMD>Telescope lsp_implementations<CR>", "LSP Implementations" },
}
