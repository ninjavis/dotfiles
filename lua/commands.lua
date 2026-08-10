-- General Settings
local general = vim.api.nvim_create_augroup("General", { clear = true })

-- custom user commands for managing pack plugins.
-- Will most likely just use PackUpdate to update either specific plugins or all of them.
vim.api.nvim_create_user_command("PackAdd", function(opts)
  vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (:PackAdd user/repo1 user/repo2)" })

-- Pack Delete and Update cmds are built-in on Nightly 0.13
vim.api.nvim_create_user_command("PackDel", function(opts)
  vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackDel plugin1 plugin2)" })

-- PackUpdate checks all plugins nvim has installed in ~/.local/share/nvim-pack/site/pack
vim.api.nvim_create_user_command("PackUpdate", function(opts)
  -- checks if any argument is passed
  if opts.args:match("%S") then
    -- update specific plugins
    local plugins = vim.split(opts.args, "%s+", { trimempty = true })
    -- update only specified plugins
    vim.pack.update(plugins)
  else
    -- update all
    vim.pack.update()
  end
end, { nargs = "*", desc = "Update all plugins or specific ones" })

-- Remove all trailing whitespaces in buffer on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function(_)
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Remove auto comment new line
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  group = general,
  desc = "Disable New Line Comment",
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('my.lsp', {}),
--   callback = function(ev)
--     local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
--     -- if client:supports_method('textDocument/implementation') then
--     --   -- Create a keymap for vim.lsp.buf.implementation ...
--     -- end
--
--     -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
--     if client:supports_method('textDocument/completion') then
--       -- Optional: trigger autocompletion on EVERY keypress. May be slow!
--       -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
--       -- client.server_capabilities.completionProvider.triggerCharacters = chars
--
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--
--     -- Auto-format ("lint") on save.
--     -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
--     -- if not client:supports_method('textDocument/willSaveWaitUntil')
--     --     and client:supports_method('textDocument/formatting') then
--     --   vim.api.nvim_create_autocmd('BufWritePre', {
--     --     group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
--     --     buffer = ev.buf,
--     --     callback = function()
--     --       vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
--     --     end,
--     --   })
--     -- end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("CompleteDone", {
--   callback = function()
--     -- Get the completed item details
--     local completed_item = vim.v.completed_item
--     -- local user_data = completed_item.user_data
--
--     -- Exit early if no item was selected
--     if not completed_item or not completed_item.kind then
--       return
--     end
--
--     -- 1. Append brackets after Method/Function is selected in autocomplete + move cursor inside.
--     if completed_item.kind == "Function" or completed_item.kind == "Method" then
--       -- Insert brackets and move the cursor left into them
--       -- Using feedkeys ensures it behaves natively as if typed
--       vim.api.nvim_feedkeys(
--         vim.api.nvim_replace_termcodes("()<Left>", true, false, true),
--         "n",
--         true
--       )
--     end
--
--     -- 2. Defer signature help slightly so Neovim settles into the new cursor position first
--     vim.schedule(function()
--       vim.lsp.buf.signature_help()
--     end)
--
--   end,
-- })
--
-- -- 1. TURN OFF autocomplete when entering a Telescope prompt
-- -- Create an isolated group to cleanly manage Telescope autocompletion overrides
-- local telescope_complete_grp = vim.api.nvim_create_augroup("TelescopeAutoCompleteToggle", { clear = true })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "TelescopePrompt",
--   group = telescope_complete_grp,
--   callback = function()
--     -- Disable the global auto-trigger loop completely while searching
--     vim.o.autocomplete = false
--
--     -- Clear fallback variables out of this buffer safely
--     vim.bo.omnifunc = ""
--     vim.bo.completefunc = ""
--
--     -- Safely local-bind navigation mappings inside this specific Telescope window
--     local opts = { silent = true, buffer = true }
--     vim.keymap.set("i", "<Tab>", function()
--       require("telescope.actions").move_selection_next(vim.api.nvim_get_current_buf())
--     end, opts)
--
--     vim.keymap.set("i", "<S-Tab>", function()
--       require("telescope.actions").move_selection_previous(vim.api.nvim_get_current_buf())
--     end, opts)
--   end,
-- })
--
-- -- 2. TURN ON autocomplete when leaving the Telescope prompt buffer
-- vim.api.nvim_create_autocmd("BufLeave", {
--   pattern = "*",
--   group = telescope_complete_grp,
--   callback = function()
--     -- Check if the buffer we are exiting is actually Telescope
--     if vim.bo.filetype == "TelescopePrompt" then
--       -- Safely restore global auto-triggers so coding files get suggestions back
--       vim.o.autocomplete = true
--     end
--   end,
-- })

-- Handle large files - disable performance killers for files larger than 1mb
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function()
    local max_filesize = 1024 * 1024 -- 1 Megabyte ceiling
    local check_file = vim.fn.expand("<afile>")
    local status, stats = pcall(vim.uv.fs_stat, check_file)

    -- If the file is massive, turn off the heavy features instantly
    if status and stats and stats.size > max_filesize then
      vim.opt_local.swapfile = false
      vim.opt_local.bufhidden = "unload"
      vim.opt_local.undolevels = -1

      -- Disable heavy UI rendering elements for this buffer
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.relativenumber = false

      -- Stop matchparen plugin from scanning matching brackets on large file scroll
      vim.g.loaded_matchparen = 1

      -- Scheduled safety cleanup once the buffer is open
      vim.schedule(function()
        vim.cmd("syntax off") -- Kill classic regex syntax highlighting
      end)
    end
  end,
})
