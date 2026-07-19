return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon Add" },
        { "<M-e>", function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, desc = "Harpoon Menu" },
        { "<M-1>", function() require("harpoon"):list():select(1) end },
        { "<M-2>", function() require("harpoon"):list():select(2) end },
        { "<M-3>", function() require("harpoon"):list():select(3) end },
        { "<M-4>", function() require("harpoon"):list():select(4) end },
        { "<M-5>", function() require("harpoon"):list():select(5) end },
        { "<M-6>", function() require("harpoon"):list():select(6) end },
        { "<M-7>", function() require("harpoon"):list():select(7) end },
        { "<M-8>", function() require("harpoon"):list():select(8) end },
        { "<M-9>", function() require("harpoon"):list():prev() end },
        { "<M-0>", function() require("harpoon"):list():next() end },
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()
    end,
}
