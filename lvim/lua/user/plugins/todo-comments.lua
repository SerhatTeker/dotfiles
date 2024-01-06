require("todo-comments").setup({
    keywords = {
        -- # Defaults
        -- TODO = { icon = " ", color = "info" },
        -- WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        -- PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        -- NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        -- # Custom
        HACK = { icon = " ", color = "warning", alt = { "DEBUG" } },
        TEST = {
            icon = " ",
            color = "warning",
            alt = { "TESTING", "PASSED", "FAILED" }
        },
    }
})
