-- when you install a plugin using vim.pack, the nvim-pack-lock.json file will automatically be created in the root dir.
-- when you install a plugin using vim.pack, the nvim-pack-lock.json file will automatically be created in the root dir.

vim.pack.add({
  -- 1. LSP Plugins
  { src = "https://github.com/neovim/nvim-lspconfig", load = true },
  { src = "https://github.com/mason-org/mason.nvim",  load = true },

  -- 2. Telescope & Core Dependencies
  { src = "https://github.com/nvim-lua/plenary.nvim", load = true },
  {
    src = "https://github.com/nvim-telescope/telescope.nvim",
    load = true
  },
  {
    src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    -- On install/update, vim.pack can fire a shell command to compile FZF
    build = function() vim.fn.system({'make'}) end,
    load = true
  },
  { src = "https://github.com/nvim-telescope/telescope-file-browser.nvim", load = true } -- allows for browsing directories/directory specific search
})

-- Now that load = true forces them onto the runtime path, your modules can load safely!
require("lsp")
require("telescope_config") -- Make sure to load your separate telescope setup file here!

-- vim.pack.add({
--   "https://github.com/neovim/nvim-lspconfig", -- provides default language server configs
--   "https://github.com/mason-org/mason.nvim",  -- manage lsps
--
--   -- telescope
--   'nvim-lua/plenary.nvim',
--   {
--     'nvim-telescope/telescope.nvim', version = '*',
--   },
--   {
--     'nvim-telescope/telescope-fzf-native.nvim', build = 'make'
--   }
--
--   -- glyphs
--   -- 'nvim-tree/nvim-web-devicons',
--
-- })
--
-- -- lsp
-- require("lsp")
--
-- -- telescope
-- -- require("telescope_config")
