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
        integrations = {
            markdown = {
                only_render_image_at_cursor = true,
                only_render_image_at_cursor_mode = "popup", -- "popup" or "inline"
            }
        }
    }
}
