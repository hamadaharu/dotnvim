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

      -- Auto-add to local_servers.lua on successful installation
      local registry = require("mason-registry")
      registry:on("package:install:success", function(pkg)
        vim.schedule(function()
          local mason_to_lsp = {
            ["html-lsp"] = "html",
            ["css-lsp"] = "cssls",
            ["tailwindcss-language-server"] = "tailwindcss",
            ["lua-language-server"] = "lua_ls",
            ["emmet-language-server"] = "emmet_language_server",
            ["eslint-lsp"] = "eslint",
            ["astro-language-server"] = "astro",
            ["svelte-language-server"] = "svelte",
            ["intelephense"] = "intelephense",
            ["yaml-language-server"] = "yamlls",
          }
          local lsp_name = mason_to_lsp[pkg.name] or pkg.name

          local path = vim.fn.stdpath("config") .. "/lua/configs/lsp/local_servers.lua"
          
          -- Read existing servers
          package.loaded["configs.lsp.local_servers"] = nil
          local ok, local_servers = pcall(require, "configs.lsp.local_servers")
          local servers_list = {}
          if ok and type(local_servers) == "table" then
            servers_list = vim.deepcopy(local_servers)
          end

          -- Check if already exists
          local exists = false
          for _, v in ipairs(servers_list) do
            if v == lsp_name then
              exists = true
              break
            end
          end

          if not exists then
            table.insert(servers_list, lsp_name)
            local content = "return {\n"
            for _, name in ipairs(servers_list) do
              content = content .. '  "' .. name .. '",\n'
            end
            content = content .. "}\n"
            
            local f = io.open(path, "w")
            if f then
              f:write(content)
              f:close()
              package.loaded["configs.lsp.local_servers"] = nil
              vim.notify("Auto-added " .. lsp_name .. " to local_servers.lua!", vim.log.levels.INFO)
              
              -- Reload configurations to enable the newly installed LSP
              package.loaded["configs.lsp.lsplist"] = nil
              pcall(require, "configs.lsp.lsplist")
            end
          end
        end)
      end)
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
