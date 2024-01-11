return {
    'tpope/vim-surround',
    init = function()
        vim.g.surround_no_mappings = true
        vim.keymap.set('n', 'cgz', '<Plug>Csurround')
        vim.keymap.set('n', 'cgZ', '<Plug>CSurround')

        vim.keymap.set('n', 'dgz', '<Plug>Dsurround')

        vim.keymap.set('n', 'ygz', '<Plug>Ysurround')
        vim.keymap.set('n', 'ygZ', '<Plug>YSurround')

        vim.keymap.set('n', 'ygzz', '<Plug>Yssurround')
        vim.keymap.set('n', 'ygZz', '<Plug>YSsurround')
        vim.keymap.set('n', 'ygZZ', '<Plug>YSSurround')

        vim.keymap.set('x', 'gZ', '<Plug>VSurround')
    end
}
