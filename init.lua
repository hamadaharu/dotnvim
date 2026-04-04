require('options')
if vim.g.neovide then
    require("neovide")
end

require('keymaps')
require('autocmd')
require('configs.lazy')

function Inspect(table)
  print(vim.inspect(table))
end
