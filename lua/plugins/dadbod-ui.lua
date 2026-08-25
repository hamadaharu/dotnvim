return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  keys = {
    { "<F8>", "<CMD>DBUIToggle<CR>", mode = { "n" }, desc = "DBUI Toggle" },
    { "<leader><F8>", "<CMD>DBUIFindBuffer<CR>", mode = { "n" }, desc = "DBUI Toggle" },
    { "<F9>", "<Plug>(DBUI_ExecuteQuery)", mode = { "n" }, desc = "DBUI exec" },
    { "<F9>", "db#op_exec()", expr = true, mode = { "x" }, desc = "DBUI exec" },
    { "<A-r>", "<Plug>(DBUI_ExecuteQuery)", mode = { "n" }, desc = "DBUI exec" },
    { "<A-r>", "db#op_exec()", expr = true, mode = { "x" }, desc = "DBUI exec" },
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_execute_on_save = 0
  end,
}
