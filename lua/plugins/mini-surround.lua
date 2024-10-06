return {
  'echasnovski/mini.nvim',
  version = false,
  opts = {
    -- add any options here
  },
  config = function()
    require("mini.surround").setup()
  end
}
