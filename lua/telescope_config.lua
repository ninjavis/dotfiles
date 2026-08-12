-- 1. Run the main telescope setup
local tscope = require("telescope")

tscope.setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = { width = 0.97, height = 0.97 },
      -- preview_cutoff = 999,
      -- other layout configuration here
    },
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    },
    file_ignore_patterns = { 'node%_modules', '.angular', '.git', 'dist', 'assets', 'e2e', 'tslint.json', 'package%-lock.json' },
  },
  pickers = {},
  extensions = {
    -- ADD THE FILE BROWSER EXTENSION CONFIG HERE:
    file_browser = {
      theme = "ivy",                  -- Uses an elegant bottom split view layout
      hijack_netrw = false,            -- Disables netrw and opens telescope-file-browser instead
      hidden = { file = true, folder = true }, -- Shows hidden dotfiles (like .git, .env, etc.)
    }
  }
})

tscope.load_extension("live_grep_args")

-- 2. Load the native FZF extension (compiled by vim.pack)
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'file_browser') -- Loads the browser

-- 3. Define telescope keymaps
local builtin = require('telescope.builtin')

-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' }) -- to open Telescope help docs
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-n>', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<C-b>', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>D',"<cmd>Telescope diagnostics bufnr=0<CR>", { desc = 'Telescope help tags' })

-- Live Grep with Args allows for searching specific folders and files
local function live_grep_current_dir_args()
  -- 1. Get the absolute directory path of the active buffer
  local absolute_buffer_dir = vim.fs.dirname(vim.fn.expand('%:p'))
  local project_root = vim.fn.getcwd()

  local relative_dir = ""

  -- 2. Manually strip the project root prefix from the absolute path
  if absolute_buffer_dir:sub(1, #project_root) == project_root then
    -- Extract everything after the project root path
    relative_dir = absolute_buffer_dir:sub(#project_root + 1)
    -- Remove a leading slash if it exists (e.g., "/src/components" -> "src/components")
    if relative_dir:sub(1, 1) == "/" then
      relative_dir = relative_dir:sub(2)
    end
  end

  -- 3. Clean up evaluation edge cases and add trailing slash
  if relative_dir == "" or relative_dir == "." then
    relative_dir = ""
  else
    relative_dir = relative_dir .. "/"
  end

  -- 4. Construct the template string (Outputs exactly: "" -g "src/components/**")
  local template_text = string.format('"xwxw" -g "%s**"', relative_dir)

  -- 5. Calculate character shift back inside the quotes
  -- local move_left_count = string.len(template_text) - 1
  local cursor_escape = vim.api.nvim_replace_termcodes(string.format('<Left>', 0), true, false, true)

  -- 6. Launch Telescope with deferred cursor positioning
  require('telescope').extensions.live_grep_args.live_grep_args({
    default_text = template_text,
    attach_mappings = function(_, _)
      vim.schedule(function()
        vim.api.nvim_feedkeys(cursor_escape, 'm', true)
      end)
      return true
    end
  })
end

-- can't set keymap below to <C-m> because <C-m> maps to <CR> automatically
vim.keymap.set('n', '<C-g>', live_grep_current_dir_args, { desc = 'Telescope live grep with search directory of current buffer'}) -- global search with args

-- vim.keymap.set('n', '<C-n>', "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {}) -- global search with args

-- vim.keymap.set('n', '<C-b>', ':Telescope file_browser<CR>', { desc = 'Telescope open file browser' }) -- does not work if netrw is open, only if file is open

-- Telescope file_browser default keymaps
-- <A-c>/c 	  create	              Create file/folder at current path (trailing path separator creates folder)
-- <S-CR>  	  create_from_prompt	  Create and open file/folder from prompt (trailing path separator creates folder)
-- <A-r>/r	  rename	              Rename multi-selected files/folders
-- <A-m>/m	  move	                Move multi-selected files/folders to current path
-- <A-y>/y	  copy	                Copy (multi-)selected files/folders to current path
-- <A-d>/d	  remove	              Delete (multi-)selected files/folders
-- <C-o>/o	  open	                Open file/folder with default system application
-- <C-g>/g	  goto_parent_dir	      Go to parent directory
-- <C-e>/e	  goto_home_dir	        Go to home directory
-- <C-w>/w	  goto_cwd	            Go to current working directory (cwd)
-- <C-t>/t	  change_cwd	          Change nvim's cwd to selected folder/file(parent)
-- <C-f>/f	  toggle_browser	      Toggle between file and folder browser
-- <C-h>/h	  toggle_hidden	        Toggle hidden files/folders
-- <C-s>/s	  toggle_all	          Toggle all entries ignoring ./ and ../
-- <Tab>	    see telescope.nvim	  Toggle selection and move to next selection
-- <S-Tab>	  see telescope.nvim	  Toggle selection and move to prev selection
-- <bs>/	    backspace	            With an empty prompt, goes to parent dir. Otherwise acts normally
