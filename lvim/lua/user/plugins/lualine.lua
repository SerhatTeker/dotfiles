lvim.builtin.lualine = {
  style = "default",
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    -- lightline-like
    -- component_separators = { left = '|', right = '|'},
    -- section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {''},
    lualine_z = {'location'}
  }
}
