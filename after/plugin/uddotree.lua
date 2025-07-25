if vim.fn.has("persistent_undo") == 1 then
  local target_path = vim.fn.expand("~/.myvim/undodir")

  if vim.fn.isdirectory(target_path) == 0 then
    vim.fn.mkdir(target_path, "p", 755)
  end

  vim.o.undodir = target_path
  vim.o.undofile = true
end

vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle)
