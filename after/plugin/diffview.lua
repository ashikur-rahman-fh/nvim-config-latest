vim.keymap.set('n', '<leader>do', ':DiffviewOpen<CR>', { desc = 'Open Diffview' })

vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>', { desc = 'Close Diffview' })

vim.keymap.set('n', '<leader>dh', ':DiffviewFileHistory %<CR>', { desc = 'Diffview File History (current file)' })

vim.keymap.set('n', '<leader>gh', ':DiffviewFileHistory<CR>', { desc = 'Diffview git commit history' })
