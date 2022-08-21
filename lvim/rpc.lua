-- local chan_id = vim.fn.sockconnect("pipe", "/tmp/nvim.pipe", { rpc = true })
-- vim.rpcrequest(chan_id, "nvim_exec_lua", [[print("hello")]], {})
-- vim.fn.chanclose(chan_id)

local function rpc_nvim_exec_lua()
    local success, errmsg = pcall(function()
        local chan_id = vim.fn.sockconnect("pipe", "/tmp/nvim.pipe", { rpc = true })
        -- vim.rpcrequest(chan_id, "nvim_exec_lua", [[print("salla")]], {})
        vim.rpcrequest(chan_id, "nvim_command", [[Sync]])

        vim.rpcrequest(chan_id, "nvim_command", [["PackerSnapshot default.json]])
        vim.fn.chanclose(chan_id)
    end)
    if not success then
        io.write("NVIM-FZF LUA ERROR\n\n" .. errmsg .. "\n")
    end
    vim.cmd [[qall]]
end

rpc_nvim_exec_lua()
