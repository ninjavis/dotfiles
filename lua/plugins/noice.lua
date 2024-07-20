-- https://github.com/folke/noice.nvim
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function()
    -- require("noice").setup()
    require("noice").setup({
        views = {
          cmdline_popup = {
            position = {
              row = 2,
              col = "50%",
            },
            size = {
              width = 70,
              height = "auto",
            },
          },
          popupmenu = {
            enabled = true, -- enables the Noice popupmenu UI
            ---@type 'nui'|'cmp'
            backend = "cmp", -- backend to use to show regular cmdline completions
            relative = "editor",
            position = {
              row = 5,
              col = "50%",
            },
            size = {
              width = 60,
              height = 10,
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
          },
        },
      })
  end
}
