-- ~/.config/nvim/init.lua
vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.updatetime = 250

vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/neovim/nvim-lspconfig', -- just ships config *tables*, no setup() needed anymore
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.0') },
  'https://github.com/stevearc/conform.nvim',   -- formatting (prettier)
  'https://github.com/nvim-telescope/telescope.nvim',
})

require('nvim-treesitter').setup()

local ts_filetypes = { 'typescript', 'tsx', 'html', 'css', 'javascript', 'json', 'lua' }

require('nvim-treesitter').install(ts_filetypes)

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'typescriptreact', 'html', 'css', 'javascript', 'json', 'lua' },
  callback = function()
    vim.treesitter.start()
  end,
})
-- 
-- require('nvim-treesitter.configs').setup({
--   ensure_installed = { 'typescript', 'tsx', 'html', 'css', 'javascript', 'json', 'lua' },
--   highlight = { enable = true },
-- })

require('blink.cmp').setup({
  keymap = { preset = 'default' },
  sources = { default = { 'lsp', 'path', 'buffer', 'snippets' } },
})

require('conform').setup({
  formatters_by_ft = { typescript = { 'prettier' }, html = { 'prettier' } },
  format_on_save = { timeout_ms = 1000, lsp_format = 'fallback' },
})

-- Native LSP config files under lsp/*.lua are auto-discovered by name
vim.lsp.enable({ 'tsgo', 'vtsls' })

vim.diagnostic.config({ virtual_text = true, severity_sort = true })
