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

-- TODO: Append references instead of adding all of them
-- LSP
wk.mappings["l"] = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    f = { require("lvim.lsp.utils").format, "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Mason Info" },
    -- diagnostic
    dd = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
    dw = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    j = {
        vim.diagnostic.goto_next,
        "Next Diagnostic",
    },
    k = {
        vim.diagnostic.goto_prev,
        "Prev Diagnostic",
    },
    --
    d = { cmd("Telescope lsp_definitions"), "Definitions" },
    r = { cmd("Telescope lsp_references"), "Refences" },
    m = { cmd("Telescope lsp_implementations"), "Implementations" },
    x = { vim.lsp.buf.rename, "Rename" },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
    },
    e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
}
-- }}}
