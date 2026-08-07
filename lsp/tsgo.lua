-- ~/.config/nvim/lsp/tsgo.lua
return {
  cmd = { 'tsgo', 'lsp', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  root_dir = function(fname)
    return vim.fs.root(fname, { 'tsconfig.json', 'package.json', '.git' })
  end,
  capabilities = {
    -- Force UTF-16 encoding to fix position encoding mismatch with vtsls
    offsetEncoding = { 'utf-16' },
  },
  on_attach = function(client, bufnr)
    -- Disable diagnostics from tsgo so vtsls owns all errors/warnings
    client.server_capabilities.diagnosticProvider = false
  end,
}
-- ~/.config/nvim/lsp/tsgo.lua
-- ~/.config/nvim/lsp/tsgo.lua
-- return {
--   cmd = { 'tsgo', 'lsp', '--stdio' },
--   filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
--   root_dir = function(fname)
--     return vim.fs.root(fname, { 'tsconfig.json', 'package.json', '.git' })
--   end,
-- }
-- return {
--   cmd = { 'tsgo', 'lsp', '--stdio' },
--   filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
--   root_markers = { 'tsconfig.json', 'package.json', '.git' },
-- }
