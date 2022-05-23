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
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {''},
    lualine_z = {'location'}
}
