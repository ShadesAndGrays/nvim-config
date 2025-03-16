return {{
    "ShadesAndGrays/scratch-buffer",
    config = function ()
        local scratch = require('scratch-buffer')
        Kmap('n','<leader>bo',scratch.open,{desc="Opens a scratch buffer"})
    end
}}
