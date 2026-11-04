-- Build hook must be registered BEFORE avante is added
vim.api.nvim_create_autocmd(
    'PackChanged',
    {
        callback = function(ev)
            local name, kind = ev.data.spec.name, ev.data.kind
            if name == 'avante.nvim' and (kind == 'install' or kind == 'update') then
                -- compile avante rust libraries yourself
                if vim.fn.has('win32') == 1 then
                    vim.system({
                        'powershell', '-ExecutionPolicy', 'Bypass',
                        '-File', 'Build.ps1', '-BuildFromSource', 'false',
                    }, { cwd = ev.data.path }):wait()
                else
                    vim.system({ 'make' }, { cwd = ev.data.path }):wait()
                end
                -- or restart neovim and call `:AvanteBuild` to download prebuilt libraries
            end
        end
    }
)

vim.pack.add({
    -- Deps first
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/MunifTanjim/nui.nvim',
    'https://github.com/ColinKennedy/mega.logging',
    'https://github.com/ColinKennedy/mega.cmdparse',

    -- Optional deps
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    'https://github.com/hrsh7th/nvim-cmp',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/HakonHarnes/img-clip.nvim',
    'https://github.com/zbirenbaum/copilot.lua',
    'https://github.com/folke/snacks.nvim',

    -- Plugins that depend on the above
    'https://github.com/sudo-tee/opencode.nvim',
    { src = 'https://github.com/yetone/avante.nvim', version = 'v0.4.8' },
})

require('opencode').setup({})
require("avante").setup({
    provider = "openrouter",
    mode = "agentic",


    providers = {
        openrouter = {
            endpoint = "https://openrouter.ai/api/v1",
            -- model = "claude-sonnet-4-20250514",
            timeout = 30000, -- Timeout in milliseconds
            extra_request_body = {
                temperature = 0.75,
                max_tokens = 20480,
            },
        },
    },
    selector = {
        provider = "telescope",
        provider_opts = {},
        exclude_auto_select = {}, -- List of items to exclude from auto selection
    },
    behaviour = {
        auto_suggestions = false,
    },
})
