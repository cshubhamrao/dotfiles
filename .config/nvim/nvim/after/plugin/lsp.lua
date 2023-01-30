local lsp = require('lsp-zero')
lsp.preset('recommended')

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

require'lspconfig'.gopls.setup{}

lsp.setup()
