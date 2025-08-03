-- Setup Mason for managing LSP servers
local mason = require('mason')
mason.setup({})

local mason_lsp_conf = require('mason-lspconfig')
mason_lsp_conf.setup({
  ensure_installed = {
    'clangd',
    'pyright',
    'bashls',
    'rust_analyzer',
    'ts_ls'
  },

  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})

-- ## Completion ## --
local cmp = require('cmp')

cmp.setup({
  -- Enable completion on 3 characters
  completion = {
    keyword_length = 3,
    debounce = 150,
  },

  sources = {
    { name = 'buffer', priority = 10 },
    { name = 'path', priority = 7 },
    { name = 'nvim_lsp', priority = 6 },
    { name = 'luasnip', priority = 5 },
  },

  mapping = {
    -- Use Tab to select the top option
    -- Use Tab to select and confirm the current suggestion
    -- Use Ctrl+n for next item
    ['<C-n>'] = cmp.mapping.select_next_item(),

    -- Use Ctrl+p for previous item
    ['<C-p>'] = cmp.mapping.select_prev_item(),

    -- Use ENTER key for confirm selection
    ['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      else
        fallback();
      end
    end, { 'i', 's' }),


    -- TAB to go to the next completion option
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- SHIFT + TAB to go to the previous completion option
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- CTRL + SPACE to open completion menu if not visible
    -- Cancel selection if visible
    ['<C-Space>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        fallback()
      else
        cmp.complete()
      end
    end, { 'i', 's' }),
  },

  -- Additional configuration for the completion window
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-- Enable command-line completions
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'cmdline' },
  }),
})


-- #1 setup for C/C++
local lsp_config = require('lspconfig')
lsp_config.clangd.setup({
  filetypes = {
    'c',
    'cc',
    'cpp',
    'h',
    'hh',
    'hpp'
  },

  cmd = { "clangd", "--header-insertion=never" },

  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
  end,
})

-- #2 setup for rust
lsp_config.rust_analyzer.setup({
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("RustFormatOnSave", { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = true,
    }
  }
})

