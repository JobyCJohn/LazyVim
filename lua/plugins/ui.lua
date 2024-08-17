return {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        if vim.fn.has("gui_running") == 1 then
            require('onedark').setup {
                style = 'dark'
            }
        else
            require('onedark').setup {
                style = 'dark',
                transparent = true,
                lualine = {
                    transparent = true
                }
            }
        end
        require('onedark').load()
    end,
}
