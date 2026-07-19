return {
    "MunsMan/kitty-navigator.nvim",
    build = {
        "cp navigate_kitty.py ~/.config/kitty",
        "cp pass_keys.py ~/.config/kitty",
    },
    keys = {
        { "<C-h>", function() require("kitty-navigator").navigateLeft() end, desc = "Move left a Split", mode = { "n", "t" } },
        { "<C-j>", function() require("kitty-navigator").navigateDown() end, desc = "Move down a Split", mode = { "n", "t" } },
        { "<C-k>", function() require("kitty-navigator").navigateUp() end,  desc = "Move up a Split",    mode = { "n", "t" } },
        { "<C-l>", function() require("kitty-navigator").navigateRight() end, desc = "Move right a Split", mode = { "n", "t" } },
    },
    opts = {
        keybindings = {
            left = "<C-h>",
            down = "<C-j>",
            up = "<C-k>",
            right = "<C-l>",
        },
    },
}
