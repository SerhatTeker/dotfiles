-- Treesitter
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
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

-- lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
