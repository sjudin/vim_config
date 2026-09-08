return {
    "christoomey/vim-tmux-navigator",
    init = function()
        -- Keep the <cmd> mappings below instead of the plugin's command-line mappings.
        vim.g.tmux_navigator_no_mappings = 1
        vim.g.tmux_navigator_save_on_switch = 2
    end,
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
    },
    keys = {
        { "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
}
