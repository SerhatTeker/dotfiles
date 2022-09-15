local bufferline = lvim.builtin.bufferline

bufferline.options = {
    buffer_close_icon = "",
    close_icon = "",
    -- Indicator
    -- U+2589 ▐ Right half block, this character is right aligned so the
    -- background highlight doesn't appear in the middle
    -- alternatives:  right aligned => ▕ ▐ ,  left aligned => ▍
    -- icon = "▐ ",
    -- icon = "▍",
    -- icon = "▎",
    -- icon = "▕ ▐ ",
    indicator = {
        style = "icon",
        icon = "",
        -- icon = "▐ ",
        -- icon = "▍",
        -- icon = "▎",
        -- icon = "▕ ▐ ",
    },
}

bufferline.highlights = {
    background = {
        italic = true,
    },
    buffer_selected = {
        bold = true,
    },
}
