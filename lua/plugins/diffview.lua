return {
    "sindrets/diffview.nvim",
    cmd = {
        "DiffviewOpen",
        "DiffviewFileHistory",
    },
    opts = function()
        return {
            enhanced_diff_hl = true,
            show_help_hints = false,
        }
    end
}
