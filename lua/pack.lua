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
  { src = "https://github.com/nvim-telescope/telescope-file-browser.nvim", load = true }, -- allows for browsing directories/directory specific search

  -- 3. Autopairs
  { src = "https://github.com/windwp/nvim-autopairs", load = true }
})

-- Now that load = true forces them onto the runtime path, your modules can load safely!
-- lsp
require("lsp")
-- telescope
require("telescope_config") -- Make sure to load your separate telescope setup file here!
-- autopairs
require("autopairs_config")

-- require("lsp")
--
-- -- require("telescope_config")
