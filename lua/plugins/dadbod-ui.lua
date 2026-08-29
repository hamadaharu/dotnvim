return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', cmd = {"DB"}, lazy = true },
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
    { "<A-r>", "<CMD>%DB<CR>", mode = { "n" }, desc = "DBUI exec (whole file)" },
    { "<A-r>", ":DB<CR>", mode = { "x" }, desc = "DBUI exec (selection)" },
    { "<leader>db", "<CMD>DBSelect<CR>", mode = { "n" }, desc = "Select Database Connection" }
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_execute_on_save = 0
    
    -- Load custom Telescope connection picker
    require("utils.db-select")
  end,
}
