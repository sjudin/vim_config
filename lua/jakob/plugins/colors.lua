return {
    {
        'sainnhe/gruvbox-material',
        config = function() 
            color = "gruvbox-material"

            -- Enables transparency
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

            -- Define colorscheme specific settings here
            if color == "gruvbox" or color == "gruvbox-material" then
                vim.o.background = "dark"
            end
            if color == "gruvbox-material" then
                vim.g.gruvbox_material_foreground = "original"
            end

            if color == "material" then
                vim.g.material_style = "darker"
            end

        end,
        lazy=true,
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy=true
    }
}
