-- # Colorschemes

-- Define colorscheme if you don't want to use global theme
local background = nil
local colorscheme = nil

-- Defaults
-- local background = "dark"
-- local colorscheme = "neodarker"

-- Colorscheme options
-- local colorscheme = "neodarker" -- default
-- local colorscheme = "onedark"
-- local colorscheme = "gruvbox-material"
-- local colorscheme = "vscode"
-- local colorscheme = "tokyonight"

-- ## Neodarker {{{

-- require("neodarker").setup()
-- vim.cmd [[colorscheme neodarker]]
-- vim.colorscheme = "neodarker"
-- lvim.builtin.lualine.options.theme = "onedark"

local function init_neodarker()
    require("neodarker").setup()
    -- lvim.builtin.lualine.options.theme = "neodarker"
    lvim.builtin.lualine.options.theme = "auto"
end

-- }}}

-- ## Onedark {{{

local function init_onedark()
    require('onedark').setup {
        style = "darker"
    }
    require("onedark").load()
    -- lvim.builtin.lualine.options.theme = "onedark"
    lvim.builtin.lualine.options.theme = "auto"
end

-- }}}

-- ## Gruvbox {{{

-- lvim.colorscheme = "gruvbox"
-- }}}

-- ## Gruvbox Material {{{

local function init_gruvbox_material()
    -- INFO: the configuration options should be placed before `colorscheme gruvbox-material`
    -- hard | medium | soft
    vim.api.nvim_set_var("gruvbox_material_background", "hard")
    -- material | mix | original
    vim.api.nvim_set_var("gruvbox_material_foreground", "original")

    lvim.colorscheme = "gruvbox-material"
end

-- }}}

-- ## Vscode {{{

-- Switching theme
-- :lua require('vscode').change_style("light")
-- :lua require('vscode').change_style("dark")

local function init_vscode()
    vim.g.vscode_style = "dark"
end

-- }}}

-- ChangeBackground() {{{

local function init_colorscheme(cs, bg)
    vim.opt_global.background = bg
    lvim.colorscheme = cs

    if cs == "onedark" then
        init_onedark()
    elseif cs == "gruvbox-material" then
        init_gruvbox_material()
    elseif cs == "vscode" then
        init_vscode()
    else
        init_neodarker()
    end
end

function ChangeBackground()
    if vim.fn.has("unix") == 1 then
        -- default colorscheme and background
        -- local colorscheme = "neodarker"
        -- local background = "dark"
        if colorscheme ~= nil and background ~= nil then
            init_colorscheme(colorscheme, background)
        else

            -- TODO: Use func global colorscheme, background
            if vim.fn.has("mac") == 1 then
                local theme = vim.fn.system("defaults read -g AppleInterfaceStyle")
                if string.find(theme, "Dark") then -- ^Dark
                    init_colorscheme("neodarker", "dark")
                else
                    init_colorscheme("onedark", "light")
                end
            else
                local theme = vim.fn.system("gsettings get org.gnome.desktop.interface gtk-theme")
                -- if theme == "Yaru-light" then -- Not working
                if string.find(theme, "light") then -- Yaru-light
                    init_colorscheme("onedark", "light")
                else
                    init_colorscheme("neodarker", "dark")
                end
            end
        end
    end
end

-- }}}

-- init {{{

-- TODO: Use global M = {}
--  initiate in the beginning
ChangeBackground()

-- Add custom command for ChangeBackground()
vim.api.nvim_create_user_command("AdaptGlobalTheme", ChangeBackground, { force = true })

vim.api.nvim_create_autocmd("Signal SIGUSR1", {
    pattern = "*",
    -- callback = ChangeBackground,
    command = "AdaptGlobalTheme",
})

-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
-- }}}
-- queries/python/highlights.scm
