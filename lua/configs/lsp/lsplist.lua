-- import lsp config
local lspconfig = require("lspconfig")

-- import cmp-nvim-lsp plugin
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- used to enable autocompletion (umm)
local capabilities = cmp_nvim_lsp.default_capabilities()

--Enable (broadcasting) snippet capability for completion
local capabilitiesHtml = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
    -- Webdev Language Servers
    html = {
        filetypes = { "html", "php", "blade", "htmlhugo" },
        supersaian = true,
        init_options = {
            provideFormatter = true
        },
        capabilities = capabilities,
        settings = {
            suggest = {
                paths = false, -- Disable path autocomplete
            },
        },
    },
    eslint = {
        autostart = false,
        capabilities = capabilities,
    },
    cssls = {
        filetypes = { "css", "less" },
        capabilities = capabilities,
    },
    somesass_ls = {
        capabilities = capabilities,
    },
    ts_ls = {
        capabilities = capabilities,
    },
    svelte = {
        capabilities = capabilities,
    },
    tailwindcss = {
        autostart = false,
        filetypes = { "html", "php", "blade", "htmlhugo" },
        capabilities = capabilities,
        settings = {
            tailwindCSS = {
                classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
                includeLanguages = {
                    eelixir = "html-eex",
                    elixir = "phoenix-heex",
                    eruby = "erb",
                    heex = "phoenix-heex",
                    htmlangular = "html",
                    templ = "html",
                    htmlhugo = "html"
                },
                validate = true
            }
        }
    },
    intelephense = {
        capabilities = capabilities,
    },
    emmet_language_server = {
        filetypes = { "astro", "blade", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "svelte", "typescriptreact", "vue", "htmlangular", "php", "htmlhugo", "markdown" },
        capabilities = capabilities,
    },
    -- Go Language Server
    gopls = {
        capabilities = capabilities
    },
    -- Sqls
    sqls = {
        capabilities = capabilities,
    },
    -- lua
    lua_ls = {
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    -- Pastikan path sudah ke runtime Neovim Lua
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false, -- agar tidak muncul warning
                },
                telemetry = { enable = false },
            },
        },
    },
    -- python
    pylsp =  {
        capabilities = capabilities,
    },
    -- C and Arduino
    clangd = {
        capabilities = capabilities,
    },
    arduino_language_server = {
        capabilities = capabilities,
    },
    -- Java
    jdtls = {
        capabilities = capabilities,
    },
    -- Typst
    tinymist = {
        capabilities = capabilities,
    }
}

local function is_installed(name)
    local custom_executables = vim.lsp.config[name].cmd[1]
    local executable = custom_executables or name

    return vim.fn.executable(executable) == 1
end

for lsp, config in pairs(servers) do
    if is_installed(lsp) then
        -- Default
        if config == true then
            vim.lsp.config[lsp] = {
                capabilities = capabilities
            }
        elseif type(config) == 'table' then
            vim.lsp.config[lsp] = config
        end
        if config.autostart or config.autostart == nil then
            vim.lsp.enable(lsp)
        end
    else
        vim.notify(string.format("[LSP] %s tidak terinstall", lsp), vim.log.levels.WARN)
    end
end
