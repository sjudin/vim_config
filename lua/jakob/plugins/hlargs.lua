-- :h vim.highlight.priorities
-- treesitter.priority = 100
-- semantic_tokens.priority = 125
-- diagnostics.priority = 150

return {
    'm-demare/hlargs.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('hlargs').setup({
            excluded_filetypes = {"c", "cpp"},
            hl_priority = vim.highlight.priorities.semantic_tokens + 1
        })
    end
}
