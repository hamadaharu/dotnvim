local function natural_cmp(left, right)
  -- is it directory?
  if left.type ~= "directory" and right.type == "directory" then
    return false
  elseif left.type == "directory" and right.type ~= "directory" then
    return true
  end

	left = left.name:lower()
	right = right.name:lower()

	if left == right then
		return false
	end


	for i = 1, math.max(string.len(left), string.len(right)), 1 do
		local l = string.sub(left, i, -1)
		local r = string.sub(right, i, -1)

		if type(tonumber(string.sub(l, 1, 1))) == "number" and type(tonumber(string.sub(r, 1, 1))) == "number" then
			local l_number = tonumber(string.match(l, "^[0-9]+"))
			local r_number = tonumber(string.match(r, "^[0-9]+"))

			if l_number ~= r_number then
				return l_number < r_number
			end
		elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
			return l < r
		end
	end
end


return {
  "nvim-tree/nvim-tree.lua",
  cmd = {
    "NvimTreeToggle",
  },
  keys = { "<C-n>" },
  config = function()
    -- start barbar
    vim.cmd("Lazy load barbar.nvim")

    -- optionally enable 24-bit colour
    vim.opt.termguicolors = true

    -- setup with some options
    require("nvim-tree").setup({
      filters = {
        dotfiles = true,
      },
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        adaptive_size = false,
        side = "left",
        width = 32,
        preserve_window_proportions = true,
      },
      git = {
        enable = true,
        ignore = true,
      },
      filesystem_watchers = {
        enable = true,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        highlight_opened_files = "none",
        icons = {
        }
      },
      sort = {
        sorter = function (nodes)
          table.sort(nodes, natural_cmp)
        end,
        folders_first = true
      }
    })

    vim.keymap.set("n", "<C-n>", "<CMD>NvimTreeToggle<CR>")
  end,
}
