-- ~/.config/nvim/lsp/angularls.lua

-- In Mason 2.0+, we find the path via stdpath
local mason_path = vim.fn.stdpath("data") .. "/mason"
local angular_install_path = mason_path .. "/packages/angular-language-server"

local cmd = {
  "ngserver",
  "--stdio",
  "--tsProbeLocations",
  table.concat({ angular_install_path, vim.fn.getcwd() }, ","),
  "--ngProbeLocations",
  table.concat({ angular_install_path .. "/node_modules/@angular/language-server", vim.fn.getcwd() }, ","),
}

return {
  cmd = cmd,
  on_new_config = function(new_config, _)
    new_config.cmd = cmd
  end,
}
