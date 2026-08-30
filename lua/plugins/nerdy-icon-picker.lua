return {
    '2kabhishek/nerdy.nvim',
    lazy = true,
    dependencies = {
        'stevearc/dressing.nvim',
        'nvim-telescope/telescope.nvim',
    },
    cmd = 'Nerdy',
    opts = {
        max_recents = 30,
        copy_to_clipboard = false,
        copy_register = '+',
    },
    keys = {
      {"<leader>fi", ":Nerdy<cr>", desc = "Nerd Icons Picker", silent = true}
    }
}
