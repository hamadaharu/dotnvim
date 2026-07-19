return {
    "monaqa/dial.nvim",
    keys = {
        { "<C-a>", function() require("dial.map").manipulate("increment", "normal") end, mode = "n", desc = "Increment number" },
        { "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end, mode = "n", desc = "Decrement number" },
        { "<C-a>", function() require("dial.map").manipulate("increment", "visual") end, mode = "v", desc = "Increment numbers in visual" },
        { "<C-x>", function() require("dial.map").manipulate("decrement", "visual") end, mode = "v", desc = "Decrement numbers in visual" },
    },
    config = function()
        local augend = require("dial.augend")

        local tailwind_augend = augend.user.new({
            find = require("dial.augend.common").find_pattern("%d+%.?%d*"),
            add = function(text, addend, cursor)
                local num = tonumber(text)
                if not num then return {text = text, cursor = 1} end

                local is_color = false
                if num == 50 or num == 950 or (num >= 100 and num <= 900 and num % 100 == 0) then
                    is_color = true
                end

                if is_color then
                    local new_num = num
                    if addend > 0 then -- Increment (=)
                        if num == 50 then new_num = 100
                        elseif num == 900 then new_num = 950
                        elseif num < 900 then new_num = num + 100 end
                    else -- Decrement (-)
                        if num == 100 then new_num = 50
                        elseif num == 950 then new_num = 900
                        elseif num > 100 then new_num = num - 100 end
                    end
                    return {text = tostring(new_num), cursor = 1}
                else
                    local spacing = {
                        0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 5, 6, 7, 8, 9, 10, 11, 12,
                        14, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 72, 80, 96
                    }
                    local current_idx = 1
                    
                    for i, v in ipairs(spacing) do
                        if v == num then
                            current_idx = i
                            break
                        elseif v > num then
                            current_idx = addend > 0 and (i - 1) or i
                            break
                        end
                        if i == #spacing and num >= v then
                            current_idx = #spacing
                        end
                    end

                    local new_idx = current_idx + addend
                    if new_idx < 1 then new_idx = 1 end
                    if new_idx > #spacing then new_idx = #spacing end

                    return {text = tostring(spacing[new_idx]), cursor = 1}
                end
            end
        })

        require("dial.config").augends:register_group({
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
            },
            tailwind = {
                tailwind_augend, -- Sekarang kita cukup pakai 1 augend sakti ini!
            },
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "astro", "javascript", "typescript", "javascriptreact", "typescriptreact", "html", "svelte", "vue", "css" },
            callback = function(args)
                vim.keymap.set("n", "=", require("dial.map").inc_normal("tailwind"), { buffer = args.buf, desc = "Increment Tailwind" })
                vim.keymap.set("n", "-", require("dial.map").dec_normal("tailwind"), { buffer = args.buf, desc = "Decrement Tailwind" })
                
                vim.keymap.set("v", "=", require("dial.map").inc_visual("tailwind"), { buffer = args.buf, desc = "Increment Tailwind Visual" })
                vim.keymap.set("v", "-", require("dial.map").dec_visual("tailwind"), { buffer = args.buf, desc = "Decrement Tailwind Visual" })
            end,
        })
    end,
}
