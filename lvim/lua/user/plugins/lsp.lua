-- LSP settings

-- generic LSP settings {{{


-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
    -- "sumeko_lua",
    -- "jsonls",
    -- "marksman",
}
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)
-- require("lvim.lsp.manager").setup "marksman"

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- }}}

-- Show line diagnostics only for line during CursorHold
-- https://github.com/LunarVim/LunarVim/issues/1712
lvim.lsp.diagnostics.virtual_text = false
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    command = "lua vim.diagnostic.open_float(0,{scope='line'})",
})

-- Mappings
lvim.lsp.buffer_mappings.normal_mode["<leader>rn"] = { vim.lsp.buf.rename, "Rename" }

-- Null-ls {{{


-- Format files on save
-- lvim.format_on_save = false
lvim.format_on_save = {
    pattern = {
        -- "*.go",
        "*.js",
        "*.jsx",
        "*.lua",
        "*.sh",
        "*.vim",
        "*.tf",
    },
}

-- Formatters {{{

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
-- default linelength
local line_length = "99"

formatters.setup {
    { command = "isort", filetypes = { "python" } },
    {
        command = "black",
        filetypes = { "python" },
        extra_args = { "--line-length", line_length },
    },
    {
        -- each formatter accepts a list of options identical to
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
        command = "prettier",
        ---@usage arguments to pass to the formatter these cannot contain
        --whitespaces, options such as `--line-width 80` become either
        --`{'--line-width', '80'}` or `{'--line-width=80'}` extra_args = {
        --"--print-with", "100" }, -@usage specify which filetypes to enable.
        --By default a providers will attach to all the filetypes it supports.
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    },
    -- { command = "gofmt", filetypes = { "go" } },
    { command = "shfmt", filetypes = { "sh" } },
    { command = "terraform_fmt", filetypes = { "terraform", "tf" } },
}
-- ]}}

-- Additional linters {{[

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {
        command = "flake8",
        filetypes = { "python" },
        extra_args = { "--max-line-length", line_length },
    },
    {
        -- each linter accepts a list of options identical to
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
        command = "shellcheck",
        ---@usage arguments to pass to the formatter these cannot contain
        --whitespaces, options such as `--line-width 80` become either
        --`{'--line-width', '80'}` or `{'--line-width=80'}`
        extra_args = { "--severity", "warning" },
    },
    {
        command = "codespell",
        ---@usage specify which filetypes to enable. By default a providers
        --will attach to all the filetypes it supports.
        filetypes = { "javascript", "python" },
    },
}
-- ]}}
-- }}}
