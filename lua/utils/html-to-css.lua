return function()
    local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
    local lines = vim.fn.getline(csrow, cerow)

    local classes = {}

    for _, line in ipairs(lines) do
    for class_str in string.gmatch(line, 'class="([^"]+)"') do
      for c in string.gmatch(class_str, "%S+") do
        table.insert(classes, "." .. c .. " {")
        table.insert(classes, "  ")
        table.insert(classes, "}")
        table.insert(classes, "")
      end
    end
  end

  vim.api.nvim_buf_set_lines(0, cerow, cerow, false, classes)
end
