local ls  = require("luasnip")
local s   = ls.snippet
local t   = ls.text_node
local i   = ls.insert_node
local c   = ls.choice_node
local f   = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- NOTE: fmt() uses { } for its own placeholders, so literal C++ braces have to
-- be doubled:  {{ -> {   and   }} -> }
return {
    -- ===== Preprocessor =====
    s("once", { t("#pragma once") }),

    s("inc", fmt("#include <{header}>", { header = i(1, "vector") })),

    s("incq", fmt('#include "{header}"', { header = i(1, "my_header.hpp") })),

    -- Include guard built from the current file name
    s("guard", fmt([[
#ifndef {name}
#define {name}

{body}

#endif  // {name}
]], {
        name = f(function()
            return (vim.fn.expand("%:t:r"):gsub("%W", "_")):upper()
        end),
        body = i(1, ""),
    })),

    -- ===== Structure =====
    s("main", fmt([[
int main(int argc, char** argv)
{{
    {body}
}}
]], {
        body = i(1, "return 0;"),
    })),

    -- name2 = rep(1) mirrors whatever you type at tabstop 1
    s("ns", fmt([[
namespace {name} {{
{body}
}}  // namespace {name2}
]], {
        name = i(1, "myns"),
        name2 = rep(1),
        body = i(2, ""),
    })),

    s("cls", {
        t("class "), i(1, "MyClass"), t({ "", "{", "public:", "    " }),
        rep(1), t("() = default;"),
        t({ "", "    ~" }), rep(1), t("() = default;"),
        t({ "", "", "private:", "    " }), i(2, ""),
        t({ "", "};" }),
    }),

    s("strct", fmt([[
struct {name}
{{
    {body}
}};
]], {
        name = i(1, "MyStruct"),
        body = i(2, ""),
    })),

    s("enum", fmt([[
enum class {name} {{
    {value},
}};
]], {
        name = i(1, "MyEnum"),
        value = i(2, "Value0"),
    })),

    s("alias", fmt("using {name} = {type};", {
        name = i(1, "Alias"),
        type = i(2, "int"),
    })),

    s("fn", fmt([[
{ret} {name}({args})
{{
    {body}
}}
]], {
        ret = i(1, "void"),
        name = i(2, "foo"),
        args = i(3, ""),
        body = i(4, ""),
    })),

    s("tmpl", fmt([[
template <{params}>
{ret} {name}({args}) {{
    {body}
}}
]], {
        params = i(1, "typename T"),
        ret = i(2, "void"),
        name = i(3, "foo"),
        args = i(4, "T value"),
        body = i(5, ""),
    })),

    s("cast", fmt("{cast}<{type}>({expr})", {
        cast = c(1, {
            t("static_cast"),
            t("dynamic_cast"),
            t("reinterpret_cast"),
            t("const_cast"),
        }),
        type = i(2, "int"),
        expr = i(3, "value"),
    })),

    -- ===== Control flow =====
    s("if", fmt([[
if ({cond}) {{
    {body}
}}
]], {
        cond = i(1, ""),
        body = i(2, ""),
    })),

    s("for", fmt([[
for (int i = 0; i < {n}; ++i) {{
    {body}
}}
]], {
        n = i(1, "n"),
        body = i(2, ""),
    })),

    s("forr", fmt([[
for (const auto& {item} : {range}) {{
    {body}
}}
]], {
        item = i(1, "item"),
        range = i(2, "container"),
        body = i(3, ""),
    })),

    s("while", fmt([[
while ({cond}) {{
    {body}
}}
]], {
        cond = i(1, "true"),
        body = i(2, ""),
    })),

    s("switch", fmt([[
switch ({expr}) {{
    case {value}:
        {body}
        break;
    default:
        break;
}}
]], {
        expr = i(1, "x"),
        value = i(2, "0"),
        body = i(3, ""),
    })),

    s("try", fmt([[
try {{
    {body}
}} catch (const std::exception& e) {{
    {handler}
}}
]], {
        body = i(1, ""),
        handler = i(2, "std::cerr << e.what() << '\\n';"),
    })),

    s("lambda", fmt([[
[{capture}]({params}) {{
    {body}
}}
]], {
        capture = i(1, "&"),
        params = i(2, ""),
        body = i(3, ""),
    })),

    -- ===== Standard library =====
    s("std", { t("std::") }),

    s("cout", fmt("std::cout << {expr} << std::endl;", {
        expr = i(1, '"hello"'),
    })),

    s("print", fmt([[std::println("{msg} {{}}", {val});]], {
        msg = i(1, "hello"),
        val = i(2, '"world"'),
    })),

    s("vec", fmt("std::vector<{type}> {name};", {
        type = i(1, "int"),
        name = i(2, "v"),
    })),

    s("uniq", fmt("std::unique_ptr<{type}> {name};", {
        type = i(1, "T"),
        name = i(2, "p"),
    })),

    s("shared", fmt("std::shared_ptr<{type}> {name};", {
        type = i(1, "T"),
        name = i(2, "p"),
    }))
}
