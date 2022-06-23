-- # Core {{{


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","
vim.g.mapleader = ","
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
-- }}}

-- # Lvim {{{

-- use the default vim behavior for H and L
lvim.keys.normal_mode["<S-l>"] = false
lvim.keys.normal_mode["<S-h>"] = false

-- Buffers
-- command
vim.api.nvim_create_user_command("BufCurOnly", "%bdelete|edit#|bdelete#", { force = true })
-- mappings
lvim.keys.normal_mode["<S-n>"] = ":bn<CR>"
lvim.keys.normal_mode["<S-m>"] = ":bp<CR>"
lvim.keys.normal_mode["<C-b>d"] = ":BufferKill<CR>"
lvim.keys.normal_mode["<C-b>c"] = ":BufCurOnly<CR>"
-- lvim.keys.normal_mode["<C-b>c"] = ":BufferCloseAllButCurrent<CR>"
-- }}}

-- # Custom {{{

-- ## Commands {{{

-- Shortcuts for qa
vim.api.nvim_create_user_command("Q", "qa", { force = true })
vim.api.nvim_create_user_command("WQ", "wqa", { force = true })

-- Functional wrapper for mapping custom keybindings
-- * mode (as in Vim modes like Normal/Insert mode)
-- * lhs (the custom keybinds you need)
-- * rhs (the commands or existing keybinds to customise)
-- * opts (additional options like <silent>/<noremap>, see :h map-arguments for more info on it)
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- }}}

-- ## Keymappings {{{


-- one key stroke less
-- lvim.keys.normal_mode[";"] = ":"
vim.keymap.set("n", ";", ":")

-- " noh - no highlight with Esc
-- vim.keymap.set("n", "<esc>", ":noh <CR>")
map("n", "<Esc>", "<CMD>noh<CR>", { expr = false, noremap = false })

-- Fold
map("n", "<F3>", "<CMD>set foldmethod=marker<CR>", { silent = false })

-- Packer
-- map("n", "<F12>", "<CMD>PackerCompile<CR>", { silent = false })
map("n", "<F12>", "", {
    silent = false,
    noremap = true,
    callback = function()
        print(":PackerInstall && :PackerCompile")
        require("packer").install()
        require("packer").compile("profile=true")
    end,
    -- Since Lua function don't have a useful string representation, use the
    -- "desc" option to document your mapping. Showing on telescope as well.
    desc = "Runs :PackerInstall and :PackerCompile",
})
-- }}}
-- }}}
