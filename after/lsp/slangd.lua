return {
    cmd = { "slang" },
    filetypes = {
        'shaderslang', 'slang', 'hlsl', 'vert', 'frag' },
    root_markers = { '.git', 'slang.toml' },
    settings = {
        slang = {
            inlayHints = {
                deducedTypes = true,
                parameterNames = true,
            }
        }

    }
}
