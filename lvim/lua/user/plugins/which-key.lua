-- # Which Key
local wk = lvim.builtin.which_key

wk.setup.plugins.presets.text_objects = true

wk.opts = {
    mode = "n", -- NORMAL mode
    prefix = "<space>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
wk.vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<space>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

-- ## Mappings {{{

local cmd = require("user.utils").cmd

-- ## Defaults {{{

-- Remove usless Lvim defaults
wk.mappings[";"] = nil
wk.mappings["w"] = nil
wk.mappings["q"] = nil
wk.mappings["F"] = nil
wk.mappings["e"] = nil -- DEBUG: NW

-- lvim.builtin.which_key.mappings["F"] = { require("lvim.core.telescope.custom-finders").find_project_files, "Find File" }
wk.mappings["f"] = { require("lvim.lsp.utils").format, "Format" }
wk.mappings["D"] = { cmd("Trouble document_diagnostics"), "Diagnostics" }
-- }}}

-- ## SymbolsOutline
wk.mappings["o"] = { cmd("SymbolsOutline"), "Outline" }

-- ## Helps
wk.mappings["h"] = { cmd("Telescope help_tags"), "Help" }

-- Diffview
wk.mappings["v"] = { cmd("DiffviewOpen"), "DiffviewOpen" }

-- Tab
wk.mappings["n"] = { cmd("tabedit %"), "Tab New" }
-- }}}
