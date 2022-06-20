-- Treesitter

local ts = lvim.builtin.treesitter

-- if you don't want all the parsers change this to a table of the ones you want
ts.ensure_installed = {
    "bash",
    "c",
    "css",
    "go",
    "java",
    "javascript",
    "json",
    "lua",
    "python",
    "rust",
    "typescript",
    "tsx",
    "yaml",
}

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
}

ts.rainbow = {
    enable = true,
    disable = { "python" }, -- list of languages you want to disable the plugin for
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
}
