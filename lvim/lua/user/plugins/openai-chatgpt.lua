-- https://platform.openai.com/docs/models/gpt-4-and-gpt-4-turbo
local gpt_35 = "gpt-3.5-turbo"
local gpt_4 = "gpt-4"
local gpt_4_turbo = "gpt-4-1106-preview"
local use_model = gpt_4

local os_home = vim.fn.expand("$HOME")

require("chatgpt").setup({
    -- https://github.com/jackMort/ChatGPT.nvim?tab=readme-ov-file#installation
    -- using $OPENAI_API_KEY env var

    -- Additional custom actions
    -- https://github.com/jackMort/ChatGPT.nvim/issues/168
    -- actions_paths = { "~/.config/lvim/openai/custom-actions.json" },
    -- actions_paths = { openai_actions_paths },
    actions_paths = { os_home .. "/dotfiles/lvim/openai/custom-actions.json" },

    openai_params = {
        -- model = "gpt-3.5-turbo",
        model = use_model,
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 3000,
        temperature = 0,
        top_p = 1,
        n = 1,
    },
    openai_edit_params = {
        model = use_model,
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
    },
})
