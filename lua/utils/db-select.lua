local M = {}

-- Function to load connections from JSON file
local function load_connections()
  local save_location = vim.g.db_ui_save_location
  if not save_location then
    vim.notify("vim.g.db_ui_save_location is not set", vim.log.levels.ERROR)
    return {}
  end

  local expanded_location = vim.fs.normalize(vim.fn.expand(save_location))
  local file_path = expanded_location .. "/connections.json"
  local file = io.open(file_path, "r")
  if not file then
    vim.notify("Could not open connections file: " .. file_path, vim.log.levels.ERROR)
    return {}
  end

  local content = file:read("*all")
  file:close()

  local ok, connections = pcall(vim.json.decode, content)
  if not ok then
    vim.notify("Invalid JSON in connections file", vim.log.levels.ERROR)
    return {}
  end

  return connections
end

-- Function to set vim.g.db
local function set_db_connection(connection)
  vim.g.db = connection.url
  vim.notify("Database connection set to: " .. connection.name .. "\nURL: " .. connection.url, 
             vim.log.levels.INFO)
end

-- Main function to show connection picker
function M.select_connection()
  local connections = load_connections()
  
  if #connections == 0 then
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Select Database Connection",
    finder = finders.new_table({
      results = connections,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name .. "  [" .. entry.url .. "]",
          ordinal = entry.name .. " " .. entry.url,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          set_db_connection(selection.value)
        end
      end)
      return true
    end,
  }):find()
end

-- Optional: Create a command
vim.api.nvim_create_user_command("DBSelect", function()
  M.select_connection()
end, {})

return M
