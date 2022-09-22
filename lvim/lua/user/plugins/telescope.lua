-- # Telescope

-- ## Pickers {{{

local custom_pickers = {
    find_files = {
        hidden = true,
    },
    live_grep = {
        --@usage don't include the filename in the search results
        only_sort_text = true,
    },
    grep_string = {
        only_sort_text = true,
    },
    buffers = {
        previewer = false,
        initial_mode = "normal",
    },
    planets = {
        show_pluto = true,
        show_moon = true,
    },
    git_files = {
        hidden = true,
        show_untracked = true,
    },
    lsp_references = {
        initial_mode = "normal",
    },
    lsp_definitions = {
        initial_mode = "normal",
    },
    lsp_declarations = {
        initial_mode = "normal",
    },
    lsp_implementations = {
        initial_mode = "normal",
    },
}

lvim.builtin.telescope.defaults.pickers = custom_pickers
lvim.builtin.telescope.pickers = custom_pickers
-- }}}

-- ## Prefix {{{

-- use defaults, same as fzf-like
lvim.builtin.telescope.defaults.prompt_prefix = nil
lvim.builtin.telescope.defaults.selection_caret = nil

-- -- fzf-like
-- lvim.builtin.telescope.defaults.prompt_prefix = "> "
-- lvim.builtin.telescope.defaults.selection_caret = "> "

-- -- default lvim ones
-- prompt_prefix = " ",
-- selection_caret = " ",
-- }}}

-- ## Mappings {{{

local utils = require("user.utils")
local map_cmd = utils.map_cmd
local cmd = utils.cmd

-- Default mappings {{{

-- Change Telescope navigation to use j and k for navigation and n and p for
-- history in both input and normal mode. we use protected-mode (pcall) just in
-- case the plugin wasn't loaded yet.
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local multiopen_mappings = require('user.plugins.telescope_multiopen')

lvim.builtin.telescope.defaults.mappings = {
    -- insert mode
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        -- ["<CR>"] = actions.select_default,
        ["?"]     = action_layout.toggle_preview,
        -- multiopen
        ['<C-v>'] = multiopen_mappings.i['<C-v>'],
        ['<C-s>'] = multiopen_mappings.i['<C-s>'],
        ['<C-t>'] = multiopen_mappings.i['<C-t>'],
        ['<CR>']  = multiopen_mappings.i['<CR>'],

    },
    -- normal mode
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        -- ["?"] = action_layout.toggle_preview,
        -- multiopen
        ['<C-v>'] = multiopen_mappings.n['<C-v>'],
        ['<C-s>'] = multiopen_mappings.n['<C-s>'],
        ['<C-t>'] = multiopen_mappings.n['<C-t>'],
        ['<CR>']  = multiopen_mappings.n['<CR>'],
    },
}
-- }}}

-- Custome mappings {{{

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
    c = { cmd("Telescope colorscheme"), "Colorscheme" },
    -- LSP
    ld = { cmd("Telescope lsp_definitions"), "LSP Definitions" },
    lr = { cmd("Telescope lsp_references"), "LSP Refences" },
    li = { cmd("Telescope lsp_implementations"), "LSP Implementations" },
    -- Git
    gb = { cmd("Telescope git_branches"), "Branches" },
    gc = { cmd("Telescope git_commits"), "Commits" },
    gx = { cmd("Telescope git_bcommits"), "Commits Buffer" },
    gs = { cmd("Telescope git_status"), "Status Files" },
}
-- }}}
-- }}}
