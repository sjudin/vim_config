-- Session management
return {
    'jedrzejboczar/possession.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
        require('possession').setup {
            silent = true,
            autosave = {
                current = true,
                on_quit = true,
                on_load = true,
            },
            plugins = {
                -- Close terminal buffers when the session is changed
                delete_hidden_buffers = {
                    force = function(buf)
                        return vim.api.nvim_get_option_value("buftype", { buf = buf }) == 'terminal'
                    end
                }
            },
        }
        require('telescope').load_extension('possession')



        local function list_sessions()
            vim.cmd.Telescope { args = { 'possession', 'list' } }
        end

        vim.keymap.set("n", "<leader>pp", list_sessions)
    end
}
