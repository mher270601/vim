local M = {}

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local ack = function()
    return "Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>"
end

local review = function()
    return "Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>"
end

local cc_stable = function()
    return "Cc: stable@vger.kernel.org"
end

luasnip.add_snippets(nil, {
    all = {
        luasnip.snippet({
            trig = "Acked-by",
            namr = "Ack",
            dscr = "Acked-by: Thinh Nguyen",
        }, {
            luasnip.function_node(ack, {}),
        }),
        luasnip.snippet({
            trig = "Reviewed-by",
            namr = "Review",
            dscr = "Reviewed-by: Thinh Nguyen",
        }, {
            luasnip.function_node(review, {}),
        }),
        luasnip.snippet({
            trig = "Cc stable",
            namr = "Cc stable",
            dscr = "Cc: stable@vger.kernel.org",
        }, {
            luasnip.function_node(cc_stable, {}),
        }),
    },
})

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp', keyword_length = 3},
        {name = 'buffer', keyword_length = 3},
        {name = 'luasnip', keyword_length = 2},
    },
    mapping = {
        ['<Tab>'] = cmp.mapping(function(fallback)
            vim.api.nvim_feedkeys(t('<Tab>'), 'n', true)
        end, { "i", "s" }),
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-k>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-j>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<C-e>'] = cmp.mapping.abort(),
        --['<CR>'] = cmp.mapping.confirm({select = true}),
        -- Ignore Enter key
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.get_active_entry() then
                cmp.confirm({select = true})
            else
                fallback()
            end
        end,{"i","c"}),

        ['<C-h>'] = cmp.mapping.abort(),
        ['<C-l>'] = cmp.mapping.confirm({select = true}),
    },
})

return M
