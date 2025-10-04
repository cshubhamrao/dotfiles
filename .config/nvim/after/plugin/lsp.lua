local lsp = require("lsp-zero")

vim.opt.signcolumn = 'yes'


-- Add border to hover windows
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "rounded"
    }
)

-- Add border to signature help
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = "rounded"
    }
)

-- Add cmp_nvim_lsp capabilities settings
local capabilities = vim.tbl_deep_extend('force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities())

-- Setup language servers with vim.lsp.config

-- TypeScript/JavaScript
vim.lsp.config.ts_ls = {
    capabilities = capabilities,
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
            format = {
                enable = true,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
            format = {
                enable = true,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
            },
        }
    }
}

-- ESLint
vim.lsp.config.eslint = {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Enable ESLint to provide formatting
        client.server_capabilities.documentFormattingProvider = true
    end,
    settings = {
        format = true,
    },
}

-- Python
vim.lsp.config.pyright = {
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoImportCompletions = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            }
        }
    }
}

-- Ruff (replacing deprecated ruff_lsp)
vim.lsp.config.ruff = {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
    end
}

-- Go
vim.lsp.config.gopls = {
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
}

-- Rust
vim.lsp.config.rust_analyzer = {
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                command = "clippy"
            },
            cargo = {
                allFeatures = true
            }
        }
    }
}

-- Lua
vim.lsp.config.lua_ls = {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

-- JSON
vim.lsp.config.jsonls = {
    capabilities = capabilities,
}

-- YAML
vim.lsp.config.yamlls = {
    capabilities = capabilities,
}

-- Docker
vim.lsp.config.dockerls = {
    capabilities = capabilities,
}

vim.lsp.config.docker_compose_language_service = {
    capabilities = capabilities,
}

-- Bash
vim.lsp.config.bashls = {
    capabilities = capabilities,
}

-- Enable all configured LSPs
vim.lsp.enable('ts_ls')
vim.lsp.enable('eslint')
vim.lsp.enable('pyright')
vim.lsp.enable('ruff')
vim.lsp.enable('gopls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('lua_ls')
vim.lsp.enable('jsonls')
vim.lsp.enable('yamlls')
vim.lsp.enable('dockerls')
vim.lsp.enable('docker_compose_language_service')
vim.lsp.enable('bashls')
-- Setup completion
local cmp = require('cmp')
local luasnip = require('luasnip')

-- Load friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    completion = {
        autocomplete = false
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'path' },
    }, {
        { name = 'buffer' },
    }),
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm({
            select = true
        }),
        ['<CR>'] = cmp.mapping.confirm({
            select = true
        }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    formatting = {
        format = function(entry, vim_item)
            -- Kind icons
            local kind_icons = {
                Text = "",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰇽",
                Variable = "󰂡",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
            }
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
                nvim_lua = "[Lua]",
            })[entry.source.name]
            return vim_item
        end
    },
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

-- Enhanced diagnostic configuration
vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
        source = 'if_many',
        spacing = 4,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

-- Keybinding to toggle lsp_lines (inline diagnostics)
vim.keymap.set('n', '<leader>tl', function()
    local config = vim.diagnostic.config()
    if config.virtual_lines then
        vim.diagnostic.config({ virtual_lines = false })
    else
        vim.diagnostic.config({ virtual_lines = true })
    end
end, { desc = "Toggle lsp_lines" })

lsp.setup()
