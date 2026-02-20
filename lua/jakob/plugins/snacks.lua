return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        input = {
            enabled = true,

            -- Window-specific configuration goes inside the 'win' table
            win = {
                -- Centers the floating window relative to the entire editor
                relative = "editor",
                position = "float",

                -- Snacks.input natively enters insert mode when opened.
                -- We use the 'on_buf' callback to intercept it and stop insert mode.
                on_buf = function(_)
                    vim.schedule(function()
                        vim.cmd("stopinsert")
                        vim.cmd("normal! ^")
                    end)
                end,
            }
        },
        picker = {
            enabled = true,
            -- This explicitly tells Snacks to hijack vim.ui.select
            ui_select = true,
        }
    }
}
