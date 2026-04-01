local o = vim.opt

o.showmatch = true          -- show matching
o.ignorecase = true         -- case insensitive
o.mouse = "v"               -- middle-click paste with
o.hlsearch = true           -- highlight search
o.incsearch = true          -- incremental search
o.tabstop = 4               -- number of columns occupied by a tab
o.softtabstop = 4           -- see multiple spaces as tabstops so <BS> do>
o.expandtab = true          -- converts tabs to white space
o.shiftwidth = 4            -- width for autoinden:s
o.autoindent = true         -- indent a new line the same amount as the l>
o.smartindent = true
o.number = true             -- add line numbers
o.relativenumber = true     -- relative number on
o.wildmode = "full"         -- Comand Auto COmplete Listing
o.mouse = "a"               -- mouse click
o.clipboard = "unnamedplus" -- systen clipboard
o.linebreak = true          -- Break Words by Words
o.breakindent = true        -- Space Indention
o.cursorline = true         -- Cursor Line

o.ttyfast = true            -- speed up scrolling
o.sidescroll = 1            -- enable side scrolling
o.so = 999                  -- cursor on center
o.splitbelow = true         -- Split on bellow
o.exrc = true               -- Source dir config
-- o.nowrap = true
o.foldlevel = 20
-- o.foldmethod = "expr"
-- o.foldexpr = "nvim_treesitter#foldexpr()"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

o.laststatus = 3 -- just one status line pls

-- enable loader
vim.loader.enable()

vim.cmd([[filetype plugin indent on]])
vim.cmd([[filetype plugin on]])
vim.cmd([[autocmd FileType php setlocal autoindent]])
vim.cmd([[autocmd FileType javascriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab]])
