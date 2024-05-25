return {
    'akinsho/bufferline.nvim',
    enabled=false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('bufferline').setup {
            options = {
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true -- use a "true" to enable the default, or set your own character
                    }
                }
            }
        }
    end,
}
