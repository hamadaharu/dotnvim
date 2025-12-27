vim.o.guifont = "UbuntuMono Nerd Font:h12"

vim.keymap.set({ "n", "v" }, "<C-+>", "<CMD>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
vim.keymap.set({ "n", "v" }, "<C-->", "<CMD>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
vim.keymap.set({ "n", "v" }, "<C-0>", "<CMD>lua vim.g.neovide_scale_factor = 1<CR>")

