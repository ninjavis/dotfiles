-- https://github.com/lukas-reineke/indent-blankline.nvim
-- show vertical lines to indicate indentation
return { 
  "lukas-reineke/indent-blankline.nvim", 
  main = "ibl",
  config = function()
    require("ibl").setup({
      scope = { enabled = false }
    })
  end
}
