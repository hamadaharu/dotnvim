local M = {}

M.add_to_harpoon = function(prompt_bufnr, clear_old)
  local action_state = require("telescope.actions.state")
  local action_utils = require("telescope.actions.utils")
  local actions = require("telescope.actions")
  local harpoon = require("harpoon")
  local harpoon_config = harpoon:list().config

  if clear_old then
    harpoon:list():clear()
  end

  local selected_entries = {}

  action_utils.map_selections(prompt_bufnr, function(entry)
    table.insert(selected_entries, entry.value)
  end)

  if vim.tbl_isempty(selected_entries) then
    local current_entry = action_state.get_selected_entry()
    if current_entry then
      table.insert(selected_entries, current_entry.value)
    end
  end

  for _, file_path in ipairs(selected_entries) do
    local item = harpoon_config.create_list_item(harpoon_config, file_path)
    harpoon:list():add(item)
  end

  actions.close(prompt_bufnr)
  print("Harpoon: Added " .. #selected_entries .. " files")
end

return M
