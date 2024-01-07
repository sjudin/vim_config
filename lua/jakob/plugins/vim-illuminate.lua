-- highlights occurrences of word under cursor using treesitter and LSP
return {
    'RRethy/vim-illuminate',
    config = function()
        require('illuminate').configure()
    end

}
