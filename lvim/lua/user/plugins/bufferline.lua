local bl = lvim.builtin.bufferline

bl.options = {
    -- Indicator
    -- U+2589 ▐ Right half block, this character is right aligned so the
    -- background highlight doesn't appear in the middle
    -- alternatives:  right aligned => ▕ ▐ ,  left aligned => ▍
    -- indicator_icon = "▐ ",
    -- indicator_icon = "▕ ▐ ",
    -- indicator_icon = "▍",
    -- indicator_icon = "▎",
    indicator_icon = "",
    buffer_close_icon = "",
    close_icon = "",
}

bl.highlights = {
    background = {
        gui = "italic",
    },
    buffer_selected = {
        gui = "bold",
    },
    tab_selected = {
        guifg = {
            attribute = "fg",
            -- highlight = "Pmenu"
            highlight = "BufferLineBufferSelected"
        },
        gui = "bold",
    },
}
