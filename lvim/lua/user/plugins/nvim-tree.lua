-- Nvimtree
local nt = lvim.builtin.nvimtree
nt.setup.view.side = "left"
nt.show_icons.git = 1
-- indent markers
nt.setup.renderer.indent_markers.enable = true
-- diagnostics icons
nt.setup.diagnostics.enable = true

-- Ingore/Exclude directories/files patterns
-- https://github.com/kyazdani42/nvim-tree.lua/issues/824
nt.setup.filters.custom = {
    ".mypy_cache",
    "__pycache__",
    ".pytest_cache",
    "htmlcov",
    "hypothesis",
    "node_modules",
    "\\.cache",
}

-- Keymaps

--- mappings list
local function telescope_find_files(_)
    require("lvim.core.nvimtree").start_telescope "find_files"
end

local function telescope_live_grep(_)
    require("lvim.core.nvimtree").start_telescope "live_grep"
end

-- Disable default <C-t>
-- Add Default ones from lvim
-- https://github.com/LunarVim/LunarVim/blob/23df368b00bda0ed4a01fac92f7ad80998c1d34a/lua/lvim/core/nvimtree.lua#L173-L190
lvim.builtin.nvimtree.setup.view.mappings.list = {
    -- defaults
    { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
    { key = "h", action = "close_node" },
    { key = "v", action = "vsplit" },
    { key = "C", action = "cd" },
    { key = "gtf", action = "telescope_find_files", action_cb = telescope_find_files },
    { key = "gtg", action = "telescope_live_grep", action_cb = telescope_live_grep },
    -- disable <C-t>
    { key = "<C-t>", action = "" },
}

local lnmap = lvim.keys.normal_mode
lnmap["<C-t>"] = "<CMD>NvimTreeToggle<CR>"
lnmap["<leader>v"] = "<CMD>NvimTreeFindFile<CR>"
