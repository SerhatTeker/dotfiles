-- # Colorschemes

local M = {}

function M.init_gruvbox()
    lvim.colorscheme = "gruvbox"
end

function M.init_neodarker()
    lvim.colorscheme = "neodarker"
end

function M.init_onedark()
    lvim.colorscheme = "onedark"
    require("onedark").setup {
        style = "darker"
    }
    require("onedark").load()
end

function M.change_background()
    if vim.fn.has("unix") ~= 1 then
        vim.notify("OS should bu UNIX", vim.log.levels.ERROR, { title = "OS Type Error" })
        return false
    end

    -- default background
    local bg = "Dark"

    -- MacOS
    if vim.fn.has("mac") == 1 then
        local theme = vim.fn.system("defaults read -g AppleInterfaceStyle")
        if string.find(theme, "Dark") == nil then -- ^Dark
            bg = "Light"
        end
    -- Linux
    else
        local theme = vim.fn.system("gsettings get org.gnome.desktop.interface gtk-theme")
        if string.find(theme, "light") then -- Yaru-light
            bg = "Light"
        end
    end

    if bg == "Dark" then
        vim.o.background = "dark"
    else
        vim.o.background = "light"
    end
end
-- }}}

function M.setup()
    M.init_gruvbox()
    -- M.init_neodarker()
    -- M.init_onedark()

    --  initiate in the beginning
    M.change_background()

    -- Add custom command for ChangeBackground()
    vim.api.nvim_create_user_command("AdaptGlobalTheme", M.change_background, { force = true })

    -- FIXME: - < Invalid "event": "Signal SIGUSR! >
    -- vim.api.nvim_create_autocmd("Signal SIGUSR1", {
    --     pattern = "*",
    --     callback = M.change_background,
    --     -- command = "AdaptGlobalTheme",
    -- })
end

return M
