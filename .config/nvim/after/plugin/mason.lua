require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    ensure_installed = {
        -- TypeScript/JavaScript
        "ts_ls",
        "eslint",

        -- Python
        "pyright",
        "ruff",  -- Changed from ruff_lsp

        -- Go
        "gopls",

        -- Rust
        "rust_analyzer",

        -- Other useful ones
        "lua_ls",
        "jsonls",
        "yamlls",
        "dockerls",
        "docker_compose_language_service",
        "bashls",
    },
    automatic_installation = true,
})