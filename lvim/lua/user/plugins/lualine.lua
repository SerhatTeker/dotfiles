local ll = lvim.builtin.lualine

-- ## Style
ll.style = "lvim"

-- # Snippets {{{

-- ## Changing filename color based on modified status
local custom_fname = require('lualine.components.filename'):extend()
local highlight = require 'lualine.highlight'
local default_status_colors = { saved = '#228B22', modified = '#C70039' }

function custom_fname:init(options)
    custom_fname.super.init(self, options)
    self.status_colors = {
        saved = highlight.create_component_highlight_group(
            { fg = default_status_colors.saved }, 'filename_status_saved', self.options),
        modified = highlight.create_component_highlight_group(
            { fg = default_status_colors.modified }, 'filename_status_modified', self.options),
    }
    if self.options.color == nil then self.options.color = '' end
end

function custom_fname:update_status()
    local data = custom_fname.super.update_status(self)
    data = highlight.component_format_highlight(vim.bo.modified
        and self.status_colors.modified
        or self.status_colors.saved) .. data
    return data
end

-- }}}

-- # Styles {{{

-- ## Default
if ll.style == "default" then
    -- ### Separators
    -- #### default
    -- ll.options.section_separators = { left = "", right = "" }
    -- ll.options.component_separators = { left = "", right = "" }
    -- #### lightline-like
    ll.options.section_separators = { left = "", right = "" }
    ll.options.component_separators = { left = "|", right = "|" }

    ll.sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        -- lualine_c = { "%f" }, -- relative full filename
        -- lualine_c = { custom_fname },
        lualine_x = { "diagnostics" },
        lualine_y = { "filetype", "fileformat", "encoding" },
        lualine_z = { "location" },
    }

    -- ## lvim-like lualine_b
    -- ll.sections.lualine_b = {
    --     { 'branch', icon = '' },
    --     { "diff",
    --         symbols = { added = "  ", modified = " ", removed = " " },
    --     },
    -- }
    -- }}}
end

if ll.style == "lvim" then
    local components = require "lvim.core.lualine.components"

    ll.sections = {
        lualine_a = {
            components.mode,
        },
        lualine_b = {
            components.branch,
        },
        lualine_c = {
            components.diff,
            components.filename,
            components.python_env,
        },
        lualine_x = {
            components.diagnostics,
            -- components.treesitter,
            -- components.lsp,
            components.filetype,
            "fileformat",
            "encoding",
        },
        lualine_y = {},
        lualine_z = { "location" },
    }
    ll.tabline = {}
    ll.extensions = { "nvim-tree" }
end
-- }}}
