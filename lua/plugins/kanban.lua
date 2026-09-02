return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
  },
  {
    "hasansujon786/super-kanban.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = { "SuperKanban" },
    keys = {
      { "<leader>kb", "<cmd>SuperKanban open<cr>", desc = "Open Kanban Board" },
    },
    config = function()
      require("super-kanban").setup({
        markdown = {
          notes_dir = "./tasks/",
          list_heading = "h2",
          default_template = {
            "## Backlog\n",
            "## Todo\n",
            "## Work in progress\n",
            "## Completed\n",
          },
        },
        mappings = {
          ["H"] = "move_left",
          ["J"] = "move_down",
          ["K"] = "move_up",
          ["L"] = "move_right",
        }
      })
    end,
  }
}
