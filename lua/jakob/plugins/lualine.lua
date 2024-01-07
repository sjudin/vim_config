return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local lualine = require('lualine')

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand('%:p:h')
                local gitdir = vim.fn.finddir('.git', filepath .. ';')
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        local function get_attached_lsp()
            local msg = 'No Active Lsp'
            local buf_ft = vim.bo.filetype
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
                return msg
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return " LSP: " .. client.name
                end
            end
            return msg
        end

        local custom_gruxbox = require('lualine.themes.gruvbox')

        -- Config
        local config = {
            options = {
                component_separators = '',
                section_separators = '',
                theme = custom_gruxbox,
                disabled_filetypes = {
                    statusline = { 'packer', 'NvimTree' }
                }
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(str)
                            local fwidth = 9
                            return string.format('%' .. fwidth .. 's', str)
                        end
                    }
                },
                lualine_b = {
                    function() return "" end,
                    "diff",
                    { "diagnostics", cond = conditions.hide_in_width }
                },
                lualine_c = {
                    "filename", { get_attached_lsp, cond = conditions.hide_in_width }
                }
            },
        }

        -- Now don't forget to initialize lualine
        lualine.setup(config)
    end
}
