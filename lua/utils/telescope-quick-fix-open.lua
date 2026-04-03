local openQuickFix = function(prompt_bufnr)
  require("telescope.actions").send_selected_to_qflist(prompt_bufnr)
  vim.cmd.cfdo("edit")
end

return openQuickFix
