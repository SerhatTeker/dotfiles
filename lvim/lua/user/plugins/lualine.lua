local ll = lvim.builtin.lualine

-- ## Style
ll.style = "lvim"

-- # Styles {{{

-- ## Default {{{

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
end
-- }}}

-- ## Lvim {{{

local mode = {
    function()
        -- return "  "
        return " "
    end,
    padding = { left = 0, right = 0 },
    color = {},
    cond = nil,
}

if ll.style == "lvim" then
    local components = require "lvim.core.lualine.components"

    ll.sections = {
        lualine_a = {
            mode,
        },
        lualine_b = {
            components.branch,
            -- components.diff,
        },

        lualine_c = {
            {
                'filename',
                file_status = true, -- Displays file status (readonly status, modified status)
                -- 0: Just the filename
                -- 1: Relative path
                -- 2: Absolute path
                -- 3: Absolute path, with tilde as the home directory
                path = 1,
                shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                symbols = {
                    modified = '[+]', -- Text to show when the file is modified.
                    readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                }
            },
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
-- }}}
