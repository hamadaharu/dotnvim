return {
    "olimorris/codecompanion.nvim",
    cmd = {
        "CodeCompanion",
        "CodeCompanionCLI",
        "CodeCompanionCmd",
        "CodeCompanionChat",
        "CodeCompanionActions"
    },
    keys = {
        { "<leader><C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, noremap = true, silent = true, desc = "CodeCompanion Action" },
        { "<leader>i", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, noremap = true, silent = true, desc = "Toggle CodeCompanion Chat" },
        { "gi", "<cmd>CodeCompanionChat Add<cr>", mode = "v" , noremap = true, silent = true, desc = "Add Visual Selection to CodeCompanion Chat" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "ravitemer/codecompanion-history.nvim"
    },
    config = function()
        require("codecompanion").setup({
            extensions = {
                history = {
                    enabled = true,
                    opts = {
                        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
                    }
                }
            },
            adapters = {
                http = {
                    groq = function()
                        return require("codecompanion.adapters").extend("openai", {
                            env = {
                                api_key = os.getenv("GROQ_API_KEY"),
                            },
                            name = "Groq",
                            url = "https://api.groq.com/openai/v1/chat/completions",
                            schema = {
                                model = {
                                    default = "groq/compound",
                                    choices = {
                                        "llama-3.3-70b-versatile",
                                        "llama-3.1-8b-instant",
                                        "qwen/qwen3-32b",
                                        "groq/compound",
                                        "groq/compound-mini",
                                    },
                                },
                            },
                            max_tokens = {
                                default = 8192,
                            },
                            temperature = {
                                default = 1,
                            },
                            handlers = {
                                form_messages = function(self, messages)
                                    for i, msg in ipairs(messages) do
                                        -- Remove 'id' and 'opts' properties from all messages
                                        msg.id = nil
                                        msg.opts = nil

                                        -- Ensure 'name' is a string if present, otherwise remove it
                                        if msg.name then
                                            msg.name = tostring(msg.name)
                                        else
                                            msg.name = nil
                                        end

                                        -- Ensure only supported properties are present
                                        local supported_props =
                                        { role = true, content = true, name = true }
                                        for prop in pairs(msg) do
                                            if not supported_props[prop] then
                                                msg[prop] = nil
                                            end
                                        end
                                    end
                                    return { messages = messages }
                                end,
                            },
                        })
                    end,
                    gemini = function()
                        return require("codecompanion.adapters").extend("gemini", {
                            env = {
                                api_key = os.getenv("GEMINI_API_KEY"),
                            },
                            name = "Gemini",
                            schema = {
                                model = {
                                    default = "gemini-3.5-flash-lite",
                                    choices = {
                                        "gemini-3.6-flash",
                                        "gemini-3.5-flash",
                                        "gemini-3.5-flash-lite",
                                        "gemini-3.1-flash-lite",
                                        "gemini-3.0-flash",
                                        "gemini-2.5-flash",
                                        "gemini-2.5-flash-lite",
                                    },
                                },
                            },
                        })
                    end,
                },
                acp = {
                    gemini_cli = function()
                        return require("codecompanion.adapters").extend("gemini_cli", {
                            defaults = {
                                auth_method = "oauth-personal", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
                            },
                        })
                    end,
                },
            },
            strategies = {
                chat = { adapter = "gemini" },
                inline = { adapter = "gemini" },
                agent = { adapter = "gemini" },
            },
        })
    end,
}

