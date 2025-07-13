local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Search filenames in the workspace' })
vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Search files by text in the workspace' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Search neovim buffers' })
vim.keymap.set('n', '<leader>of', builtin.oldfiles, { desc = 'List previously open files' })
