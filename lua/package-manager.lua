-- https://github.com/folke/lazy.nvim
-- LAZY.NVIM PACKAGE MANAGER

-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)
--
-- require("lazy").setup(
--   {
--     { import = "plugins" },
--     { import = "plugins.lsp" }
--   },
--   {
--     install = {
--       -- colorscheme = { "tokyonight" } -- try load colorscheme immediately
--       -- colorscheme = { "tokyodark" } -- try load colorscheme immediately
--       -- colorscheme = { "nightfly" } -- try load colorscheme immediately
--       colorscheme = { "ayu" } -- try load colorscheme immediately
--     },
--     checker = {
--       enabled = false,
--       notify = true -- display the lazy popup when nvim starts and new plugins need to be installed.
--     },
--     change_detection = {
--       notify = false -- dont' display notifications when lazy detects lua config file changes
--     },
--     ui = {
--       border = "rounded"
--     }
--   }
-- )
--
-- LAZY.NVIM PACKAGE MANAGER
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Use vim.uv instead of vim.loop to clear the warning
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
    { import = "plugins.lsp" },
  },
  defaults = {
    -- This makes sure all your plugins are loaded with the latest stable versions
    lazy = false, -- by default, plugins are NOT lazy-loaded unless specified
    version = false, -- always use the latest git commit
  },
  install = {
    colorscheme = { "ayu", "habamax" } -- Fallback to habamax if ayu fails
  },
  checker = {
    enabled = false, -- Keep this false if you don't want popups on start
    notify = true,
  },
  change_detection = {
    notify = false,
  },
  ui = {
    border = "rounded",
    -- You can add icons here to make the UI match your devicons
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
  performance = {
    rtp = {
      -- disable some rtp plugins that you don't use to speed up startup
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
