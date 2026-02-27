return {
    'tpope/vim-fugitive',
    lazy=false,
    keys = {
        { "<leader>gs", mode = { "n" }, vim.cmd.Git, desc = "Fugitive open" }
    }

}
