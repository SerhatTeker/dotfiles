-- # Colorschemes

local M = {}

-- Colorschemes  {{{

-- ## Neodarker
function M.init_neodarker()
    require("neodarker").setup()
    -- lvim.builtin.lualine.options.theme = "neodarker"
    lvim.builtin.lualine.options.theme = "auto"
end

-- ## Onedark
function M.init_onedark()
    require('onedark').setup {
        style = "darker"
    }
    require("onedark").load()
    -- lvim.builtin.lualine.options.theme = "onedark"
    lvim.builtin.lualine.options.theme = "auto"
end

-- ## Gruvbox Material
function M.init_gruvbox_material()
    -- INFO: the configuration options should be placed before `colorscheme gruvbox-material`
    -- hard | medium | soft
    vim.api.nvim_set_var("gruvbox_material_background", "hard")
    -- material | mix | original
    vim.api.nvim_set_var("gruvbox_material_foreground", "original")

    lvim.colorscheme = "gruvbox-material"
end

-- ## Vscode
function M.init_vscode()
    -- Switching theme
    -- :lua require('vscode').change_style("light")
    -- :lua require('vscode').change_style("dark")

    vim.g.vscode_style = "dark"
end

-- }}}

-- ChangeBackground() {{{

local function init_colorscheme(cs, bg)
    vim.opt_global.background = bg
    lvim.colorscheme = cs

    if cs == "onedark" then
        M.init_onedark()
    elseif cs == "gruvbox-material" then
        M.init_gruvbox_material()
    elseif cs == "vscode" then
        M.init_vscode()
    else
        M.init_neodarker()
    end
end

-- Global custom default colorscheme and background
local background = nil -- light | dark
local colorscheme = nil -- neodarker | onedark | gruvbox-material | vscode | tokyonight

function M.ChangeBackground()
    if vim.fn.has("unix") ~= 1 then
        vim.notify("OS should bu UNIX", vim.log.levels.ERROR, { title = "OS Type Error" })
        return false
    end

    -- Global custom default colorscheme and background from local
    if colorscheme ~= nil and background ~= nil then
        init_colorscheme(colorscheme, background)
        return true
    end

    -- default colorscheme and background
    local cs, bg = "neodarker", "dark"

    if vim.fn.has("mac") == 1 then
        local theme = vim.fn.system("defaults read -g AppleInterfaceStyle")
        if string.find(theme, "Dark") == nil then -- ^Dark
            cs, bg = "onedark", "light"
        end
    else
        local theme = vim.fn.system("gsettings get org.gnome.desktop.interface gtk-theme")
        if string.find(theme, "light") then -- Yaru-light
            cs, bg = "onedark", "light"
        end
    end

    init_colorscheme(cs, bg)
end

-- }}}

function M.setup()
    --  initiate in the beginning
    M.ChangeBackground()

    -- Add custom command for ChangeBackground()
    vim.api.nvim_create_user_command("AdaptGlobalTheme", M.ChangeBackground, { force = true })

    vim.api.nvim_create_autocmd("Signal SIGUSR1", {
        pattern = "*",
        callback = M.ChangeBackground,
        -- command = "AdaptGlobalTheme",
    })

end

return M
