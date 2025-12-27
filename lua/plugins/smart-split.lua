return {
	"mrjones2014/smart-splits.nvim",
    lazy = true,
    keys = {
        {"<A-Left>", function() require("smart-splits").resize_left(2) end, mode = { "n" }},
		{"<A-Down>", function() require("smart-splits").resize_down(2) end, mode = { "n" }},
		{"<A-Up>", function() require("smart-splits").resize_up(2) end, mode = { "n" }},
		{"<A-Right>", function() require("smart-splits").resize_right(2) end, mode = { "n" }},
    },
	config = function()
		local splits = require("smart-splits")
	end,
}
