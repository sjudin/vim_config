-- :h vim.highlight.priorities
-- treesitter.priority = 100
-- semantic_tokens.priority = 125
-- diagnostics.priority = 150

require('hlargs').setup({
    hl_priority = vim.highlight.priorities.semantic_tokens + 1
})
