-- import cmp-nvim-lsp plugin
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- used to enable autocompletion (umm)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Set Fold Capabilities
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local servers_config = {
    -- Webdev Language Servers
    html = {
        filetypes = { "html", "php", "blade", "htmlhugo" },
        init_options = {
            provideFormatter = true
        },
        settings = {
            suggest = {
                paths = false, -- Disable path autocomplete
            },
        },
    },
    eslint = {
        autostart = false,
    },
    cssls = {
        filetypes = { "css", "less" },
    },
    tailwindcss = {
        autostart = false,
        filetypes = { "html", "php", "blade", "htmlhugo" },
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
                validate = true,
                colorDecorators = false,
                hovers = false,
                suggestions = true, -- Tetap nyalakan autocomplete
            }
        }
    },
    emmet_language_server = {
        filetypes = { "astro", "blade", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "svelte", "typescriptreact", "vue", "htmlangular", "php", "htmlhugo", "markdown" },
    },
    lua_ls = {
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
    yamlls = {
        settings = {
            yaml = {
                schemas = {
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                    [vim.fn.expand("~/.config/nvim/.schemas/hugo.json")] = {
                        "hugo.yaml",
                        "config.yaml",
                        "config/_default/*.yaml"
                    },
                    [vim.fn.expand("~/.config/nvim/.schemas/sveltia-cms.json")] = {
                        "static/admin/*.yml"
                    },
                },
            },
        }
    }
}

local ok, servers = pcall(require, "configs.lsp.local_servers")

if not ok then
    servers = {}
end

local function is_installed(name)
    local executable = name

    local config = vim.lsp.config[name]

    if config and config.cmd then
        if type(config.cmd) == "table" then
            executable = config.cmd[1]
        elseif type(config.cmd) == "string" then
            executable = config.cmd
        end
    end

    return vim.fn.executable(executable) == 1
end


for _, lsp_name in ipairs(servers) do
    if is_installed(lsp_name) then
        -- Default
        local config = servers_config[lsp_name] or {}

        config.capabilities = config.capabilities or capabilities

        vim.lsp.config[lsp_name] = config

        if config.autostart or config.autostart == nil then
            vim.lsp.enable(lsp_name)
        end
    end
end
