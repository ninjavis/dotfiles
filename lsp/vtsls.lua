-- ~/.config/nvim/lsp/vtsls.lua
local global_npm_root = vim.trim(vim.fn.system('npm root -g'))
local angular_plugin_path = global_npm_root .. '/@angular/language-server'

return {
  cmd = { 'vtsls', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'html' },
  root_dir = function(fname)
    return vim.fs.root(fname, { 'tsconfig.json', 'angular.json', 'package.json', '.git' })
  end,
  capabilities = {
    offsetEncoding = { 'utf-16' },
  },
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      tsserver = {
        globalPlugins = {
          {
            name = '@angular/language-server',
            location = angular_plugin_path,
            enableForWorkspaceTypeScriptVersions = true,
            languages = { 'typescript', 'html' }, -- MUST include 'typescript'
          },
        },
      },
    },
    typescript = {
      tsdk = global_npm_root .. '/typescript/lib',
    },
  },
  on_attach = function(client, bufnr)
    local ft = vim.bo[bufnr].filetype
    if ft == 'typescript' or ft == 'typescriptreact' then
      -- Let tsgo handle light/fast features on .ts files
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.completionProvider = nil

      -- Keep vtsls for heavy lifting:
      -- renameProvider, codeActionProvider, documentSymbolProvider, diagnosticProvider
    end
  end,
}
-- ~/.config/nvim/lsp/vtsls.lua
-- local global_npm_root = vim.trim(vim.fn.system('npm root -g'))
-- local angular_plugin_path = global_npm_root .. '/@angular/language-server'
--
-- return {
--   cmd = { 'vtsls', '--stdio' },
--   filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'html' },
--   root_dir = function(fname)
--     return vim.fs.root(fname, { 'tsconfig.json', 'angular.json', 'package.json', '.git' })
--   end,
--   settings = {
--     vtsls = {
--       autoUseWorkspaceTsdk = true,
--       experimental = {
--         completion = {
--           enableServerSideFuzzyMatch = true,
--         },
--       },
--       tsserver = {
--         globalPlugins = {
--           {
--             name = '@angular/language-server',
--             location = angular_plugin_path,
--             enableForWorkspaceTypeScriptVersions = true,
--             languages = { 'typescript', 'html' },
--           },
--         },
--       },
--     },
--     typescript = {
--       tsdk = global_npm_root .. '/typescript/lib',
--       preferences = {
--         importModuleSpecifier = 'non-relative',
--       },
--     },
--   },
--   on_attach = function(client, bufnr)
--     local ft = vim.bo[bufnr].filetype
--     if ft == 'typescript' or ft == 'typescriptreact' then
--       -- Mute duplicate capabilities where tsgo handles them
--       client.server_capabilities.hoverProvider = false
--       client.server_capabilities.definitionProvider = false
--       client.server_capabilities.completionProvider = nil
--     end
--   end,
-- }
-- local angular_ls_path = vim.fn.exepath('ngserver')
--   and vim.fn.fnamemodify(vim.fn.exepath('ngserver'), ':h:h') -- adjust to your global npm root if needed
-- local angular_plugin_path = vim.fn.system('npm root -g'):gsub('\n', '') .. '/@angular/language-server'
--
-- return {
--   cmd = { 'vtsls', '--stdio' },
--   filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'html' },
--   root_markers = { 'tsconfig.json', 'angular.json', 'package.json', '.git' },
--   settings = {
--     vtsls = {
--       tsserver = {
--         globalPlugins = {
--           {
--             name = '@angular/language-server',
--             location = angular_plugin_path,
--             enableForWorkspaceTypeScriptVersions = true,
--             languages = { 'html' },
--           },
--         },
--       },
--     },
--   },
--   on_attach = function(client, bufnr)
--     local ft = vim.bo[bufnr].filetype
--     if ft == 'typescript' or ft == 'typescriptreact' then
--       -- tsgo already owns these on .ts/.tsx — avoid duplicate hover/completion/diagnostics
--       client.server_capabilities.hoverProvider = false
--       client.server_capabilities.definitionProvider = false
--       client.server_capabilities.completionProvider = nil
--       -- keep: renameProvider, codeActionProvider, documentSymbolProvider
--       -- these stay on vtsls since the Angular plugin needs them for template-aware rename/refactors
--     end
--     -- on .html buffers vtsls is the only server, so it keeps full capabilities
--   end,
-- }
