local function telescope_find_dirs_to_minifiles()
    local action_state = require("telescope.actions.state")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    builtin.find_files({
        prompt_title = "Select Directory for Mini.Files",
        find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },

        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)

                local selection = action_state.get_selected_entry()
                local dir_path = selection[1]

                require("mini.files").open(dir_path)
            end)
            return true
        end,
    })
end

return {
    'nvim-mini/mini.files',
    version = false,
    config = function()
        require("configs.minifiles_git")
        require('mini.files').setup(
            {
                -- Customization of shown content
                content = {
                    -- Predicate for which file system entries to show
                    filter = nil,
                    -- Highlight group to use for a file system entry
                    highlight = nil,
                    -- Prefix text and highlight to show to the left of file system entry
                    prefix = nil,
                    -- Order in which to show file system entries
                    sort = function(fs_entries)
                        local res = vim.deepcopy(fs_entries)

                        table.sort(res, function(a, b)
                            local a_is_dir = a.fs_type == "directory"
                            local b_is_dir = b.fs_type == "directory"

                            if a_is_dir ~= b_is_dir then return a_is_dir end

                            local name_a, name_b = a.name:lower(), b.name:lower()
                            if name_a == name_b then return false end

                            return name_a:gsub("(%d+)", function(n) return string.format("%10d", n) end) <
                                name_b:gsub("(%d+)", function(n) return string.format("%10d", n) end)
                        end)

                        return res
                    end,
                },

                -- Module mappings created only inside explorer.
                -- Use `''` (empty string) to not create one.
                mappings = {
                    close       = 'q',
                    go_in       = 'l',
                    go_in_plus  = 'L',
                    go_out      = 'h',
                    go_out_plus = 'H',
                    mark_goto   = "'",
                    mark_set    = 'm',
                    reset       = '<BS>',
                    reveal_cwd  = '@',
                    show_help   = 'g?',
                    synchronize = 's',
                    trim_left   = '<',
                    trim_right  = '>',
                },

                -- General options
                options = {
                    -- Whether to delete permanently or move into module-specific trash
                    permanent_delete = true,
                    -- Whether to use for editing directories
                    use_as_default_explorer = true,
                },

                -- Customization of explorer windows
                windows = {
                    -- Maximum number of windows to show side by side
                    max_number = math.huge,
                    -- Whether to show preview of file/directory under cursor
                    preview = true,
                    -- Width of focused window
                    width_focus = 50,
                    -- Width of non-focused window
                    width_nofocus = 15,
                    -- Width of preview window
                    width_preview = 25,
                },
            })
        local map = vim.keymap.set

        map("n", "<leader>n", "<CMD>lua MiniFiles.open()<CR>", { desc = "Mini Files Open" })
        map("n", "<leader>m", function()
            require('mini.files').open(vim.api.nvim_buf_get_name(0))
        end, { desc = "Mini Files Open Current Buffer" })
        map("n", "<leader>fx", telescope_find_dirs_to_minifiles, { desc = "Telescope To MiniFiles" })

        -- Autocmd open renamed files
        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesActionRename',
            callback = function(args)
                local from = args.data.from
                local to = args.data.to

                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.api.nvim_buf_is_valid(buf) then
                        local buf_name = vim.api.nvim_buf_get_name(buf)
                        if buf_name == from then
                            pcall(function ()
                                vim.api.nvim_buf_set_name(buf, to)
                                vim.api.nvim_buf_call(buf, function()
                                    vim.cmd('edit!')
                                end)
                            end)
                        end
                    end
                end
            end,
        })

        -- Highlight Groups Change
        local gethl = vim.api.nvim_get_hl
        local sethl = vim.api.nvim_set_hl

        local bg = gethl(0, { name = "NormalFloat" }).bg
        local fg = gethl(0, { name = "WinSeparator" }).fg

        sethl(0, "MiniFilesBorder", {
            fg = fg,
            bg = bg
        })
    end
}
