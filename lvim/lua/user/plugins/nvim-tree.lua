-- Nvimtree
local nt = lvim.builtin.nvimtree
nt.setup.view.side = "left"
nt.show_icons.git = 1
-- indent markers
nt.setup.renderer.indent_markers.enable = true
-- diagnostics icons
nt.setup.diagnostics.enable = false

lvim.keys.normal_mode["<C-t>"] = "<CMD>NvimTreeToggle<CR>"
lvim.keys.normal_mode["<leader>v"] = "<CMD>NvimTreeFindFile<CR>"
