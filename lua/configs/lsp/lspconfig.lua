-- add binaries installed by mason.nvim to path 
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

local keymap = vim.keymap
vim.api.nvim_create_autocmd('LspAttach', {
  desc = "LSP action",
  callback = function(ev)
    -- DISABLE SEMANTIC TOKENS
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client then
        client.server_capabilities.semanticTokensProvider = nil
    end

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    -- set keybinds
    opts.desc = "Show LSP references"
    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

    opts.desc = "Go to declaration"
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

    opts.desc = "Show LSP definitions"
    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

    opts.desc = "Show LSP implementations"
    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

    opts.desc = "Show LSP type definitions"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

    opts.desc = "Go to next diagnostic"
    keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Format file"
    keymap.set({ "n", "x" }, "<leader>fm", vim.lsp.buf.format, opts) -- show definition, references

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", "<CMD>LspRestart<CR>", opts) -- mapping to restart lsp if necessary
  end
})

require("configs.lsp.lsplist")

local function get_all_lsp_servers()
  local files = vim.api.nvim_get_runtime_file("lua/lspconfig/configs/*.lua", true)
  local names = {}
  for _, file in ipairs(files) do
    local normalized = file:gsub("\\", "/")
    local name = normalized:match("([^/]+)%.lua$")
    if name then
      table.insert(names, name)
    end
  end
  table.sort(names)
  return names
end

vim.api.nvim_create_user_command("LspEnable", function(opts)
  local lsp_name = opts.args
  if lsp_name == "" then
    vim.notify("Usage: :LspEnable <server_name>", vim.log.levels.ERROR)
    return
  end

  local path = vim.fn.stdpath("config") .. "/lua/configs/lsp/local_servers.lua"
  
  package.loaded["configs.lsp.local_servers"] = nil
  local ok, local_servers = pcall(require, "configs.lsp.local_servers")
  local servers_list = {}
  if ok and type(local_servers) == "table" then
    servers_list = vim.deepcopy(local_servers)
  end

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
      vim.notify("Enabled and added " .. lsp_name .. " to local_servers.lua!", vim.log.levels.INFO)
      
      package.loaded["configs.lsp.lsplist"] = nil
      pcall(require, "configs.lsp.lsplist")
    else
      vim.notify("Could not write to local_servers.lua", vim.log.levels.ERROR)
    end
  else
    vim.notify(lsp_name .. " is already enabled.", vim.log.levels.WARN)
  end
end, {
  nargs = 1,
  complete = function(ArgLead, CmdLine, CursorPos)
    local servers = get_all_lsp_servers()
    return vim.tbl_filter(function(val)
      return val:match("^" .. vim.pesc(ArgLead))
    end, servers)
  end,
})

vim.api.nvim_create_user_command("LspDisable", function(opts)
  local lsp_name = opts.args
  if lsp_name == "" then
    vim.notify("Usage: :LspDisable <server_name>", vim.log.levels.ERROR)
    return
  end

  local path = vim.fn.stdpath("config") .. "/lua/configs/lsp/local_servers.lua"
  
  package.loaded["configs.lsp.local_servers"] = nil
  local ok, local_servers = pcall(require, "configs.lsp.local_servers")
  if not ok or type(local_servers) ~= "table" then
    vim.notify("No local_servers.lua file found or invalid format.", vim.log.levels.ERROR)
    return
  end

  local new_list = {}
  local found = false
  for _, v in ipairs(local_servers) do
    if v == lsp_name then
      found = true
    else
      table.insert(new_list, v)
    end
  end

  if found then
    local content = "return {\n"
    for _, name in ipairs(new_list) do
      content = content .. '  "' .. name .. '",\n'
    end
    content = content .. "}\n"
    
    local f = io.open(path, "w")
    if f then
      f:write(content)
      f:close()
      package.loaded["configs.lsp.local_servers"] = nil
      vim.notify("Disabled and removed " .. lsp_name .. " from local_servers.lua!", vim.log.levels.INFO)
      vim.notify("Please restart Neovim to fully unload the server.", vim.log.levels.WARN)
    else
      vim.notify("Could not write to local_servers.lua", vim.log.levels.ERROR)
    end
  else
    vim.notify(lsp_name .. " is not enabled.", vim.log.levels.WARN)
  end
end, {
  nargs = 1,
  complete = function(ArgLead, CmdLine, CursorPos)
    package.loaded["configs.lsp.local_servers"] = nil
    local ok, local_servers = pcall(require, "configs.lsp.local_servers")
    if ok and type(local_servers) == "table" then
      return vim.tbl_filter(function(val)
        return val:match("^" .. vim.pesc(ArgLead))
      end, local_servers)
    end
    return {}
  end,
})
