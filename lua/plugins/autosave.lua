return {
	"Pocco81/auto-save.nvim",
	lazy = true,
	cmd = "ASToggle",
	keys = {
		{ "<leader>as" },
	},
	config = function()
		require("auto-save").setup({
			enabled = false,
			trigger_events = { "InsertLeave", "FocusLost" }, -- vim events that trigger auto-save. See :h events
			condition = function(buf)
				local fn = vim.fn
				local utils = require("auto-save.utils.data")

				if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
					return true -- met condition(s), can save
				end
				return false -- can't save
			end,
			write_all_buffers = true, -- write all buffers when the current one meets `condition`
			debounce_delay = 2200, -- saves the file at most every `debounce_delay` milliseconds
		})
		vim.api.nvim_set_keymap("n", "<leader>s", ":ASToggle<CR>", {})
	end,
}
