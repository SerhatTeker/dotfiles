-- Alpha Dashboard
-- INFO: Disabled in plugs.lua
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.alpha.dashboard.section.buttons.entries = {
    { "SPC c", "  Current Session", "<CMD>lua require('persistence').load()<CR>" },
    { "SPC f", "  Find File", "<CMD>Telescope find_files<CR>" },
    { "SPC n", "  New File", "<CMD>ene!<CR>" },
    { "SPC P", "  Recent Projects ", "<CMD>Telescope projects<CR>" },
    { "SPC s r", "  Recently Used Files", "<CMD>Telescope oldfiles<CR>" },
    { "SPC s t", "  Find Word", "<CMD>Telescope live_grep<CR>" },
    {
        "SPC L c",
        "  Configuration",
        "<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>",
    },
}
