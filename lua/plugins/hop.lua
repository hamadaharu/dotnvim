return {
    "smoka7/hop.nvim",
    version = "*",
    cmd = {
        "HopLineMW",
        "HopWord",
        "HopLine",
        "HopChar1",
        "HopChar2",
        "HopLineAC",
        "HopLineBC",
        "HopWordAC",
        "HopWordBC",
        "HopWordMW",
        "HopChar1AC",
        "HopChar1BC",
        "HopChar1MW",
        "HopChar2AC",
        "HopChar2BC",
        "HopChar2MW",
        "HopPattern",
        "HopAnywhere",
        "HopVertical",
        "HopCamelCase"
    },
    keys = {
        {
            "<leader>qw",
            "<cmd>HopWord<cr>",
            noremap = true,
            desc = "Hop Hop Word",
        },
        {
            "<leader>qe",
            "<cmd>HopAnywhere<cr>",
            noremap = true,
            desc = "Hop Anywhere"
        }
    },
    config = function()
        require("hop").setup()
    end,
}
