-- Nvimtree
local nt_setup = lvim.builtin.nvimtree.setup

-- side
nt_setup.view.side = "left" -- verbose default
-- indent markers
nt_setup.renderer.indent_markers.enable = true
-- diagnostics icons
nt_setup.diagnostics.enable = false

-- window picker
-- open files in window from which last opened the tree
nt_setup.actions.open_file.window_picker.enable = false

-- Ingore/Exclude directories/files patterns
-- https://github.com/kyazdani42/nvim-tree.lua/issues/824
nt_setup.filters.custom = {
    ".mypy_cache",
    "__pycache__",
    ".pytest_cache",
    "htmlcov",
    "hypothesis",
    "node_modules",
    "\\.cache",
}

-- # Keymaps {{{

-- ## Disable nvim-tree default <C-t> and map <C-t> to Tree Toggle {{{

-- ### custom on_attach  {{{
local function on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function telescope_find_files(_)
        require("lvim.core.nvimtree").start_telescope "find_files"
    end

    local function telescope_live_grep(_)
        require("lvim.core.nvimtree").start_telescope "live_grep"
    end

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    local useful_keys = {
        ["l"] = { api.node.open.edit, opts "Open" },
        ["o"] = { api.node.open.edit, opts "Open" },
        ["<CR>"] = { api.node.open.edit, opts "Open" },
        ["v"] = { api.node.open.vertical, opts "Open: Vertical Split" },
        ["h"] = { api.node.navigate.parent_close, opts "Close Directory" },
        ["C"] = { api.tree.change_root_to_node, opts "CD" },
        ["gtg"] = { telescope_live_grep, opts "Telescope Live Grep" },
        ["gtf"] = { telescope_find_files, opts "Telescope Find File" },
        ["<C-t>"] = vim.keymap.set("n", "<C-t>", api.tree.toggle, opts("Open")),
    }

    require("lvim.keymappings").load_mode("n", useful_keys)
end

nt_setup.on_attach = on_attach
-- }}}

local utils = require("user.utils")
local map_cmd = utils.map_cmd

map_cmd("<C-t>", "NvimTreeToggle")
-- }}}
-- }}}
