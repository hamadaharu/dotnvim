return {
  -- { "mattn/emmet-vim" },

  -- Lsp
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp'
    },
    config = function ()
      require("configs.lsp.lspconfig")
    end
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function()
      require('mason').setup({})
    end
  },

  -- Nvim cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- 'neovim/nvim-lspconfig',
      -- 'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-calc',
      -- luasnip
      "saadparwaiz1/cmp_luasnip",

      -- lsp kind
      'onsails/lspkind.nvim',
      
      -- tailwind to css 
      "jcha0713/cmp-tw2css",

    },
    config = function ()
      require('configs.cmp')
    end,
  },

  -- Conform
  {
    'stevearc/conform.nvim',
    event = {"InsertEnter", "BufReadPre", "BufNewFile"},
    config = function()
      require("configs.conform")
    end
  },

  -- ------------------------
  -- Signature for LSP plugin
  -- ------------------------
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      handler_opts = {
        border = "none"
      }
    },
    config = function(_, opts) require'lsp_signature'.setup(opts) end
  },

  -- -------
  -- LuaSnip
  -- -------
  {
    "L3MON4D3/LuaSnip",
    event = {"BufReadPre", "InsertEnter"},
    dependencies = {
      {'rafamadriz/friendly-snippets'},
    },
    config = function ()
      local ls = require("luasnip")

      vim.keymap.set({"i"}, "<C-L>", function() ls.expand() end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump( 1) end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-K>", function() ls.jump(-1) end, {silent = true})

      vim.keymap.set({"i", "s"}, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-H>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end, {silent = true})
    end
  },

  -- -------------------------------
  -- plugins for automation (windwp)
  -- -------------------------------


  {
    "windwp/nvim-autopairs",
    -- enabled = false,
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
    opts = {
      map_cr = true,
    }
  },

}
