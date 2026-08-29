require("telescope").load_extension("persisted")

local openQuickFix = require"utils.telescope-quick-fix-open"
local h_utils = require"utils.harpoon-telescope"

require("telescope").setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "  ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      -- width = 0.87,
      -- height = 0.80,
      -- preview_cutoff = 120,
    },
    file_ignore_patterns = {
      "^node_modules/"
    },
    mappings = {
      n = {
        ["q"] = "close",
        ["<C-o>"] = openQuickFix,
        ["<leader>a"] = function(pb) h_utils.add_to_harpoon(pb, false) end,
        ["<M-a>"] = function(pb) h_utils.add_to_harpoon(pb, true) end,
      },
      i = {
        ["<C-o>"] = openQuickFix,
        ["<M-a>"] = function(pb) h_utils.add_to_harpoon(pb, true) end
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
      theme = "dropdown",
    },
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      previewer = false,
      mappings = {
        n = {
          ["<M-c>"] = "delete_buffer"
        },
        i = {
          ["<M-c>"] = "delete_buffer"
        }
      }
    },
    git_branches = {
      show_remote_tracking_branches = false,
      mappings = {
        i = {
          ["<C-s>"] = function(prompt_bufnr)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if selection then
              local branch = selection.value
              local output = vim.fn.system("git merge --squash " .. branch)
              output = vim.fn.trim(output)
              if output == "" then
                vim.notify("Squash merge initiated for: " .. branch, vim.log.levels.INFO)
              else
                vim.notify(output, vim.log.levels.INFO)
              end
            end
          end
        }
      }
    }
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    persisted = {
      layout_config = { width = 0.55, height = 0.55 }
    }
  },
})

-- UI
local sethl = vim.api.nvim_set_hl

local diffc = vim.api.nvim_get_hl(0, { name = "DiffChange" })
local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
local nfloat = vim.api.nvim_get_hl(0, { name = "NormalFloat" })
local pmenu = vim.api.nvim_get_hl(0, { name = "PmenuSbar" })

local bg1 = diffc.bg
local bg2 = nfloat.bg
local bg3 = pmenu.bg
local bg4 = "#201f34"
local fg = diffc.fg

local r1 = vim.api.nvim_get_hl(0, { name = "rainbow2" }).fg
local r2 = vim.api.nvim_get_hl(0, { name = "rainbow4" }).fg
local r3 = vim.api.nvim_get_hl(0, { name = "rainbow5" }).fg

-- Prompt
sethl(0, "TelescopePromptBorder", {
  bg = bg1,
  fg = bg1,
})

sethl(0, "TelescopePromptNormal", {
  bg = bg1,
  fg = fg,
})

sethl(0, 'TelescopePromptTitle', {
  fg = r2,
  bg = bg3,
})

-- Results
sethl(0, "TelescopeResultsBorder", {
  bg = bg1,
  fg = bg1,
})

sethl(0, "TelescopeResultsNormal", {
  bg = bg1,
})

sethl(0, 'TelescopeResultsTitle', {
  fg = r1,
  bg = bg3,
})

-- Preview
sethl(0, "TelescopePreviewBorder", {
  bg = bg2,
  fg = bg2,
})

sethl(0, "TelescopePreviewNormal", {
  bg = bg2,
})
