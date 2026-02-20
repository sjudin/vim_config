return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'onsails/lspkind.nvim'
    },

    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        cmdline = {
            enabled = true,
            keymap = {
                preset = 'none',
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ['<Tab>'] = { 'show_and_insert_or_accept_single', 'select_next' },
                ['<S-Tab>'] = { 'select_prev' },
                ['<C-j>'] = { 'select_next' },
                ['<C-k>'] = { 'select_prev' },
            },
            completion = {
                menu = {
                    auto_show = function()
                        local type = vim.fn.getcmdtype()
                        -- Auto-show for forward (/) and backward (?) searches
                        if type == '/' or type == '?' then
                            return true
                        end

                        -- if type == ':' then
                        --     local cmd = vim.fn.getcmdline()
                        --
                        --     -- If the command starts with 'e ', 'w ', 'sp ', 'vsp ', etc.
                        --     -- (The %s+ ensures we only trigger after you type a space)
                        --     if cmd:match("^e%s+") or cmd:match("^w%s+") or cmd:match("^v?sp%s+") then
                        --         return true
                        --     end
                        -- end

                        return false
                    end
                }
            },
            sources = function()
                local type = vim.fn.getcmdtype()
                if type == '/' or type == '?' then
                    return { 'buffer' }
                end

                if type == ':' then
                    local cmd = vim.fn.getcmdline()

                    -- If the command starts with 'e ', 'w ', 'sp ', 'vsp ', etc.
                    -- (The %s+ ensures we only trigger after you type a space)
                    if cmd:match("^e%s+") or cmd:match("^w%s+") or cmd:match("^v?sp%s+") then
                        return { 'cmdline', 'path' }
                    end

                    return { 'cmdline' }
                end

                return {}
            end
        },
        keymap = {
            preset = 'default',
            ['<C-j>'] = { 'select_next' },
            ['<C-k>'] = { 'select_prev' },
            ['<Tab>'] = { 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
            ['<Enter>'] = { 'accept', 'fallback' },
        },

        appearance = {
            nerd_font_variant = 'mono'
        },

        completion = {
            ghost_text = { enabled = false },
            documentation = { auto_show = true, window = { border = "single" } },
            menu = {
                border = "single",
                draw = {
                    columns = {
                        { "label",     "label_description", gap = 1 },
                        { "kind_icon", "kind",              gap = 1 },
                    },
                    components = {
                        label = {
                            -- min/max force the width. fill=true pads it with spaces to keep it fixed.
                            width = { min = 30, max = 60, fill = true },
                            ellipsis = true,
                        },
                        label_description = {
                            width = { max = 30 },
                            text = function(ctx) return ctx.label_description end,
                            highlight = 'BlinkCmpLabelDescription',
                            ellipsis = false
                        },
                        kind_icon = {
                            text = function(ctx)
                                local icon = ctx.kind_icon
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        icon = dev_icon
                                    end
                                else
                                    icon = require("lspkind").symbol_map[ctx.kind] or ""
                                end

                                return icon .. ctx.icon_gap
                            end,

                            highlight = function(ctx)
                                local hl = ctx.kind_hl
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        hl = dev_hl
                                    end
                                end
                                return hl
                            end,
                        }
                    }
                }
            }
        },

        sources = {
            default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            }
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
