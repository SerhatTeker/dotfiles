local M = {}

function M.load_options(options)
    for k, v in pairs(options) do
        vim.opt[k] = v
    end
end

-- Uri - XDG_OPEN {{{

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

    -- HACK: NW: getting comment char(s) as well
    -- local ts_utils = require "nvim-treesitter.ts_utils"
    -- local node = ts_utils.get_node_at_cursor()
    -- local uri = vim.treesitter.query.get_node_text(node, 0)
    -- DEBUG: lua print("uri:" .. vim.treesitter.query.get_node_text(require("nvim-treesitter.ts_utils").get_node_at_cursor(),0))

    local cword = vim.fn.expand("<cWORD>")

    M.open_uri(cword)
end

-- }}}

-- Mapping {{{

M.map_opts = { silent = true, noremap = true }

-- Functional wrapper for mapping custom keybindings
-- * mode (as in Vim modes like Normal/Insert mode)
-- * lhs (the custom keybinds you need)
-- * rhs (the commands or existing keybinds to customise)
-- * opts (additional options like <silent>/<noremap>, see :h map-arguments for more info on it)
function M.map(mode, lhs, rhs, opts)
    -- local options = { noremap = true }
    local options = M.map_opts
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Turn command/function to cmd string
function M.cmd(rhs)
    -- Turn command/function to cmd string
    -- return "<Cmd>" .. rhs .. "<CR>"
    return string.format("<Cmd>%s<CR>", rhs)
end

-- Map a cmd to key
function M.map_cmd(lhs, rhs, opts)
    local right_side = M.cmd(rhs)
    M.map("n", lhs, right_side, opts)
end

-- Turn command/function to lua cmd string
function M.cmd_lua(rhs)
    -- return "<Cmd>" .. rhs .. "<CR>"
    return string.format("[[%s]]", M.cmd(rhs))
end

-- Map a lua cmd to key
function M.map_cmd_lua(lhs, rhs, opts)
    local right_side = M.cmd_lua(rhs)
    M.map("n", lhs, right_side, opts)
end

-- }}}

return M
