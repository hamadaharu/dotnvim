return {
  {
    "tadmccorkle/markdown.nvim",
    ft = { "markdown", "typst" }, -- or 'event = "VeryLazy"'
    dependencies = {
      {
        "Myzel394/easytables.nvim",
        config = true
      },
      {
        'SCJangra/table-nvim',
        ft = 'markdown',
        opts = require("configs.table-nvim"),
      },
      {
        'rymdlego/readtime.nvim',
        config = function()
          require('readtime').setup()
        end
      }
    },
    config = function()
      require("configs.markdown")
    end
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    ft = { "markdown", "codecompanion" },
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    config = function()
      require('render-markdown').setup({
        file_types = { "markdown", "codecompanion" },
        render_modes = true, -- Render in ALL modes
        sign = {
          enabled = false, -- Turn off in the status column
        },
      })
    end,
  }
}
