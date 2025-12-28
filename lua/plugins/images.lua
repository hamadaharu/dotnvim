return {
    {
        "edluffy/hologram.nvim",
        enabled = false,
    },
    {
        "3rd/image.nvim",
        dependencies = {
            {
                "vhyrro/luarocks.nvim",
                priority = 1001, -- this plugin needs to run before anything else
                opts = {
                    rocks = { "magick" },
                },
            },
        },
        ft = {
            -- "md",
            -- "markdown",
            -- "markdown_inline"
        },
        config = function()
            -- ...
        end,
    },
}
