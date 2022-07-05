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
-- }}}

-- # Custom {{{

-- ## Commands {{{

-- Shortcuts for qa
vim.api.nvim_create_user_command("Q", "qa", { force = true })
vim.api.nvim_create_user_command("WQ", "wqa", { force = true })
-- }}}

-- ## Keymappings {{{

local utils = require("user.utils")
local map = utils.map
local map_cmd = utils.map_cmd

-- one key stroke less
-- lvim.keys.normal_mode[";"] = ":"
vim.keymap.set("n", ";", ":")

-- quit
map("n", "Q", "<cmd>x<CR>")

-- Buffers
vim.api.nvim_create_user_command("BufCurOnly", "%bdelete|edit#|bdelete#", { force = true })
map_cmd("<S-n>", "bn")
map_cmd("<S-m>", "bp")
map_cmd("<C-b>d", "BufferKill")
map_cmd("<C-b>c", "BufCurOnly")

-- Tab
map_cmd("[t", "tabnext")
map_cmd("]t", "tabprevious")

-- " noh - no highlight with Esc
-- vim.keymap.set("n", "<esc>", ":noh <CR>")
map_cmd("<Esc", "noh", { expr = false, noremap = false })

-- Fold
map_cmd("<F3>", "set foldmethod=marker")

-- Fix gx
-- map("n", "gx", "[[<Cmd>lua require('user.utils').xdg_open_handler()<CR>]]", { desc = "xdg open" })
map("n", "gx", "", {
    silent = false,
    callback = function()
        require("user.utils").xdg_open_handler()
    end,
    desc = "xdg open"
})

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
