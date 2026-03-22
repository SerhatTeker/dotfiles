-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Global {{{

local g = vim.g -- global

-- LazyVim auto format
g.autoformat = false

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
g.snacks_animate = false

-- if the completion engine supports the AI source,
-- use that instead of inline suggestions
g.ai_cmp = true

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
g.root_spec = { ".git", "lsp", "cwd" }
-- }}}

-- Options {{{

local opt = vim.opt -- set options

-- Relative line numbers
opt.relativenumber = false
-- Disable mouse
opt.mouse = ""
-- Remove LazyVim default margined gutter
opt.statuscolumn = ""
-- Guicursor
opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor50"

-- tabs, spaces
opt.expandtab = true -- convert tabs to spaces
opt.tabstop = 4 -- insert 4 spaces for a tab
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
opt.softtabstop = 4 -- how many columns (=spaces) the cursor moves right when you press <Tab>

-- folding
-- Alternative
-- opt.foldenable = false -- disable folding on open
-- opt.foldmethod = "expr" -- folding set to "expr" for treesitter based folding
-- opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding

-- git diff
opt.diffopt:append({ "vertical" }) -- internal, filler, closeoff, vertical
-- opt.fillchars = opt.fillchars + 'diff: ' -- alternatives: ─ ⣿ ░

-- listchars
opt.list = false -- Hide invisible characters by default
opt.listchars = { eol = "§", tab = "¤›", extends = "»", precedes = "«", nbsp = "‡", trail = "-", space = "␣" }
-- Default: eol:§,tab:¤›,extends:»,precedes:«,nbsp:‡,trail:-,space:␣"
-- Alt1:    eol:$,extends:»,precedes:«,nbsp:‡,space:␣
-- Alt2:    eol:¬,,tab:»/,extends:»,precedes:«,nbsp:‡
-- }}}

-- Languages {{{1

-- Python {{{2

-- LSP Server to use for Python.
g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
-- vim.g.lazyvim_python_ruff = "ruff"
-- }}}2
-- }}}1
