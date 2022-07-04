local M = {}

function M.load_options(options)
    for k, v in pairs(options) do
        vim.opt[k] = v
    end
end

function M.open_uri(uri)
    vim.notify("opening: " .. uri, vim.log.levels.INFO)
    local task = {
        command = "xdg-open",
        args = { uri },
    }
    local Job = require "plenary.job"
    Job:new(task):start()
end

function M.xdg_open_handler()
    if vim.fn.executable "xdg-open" ~= 1 then
        vim.notify("xdg-open was not found", vim.log.levels.WARN)
        return
    end

    -- INFO: NW: getting comment char(s) as well
    -- local ts_utils = require "nvim-treesitter.ts_utils"
    -- local node = ts_utils.get_node_at_cursor()
    -- local uri = vim.treesitter.query.get_node_text(node, 0)
    -- DEBUG: lua print("uri:" .. vim.treesitter.query.get_node_text(require("nvim-treesitter.ts_utils").get_node_at_cursor(),0))

    local cword = vim.fn.expand("<cWORD>")

    M.open_uri(cword)
end

return M
