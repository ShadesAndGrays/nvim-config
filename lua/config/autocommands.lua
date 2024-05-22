function hello()
    print("Hello new txt file")
end

function display(x)
    print(x)
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

vim.api.nvim_create_autocmd({
"BufEnter","BufRead"
},
{pattern="*.txt",
callback=hello}
)

vim.api.nvim_create_autocmd(
{"TextYankPost"},
{
    callback = function ()
        local vstart = vim.fn.getpos("<'")
        local vend = vim.fn.getpos("'>")

        local line_start = vstart[2]
        local line_end = vend[1]

        local lines = vim.fn.getline(line_start,line_end)
        if lines == {} then
            print("lines are empty")
        else
            print("lines are not empty")
            display(dump(lines))
        end
    end
})
