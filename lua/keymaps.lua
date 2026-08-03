local map = vim.keymap.set
local opt = { noremap = true, silent = true }
vim.g.mapleader = " "

-- ###################
-- #### KeyMaping ####
-- ###################

opt.desc = ""

map("i", "jj", "<esc>", {})
map("t", "jj", "<C-\\><C-n>", {})
map({ "n", "v" }, ";", ":", {})
-- quit
map({ "n", "i", "v" }, "<C-q>", "<esc>:q<cr>", {
	noremap = true,
	silent = true,
})

-- TabNavigate
map("n", "<A-[>", "<cmd>tabNext<CR>", opt)
map("n", "<A-]>", "<cmd>tabnext<CR>", opt)
map("n", "<A-S-t>", "<cmd>tabnew<CR>", opt)

-- Soft line navigate
map("n", "<Down>", "gj", opt)
map("n", "<Up>", "gk", opt)
map("i", "<Down>", "<C-o>gj", opt)
map("i", "<Up>", "<C-o>gk", opt)
map("n", "j", "gj", opt)
map("n", "k", "gk", opt)

-- Quick Fix Navigate
opt.desc = "Next Quick Fix"
map("n", "<leader>.", "<CMD>cn<CR>", opt)
opt.desc = "Prev Quick Fix"
map("n", "<leader>,", "<CMD>cp<CR>", opt)

-- Php Arrow
opt.desc = "php ->"
map("i", "-.", "->", opt)
opt.desc = "php =>"
map("i", "=.", "=>", opt)



-- Go short declaration
opt.desc = "go :="
map("i", ";=", ":=", opt)

-- Save
opt.desc = "Save File"
map("n", "s", ":w<CR>", opt)

-- Buffer Toggle 
opt.desc = "Toggle Last 2 Buffer"
map("n", "<leader><leader>", ":b#<CR>", opt)

-- Close All Buffer
opt.desc = "Close All Buffer"
map("n", "<leader>bd", "<CMD>%bd<CR>", opt)

-- insert navigation
-- map("i", "<C-k>", "<Up>", opt1)
-- map("i", "<C-j>", "<Down>", opt1)
-- map("i", "<C-h>", "<C-Left>", opt1)
-- map("i", "<C-l>", "<C-Right>", opt1)
-- UMM THIS MAYBE BAD IDEA

--  remap always center
--  function! CentreCursor()
--      let pos = getpos(".")
--      normal! zz
--      call setpos(".", pos)
--  endfunction
--  nnoremap j jzz
--  nnoremap k kzz

-- horizontal slide
-- nnoremap <A-L> 5zl5l
-- nnoremap <A-H> 5zh5h
-- end horizontal slide

-- Vim Window Navigate
-- nnoremap <C-h> <C-w><C-h>
-- nnoremap <C-l> <C-w><C-l>
-- nnoremap <C-j> <C-w><C-j>
-- nnoremap <C-k> <C-w><C-k>
-- END

-- " ToggleTerm Manager
-- nnoremap <silent> <Space>ft <Cmd>Telescope toggleterm_manager<CR>
-- " End ToggleTerm Manager
--
-- " this tes line asa
-- " save remap
-- nnoremap <silent> <C-S> :update<CR>
