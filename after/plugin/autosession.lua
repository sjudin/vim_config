require("auto-session").setup {
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
}


require('session-lens').setup({ --[[your custom config--]] })

vim.keymap.set("n", "<leader>pp", vim.cmd.SearchSession)
