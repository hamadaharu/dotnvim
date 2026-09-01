return {
  "YounesElhjouji/nvim-copy",
  keys = {
    -- Copy to clipboard as raw text
    { "<leader>yb", "<cmd>CopyVisibleBuffers<cr>",   desc = "Copy → text: visible buffers" },
    { "<leader>yg", "<cmd>CopyGitModified<cr>",      desc = "Copy → text: git modified" },
    { "<leader>yq", "<cmd>CopyQuickfix<cr>",         desc = "Copy → text: quickfix list" },
    { "<leader>ya", "<cmd>CopyCurrentBuffer<cr>",    desc = "Copy → text: current buffer" },

    -- Copy to clipboard as a virtual file (.txt file object)
    { "<leader>yfa", function() require("utils.copy-as-file").copy_current_buffer() end,  desc = "Copy → file: current buffer" },
    { "<leader>yfb", function() require("utils.copy-as-file").copy_visible_buffers() end, desc = "Copy → file: visible buffers" },
    { "<leader>yfg", function() require("utils.copy-as-file").copy_git_modified() end,    desc = "Copy → file: git modified" },
    { "<leader>yfq", function() require("utils.copy-as-file").copy_quickfix() end,        desc = "Copy → file: quickfix list" },
  },
  opts = {
    ignore_patterns = {
      "node_modules",
      ".git",
      ".lock",
      "lazy-lock.json",
    },
  },
}
