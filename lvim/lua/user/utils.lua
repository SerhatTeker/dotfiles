local M = {}

function M.load_options(options)
    for k, v in pairs(options) do
        vim.opt[k] = v
    end
end

return M
