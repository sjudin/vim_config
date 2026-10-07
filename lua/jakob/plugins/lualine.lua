return {
    'nvim-lualine/lualine.nvim',
    enabled = true,
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
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then
                return 'No Active Lsp'
            end
            local names = {}
            for _, client in ipairs(clients) do
                names[#names + 1] = client.name
            end
            table.sort(names)
            return " LSP: " .. table.concat(names, ', ')
        end


        -- Config
        local config = {
            options = {
                component_separators = '',
                section_separators = '',
                disabled_filetypes = {
                    statusline = { 'packer', 'NvimTree' }
                }
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(str)
                            -- Get the first character of the mode, ie I for insert,
                            -- N for normal etc
                            return string.sub(str, 1, 1)
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
