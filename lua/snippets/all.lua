local ls  = require("luasnip")
local s   = ls.snippet
local i   = ls.insert_node
local f   = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s("sig", fmt("{name} <{email}>", {
        name = i(1, "Your Name"),
        email = i(2, "you@example.com"),
    })),

    s("today", {
        f(function() return os.date("%A, %d %B, %Y. %I:%M %p") end),
    }),


    s("date", {
        f(function() return os.date("%Y-%m-%d") end),
    }),

    s("time", {
        f(function() return os.date("%H:%M") end),
    }),

    s("now", fmt("{d} {t}", {
        d = f(function() return os.date("%Y-%m-%d") end),
        t = f(function() return os.date("%H:%M") end),
    })),


    s("todo", fmt("TODO: {what}", {
        what = i(1, "What needs doing")
    }))

}
