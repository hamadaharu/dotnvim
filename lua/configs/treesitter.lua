local ensureInstalled = {
    "c",
    "cpp",
    "css",
    "gotmpl",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "php",
    "query",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
}

local alreadyInstalled = require('nvim-treesitter').get_installed()

local parsersToInstall = vim.iter(ensureInstalled)
:filter(function(parser)
    return not vim.tbl_contains(alreadyInstalled, parser)
end)
:totable()

require('nvim-treesitter').install(parsersToInstall)
