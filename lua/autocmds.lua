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
