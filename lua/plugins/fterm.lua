return {{
"numToStr/FTerm.nvim"
    ,
    config = function()
        
        FloatingTerm = require('FTerm')

        kmap("n", "c", "<cmd>lua FloatingTerm.toggle()<CR>", {}) 

    end
    }}
