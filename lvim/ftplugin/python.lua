-- # dap install
-- https://www.lunarvim.org/languages/python.html#debugger
-- local dap_install = require("dap-install")
-- dap_install.config("python", {})


-- # dap
local dap = require("dap")

-- ## dap adapter
dap.adapters.python = {
    type = "executable";
    -- command = "path/to/virtualenvs/debugpy/bin/python";
    command = "python3";
    args = { "-m", "debugpy.adapter" };
}

-- ## dap configuration

-- -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
-- -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
-- -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
-- -- implemented in get_venv_bin()
-- local function python_path_default()
--     local cwd = vim.fn.getcwd()

--     if vim.fn.executable(cwd .. "/.venv/bin/python3") == 1 then
--         return cwd .. "/.venv/bin/python3"
--     elseif vim.fn.executable(cwd .. "/venv/bin/python3") == 1 then
--         return cwd .. "/venv/bin/python3"
--     else
--         return "/usr/bin/python3"
--     end
-- end

-- Get venv bin if inside venv
local function get_venv_bin()
    -- local cwd = vim.fn.getcwd()
    local venv = os.getenv("VIRTUAL_ENV")
    local venv_bin = string.format("%s/bin/python3", venv)

    if venv ~= nil then
        print(string.format("~= venv_bin: %s", venv_bin))
        return venv_bin
    else
        print("/usr/bin/python3")
        return "/usr/bin/python3"
    end

end

dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        name = "Launch File",
        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = "launch",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
        program = "${file}", -- This configuration will launch the current file if used.
        -- pythonPath = python_path_default();
        pythonPath = get_venv_bin,
    },
    {
        name = "Python Attach",
        type = "python",
        request = "attach",
        connect = {
            host = "127.0.0.1",
            port = 5678,
        },
    },
    -- https://neovim.discourse.group/t/debugpy-nvim-dap-in-a-docker-container-help-getting-this-to-work/501/7
    {
        name = "Generic Remote",
        type = "generic_remote",
        request = "attach",
        pathMappings = { {
            -- Update this as needed
            localRoot = vim.fn.getcwd();
            remoteRoot = "/";
        } };
    },
    {
        name = "Django Launch",
        type = "python",
        request = "launch",
        program = vim.fn.getcwd() .. "/manage.py",
        args = { "runserver", "8000", "--noreload" },
    },
}

-- # dapui

local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
    dap.repl.close() -- close repl buffer as well
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
    dap.repl.close() -- close repl buffer as well
end
