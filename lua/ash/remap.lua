vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Copy/Paste
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-v>", '"+p', { noremap = true, silent = true })
vim.keymap.set("i", "<C-v>", '<C-r>+', { noremap = true, silent = true })
