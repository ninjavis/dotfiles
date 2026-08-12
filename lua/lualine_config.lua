require("lualine").setup({
  options = {
    section_separators = { left = '', right = '' },
    -- theme = my_lualine_theme,
  },
  sections = {
    lualine_a = { 'mode' },                            -- avw
    lualine_b = { 'branch', 'diff', 'diagnostics' },   -- avw
    lualine_c = { 'filename' },                        -- avw
    lualine_x = {
      { "encoding" },
      { "fileformat" },
      { "filetype" },
    },
    lualine_y = {
      {
        function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_get_option_value('modified', { buf = buf }) then
              return 'UNSAVED ' -- any message or icon
            end
          end
          return ''
        end,
      },
    },
    lualine_z = {
      -- Custom time component
      {
        function()
          return os.date('%H:%M') -- Displays 24-hour time (e.g., "14:30")
        end,
      },
    }
  }
})
