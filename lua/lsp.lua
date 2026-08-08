-- mason needs to be set up first so that it install the lsp binaries before vim lsp tries to use them.
require("mason").setup()

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Local buffer" })
vim.keymap.set("n", "df", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- vim.diagnostic.config({ virtual_text = true })
--
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())
--
vim.lsp.config("*", { capabilities = capabilities })
--

-- LUA LSP
-- fixes 'vim.lsp....' undefined global 'vim' in lua_ls
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

-- ANGULAR LSP
vim.lsp.config("angularls", {
  capabilities = capabilities,
  on_new_config = function(new_config, new_root_dir)
    local mr = require("mason-registry")
    local angularls_path = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server"

    pcall(function()
      if mr.has_package("angular-language-server") then
        angularls_path = mr.get_package("angular-language-server"):get_install_path()
      end
    end)

    new_config.cmd = {
      "ngserver",
      "--stdio",
      "--tsProbeLocations",
      table.concat({ angularls_path, new_root_dir }, ","),
      "--ngProbeLocations",
      table.concat({ angularls_path .. "/node_modules/@angular/language-server", new_root_dir }, ","),
    }
  end,
})

-- VTSLS LSP (replaces ts_ls until tsgo becomes available)
-- For Mason v2,
-- local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
-- or even
-- local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
local vtsls_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vtsls/node_modules/@vtsls/language-server"
local vtsls_plugin = {
  name = '@vtsls/typescript-plugin',
  location = vtsls_language_server_path,
  languages = { 'vue', 'typescript' },
  configNamespace = 'typescript',
}
vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vtsls_plugin,
        },
      },
    },
  },
  filetypes = { 'typescript', 'javascript' },
})

vim.lsp.enable('vtsls')

-- HTML
-- vim.lsp.config("html", { capabilities = capabilities })

-- TypeScript
-- vim.lsp.config("ts_ls", { capabilities = capabilities })

-- CSS
-- vim.lsp.config("cssls", { capabilities = capabilities })

-- Emmet
-- vim.lsp.config("emmet_ls", {
--   capabilities = capabilities,
--   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
-- })

vim.lsp.enable({
  "angularls",
  "vtsls",
  "lua_ls",
  -- "marksman",
  "gopls",
  -- "rust_analyzer",
})
