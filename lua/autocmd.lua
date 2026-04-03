vim.cmd([[autocmd BufRead,BufNewFile *.rasi setfiletype rasi]])

-- color for html tag
vim.cmd([[autocmd FileType html hi! link htmlTag @tag.delimiter]])
vim.cmd([[autocmd FileType html hi! link htmlEndTag htmlTag]])
vim.cmd([[autocmd FileType html hi! link htmlTagName @tag.builtin]])
vim.cmd([[autocmd FileType html hi! link htmlArg @tag.attribute]])
vim.cmd([[autocmd FileType html hi! link htmlHugoFunction @function.builtin]])

local html_hugo_group = vim.api.nvim_create_augroup("HtmlHugoMapping", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "htmlhugo",
  group = html_hugo_group,
  callback = function()
    vim.keymap.set('i', '<CR>', function()
      local line = vim.api.nvim_get_current_line()
      local col = vim.api.nvim_win_get_cursor(0)[2]

      local char_before = line:sub(col, col)
      local char_after = line:sub(col + 1, col + 1)

      if char_before == ">" and char_after == "<" then
        return "<CR><Esc>O"
      else
        return "<CR>"
      end
    end, { expr = true, silent = true, buffer = 0 })
  end
})
