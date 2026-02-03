return {
    filetypes = { 'yaml', 'yaml.openapi'},
    settings = {
        yaml = {
            schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
            },
            validate = true,
            completion = true,
        },
    },
}
