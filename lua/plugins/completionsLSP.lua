-- local command = { "CocCommand", "CocConfig", "CocDiagnostics", "CocDisable", "CocEnable", "CocFirst", "CocInfo", "CocInstall", "CocLast", "CocList", "CocListCancel", "CocListResume", "CocLocalConfig", "CocNext", "CocOpenLog", "CocOutline", "CocPrev", "CocPrintErrors", "CocRestart", "CocSearch", "CocStart", "CocUninstall", "CocUpdate", "CocUpdateSync", "CocWatch", }

return {
  -- { "mattn/emmet-vim" },

  -- Lsp
  {
    "neovim/nvim-lspconfig",
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
    "windwp/nvim-ts-autotag",
    -- enabled = false,
    event = "InsertEnter",
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          -- Defaults
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
      })
    end,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },

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

  -- ----------------------------------
  -- Main Completion using coc (UnUsed)
  -- ----------------------------------
  {
    "neoclide/coc.nvim",
    branch = "release",
    lazy = true,
    enabled = false,
    event = {
      "InsertEnter",
      -- "VeryLazy",
    },
    cmd = command,
    dependencies = {
      { "SirVer/ultisnips" },
      { "honza/vim-snippets" },
      -- { "neoclide/vim-jsx-improve" }, { "maxmellon/vim-jsx-pretty" },
      {
        "bullets-vim/bullets.vim",
        config = function()
          vim.g.bullets_enabled_file_types = { 'markdown', 'text', 'gitcommit', 'scratch' }
          vim.cmd([[let g:bullets_set_mappings = 0]])
        end
      }
    },
    config = function()
      require("configs.coc")
      -- For coc-html-css-support
      vim.cmd([[autocmd BufWritePost *.css CocCommand html-css-support.dispose]])
    end,
  },
}
