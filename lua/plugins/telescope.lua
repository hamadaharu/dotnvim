return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files", silent = true },
		{ "<leader>e",  "<cmd>Telescope find_files<cr>", desc = "Find Files", silent = true },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep", silent = true },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List Buffers", silent = true },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags", silent = true },
		{ "<leader>fs", "<cmd>Telescope persisted<cr>", desc = "Persisted", silent = true },
		{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status", silent = true },
		{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches", silent = true },
	},
	config = function()
		require("configs.telescope")
	end,
}
