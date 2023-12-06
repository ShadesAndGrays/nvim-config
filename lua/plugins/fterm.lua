return{{
"numToStr/FTerm.nvim"
    ,
    config = function()
        
        FloatingTerm = require('FTerm')

        kmap("n", "C", "<cmd>lua FloatingTerm.toggle()<CR>", {}) 

    end
    }}
