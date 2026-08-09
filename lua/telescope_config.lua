-- 1. Run the main telescope setup
-- require('telescope').setup()
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    },
    file_ignore_patterns = { 'node%_modules', '.angular', '.git', 'dist', 'assets', 'e2e', 'tslint.json', 'package%-lock.json' },
  },
  pickers = {},
  extensions = {
    -- ADD THE FILE BROWSER EXTENSION CONFIG HERE:
    file_browser = {
      theme = "ivy",                  -- Uses an elegant bottom split view layout
      hijack_netrw = false,            -- Disables netrw and opens telescope-file-browser instead
      hidden = { file = true, folder = true }, -- Shows hidden dotfiles (like .git, .env, etc.)
    }
  }
})

-- 2. Load the native FZF extension (compiled by vim.pack)
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'file_browser') -- Loads the browser

-- 3. Define telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', {
  noremap = true,
  desc = 'Telescope open file browser'
})
