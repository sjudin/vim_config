return {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'kiyoon/repeatable-move.nvim' },
    opts = {
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')
            local repeat_move = require("repeatable_move")

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            local next_hunk = function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    gitsigns.nav_hunk('next', {}, function() vim.cmd.normal({ 'zz', bang = true }) end)
                end
            end

            local prev_hunk = function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    gitsigns.nav_hunk('prev', {}, function() vim.cmd.normal({ 'zz', bang = true }) end)
                end
            end

            next_hunk, prev_hunk = repeat_move.make_repeatable_move_pair(next_hunk, prev_hunk)
            map({ "n", "x", "o" }, "L", next_hunk)
            map({ "n", "x", "o" }, "H", prev_hunk)
        end
    }
}
