-- Nvimtree
local nt = lvim.builtin.nvimtree
nt.setup.view.side = "left"
nt.show_icons.git = 1
-- indent markers
nt.setup.renderer.indent_markers.enable = true
-- diagnostics icons
nt.setup.diagnostics.enable = false

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

lvim.keys.normal_mode["<C-t>"] = "<CMD>NvimTreeToggle<CR>"
lvim.keys.normal_mode["<leader>v"] = "<CMD>NvimTreeFindFile<CR>"
