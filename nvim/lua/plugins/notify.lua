local notify = load 'notify'
if not notify then return end

vim.notify = notify
