local CS = function(color)
	vim.cmd("colorscheme" .. " " .. color)
end

return {
	-- colorscheme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function ()
			require("configs.catppuccin")
			CS("catppuccin")
		end,
	},

	-- extra appearance
	{
		"xiyaowong/transparent.nvim",
		event = { "VeryLazy" },
		config = function()
			require("transparent").setup({
				groups = {
					"Normal",
					"NormalNC",
					"Comment",
					"Constant",
					"Special",
					"Identifier",
					"Statement",
					"PreProc",
					"Type",
					"Underlined",
					"Todo",
					"String",
					"Function",
					"Conditional",
					"Repeat",
					"Operator",
					"Structure",
					"LineNr",
					"NonText",
					"SignColumn",
					"CursorLine",
					"CursorLineNr",
					"StatusLine",
					"StatusLineNC",
					"EndOfBuffer",
				},
				extra_groups = {},
				exclude_groups = {},
			})
		end,
	},

	{ "stevearc/dressing.nvim", event = "VeryLazy" },
}
