-- when you install a plugin using vim.pack, the nvim-pack-lock.json file will automatically be created in the root dir.

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig", -- provides default language server configs
  "https://github.com/mason-org/mason.nvim", -- manage lsps
})

-- lsp
require("lsp")
