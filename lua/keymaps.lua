-- CUSTOM KEYMAPS
local keymap = vim.keymap

-- Set <leader>
keymap.set('n', '<Space>', '')
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remap <esc>
keymap.set('i', 'jj', '<esc>')

-- Enter command mode quicker
keymap.set({'n', 'v'}, ';', ':')

-- Window Navigation
-- keymap.set('n', '<m-h>', '<C-w>h') -- jump window left
-- keymap.set('n', '<m-l>', '<C-w>l') -- jump window right
-- keymap.set('n', '<m-k>', '<C-w>k') -- jump window up
-- keymap.set('n', '<m-j>', '<C-w>j') -- jump window down
keymap.set('n', '<left>', '<C-w>h') -- jump window left
keymap.set('n', '<right>', '<C-w>l') -- jump window right
keymap.set('n', '<up>', '<C-w>k') -- jump window up
keymap.set('n', '<down>', '<C-w>j') -- jump window down

-- Center screen on search word/next/prev
keymap.set('n', 'n', 'nzz')
keymap.set('n', 'N', 'Nzz')
keymap.set('n', '*', '*zz')
keymap.set('n', '#', '#zz')
keymap.set('n', 'gd', 'gdzz')

-- Save Buffer
keymap.set('n', '<C-s>', ':w<CR>') -- save file with CTRL+s
-- keymap.set('i', '<C-s>', '<esc>:w<CR>a') -- save file when in insert mode then return to insert mode
keymap.set('i', '<C-s>', '<esc>:w<CR>') -- exit insert mode then save file
keymap.set('v', '<C-s>', '<esc>:w<CR>') -- exit visual mode then save file

-- Manipulate lines
keymap.set('n', '<A-K>', ':m .-2<CR>==') -- move line up(n)
keymap.set('n', '<A-J>', ':m .+1<CR>==') -- move line down(n)
keymap.set('v', '<A-K>', ":m '<-2<CR>gv=gv") -- move line/selection up(v)
keymap.set('v', '<A-J>', ":m '>+1<CR>gv=gv") -- move line/selection down (v)

keymap.set({'n','v'}, '<A-j>', ':co.<CR>') -- duplicate line down
keymap.set('i', '<A-,>', '<BS>') -- Alt + comma to backspace(i)
keymap.set('i', '<A-.>', '<del>') -- Alt + fullstop to delete(i)

-- Stay in indent mode and visual mode after indenting
keymap.set('v', '>', '>gv')
keymap.set('v', '<', '<gv')

-- Keep Copied value after replacing with pasted value
keymap.set('x', 'p', '[["_dP]]')
keymap.set('n', ',p', '"0p')
keymap.set('n', ',P', '"0P')

-- NEOVIDE SPECIFIC
-- Enable zoom in/out
if vim.g.neovide == true then
  vim.api.nvim_set_keymap("n", "<C-=>", ":lua vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1,  1.0)<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1,  0.1)<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-+>", ":lua vim.g.neovide_transparency = math.min(vim.g.neovide_transparency + 0.05, 1.0)<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-_>", ":lua vim.g.neovide_transparency = math.max(vim.g.neovide_transparency - 0.05, 0.0)<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 0.5<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-)>", ":lua vim.g.neovide_transparency = 0.9<CR>", { silent = true })
end
