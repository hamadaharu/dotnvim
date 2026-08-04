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
        filetypes = { "html", "php", "blade", "htmlhugo", "astro" },
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
    astro = {
        autostart = false,
        flags = {
            debounce_text_changes = 1000,
        },
        init_options = {
            typescript = {
                tsdk = vim.fn.trim(vim.fn.system('echo $HOME')) ..
                    '/.local/share/pnpm/global/5/node_modules/typescript/lib'
            }
        }
    },
    svelte = {
        flags = {
            debounce_text_changes = 1000,
        },

        on_attach = function(client, bufnr)
            client.server_capabilities.semanticTokensProvider = nil
        end,
    },
    intelephense = {
        settings = {
            intelephense = {
                stubs = {
                    "bcmath", "bz2", "calendar", "Core", "curl", "date", "dba", "dom", "enchant", "fileinfo", "filter",
                    "ftp", "gd", "gettext", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring",
                    "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre", "PDO", "pdo_mysql", "Phar", "readline",
                    "recode", "Reflection", "regex", "session", "SimpleXML", "soap", "sockets", "sodium", "SPL",
                    "standard", "superglobals", "sysvsem", "sysvshm", "tokenizer", "xml", "xdebug", "xmlreader", "xmlrpc",
                    "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
                    "wordpress",
                },
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

local active_servers = {}
local seen = {}

-- 1. Auto-detect from servers_config keys if the executable is present
for lsp_name, _ in pairs(servers_config) do
    local is_installed = false
    local server_def = vim.lsp.config and vim.lsp.config[lsp_name]
    if server_def and server_def.cmd then
        if type(server_def.cmd) == "table" then
            local cmd = server_def.cmd[1]
            if type(cmd) == "string" and vim.fn.executable(cmd) == 1 then
                is_installed = true
            end
        elseif type(server_def.cmd) == "function" then
            is_installed = true
        end
    end

    if is_installed then
        table.insert(active_servers, lsp_name)
        seen[lsp_name] = true
    end
end

-- 2. Add from local_servers.lua if it exists
local ok, local_servers = pcall(require, "configs.lsp.local_servers")
if ok and type(local_servers) == "table" then
    for _, lsp_name in ipairs(local_servers) do
        if not seen[lsp_name] then
            table.insert(active_servers, lsp_name)
            seen[lsp_name] = true
        end
    end
end

-- 3. Configure and enable active servers
for _, lsp_name in ipairs(active_servers) do
    -- Default
    local config = servers_config[lsp_name] or {}

    config.capabilities = config.capabilities or capabilities
    config.flags = config.flags or {}
    config.flags.debounce_text_changes = config.flags.debounce_text_changes or 300

    vim.lsp.config[lsp_name] = config

    if config.autostart or config.autostart == nil then
        vim.lsp.enable(lsp_name)
    end
end
