return {
  'nvim-telescope/telescope.nvim',
  --  tag = '0.1.5',
  branch = '0.1.x',
  dependencies = {
    "nvim-telescope/telescope-live-grep-args.nvim" ,
    -- This will not install any breaking changes.
    -- For major updates, this must be adjusted manually.
    version = "^1.0.0",
    'nvim-lua/plenary.nvim',
    -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  },
  event = "VeryLazy",
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require('telescope.builtin')

    -- map telescope.nvim keybindings
    vim.keymap.set('n', '<C-p>', builtin.find_files, {}) -- find files
    vim.keymap.set('n', '<C-b>', builtin.buffers, {}) -- view open buffers
    -- vim.keymap.set('n', '<C-n>', builtin.live_grep, {}) -- global search
    vim.keymap.set('n', '<C-n>', "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {}) -- global search with args
    -- vim.keymap.set('n', '<C-t>', builtin.treesitter, {}) -- global search
    vim.keymap.set('n', '<C-t>', builtin.lsp_document_symbols, {}) -- see file overview
    -- vim.keymap.set('n', '<C->', builtin.oldfiles, {}) -- view list of last searched files
    -- vim.keymap.set('n', '<C->', builtin.grep_string, {}) -- search files for string under cursor


    telescope.setup({
      defaults = {
        layout_strategy = 'vertical',
        layout_config = {
          vertical = { width = 0.9, height = 0.9 },
          -- preview_cutoff = 999,
          -- other layout configuration here
        },
        file_ignore_patterns = { 'node%_modules', '.angular', '.git', 'dist', 'assets', 'e2e', 'tslint.json', 'package%-lock.json' },
        -- other defaults configuration here
        mappings = {
          i = {
            -- ["<esc>"] = actions.close,
            -- ["<CR>"] = actions.select_default,
            -- ["<C-n>"] = actions.cycle_history_next,
            -- ["<C-p>"] = actions.cycle_history_prev,
            -- ["<C-j>"] = actions.move_selection_next,
            -- ["<C-k>"] = actions.move_selection_previous,
            -- ["<C-c>"] = actions.close,
            -- ["<C-t>"] = actions.select_tab,
            -- ["<C-s>"] = actions.select_horizontal,
            -- ["<C-v>"] = actions.select_vertical,
            -- ["<C-u>"] = actions.preview_scrolling_up,
            -- ["<C-d>"] = actions.preview_scrolling_down,
            -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-q>"] = actions.smart_send_to_qflist,
            -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          },
          n = {
            -- ["<esc>"] = actions.close,
            -- ["<CR>"] = actions.select_default,
            -- ["s"] = actions.select_horizontal,
            -- ["v"] = actions.select_vertical,
            -- ["t"] = actions.select_tab,
            -- ["K"] = actions.preview_scrolling_up,
            -- ["J"] = actions.preview_scrolling_down,
            -- ["n"] = actions.cycle_history_next,
            -- ["p"] = actions.cycle_history_prev,
            -- ["j"] = actions.move_selection_next,
            -- ["k"] = actions.move_selection_previous,
            -- ["c"] = actions.close,
            -- ["H"] = actions.move_to_top,
            -- ["M"] = actions.move_to_middle,
            -- ["L"] = actions.move_to_bottom,
            -- ["gg"] = actions.move_to_top,
            -- ["G"] = actions.move_to_bottom,
            -- ["q"] = actions.send_to_qflist + actions.open_qflist,
            ["q"] = actions.smart_send_to_qflist,
            -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          },
        },
      },
      -- other configuration values here
    })

    -- AvW - auto open telescope when nvim starts.
    -- vim.cmd('Telescope find_files')

    -- telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")

  end
}

