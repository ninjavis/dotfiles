-- Initialize blink.cmp with default settings
require('blink.cmp').setup({
  -- Keymaps fallback to 'default' if not explicitly stated
  keymap = { 
    preset = 'none',
    -- control whether the next command will be run when using a function
    -- Overriding select_next, select_prev, and accept
    ['<C-j>'] = { 'select_next' },
    ['<C-k>'] = { 'select_prev' },
    ['<CR>'] = { 'accept', 'fallback' },

    -- Optional: Keep these standard controls active
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide' },
    ['<C-b>'] = { 'scroll_documentation_up' },
    ['<C-f>'] = { 'scroll_documentation_down' },
  },

  -- Define completion sources
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  fuzzy = { implementation = "prefer_rust_with_warning" }
})

