local M = {}

local ignore_patterns = {
  "node_modules",
  ".git",
  "lazy%-lock%.json",
  "%.lock$",
}

local function should_ignore(path)
  for _, pat in ipairs(ignore_patterns) do
    if path:match(pat) then return true end
  end
  return false
end

local function read_file(path)
  local f = io.open(path, "r")
  if not f then return nil end
  local content = f:read("*a")
  f:close()
  return content
end

local function build_block(path, content)
  return string.format("--- file: %s ---\n%s\n\n", path, content)
end

local function collect_from_paths(paths)
  local blocks = {}
  for _, path in ipairs(paths) do
    if not should_ignore(path) then
      local content = read_file(path)
      if content then
        table.insert(blocks, build_block(path, content))
      end
    end
  end
  return table.concat(blocks)
end

local function copy_to_clipboard_as_file(text, label)
  if text == "" then
    vim.notify("No content to copy.", vim.log.levels.WARN)
    return
  end

  local temp_dir = os.getenv("TEMP") or os.getenv("TMP") or vim.fn.stdpath("cache")
  local filename = string.format("%s/nvim-context_%s.txt", temp_dir, label)
  filename = filename:gsub("\\", "/") -- Normalize slashes

  -- 1. Write to temp file
  local f = io.open(filename, "w")
  if not f then
    vim.notify("Could not write temp file.", vim.log.levels.ERROR)
    return
  end
  f:write(text)
  f:close()

  -- 2. Use PowerShell to copy the file itself to clipboard
  local win_path = filename:gsub("/", "\\")
  local cmd = string.format('powershell -NoProfile -Command "Set-Clipboard -Path \'%s\'"', win_path)
  
  local success = os.execute(cmd)
  if success == 0 or success == true then
    vim.notify("Copied as virtual file: nvim-context_" .. label .. ".txt", vim.log.levels.INFO)
  else
    vim.notify("Failed to copy file to clipboard.", vim.log.levels.ERROR)
  end
end

-- Copy current buffer
function M.copy_current_buffer()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Buffer has no file.", vim.log.levels.WARN)
    return
  end
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local text = build_block(path, table.concat(lines, "\n"))
  copy_to_clipboard_as_file(text, "buffer")
end

-- Copy all listed buffers
function M.copy_visible_buffers()
  local paths = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" then table.insert(paths, name) end
    end
  end
  copy_to_clipboard_as_file(collect_from_paths(paths), "buffers")
end

-- Copy files in quickfix list
function M.copy_quickfix()
  local qflist = vim.fn.getqflist()
  local seen = {}
  local paths = {}
  for _, item in ipairs(qflist) do
    local path = vim.fn.bufname(item.bufnr)
    if path ~= "" and not seen[path] then
      seen[path] = true
      table.insert(paths, path)
    end
  end
  if #paths == 0 then
    vim.notify("Quickfix list is empty.", vim.log.levels.WARN)
    return
  end
  copy_to_clipboard_as_file(collect_from_paths(paths), "quickfix")
end

-- Copy git-modified files
function M.copy_git_modified()
  local handle = io.popen("git diff --name-only HEAD 2>/dev/null")
  if not handle then
    vim.notify("git not available.", vim.log.levels.WARN)
    return
  end
  local result = handle:read("*a")
  handle:close()

  local paths = {}
  for line in result:gmatch("[^\n]+") do
    table.insert(paths, line)
  end
  if #paths == 0 then
    vim.notify("No git-modified files.", vim.log.levels.WARN)
    return
  end
  copy_to_clipboard_as_file(collect_from_paths(paths), "git")
end

return M
