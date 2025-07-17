local telescope = require('telescope')

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

telescope.load_extension('fzf')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Search filenames in the workspace' })
vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Search files by text in the workspace' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Search neovim buffers' })
vim.keymap.set('n', '<leader>of', builtin.oldfiles, { desc = 'List previously open files' })
