return{

    {"mfussenegger/nvim-dap",
    config =  function ()
        local dap = require('dap')
        Kmap('n','<leader>gdc',dap.continue,{desc='Continue Debugging'})
        Kmap('n','<leader>gdb',dap.toggle_breakpoint,{desc='Toggle Breakpoint'})

        dap.configurations.python = {
            {
                type = 'python';
                request = 'launch';
                name = "Launch file";
                program = "${file}";
                pythonPath = function()
                    return '/usr/bin/python'
                end;
            },}


            dap.adapters.python = {
                type = 'executable',
                command = 'python';
                args = { '-m', 'debugpy.adapter' };
            }
        end},
        {"theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end
    },
    { "rcarriga/nvim-dap-ui",
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup() -- setup DAP
        Kmap('n','<leader>gdd',dapui.toggle,{desc="Toggle DAP UI"})
        -- listen for all event emitted by DAP
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
}
