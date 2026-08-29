return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUpdate" },
  build = ":TSUpdate",
  init = function()
    local disabled_indent_ft = {
      cs = true,
      csharp = true
    }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start, args.buf)

        -- Enable treesitter-based indentation except for specific filetypes
        if not disabled_indent_ft[vim.bo[args.buf].filetype] then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
  config = function()
    require("configs.treesitter")
  end,
}
