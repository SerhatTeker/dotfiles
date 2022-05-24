local ll = lvim.builtin.lualine

ll.style = "default"
ll.options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    -- lightline-like
    -- component_separators = { left = '|', right = '|'},
    -- section_separators = { left = '', right = ''},
}
ll.sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { "filename" },
    -- lualine_c = { "%f" }, -- relative full filename
    lualine_x = { "diagnostics" },
    lualine_y = { "encoding", "fileformat", "filetype" },
    lualine_z = { "location" }
}
