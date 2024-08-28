return {
    {
        "ludovicchabant/vim-gutentags",
        ft = { "c", "cpp" },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                desc = "Auto generate C/C++ tags",
                callback = function()
                    local is_c = vim.bo.filetype == "c" or vim.bo.filetype == "cpp"
                    if is_c then
                    else
                        vim.g.gutentags_enabled = 0
                    end
                end,
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
        },
        opts = function(_, opts)
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            opts.mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete({}),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })

            opts.experimental = {}
        end,
    },
}
