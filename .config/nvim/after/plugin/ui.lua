-- UI enhancements and keybindings

-- Trouble.nvim keybindings (better diagnostic list)
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, desc = "Toggle trouble list"})
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, desc = "Workspace diagnostics"})
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, desc = "Document diagnostics"})
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, desc = "Location list"})
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, desc = "Quickfix list"})
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, desc = "LSP references"})


-- Diagnostic navigation with preview
vim.keymap.set('n', '<leader>dp', function()
  vim.diagnostic.open_float(nil, {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = 'rounded',
    source = 'always',
    prefix = ' ',
    scope = 'cursor',
  })
end, { desc = "Show diagnostic in floating window" })

-- Quick diagnostic stats
vim.keymap.set('n', '<leader>ds', function()
  local diagnostics = vim.diagnostic.get(0)
  local counts = { errors = 0, warnings = 0, info = 0, hints = 0 }

  for _, diagnostic in ipairs(diagnostics) do
    if diagnostic.severity == vim.diagnostic.severity.ERROR then
      counts.errors = counts.errors + 1
    elseif diagnostic.severity == vim.diagnostic.severity.WARN then
      counts.warnings = counts.warnings + 1
    elseif diagnostic.severity == vim.diagnostic.severity.INFO then
      counts.info = counts.info + 1
    elseif diagnostic.severity == vim.diagnostic.severity.HINT then
      counts.hints = counts.hints + 1
    end
  end

  print(string.format(" %d  %d  %d  %d",
    counts.errors, counts.warnings, counts.info, counts.hints))
end, { desc = "Show diagnostic counts" })

-- Set colorscheme
vim.cmd.colorscheme "catppuccin"

-- Transparent background (optional, uncomment if desired)
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })