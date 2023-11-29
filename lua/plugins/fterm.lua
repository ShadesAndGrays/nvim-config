return {{
"numToStr/FTerm.nvim"
    ,
    config = function()
        
        FloatingTerm = require('FTerm')

        kmap("n", "`", "<cmd>lua FloatingTerm.toggle()<CR>", {}) 

    end
    }}
