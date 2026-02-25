return {
    "kylechui/nvim-surround",
    version = "^4.0.0",
    event = "VeryLazy",
    config = function()
        local config = vim.fn['gruvbox_material#get_configuration']()
        local palette = vim.fn['gruvbox_material#get_palette'](config.background, config.foreground,
            config.colors_override)
        vim.api.nvim_set_hl(0, "NvimSurroundHighlight",
            { fg = palette.red[1], bold = true })
        require("nvim-surround").setup({ move_cursor = "sticky" })
    end
}
