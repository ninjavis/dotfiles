-- require("bufferline").setup({})
require("bufferline").setup({
  options = {
    truncate_names = false,
    separator_style = "slant",
    -- stylua: ignore
    close_command = function(n) require("mini.bufremove").delete(n, false) end,
    -- stylua: ignore
    right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    always_show_bufferline = true,
    -- diagnostics_indicator = function(_, _, diag)
      --   local icons = require("lazyvim.config").icons.diagnostics
      --   local ret = (diag.error and icons.Error .. diag.error .. " " or "")
      --   .. (diag.warning and icons.Warn .. diag.warning or "")
      --   return vim.trim(ret)
      -- end,
    offsets = {
      {
        filetype = "nvim-tree",
        text = "Nvim-tree",
        highlight = "Directory",
        text_align = "left",
      },
    },
  }
})
