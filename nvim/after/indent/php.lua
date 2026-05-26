vim.bo.autoindent = true
vim.wo.breakindent = true

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or '') ..
' | setl autoindent< breakindent<'
