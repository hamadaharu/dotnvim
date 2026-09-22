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
        start_in_insert = true,
        persist_mode = false, -- if set to true (default) the previous terminal mode will be remembered
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

      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        close_on_exit = true,
        float_opts = {
          -- full screen terminal
          border = "none",
          width = function () return vim.o.columns end,
          height = function () return vim.o.lines end,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.keymap.set({"n", "t"}, "<M-j>", "<cmd>close<CR>", { buffer = term.bufnr, silent = true })
          vim.keymap.set({"n", "t"}, "<M-y>", function()
            local obj = vim.system({ "git", "diff", "--staged" }, { text = true }):wait()
            if obj.code == 0 and obj.stdout ~= "" then
              vim.fn.setreg("+", obj.stdout)
              vim.notify("Git staged diff copied to clipboard!", vim.log.levels.INFO)
            else
              vim.notify("No staged changes or git error", vim.log.levels.WARN)
            end
          end, { buffer = term.bufnr, silent = true })
        end,
      })

      vim.keymap.set({"n"}, '<leader>th', function() horizontal:toggle() end, { desc = "Toggle Term Horizontal" })
      vim.keymap.set({"n"}, '<leader>tv', function() vertical:toggle() end, { desc = "Toggle Term Vertical" })
      vim.keymap.set({"n"}, '<leader>tf', function() float:toggle() end, { desc = "Toggle Term Float" })
      vim.keymap.set({"n"}, '<leader>lg', function() lazygit:toggle() end, { desc = "Toggle LazyGit" })
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
