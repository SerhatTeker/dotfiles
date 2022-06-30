-- # Colorschemes

-- Options
-- lvim.colorscheme = "neodarker" -- default
-- lvim.colorscheme = "onedark"
-- lvim.colorscheme = "gruvbox-material"
-- lvim.colorscheme = "vscode"
-- lvim.colorscheme = "tokyonight"

-- ## Neodarker {{{

-- require("neodarker").setup()
-- vim.cmd [[colorscheme neodarker]]
-- vim.colorscheme = "neodarker"
-- lvim.builtin.lualine.options.theme = "onedark"
-- }}}

-- ## Onedark {{{

local function init_onedark()
    require('onedark').setup {
        style = "darker"
    }
    require("onedark").load()
    lvim.builtin.lualine.options.theme = "onedark"
end

-- }}}

-- ## Gruvbox {{{

-- lvim.colorscheme = "gruvbox"
-- }}}

-- ## Gruvbox Material {{{

-- NOTE: the configuration options should be placed before `colorscheme gruvbox-material`
local function init_gruvbox_material()
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

-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- functions - changeBackground() {{{
local function init_colorscheme(colorscheme, background)
    print(string.format("colorscheme: %s", colorscheme))
    print(string.format("background: %s", background))

    vim.opt_global.background = background
    lvim.colorscheme = colorscheme

    if lvim.colorscheme == "onedark" then
        init_onedark()
    elseif lvim.colorscheme == "gruvbox" then
        init_gruvbox_material()
    elseif lvim.colorscheme == "vscode" then
        init_vscode()
    end
end

local function changeBackground()
    if vim.fn.has("unix") == 1 then
        -- default colorscheme and background
        -- local colorscheme = "neodarker"
        -- local background = "dark"

        -- TODO: Use func global colorscheme, background
        if vim.fn.has("mac") == 1 then
            local theme = vim.fn.system("defaults read -g AppleInterfaceStyle")
            if string.find(theme, "light") then -- Yaru-light
                init_colorscheme("onedark", "light")
            else
                init_colorscheme("neodarker", "dark")
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

changeBackground()

-- vim.api.nvim_create_autocmd("VimEnter", {
--     pattern = "*",
--     callback = changeBackground,
-- })
-- }}}
