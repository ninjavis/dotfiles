-- https://github.com/folke/lazy.nvim
-- LAZY.NVIM PACKAGE MANAGER

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {
    { import = "plugins" },
    { import = "plugins.lsp" }
  },
  {
    install = {
      -- colorscheme = { "tokyonight" } -- try load colorscheme immediately
      -- colorscheme = { "tokyodark" } -- try load colorscheme immediately
      -- colorscheme = { "nightfly" } -- try load colorscheme immediately
      colorscheme = { "ayu" } -- try load colorscheme immediately
    },
    checker = {
      enabled = false,
      notify = true -- display the lazy popup when nvim starts and new plugins need to be installed.
    },
    change_detection = {
      notify = false -- dont' display notifications when lazy detects lua config file changes
    },
    ui = {
      border = "rounded"
    }
  }
)
