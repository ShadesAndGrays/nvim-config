
return {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    init_options={
        buildDirectory = "build",
        format = {
            enable = true,
        }
    },
    root_markers = {'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake'},
}
