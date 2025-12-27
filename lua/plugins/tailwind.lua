return {
  {
    "razak17/tailwind-fold.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
    cmd = {
      "TailwindFoldEnable"
    },
  },
  -- tailwind-tools.
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    keys = {
      { "<leader>tsc", "<CMD>TailwindSort<CR>", mode = { "n" }, desc = "Tailwind Sort Classes" },
    },
    opts = {
      server = {
        override = false, -- setup the server from the plugin if true
        settings = { -- shortcut for `settings.tailwindCSS`
          -- experimental = {
          --   classRegex = { "tw\\('([^']*)'\\)" }
          -- },
          -- includeLanguages = {
          --   elixir = "phoenix-heex",
          --   heex = "phoenix-heex",
          -- },
        },
        on_attach = function(client, bufnr) end, -- callback executed when the language server gets attached to a buffer
        root_dir = function(fname) end, -- overrides the default function for resolving the root directory
      },
      document_color = {
        enabled = true, -- can be toggled by commands
        kind = "background", -- "inline" | "foreground" | "background"
        inline_symbol = "󰝤 ", -- only used in inline mode
        debounce = 200, -- in milliseconds, only applied in insert mode
      },
      conceal = {
        enabled = false, -- can be toggled by commands
        min_length = nil, -- only conceal classes exceeding the provided length
        symbol = "󱏿", -- only a single character is allowed
        highlight = { -- extmark highlight options, see :h 'highlight'
          fg = "#38BDF8",
        },
      },
      cmp = {
        highlight = "foreground", -- color preview style, "foreground" | "background"
      },
    }
  }
}
