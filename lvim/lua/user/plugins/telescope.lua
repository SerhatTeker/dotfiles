-- # Telescope

-- ## Pickers {{{

-- Default lvim `hidden` not working, maybe due to `fd` version
lvim.builtin.telescope.pickers = {
    find_files = {
        hidden = true,
        find_command = {
            "fd", "--hidden", "--type", "f", "--strip-cwd-prefix"
        },
    },
    live_grep = {
        --@usage don't include the filename in the search results
        only_sort_text = true,
    },
}
-- }}}

-- ## Mappings {{{

-- Core {{{

-- Change Telescope navigation to use j and k for navigation and n and p for
-- history in both input and normal mode. we use protected-mode (pcall) just in
-- case the plugin wasn't loaded yet.
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["?"] = action_layout.toggle_preview,
    },
    -- for normal mode
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["?"] = action_layout.toggle_preview,
    },
}

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<C-p>", "<CMD>Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-f>", "<CMD>Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-b>", "<CMD>Telescope buffers<CR>", opts)
-- }}}

-- Git {{{

vim.api.nvim_set_keymap("n", "<leader>gb", "<CMD>Telescope git_branches<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gc", "<CMD>Telescope git_commits<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gx", "<CMD>Telescope git_bcommits<CR>", opts)
-- }}}

-- Which key {{{

lvim.builtin.which_key.mappings["t"] = {
    name = "Telescope",
    p = { require("lvim.core.telescope.custom-finders").find_project_files, "Files" },
    f = { "<CMD>Telescope live_grep<CR>", "Find" },
    b = { "<CMD>Telescope buffers<CR>", "Buffers" },
    d = { "<CMD>Telescope diagnostics<CR>", "Diagnostics" },
    -- LSP
    ld = { "<CMD>Telescope lsp_definitions<CR>", "LSP Definitions" },
    lr = { "<CMD>Telescope lsp_references<CR>", "LSP Refences" },
    li = { "<CMD>Telescope lsp_implementations<CR>", "LSP Implementations" },
    -- Git
    gb = { "<CMD>Telescope git_branches<CR>", "Branches" },
    gc = { "<CMD>Telescope git_commits<CR>", "Commits" },
    gx = { "<CMD>Telescope git_bcommits<CR>", "Commits Buffer" },
}
-- }}}
-- }}}
