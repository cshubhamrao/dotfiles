# Neovim Configuration Cheatsheet

Modern Neovim setup optimized for TypeScript/NestJS (work) and Go/Python/Rust (fun).

## Quick Start

- **Leader key**: `<space>`
- **Local leader**: Not set
- **Completion trigger**: `<C-Space>`

---

## LSP & Code Actions

| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `gR` | References in Trouble |
| `go` / `<space>D` | Go to type definition |
| `gs` / `<C-k>` | Signature help |
| `<space>ca` / `<F4>` | Code actions |
| `<space>rn` / `<F2>` | Rename symbol |
| `<leader>f` / `<F3>` | Format file/selection |
| `<leader>fi` | Show active formatters |

## Diagnostics

| Key | Action |
|-----|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<space>e` | Show diagnostic float |
| `<leader>dp` | Show diagnostic preview |
| `<leader>ds` | Show diagnostic counts |
| `<space>q` | Diagnostic loclist |
| `<leader>tl` | Toggle inline diagnostics (lsp_lines) |

## Trouble (Diagnostic List)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle trouble list |
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xl` | Location list |
| `<leader>xq` | Quickfix list |

## Telescope (Fuzzy Finder)

### File Navigation
| Key | Action |
|-----|--------|
| `<leader>pf` | Find files |
| `<leader>pg` | Live grep |
| `<leader>ps` | Search string under cursor |
| `<leader>pb` | Find buffers |
| `<leader>ph` | Help tags |

### LSP Integration
| Key | Action |
|-----|--------|
| `<leader>lr` | LSP references |
| `<leader>ld` | LSP definitions |
| `<leader>lt` | LSP type definitions |
| `<leader>li` | LSP implementations |
| `<leader>ls` | Document symbols |
| `<leader>lw` | Workspace symbols |

### Git Integration
| Key | Action |
|-----|--------|
| `<leader>gs` | Git status |
| `<leader>gc` | Git commits |
| `<leader>gb` | Git branches |
| `<leader>lg` | Open LazyGit |

## Completion (nvim-cmp)

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<C-n>` / `<C-p>` | Next/Previous item |
| `<Tab>` / `<S-Tab>` | Next/Previous (or jump snippet) |
| `<C-y>` / `<CR>` | Confirm selection |
| `<C-b>` / `<C-f>` | Scroll docs |

## Window Management

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate windows |
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>se` | Equal splits |
| `<leader>sx` | Close split |
| `<C-Up/Down/Left/Right>` | Resize windows |

## Editing

| Key | Action |
|-----|--------|
| `<C-s>` | Save file (any mode) |
| `<Esc>` | Clear search highlights |
| `<A-j/k>` | Move line down/up |
| `<` / `>` (visual) | Indent left/right (stays selected) |

## File Explorer

| Key | Action |
|-----|--------|
| `<leader>pv` | Open file explorer (`:Ex`) |

## Undotree

| Key | Action |
|-----|--------|
| (No default keymap set) | Use `:UndotreeToggle` |

## Treesitter Text Objects

| Key | Action |
|-----|--------|
| `gnn` | Init selection |
| `grn` | Increment node |
| `grc` | Increment scope |
| `grm` | Decrement node |
| `af` / `if` | Around/Inside function |
| `ac` / `ic` | Around/Inside class |
| `as` | Around scope |

## Workspace Management

| Key | Action |
|-----|--------|
| `<space>wa` | Add workspace folder |
| `<space>wr` | Remove workspace folder |
| `<space>wl` | List workspace folders |

## Formatting

| Key | Action |
|-----|--------|
| `<leader>f` | Format using LSP |
| `:Format` | Format command |
| `:FormatToggle` | Toggle format on save (disabled by default) |
| `<leader>fi` | Show available LSP formatters |

---

## Language Server Support

- **TypeScript/JavaScript**: ts_ls, eslint
- **Python**: pyright, ruff
- **Go**: gopls
- **Rust**: rust_analyzer
- **Lua**: lua_ls
- **JSON/YAML**: jsonls, yamlls
- **Docker**: dockerls, docker_compose_language_service
- **Bash**: bashls

## Plugins

- **lazy.nvim**: Plugin manager
- **nvim-lspconfig**: LSP configuration
- **mason.nvim**: LSP/tool installer
- **nvim-cmp**: Completion engine
- **nvim-treesitter**: Syntax highlighting
- **telescope.nvim**: Fuzzy finder
- **trouble.nvim**: Diagnostic list
- **lsp_lines.nvim**: Inline diagnostics
- **fidget.nvim**: LSP progress
- **lualine.nvim**: Status line
- **catppuccin**: Color scheme
- **copilot.vim**: GitHub Copilot
- **lazygit.nvim**: Git UI
- **undotree**: Undo history

## Tips

1. **Format on save**: Disabled by default. Enable with `:FormatToggle`
2. **Inline diagnostics**: Toggle with `<leader>tl` for detailed error messages
3. **Completion**: Manually triggered with `<C-Space>`, not automatic
4. **LSP progress**: Shown in bottom-right corner via fidget.nvim
5. **Diagnostic signs**: Error , Warn , Hint , Info  in gutter
