local lsp = require("lsp-zero")

-- Configure mason-lspconfig to install and setup servers
require('mason-lspconfig').setup({
  ensure_installed = {
    'ts_ls',       -- TypeScript/JavaScript
    'eslint',      -- ESLint
    'lua_ls',      -- Lua
    'pyright',     -- Python
  },
  handlers = {
    -- Default handler for all servers
    lsp.default_setup,

    -- Custom handler for lua_ls to fix 'vim' undefined warning
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })
    end,
  },
})

-- LSP keymaps - triggered when LSP attaches to buffer
lsp.on_attach(function(client, bufnr)
  -- Fix for incremental sync bug: force full document sync
  if client.server_capabilities.textDocumentSync then
    if type(client.server_capabilities.textDocumentSync) == "table" then
      client.server_capabilities.textDocumentSync.change = vim.lsp.protocol.TextDocumentSyncKind.Full
    else
      client.server_capabilities.textDocumentSync = vim.lsp.protocol.TextDocumentSyncKind.Full
    end
  end

  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.HINT] = "H",
      [vim.diagnostic.severity.INFO] = "I",
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})
