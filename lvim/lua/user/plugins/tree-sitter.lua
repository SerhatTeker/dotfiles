-- Treesitter

local ts = lvim.builtin.treesitter

-- if you don't want all the parsers change this to a table of the ones you want
ts.ensure_installed = {
    "bash",
    "c",
    "css",
    "go",
    "hcl",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "markdown", -- experimental
    "python",
    "rust",
    "typescript",
    "tsx",
    "yaml",
}

-- DEBUG: NW | Lvim: To enable Syntax Highlighting for .tf files as well
-- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_configs.hcl = {
--     filetype = "hcl", "terraform",
-- }

-- Textobjects
ts.textobjects = {
    select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["an"] = "@conditional.outer",
            ["in"] = "@conditional.inner",
        },
    },
    move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
        },
        goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
        },
        goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
        },
        goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
        },
    },
    swap = {
        enable = true,
        swap_next = {
            ["<leader>]a"] = "@function.outer",
        },
        swap_previous = {
            ["<leader>[a"] = "@function.outer",
        },
    },
}

-- Rainbow
ts.rainbow = {
    enable = true,
    disable = { "python" }, -- list of languages you want to disable the plugin for
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
}

-- Autotag
ts.autotag.enable = true
