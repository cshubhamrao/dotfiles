-- LSP-based formatting configuration

-- Format using LSP
local function lsp_format(bufnr)
  vim.lsp.buf.format({
    bufnr = bufnr,
    timeout_ms = 2000,
    async = false,
  })
end

-- Format command
vim.api.nvim_create_user_command("Format", function()
  lsp_format(0)
end, {})

-- Formatting keymaps
vim.keymap.set({ "n", "v" }, "<leader>f", function()
  lsp_format(0)
end, { desc = "Format file or range using LSP" })

-- Toggle format on save
local format_on_save = false -- Disabled by default
vim.api.nvim_create_user_command("FormatToggle", function()
  format_on_save = not format_on_save
  if format_on_save then
    print("LSP format on save enabled")
  else
    print("LSP format on save disabled")
  end
end, {})

-- Setup format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    if format_on_save then
      -- Only format if there's an LSP client that supports formatting
      local clients = vim.lsp.get_clients({ bufnr = args.buf })
      for _, client in ipairs(clients) do
        if client.server_capabilities.documentFormattingProvider then
          lsp_format(args.buf)
          break
        end
      end
    end
  end,
})

-- Show LSP formatter info
vim.keymap.set("n", "<leader>fi", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local formatters = {}
  for _, client in ipairs(clients) do
    if client.server_capabilities.documentFormattingProvider then
      table.insert(formatters, client.name)
    end
  end

  if #formatters == 0 then
    print("No LSP formatters available for this buffer")
  else
    print("LSP formatters: " .. table.concat(formatters, ", "))
  end
end, { desc = "Show available LSP formatters" })