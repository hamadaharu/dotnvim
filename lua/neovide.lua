vim.o.guifont = "UbuntuMono Nerd Font:h12"

vim.keymap.set({ "n", "v" }, "<C-+>", "<CMD>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
vim.keymap.set({ "n", "v" }, "<C-->", "<CMD>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
vim.keymap.set({ "n", "v" }, "<C-0>", "<CMD>lua vim.g.neovide_scale_factor = 1<CR>")

vim.g.neovide_refresh_rate = 30
vim.g.neovide_no_idle = true

vim.g.neovide_cursor_vfx_mode = "railgun" -- or "torpedo", "pixiedust"
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2

vim.g.neovide_scroll_animation_length = 0.3

vim.g.neovide_opacity = 0.95 -- Jangan 0.0 (tembus pandang total bikin pusing)
vim.g.neovide_fullscreen = false
