-- General Settings
local general = vim.api.nvim_create_augroup("General", { clear = true })

-- Remove all trailing whitespaces in buffer on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function(ev)
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Set indentation to 2 spaces
vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  -- pattern = { 'css', 'html', 'javascript',
  --   'lua', 'markdown', 'md', 'typescript',
  --   'scss', 'xml', 'xhtml', 'yaml'
  -- },
	pattern = { 'html' },
  command = 'setlocal shiftwidth=4 tabstop=4'
})

-- Fix Nvim Tree issues when restoring session. Sometimes Nvim Tree opens up weirdly or is an empty buffer.
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = 'NvimTree*',
  callback = function()
    local api = require('nvim-tree.api')
    local view = require('nvim-tree.view')

    if not view.is_visible() then
      api.tree.open()
    end
  end,
})

-- Remove auto comment new line
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  group = general,
  desc = "Disable New Line Comment",
})

-- Auto expand Nvim-Tree when it receives focus, and disable when losing focus
-- NOT WORKING YET
-- local group = vim.api.nvim_create_augroup("nvim_tree", { clear = true })

-- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
--   -- pattern = 'NvimTree*',
--   pattern = "NvimTreeBuf",
--   callback = function()
--     print("TreeOpen 3")
--     -- local api = require('nvim-tree.api')
--     local view = require('nvim-tree.view')
--
--     view.adaptive_resize = true
--   end,
-- })

-- vim.api.nvim_create_autocmd("BufEnter", {
--     pattern = "NvimTreeBuf",
--     callback = function()
--     print("buf entering")
--         require("nvim-tree").setup({
--             force = true,
--             view = {
--                 adaptive_resize = true,
--             },
--         })
--     end,
--     group = group,
-- })
--
-- vim.api.nvim_create_autocmd("BufLeave", {
--     pattern = "NvimTreeBuf",
--     callback = function()
--     print("buf leaving")
--         require("nvim-tree").setup({
--             force = true,
--             view = {
--                 adaptive_resize = false,
--             },
--         })
--     end,
--     group = group,
-- })
