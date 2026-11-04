local ls  = require("luasnip")
local s   = ls.snippet
local t   = ls.text_node
local i   = ls.insert_node
local f   = ls.function_node
local c   = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s("min", fmt("cmake_minimum_required(VERSION {ver})", {
        ver = i(1, "3.28"),
    })),
    s("proj", fmt([[
project({name}
    VERSION {ver}
    LANGUAGES {langs}
)]], {
        name = i(1, "MyProject"),
        ver = i(2, "0.0.0"),
        langs = c(3, {
            t("CXX"),
            t("C"),
            t("C CXX"),
        }),

    })),

    s("exe", {
        t("add_executable("),
        i(1, "main"),
        t(" "),
        c(2, {
            t("main.cpp"),
            t("src/main.cpp"),
        }),
        t(")"),
    }),

    s("lib", {
        t("add_library("),
        i(1, "mylib"),
        t(" "),
        c(2, {
            t("STATIC"),
            t("SHARED"),
            t("INTERFACE"),
        }),
        t(" "),
        i(3, "src/lib.cpp"),
        t(")"),
    }),

    s("set", fmt("set({var} {val})", {
        var = i(1, "VARIABLE"),
        val = i(2, "VALUE")

    })),

    s("msg", fmt("message({lvl} {txt})", {
        lvl = c(1, {
            t("STATUS")
        }),
        txt = i(2, "Hello from cmake")
    })),

    s("tinc", {
        t("target_include_directories("),
        i(1, "${TARGET}"),
        t(" "),
        c(2, {
            t("PUBLIC"),
            t("PRIVATE"),
        }),
        t(" "),
        i(3, "include/"),
        t(")"),

    }),

    s("tlinkdir", {
        t("target_link_directories("),
        i(1, "${TARGET}"),
        t(" "),
        c(2, {
            t("PUBLIC"),
            t("PRIVATE"),
        }),
        t(" "),
        c(3, {
            t("vendor/"),
            t("external/"),
        }),
        t(")"),

    }),

    s("tlinklib", {
        t("target_link_libraries("),
        i(1, "${TARGET}"),
        t(" "),
        c(2, {
            t("PUBLIC"),
            t("PRIVATE"),
        }),
        t(" "),
        i(3, "mylib"),
        t(")"),

    }),

    s("std", fmt([[
        set(CMAKE_CXX_STANDARD {standard})
        set(CMAKE_CXX_STANDARD_REQUIRED {required})
        set(CMAKE_CXX_EXTENSIONS {ext})
        set(CMAKE_EXPORT_COMPILE_COMMANDS {export})
        set(CMAKE_CXX_SCAN_FOR_MODULES {mod})
    ]], {
        standard = i(1, "23"),
        required = i(2, "ON"),
        ext = i(3, "OFF"),
        export = i(4, "ON"),
        mod = i(5, "OFF"),

    })),

    s("sub", {
        t("add_subdirectory("),
        i(1, "path/to/directory"),
        t(")"),
    }),


    s("file", {

        t("file("),
        c(1, {
            t("GLOB"),
            t("GLOB_RECURSE"),
        }),
        t(" "),
        i(2, "SRC"),
        t(" "),
        i(3, "src/*.cpp"),
        t(")"),
    }),



    s("tdef", {
        t("target_compile_definitions("),
        i(1, "${TARGET}"),
        t(" "),
        c(2, {
            t("PUBLIC"),
            t("PRIVATE"),
        }),
        t(" "),
        i(3, "DEFINITION_HERE"),
        t(")"),
    }),

    s("tsrc", {
        t("target_sources("),
        i(1, "${TARGET}"),
        t(" "),
        c(2, {
            t("PUBLIC"),
            t("PRIVATE"),
        }),
        t(" "),
        i(3, "src/main.cpp"),
        t(")"),
    })



}
