function SetColorscheme(color)
    color = color or "gruvbox-material"

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    if color == "gruvbox" or color == "gruvbox-material" then
        vim.o.background = "dark"
    end
    if color == "gruvbox-material" then
        vim.g.gruvbox_material_foreground = "original"
    end

    if color == "material" then
        vim.g.material_style = "darker"
    end

    vim.cmd.colorscheme(color)
end

SetColorscheme("gruvbox-material")
