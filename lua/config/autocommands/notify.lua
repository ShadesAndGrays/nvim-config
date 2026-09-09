local notify = require("notify")

vim.api.nvim_create_user_command("NotifyClear", notify.dismiss, {})
