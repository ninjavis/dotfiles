require("keymaps")
require("options")
require("autocmds")
require("package-manager")

-- Change buffer background/row highlight color when in insert mode
-- https://www.reddit.com/r/neovim/comments/q8tlyb/how_to_get_values_from_the_current_color_scheme/
-- :lua =vim.api.nvim_get_hl_by_name("Normal", true)
-- local backgroundDecimal = vim.api.nvim_get_hl_by_name("Normal", true).background
-- local background = string.format("%06x", backgroundDecimal)
--
-- local cursorLineHighlightDecimal = vim.api.nvim_get_hl_by_name("CursorLine", true).background
-- local cursorLineHighlight = "#" .. string.format("%06x", cursorLineHighlightDecimal)
--
-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--   callback = function()
--     -- vim.api.nvim_set_hl(0, "Normal", {bg="#110000"})
--     vim.api.nvim_set_hl(0, "CursorLine", {bg="#362f45"})
--     print(cursorLineHighlight)
--
--   end
-- })
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--   callback = function()
--     -- vim.api.nvim_set_hl(0, "Normal", {bg="#" .. background})
--     vim.api.nvim_set_hl(0, "CursorLine", {bg=cursorLineHighlight})
--   end
-- })
