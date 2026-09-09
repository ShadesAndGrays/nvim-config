
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("lua", {
    s("hello", { 
        t('print("Hello '),
        i(1),
        t(' World!")')
    })
})

ls.add_snippets("lua",{

    s("if", {
        t('if '),
        i(1, "false"),
        t(' then '),
        i(2),
        t(' end')

    }),

    s("<", fmt(
        [[
        <{}>
        {}
        </{}>
        ]] , {
            i(1), i(0),rep(1)
        }))

    })
