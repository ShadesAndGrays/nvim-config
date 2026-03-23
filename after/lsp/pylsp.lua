return {
    cmd = { 'pylsp' },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
    settings = {
        pylsp = {
            plugins = {
                jedi_completion = {
                    -- This helps jedi find the venv modules
                    workspace_folders = { vim.fn.getcwd() }
                },
                pycodestyle = {
                    pycodestyle = {
                        ignore = "E302",
                        maxLineLength = 88
                    },
                }
            }
        }
    }

}
