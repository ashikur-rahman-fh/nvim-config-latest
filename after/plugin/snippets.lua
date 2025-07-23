local lua_snip = require('luasnip')
vim.keymap.set({"i", "s"}, "<Tab>", function()
  if lua_snip.expand_or_jumpable() then
    lua_snip.expand_or_jump()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
  end
end, {silent = true})

vim.keymap.set({"i", "s"}, "<S-Tab>", function()
  if lua_snip.jumpable(-1) then
    lua_snip.jump(-1)
  end
end, {silent = true})
