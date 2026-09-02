return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-t>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
        insert_mappings = false,  -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      })
      
      local Terminal = require('toggleterm.terminal').Terminal

      local horizontal = Terminal:new({
        direction = 'horizontal',
          on_open = function (term) term:resize(12) end
      })

      local vertical = Terminal:new({
        direction = 'vertical',
          on_open = function (term) term:resize(80) end
      })

      local float = Terminal:new({ direction = 'float' })

      vim.keymap.set({"n"}, '<leader>th', function() horizontal:toggle() end, { desc = "Toggle Term Horizontal" })
      vim.keymap.set({"n"}, '<leader>tv', function() vertical:toggle() end, { desc = "Toggle Term Vertical" })
      vim.keymap.set({"n"}, '<leader>tf', function() float:toggle() end, { desc = "Toggle Term Float" })
    end,
  },

  -- toggleterm manager
  {
    "ryanmsnyder/toggleterm-manager.nvim",
    keys = {
      { "<leader>ft", "<cmd>Telescope toggleterm_manager<cr>", silent = true, desc = "Terminal manager" },
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = true,
  },
}
