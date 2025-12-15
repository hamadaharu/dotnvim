local CS = function(color)
	vim.cmd("colorscheme" .. " " .. color)
end


return {
	-- colorscheme
	{
		"catppuccin/nvim",
		name = "catppuccin",
    -- lazy = true,
		priority = 1000,
    config = function ()
      require("configs.catppuccin")
      CS("catppuccin")
    end,
	},

	{
		"dracula/vim",
		priority = 1000,
		-- lazy = true,
    config = function ()
      -- CS("dracula")
    end,
	},

	{
		"folke/tokyonight.nvim",
		priority = 1000,
		-- lazy = true,
    config = function ()
      -- CS("tokyonight")
      vim.cmd("hi CursorLineNr guifg=#000")
    end,
	},

	-- extra appearance
	{
		"xiyaowong/transparent.nvim",
        event = { "VeryLazy" },
		config = function()
			require("transparent").setup({ -- Optional, you don't have to run setup.
				groups = { -- table: default groups
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
				extra_groups = {}, -- table: additional groups that should be cleared
				exclude_groups = {}, -- table: groups you don't want to clear
			})
		end,
	},

	{ "stevearc/dressing.nvim", event = "VeryLazy" },
}
