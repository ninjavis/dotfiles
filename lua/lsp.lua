-- Mason needs to be set up first so that it installs the LSP binaries before Neovim tries to use them.
require("mason").setup()

-- Keymaps & Diagnostics
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Local buffer" })
vim.keymap.set("n", "df", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.diagnostic.config({
  virtual_text = true,
})

-- Merge blink.cmp capabilities so LSP servers know completion features are supported
local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

-- Mason package paths for Angular & vtsls
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local angularls_path = mason_packages .. "/angular-language-server"

-- LUA LSP
-- Fixes undefined global 'vim' in lua_ls
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

-- ANGULAR LSP
-- Restricted to HTML files so it never duplicates or blocks vtsls inside .ts files
-- ANGULAR LSP
-- Let nvim-lspconfig handle ngserver probe paths automatically; only restrict filetypes
vim.lsp.config("angularls", {
  filetypes = { "html", "htmlangular" },
})

-- vim.lsp.config("angularls", {
--   filetypes = { "html", "htmlangular" },
--   cmd = function(dispatchers, config)
--     local root_dir = (config and config.root_dir) or vim.fn.getcwd()
--     local cmd = {
--       "ngserver",
--       "--stdio",
--       "--tsProbeLocations",
--       table.concat({ angularls_path, root_dir }, ","),
--       "--ngProbeLocations",
--       table.concat({ angularls_path .. "/node_modules/@angular/language-server", root_dir }, ","),
--     }
--     return vim.lsp.rpc.start(cmd, dispatchers)
--   end,
-- })

-- VTSLS LSP
-- Handles .ts/.js exclusively, increases memory limit, and loads the Angular plugin for inline templates
vim.lsp.config("vtsls", {
  filetypes = { "typescript", "javascript" },
  settings = {
    typescript = {
      tsserver = {
        maxTsServerMemory = 4096,
      },
    },
    vtsls = {
      autoUseWorkspaceTsdk = true,
      tsserver = {
        globalPlugins = {
          {
            name = "@angular/language-server",
            location = angularls_path .. "/node_modules/@angular/language-server",
            enableForWorkspaceTypeScriptVersions = false,
          },
        },
      },
    },
  },
})

-- GOLANG
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        unusedfunc = true,
      },
      staticcheck = true,
      diagnosticsTrigger = "Edit",
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
})

-- GOLANG TEMPL
vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

vim.lsp.config("templ", {
  cmd = { "templ", "lsp" },
  filetypes = { "templ" },
  root_markers = { "go.mod", ".git" },
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = true
  end,
})

-- Enable all configured LSP servers
vim.lsp.enable({
  "angularls",
  "vtsls",
  "lua_ls",
  "gopls",
  "templ",
})

-- xxx
-- -- mason needs to be set up first so that it install the lsp binaries before vim lsp tries to use them.
-- require("mason").setup()
--
-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Local buffer" })
-- vim.keymap.set("n", "df", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
--
-- vim.diagnostic.config({
--   virtual_text = true
-- })
--
-- --
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- -- capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())
-- --
-- vim.lsp.config("*", { capabilities = capabilities })
-- --
--
-- -- LUA LSP
-- -- fixes 'vim.lsp....' undefined global 'vim' in lua_ls
-- vim.lsp.config("lua_ls", {
--   settings = {
--     Lua = {
--       diagnostics = { globals = { "vim" } },
--     },
--   },
-- })
--
-- -- ANGULAR LSP
-- vim.lsp.config("angularls", {
--   capabilities = capabilities,
--   on_new_config = function(new_config, new_root_dir)
--     local mr = require("mason-registry")
--     local angularls_path = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server"
--
--     pcall(function()
--       if mr.has_package("angular-language-server") then
--         angularls_path = mr.get_package("angular-language-server"):get_install_path()
--       end
--     end)
--
--     new_config.cmd = {
--       "ngserver",
--       "--stdio",
--       "--tsProbeLocations",
--       table.concat({ angularls_path, new_root_dir }, ","),
--       "--ngProbeLocations",
--       table.concat({ angularls_path .. "/node_modules/@angular/language-server", new_root_dir }, ","),
--     }
--   end,
-- })
--
-- -- VTSLS LSP (replaces ts_ls until tsgo becomes available)
-- -- For Mason v2,
-- -- local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
-- -- or even
-- -- local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
-- local vtsls_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vtsls/node_modules/@vtsls/language-server"
-- local vtsls_plugin = {
--   name = '@vtsls/typescript-plugin',
--   location = vtsls_language_server_path,
--   languages = { 'vue', 'typescript' },
--   configNamespace = 'typescript',
-- }
-- vim.lsp.config('vtsls', {
--   settings = {
--     vtsls = {
--       tsserver = {
--         globalPlugins = {
--           vtsls_plugin,
--         },
--       },
--     },
--   },
--   filetypes = { 'typescript', 'javascript' },
-- })
--
-- -- GOLANG
-- vim.lsp.config('gopls', {
--   settings = {
--     gopls = {
--       analyses = {
--         unusedparams = true,
--         unusedfunc = true,
--       },
--       staticcheck = true,
--       -- This ensures gopls processes changes as you type
--       diagnosticsTrigger = "Edit",
--     },
--   },
--   -- make gopls recognize templ workspace files
--   flags = {
--     allow_incremental_sync = true,
--   },
-- })
--
-- -- GOLANG TEMPL
-- vim.lsp.config("templ", {
--   cmd = { "templ", "lsp" },
--   filetypes = { "templ" },
--   root_markers = { "go.mod", ".git" },
--   -- prevent templ and gopls from fighting over formatting
--   on_attach = function(client, _)
--     -- This prevents conflicting format requests between the two servers
--     client.server_capabilities.documentFormattingProvider = true
--   end
-- })
-- vim.filetype.add({
--   extension = {
--     templ = "templ",
--   },
-- })
--
-- -- HTML
-- -- vim.lsp.config("html", { capabilities = capabilities })
--
-- -- TypeScript
-- -- vim.lsp.config("ts_ls", { capabilities = capabilities })
--
-- -- CSS
-- -- vim.lsp.config("cssls", { capabilities = capabilities })
--
-- -- Emmet
-- -- vim.lsp.config("emmet_ls", {
-- --   capabilities = capabilities,
-- --   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
-- -- })
--
-- vim.lsp.enable({
--   "angularls",
--   "vtsls",
--   "lua_ls",
--   -- "marksman",
--   "gopls",
--   "templ"
--   -- "rust_analyzer",
-- })
