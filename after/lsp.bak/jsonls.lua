return {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    init_options = {
        provideFormatter = true,
    },
    root_markers = { '.git' },
        settings = {
            json = {
                schemas = {
                    {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
                    },
                },
                validate = { enable = true },
            }
        }
}
