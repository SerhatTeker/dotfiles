-- local os_home = vim.fn.expand("$HOME")
local _model = "gpt-4"
require("chatgpt").setup({
    api_key_cmd = 0,
    openai_params = {
        -- model = "gpt-3.5-turbo",
        model = _model,
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 3000,
        temperature = 0,
        top_p = 1,
        n = 1,
    },
    openai_edit_params = {
        model = _model,
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
    },
})
