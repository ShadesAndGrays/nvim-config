require("config/autocommands/godot")
vim.api.nvim_create_user_command("ReloadConfig", ":source $MYVIMRC", {})

--vim.cmd([[au BufNewFile,BufRead *.v set filetype=vlang]])
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.v",
  command = "set filetype=vlang",
})
