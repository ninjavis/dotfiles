-- setup guide for vim.pack https://www.youtube.com/watch?v=XQuNoprFW38

-- init.lua is the entrypoint file for our configuration
-- to open netrw :Ex
-- to create a file in netrw hit %
-- to create a directory in netrw hit d
-- init.lua will be loading every single file from direcotry /lua
-- any file loaded from the /lua directory becomes a module

-- Experimental
-- In Neovim 0.12, require("vim._core.ui2").enable({}) activates ui2, an experimental core redesign of the command-line and message user interface.
-- It modernizes how Neovim handles command-line input and screen messages, aiming to eliminate legacy grid limitations and annoying "Press Enter" prompts.
-- Removes Interruptions:
-- It helps eliminate legacy "Press Enter" prompts when executing commands or displaying multiple lines of messages.
-- Better Command Line:
-- Highlights and updates the command-line area dynamically as you type.
-- Configurable Targets:
-- Allows routing messages and command feedback directly into the command line or dedicated message/pager buffers.
require("vim._core.ui2").enable({});

require("options")
require("keymaps")
require("commands")
require("pack")

-- For some reason,'n' <CR> opened Telescope live_grep_with_args. This fixes <CR> to just go to next line inside a buffer
-- vim.keymap.del('n', '<CR>')

