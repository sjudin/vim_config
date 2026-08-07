-- Better "%" matching
return {
    'andymass/vim-matchup',
    ---@type matchup.Config
    init = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
    opts = {}
}
