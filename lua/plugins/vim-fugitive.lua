return {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    lazy = true,
    keys = {
        -- Git commands
        { "<leader>gg", ":Git ", mode = { "n" }, desc = "Git Command" },
        { "<leader>gf", "<CMD>Git fetch --all --prune<CR>", mode = { "n" }, desc = "Git Fetch" },
        { "<leader>gp", "<CMD>Git pull<CR>", mode = { "n" }, desc = "Git Pull" },
        { "<leader>gP", "<CMD>Git push<CR>", mode = { "n" }, desc = "Git Push" },
        { "<leader>gc", ":Git commit -m \"\"<Left>", mode = { "n" }, desc = "Git Commit" },
        { "<leader>gca", "<CMD>Git commit --amend<CR>", mode = { "n" }, desc = "Git Commit Amend" },
        
        -- Git blame and log
        { "<leader>gB", "<CMD>Git blame<CR>", mode = { "n" }, desc = "Git Blame" },
        { "<leader>gl", "<CMD>Git log --oneline --graph --decorate<CR>", mode = { "n" }, desc = "Git Log" },
        { "<leader>gL", "<CMD>Git log<CR>", mode = { "n" }, desc = "Git Log (full)" },
        
        -- Git diff
        { "<leader>gd", "<CMD>Git diff<CR>", mode = { "n" }, desc = "Git Diff" },
        { "<leader>gds", "<CMD>Git diff --staged<CR>", mode = { "n" }, desc = "Git Diff Staged" },
        { "<leader>gdh", "<CMD>Git diff HEAD~1<CR>", mode = { "n" }, desc = "Git Diff Last Commit" },
        
        -- Visual mode operations
        { "<leader>gB", ":Git blame<CR>", mode = { "x" }, desc = "Git Blame Selection" },
        { "<leader>gd", ":Git diff<CR>", mode = { "x" }, desc = "Git Diff Selection" },
        
        -- Git operations on current file
        { "<leader>gw", "<CMD>Git write<CR>", mode = { "n" }, desc = "Git Write (stage file)" },
        { "<leader>gr", "<CMD>Git read<CR>", mode = { "n" }, desc = "Git Read (revert file)" },
        { "<leader>gm", "<CMD>Git mv <C-R>=expand('%:p')<CR> ", mode = { "n" }, desc = "Git Move" },
        { "<leader>grm", "<CMD>Git rm <C-R>=expand('%:p')<CR><CR>", mode = { "n" }, desc = "Git Remove" },
        
        -- Stash operations
        { "<leader>gst", "<CMD>Git stash<CR>", mode = { "n" }, desc = "Git Stash" },
        { "<leader>gsp", "<CMD>Git stash pop<CR>", mode = { "n" }, desc = "Git Stash Pop" },
        { "<leader>gsl", "<CMD>Git stash list<CR>", mode = { "n" }, desc = "Git Stash List" },
        
        -- Branch operations
        { "<leader>gco", ":Git checkout ", mode = { "n" }, desc = "Git Checkout" },
        { "<leader>gcb", ":Git checkout -b ", mode = { "n" }, desc = "Git Checkout New Branch" },
    },
    init = function()
        -- Optional: Set up git blame to open in vertical split
        vim.g.fugitive_blame_virtual_text = 1
        
        -- Optional: Configure status window behavior
        vim.g.fugitive_statusline_blank = 1
    end,
    config = function()
        -- Optional: Create autocmds for fugitive buffers
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "fugitive",
            callback = function()
                -- Add any fugitive-specific buffer settings
                vim.opt_local.number = true
                vim.opt_local.relativenumber = true
            end,
        })
        
        -- Optional: Keybindings inside fugitive status window
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "fugitive",
            callback = function()
                local opts = { buffer = true, silent = true }
                
                -- Navigation in fugitive windows
                vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = true, desc = "Close Fugitive" })
                vim.keymap.set("n", "<CR>", "g<CR>", { buffer = true, desc = "Open file/expand" })
                vim.keymap.set("n", "-", "g-", { buffer = true, desc = "Parent" })
                
                -- Staging operations
                vim.keymap.set("n", "s", "s", { buffer = true, desc = "Stage file" })
                vim.keymap.set("n", "u", "u", { buffer = true, desc = "Unstage file" })
                vim.keymap.set("n", "U", "U", { buffer = true, desc = "Unstage everything" })
                
                -- Diff operations
                vim.keymap.set("n", "dd", "dd", { buffer = true, desc = "Diff split" })
                vim.keymap.set("n", "dv", "dv", { buffer = true, desc = "Diff vertical" })
                vim.keymap.set("n", "dt", "dt", { buffer = true, desc = "Diff tab" })
                
                -- Commit operations
                vim.keymap.set("n", "cc", "cc", { buffer = true, desc = "Create commit" })
                vim.keymap.set("n", "ca", "ca", { buffer = true, desc = "Amend commit" })
                
                -- Push/Pull
                vim.keymap.set("n", "pp", "pp", { buffer = true, desc = "Push" })
                vim.keymap.set("n", "pl", "pl", { buffer = true, desc = "Pull" })
            end,
        })
    end,
}
