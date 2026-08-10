require("nvim-tree").setup({
  view = {
    -- width = 35,
    -- relativenumber = true,
    -- adaptive_size = false, -- Auto Resize Tree to fit file name
    centralize_selection = true
  },
  -- change folder arrow icons
  renderer = {
    root_folder_label = false,
    indent_markers = {
      enable = true,
    },
    --   icons = {
    --     glyphs = {
    --       folder = {
    --         arrow_closed = "", -- arrow when folder is closed
    --         arrow_open = "", -- arrow when folder is open
    --       },
    --     },
    --   },
  },
  -- focus open buffer
  update_focused_file = {
    enable = true
  },
  -- disable window_picker for
  -- explorer to work well with
  -- window splits
  actions = {
    open_file = {
      -- resize_window = true,
      window_picker = {
        enable = false,
      },
    },
  },
  filters = {
    custom = { ".DS_Store", "^.git$" },
  },
  git = {
    ignore = false,
  },
  -- modified = {
  --   enable = true
  -- }

})
