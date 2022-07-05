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

-- ## Prefix {{{

-- -- default lvim ones
-- prompt_prefix = " ",
-- selection_caret = " ",

-- -- fzf-like
-- lvim.builtin.telescope.defaults.prompt_prefix = "> "
-- lvim.builtin.telescope.defaults.selection_caret = "> "

-- use defaults, same as fzf-like
-- lvim.builtin.telescope.defaults.prompt_prefix = nil
-- lvim.builtin.telescope.defaults.selection_caret = nil
-- }}}

-- ## Mappings {{{

-- Core {{{

-- Change Telescope navigation to use j and k for navigation and n and p for
-- history in both input and normal mode. we use protected-mode (pcall) just in
-- case the plugin wasn't loaded yet.
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

lvim.builtin.telescope.defaults.mappings = {
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<CR>"] = actions.select_default,
        ["?"] = action_layout.toggle_preview,
    },
    -- for normal mode
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        -- ["?"] = action_layout.toggle_preview,
    },
}

-- TODO: Use global map util function
local utils = require("user.utils")
local map_cmd = utils.map_cmd
local cmd = utils.cmd

map_cmd("<C-p>", "Telescope find_files")
map_cmd("<C-f>", "Telescope live_grep")
map_cmd("<S-b>", "Telescope buffers")
-- }}}

-- Git {{{
map_cmd("<leader>gb", "Telescope git_branches")
map_cmd("<leader>gc", "Telescope git_commits")
map_cmd("<leader>gx", "Telescope git_bcommits")
map_cmd("<leader>gs", "Telescope git_status")

-- }}}

-- Which key {{{

lvim.builtin.which_key.mappings["t"] = {
    name = "Telescope",
    p = { require("lvim.core.telescope.custom-finders").find_project_files, "Files" },
    f = { cmd("Telescope live_grep"), "Find" },
    b = { cmd("Telescope buffers"), "Buffers" },
    d = { cmd("Telescope diagnostics"), "Diagnostics" },
    -- LSP
    ld = { cmd("Telescope lsp_definitions"), "LSP Definitions" },
    lr = { cmd("Telescope lsp_references"), "LSP Refences" },
    li = { cmd("Telescope lsp_implementations"), "LSP Implementations" },
    -- Git
    gb = { cmd("Telescope git_branches"), "Branches" },
    gc = { cmd("Telescope git_commits"), "Commits" },
    gx = { cmd("Telescope git_bcommits"), "Commits Buffer" },
}
-- }}}
-- }}}
