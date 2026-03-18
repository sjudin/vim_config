local repeat_move = require("repeatable_move")

-- 1. Define functions that trigger Fugitive's native jumps.
-- Using 'normal' instead of 'normal!' ensures Fugitive's mappings are respected.
local next_fugitive = function()
    vim.cmd.normal({ ')' })
end

local prev_fugitive = function()
    vim.cmd.normal({ '(' })
end

-- 2. Pass them into repeatable_move
local rep_next, rep_prev = repeat_move.make_repeatable_move_pair(next_fugitive, prev_fugitive)

-- 3. Map the repeatable functions locally to the fugitive buffer
-- Note: 'remap = true' is no longer needed since the functions handle the execution
vim.keymap.set({ "n", "x", "o" }, "L", rep_next, { buffer = true, desc = "Next fugitive item (repeatable)" })
vim.keymap.set({ "n", "x", "o" }, "H", rep_prev, { buffer = true, desc = "Prev fugitive item (repeatable)" })
