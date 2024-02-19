-- How to include environmet variable into snippets
-- https://github.com/L3MON4D3/LuaSnip/issues/476
local ls = require("luasnip")

-- then you can use  $SYS_HOME which was eagerly initialized but also $SYS_USER (or any other system environment var) in your snippets
ls.env_namespace("SYS", { vars = os.getenv, eager = { "HOME" } })
