local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    astro = { "prettierd", "prettier", stop_after_first = true },
    bash = { "beautysh" },
    c = { "astyle" },
    css = { "prettierd", "prettier", stop_after_first = true },
    erb = { "htmlbeautifier" },
    graphql = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd" },
    htmlhugo = { "prettierd" },
    java = { "google-java-format" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    kotlin = { "ktlint" },
    lua = { "stylua" },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    mysql = { "sql_formatter" },
    proto = { "buf" },
    ruby = { "standardrb" },
    rust = { "rustfmt" },
    scss = { "prettierd", "prettier", stop_after_first = true },
    sql = { "sql_formatter" },
    svelte = { "prettierd", "prettier", stop_after_first = true },
    toml = { "taplo" },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "yamlfix" },
  },
  -- format_on_save = {
  --   -- I recommend these options. See :help conform.format for details.
  --   lsp_format = "fallback",
  --   timeout_ms = 1000,
  -- },
})

vim.keymap.set({ "n", "v" }, "<leader>l", function()
  conform.format({
    async = true,
    stop_after_first = true,
  })
end, { desc = "Format file or range (in visual mode)" })
