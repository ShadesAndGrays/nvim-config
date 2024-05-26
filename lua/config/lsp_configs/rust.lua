return {
    'rust_analyzer',{
        cmd = { "/home/shadow/.cargo/bin/ra-multiplex"}, -- Path to ra-multiplex
        settings = {
            ["rust-analyzer"] = {
                server = {
                    extraEnv = { RA_MUX_SERVER = "/home/shadow/.cargo/bin/rust-analyzer" } -- Environment variable for ra-multiplex
                }
            }
        }
    }
}

