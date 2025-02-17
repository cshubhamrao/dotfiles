local lsp = require("lsp-zero")
lsp.preset("recommended")

vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend('force', lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities())

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150
}

-- Setup language servers.
local lspconfig = require("lspconfig")
lspconfig.pyright.setup {
    flags = lsp_flags
}
lspconfig.rust_analyzer.setup {
    flags = lsp_flags,
    -- Server-specific settings. See `:help lspconfig-setup`
    settings = {
        ["rust-analyzer"] = {}
    }
}

local ruff_on_attach = function(client, bufnr)
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
end

lspconfig.ruff.setup {
    on_attach = ruff_on_attach
}

lspconfig.gopls.setup {}
local cmp = require('cmp')
cmp.setup({
    completion = {
        autocomplete = false
    },
    sources = {{
        name = 'nvim_lsp'
    }},
    snippet = {
        expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        -- ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        -- ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({
            select = true
        }),
        ['<CR>'] = cmp.mapping.confirm({
            select = true
        }),
        ["<C-Space>"] = cmp.mapping.complete()
    })
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = {
    noremap = true,
    silent = true
}
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--     callback = function(ev)
--         -- Enable completion triggered by <c-x><c-o>
--         vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

--         -- Buffer local mappings.
--         -- See `:help vim.lsp.*` for documentation on any of the below functions
--         local bufopts = {
--             noremap = true,
--             silent = true,
--             buffer = ev.buf
--         }
--         vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
--         vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
--         vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
--         vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
--         vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
--         vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
--         vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
--         vim.keymap.set("n", "<space>wl", function()
--             print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--         end, bufopts)
--         vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
--         vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
--         vim.keymap.set({"n", "v"}, "<space>ca", vim.lsp.buf.code_action, bufopts)
--         vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
--         vim.keymap.set("n", "<space>f", function()
--             vim.lsp.buf.format {
--                 async = true
--             }
--         end, bufopts)
--     end
-- })

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = {
            buffer = event.buf
        }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set({"n", "v"}, "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
    end
})

vim.diagnostic.config({
    virtual_text = true
})

lsp.setup()
