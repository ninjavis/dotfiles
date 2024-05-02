-- CUSTOM OPTIONS
-- disable netrw at the very start of your init.lua

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.signcolumn = "yes" -- show two columns for line numbers and symbols( prevents shifting )

vim.opt.number = true -- show line number
vim.opt.relativenumber = true -- show relative line number from cursor

vim.opt.splitbelow = true -- when opening, for instance :help, split the window by default below
vim.opt.splitright = true -- default horizontal split to the right

vim.opt.wrap = false -- disable line wrapping

vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.tabstop = 2 -- two spaces for tab
vim.opt.shiftwidth = 2 -- two spaces for tab

vim.opt.clipboard = "unnamedplus" -- sync with system clipboard

vim.opt.virtualedit = "block" -- allow virtual block mode to ignore line limitations

vim.opt.scrolloff = 8 -- scroll page when cursor is 8 lines from top/bottom
vim.opt.sidescrolloff = 8 -- scroll page when cursor is 8 spaces from left/right

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.termguicolors = true -- enable true color support 24bit

vim.opt.cursorline = true -- enable line curor line highligt

-- default terminal
-- vim.g.terminal_emulator = 'powershell'
-- vim.api.nvim_set_var('terminal_emulator', 'powershell')
-- vim.opt.shell = 'powershell.exe'


-- SETUP POWERSHELL FOR TOGGLETERM
-- local powershell_options = {
--   shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
--   -- shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
--   shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
--   shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
--   shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
--   shellquote = "",
--   shellxquote = "",
-- }
--
-- for option, value in pairs(powershell_options) do
--   vim.opt[option] = value
-- end

-- SETUP GIT BASH FOR TOGGLETERM
vim.cmd [[let &shell = '"C:/Program Files/Git/bin/sh.exe"']]
vim.cmd [[let &shellcmdflag = '-s']]

-- vim.o.guicursor = 'n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,i:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'
-- vim.o.guicursor = 'n:highlight Cursor gui=NONE guifg=#ff000 guibg=#00ff00'

-- backup
vim.opt.backup = false
vim.opt.swapfile = false

-- set formatoptions-=cro
-- vim.opt_local.formatoptions:remove({'c', 'r', 'o' })

---@diagnostic disable-next-line: undefined-global, lowercase-global
shada = "NONE" -- disable nvim-data/shada folder containing persistent data for shared instances of nvim

-- vim.cmd [[
--     highlight nCursor guifg=#752f4d guibg=#ba7cbb
--     highlight iCursor guifg=#1b1818 guibg=#97bad0
--     highlight vCursor guifg=#1b1818 guibg=#FFFFFF
--     highlight rCursor guifg=#1b1818 guibg=#FFFFFF
--     highlight Cursor guifg=#1b1818 guibg=#FFFFFF
--     highlight cCursor guifg=#1b1818 guibg=#FFFFFF
--     set guicursor=n:block-Cursor
--     set guicursor+=i:block-iCursor
--     set guicursor+=n-v-c:noblink
--     set guicursor+=n-c:noblink
--     set guicursor+=v:noblink-vCursor
--     set guicursor+=r:noblink-rCursor
--     set guicursor+=c:noblink-cCursor
--     set guicursor+=i:blinkwait0
--   ]]

-- Disable calculating relative line number when scrolling.
-- do
--   -- register autocommand callacks to cleverly toggle
--   -- relative numbers when scrolling, .. this works
--   -- around the issue with frames dropped in neovide
--   -- when scrolling quickly with relative numbering on
--
--   -- this autocommand turns relative numbering off when we begin to scroll
--   vim.api.nvim_create_autocmd({ "WinScrolled" }, {
--     callback = function(ev)
--       if vim.o.relativenumber then
--         vim.cmd('set relativenumber norelativenumber')
--       end
--     end
--   })
--
--   -- this autocommand turns relative numberin on when we have idled (stopped scrolling)
--   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI"}, {
--     callback = function(ev)
--       if not vim.o.relativenumber then
--         vim.cmd('set relativenumber relativenumber')
--       end
--     end
--   })
-- end

-- NEOVIDE specific settings
if vim.g.neovide then

  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  vim.g.neovide_scroll_animation_length = 0.2

  vim.g.neovide_hide_mouse_when_typing = true

  vim.g.neovide_unlink_border_highlights = true

  vim.g.neovide_refresh_rate = 144

  -- vim.g.neovide_profiler = true

  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_trail_size = 0.5

end