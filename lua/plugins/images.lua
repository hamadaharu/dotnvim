return {
    "3rd/image.nvim",
    build = false,
    ft = {
        "md",
        "markdown",
        "markdown_inline"
    },
    opts = {
        processor = "magick_cli",
        hijack_file_patterns = {}, -- Nonaktifkan hijack agar tidak merusak buffer preview di mini.files
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "minifiles", "minifiles-preview", "snacks_notif", "scrollview", "scrollview_sign" },
        integrations = {
            markdown = {
                only_render_image_at_cursor = true,
                only_render_image_at_cursor_mode = "popup", -- "popup" or "inline"
            }
        }
    }
}
