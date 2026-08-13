return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup({
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')
                local opts = {}

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                opts.desc = "Next Hunk"
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end, opts)

                opts.desc = "Prev Hunk"
                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end, opts)

                -- Actions
                opts.desc = "Stage Hunk"
                map('n', '<leader>hs', gitsigns.stage_hunk, opts)
                opts.desc = "Reset Hunk"
                map('n', '<leader>hr', gitsigns.reset_hunk, opts)

                opts.desc = "Stage Hunk Visual Selection"
                map('v', '<leader>hs', function()
                    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, opts)

                opts.desc = "Reset Hunk Visual Selection"
                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, opts)

                opts.desc = "Stage Buffer"
                map('n', '<leader>hS', gitsigns.stage_buffer, opts)
                opts.desc = "Reset Buffer"
                map('n', '<leader>hR', gitsigns.reset_buffer, opts)
                opts.desc = "Preview Hunk"
                map('n', '<leader>hp', gitsigns.preview_hunk, opts)
                opts.desc = "Preview Hunk Inline"
                map('n', '<leader>hi', gitsigns.preview_hunk_inline, opts)

                opts.desc = "Blame Line"
                map('n', '<leader>hb', function()
                    gitsigns.blame_line({ full = true })
                end, opts)

                opts.desc = "Diff This"
                map('n', '<leader>hd', gitsigns.diffthis, opts)

                opts.desc = "Diff This ~"
                map('n', '<leader>hD', function()
                    gitsigns.diffthis('~')
                end, opts)

                opts.desc = "Set Quick Fix List All"
                map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, opts)
                opts.desc = "Set Quick Fix List"
                map('n', '<leader>hq', gitsigns.setqflist, opts)

                -- Toggles
                opts.desc = "Toggle Current Line Blame"
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame, opts)
                opts.desc = "Toggle Word Diff"
                map('n', '<leader>tw', gitsigns.toggle_word_diff, opts)

                -- Text object
                opts.desc = "Select Hunk"
                map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, opts)
            end
        })
    end
}
