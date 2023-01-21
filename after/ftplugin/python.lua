function insert_print()
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos) .. 'print(f"{}")'
    vim.api.nvim_set_current_line(nline)
end

vim.keymap.set("i", "<C-a>", insert_print)
