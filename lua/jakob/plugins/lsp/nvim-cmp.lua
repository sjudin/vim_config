return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        'onsails/lspkind.nvim',
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')

        local format_fn = function(entry, item)
            item.menu = ""
            local fixed_width = 40
            local content = item.abbr

            if fixed_width then
                vim.o.pumwidth = fixed_width
            end

            local win_width = vim.api.nvim_win_get_width(0)

            local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

            if #content > max_content_width then
                item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
            else
                item.abbr = content .. (" "):rep(max_content_width - #content)
            end

            return item
        end

        cmp.setup({
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text',      -- show only symbol annotations
                    maxwidth = 50,             -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = '...',     -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    before = format_fn,
                })
            },
            sources = cmp.config.sources({
                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                },
                {
                    { name = 'path' },
                    { name = 'buffer' },
                }),

            sorting = {
                priority_weight = 1.0,
                comparators = {
                    -- compare.score_offset, -- not good at all
                    cmp.config.compare.locality,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.score,     -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)

                    -- This is from https://github.com/lukas-reineke/cmp-under-comparator
                    function(entry1, entry2)
                        local _, entry1_under = entry1.completion_item.label:find "^_+"
                        local _, entry2_under = entry2.completion_item.label:find "^_+"
                        entry1_under = entry1_under or 0
                        entry2_under = entry2_under or 0
                        if entry1_under > entry2_under then
                            return false
                        elseif entry1_under < entry2_under then
                            return true
                        end
                    end,

                    cmp.config.compare.offset,
                    cmp.config.compare.order,
                    -- compare.scopes, -- what?
                    -- compare.sort_text,
                    -- compare.exact,
                    -- compare.kind,
                    -- compare.length, -- useless
                },
            },
            window = {
                completion = cmp.config.window.bordered(),
            },
            mapping = {
                -- `Enter` key to confirm completion
                ['<CR>'] = cmp.mapping.confirm({ select = false }),

                -- Ctrl+Space to trigger completion menu
                ['<C-Space>'] = cmp.mapping.complete(),

                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),

            },
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'cmdline', keyword_length = 5 },
            }),
            matching = { disallow_symbol_nonprefix_matching = false },
            window = {
                completion = cmp.config.window.bordered(),
            },
        })
    end
}
