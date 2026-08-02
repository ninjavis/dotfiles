return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap
    -- local util = require("lspconfig.util")

    -- ==========================================================
    -- GLOBAL LSP KEYBINDS (Modern LspAttach Pattern)
    -- ==========================================================
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, noremap = true, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
        opts.desc = "Show documentation"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

        -- Create the :Org command ONLY for TypeScript/JavaScript files
        local ft = vim.bo[ev.buf].filetype
        if ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
          vim.api.nvim_buf_create_user_command(ev.buf, "Org", function()
            vim.lsp.buf.execute_command({
              command = "_typescript.organizeImports",
              arguments = { vim.api.nvim_buf_get_name(ev.buf) },
              title = ""
            })
          end, { desc = "Organize Imports" })
        end

      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Modern Diagnostic Configuration (Neovim 0.11+)
    vim.diagnostic.config({
      update_in_insert = true,
      severity_sort = true,
      -- Unified Signs (Replaces sign_define)
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN]  = " ",
          [vim.diagnostic.severity.HINT]  = "󰠠 ",
          [vim.diagnostic.severity.INFO]  = " ",
        },
      },
      float = {
        border = "rounded",
        source = "always",
      },
    })

    -- ==========================================================
    -- SERVER CONFIGURATIONS
    -- ==========================================================

    -- ANGULAR SETUP
    -- We use a function for 'cmd' to avoid the "nil" error on startup
    vim.lsp.config("angularls", {
      capabilities = capabilities,
      on_new_config = function(new_config, new_root_dir)
        local mr = require("mason-registry")
        local angularls_path = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server"

        -- Try to get the dynamic path from Mason if available
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

    -- HTML
    vim.lsp.config("html", { capabilities = capabilities })

    -- TypeScript
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
    })

    -- CSS
    vim.lsp.config("cssls", { capabilities = capabilities })

    -- Emmet
    vim.lsp.config("emmet_ls", {
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    -- Lua (fixes "undefined global vim")
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- This line is key for fixing the fs_stat warning
              "${3rd}/luv/library"
            },
          },
        },
      },
    })

    -- vim.lsp.config("lua_ls", {
    --   capabilities = capabilities,
    --   settings = {
    --     Lua = {
    --       diagnostics = {
    --         globals = { "vim" },
    --       },
    --       workspace = {
    --         library = {
    --           [vim.fn.expand("$VIMRUNTIME/lua")] = true,
    --           [vim.fn.stdpath("config") .. "/lua"] = true,
    --         },
    --       },
    --     },
    --   },
    -- })

    -- Auto run :Org on save.
    -- TODO: requires attention. :Org executes, but file does not save.
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   pattern = { "*.ts", "*.js" },
    --   callback = function()
    --     vim.cmd("Org")
    --   end,
    -- })

    -- ENABLE ALL
    vim.lsp.enable({ "angularls", "html", "ts_ls", "cssls", "emmet_ls", "lua_ls" })
  end,
}
