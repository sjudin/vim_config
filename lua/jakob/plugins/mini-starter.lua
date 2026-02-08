local function file_exists(path)
    local stat = vim.uv.fs_stat(path)

    return stat ~= nil and stat.type == "file"
end

local header_art_1 =
[[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

return {
    'nvim-mini/mini.starter',
    dependencies = {
        "folke/persistence.nvim",
        'nvim-telescope/telescope.nvim'
    },
    version = false,
    config = function()
        local starter = require('mini.starter')
        local persistence = require('persistence')

        local has_session = file_exists(persistence.current())
        local items = {
            has_session and {
                name = 'Open current session',
                action = 'lua require("persistence").load()',
                section = 'Session'
            } or nil,
            starter.sections.recent_files(10, true),
            starter.sections.builtin_actions()
        }
        starter.setup({
            items = items,
            query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
            content_hooks = {
                function(content)
                    local blank_content_line = { { type = 'empty', string = '' } }
                    local section_coords = starter.content_coords(content, 'section')
                    -- Insert backwards to not affect coordinates
                    for i = #section_coords, 1, -1 do
                        table.insert(content, section_coords[i].line + 1, blank_content_line)
                    end
                    return content
                end,
                starter.gen_hook.adding_bullet("» "),
                starter.gen_hook.padding(1, 1),
                function(content)
                    -- This is because mini.starter overrides the <C-p> key which
                    -- we want to use for git files, so we have to override the override
                    local builtin = require('telescope.builtin')
                    vim.keymap.set('n', '<C-p>', builtin.git_files,
                        { buffer = true, desc = "(Telescope) [C-p] git files" })

                    -- Normal buffer movement gets overridden but we can use <C-*> variants
                    vim.keymap.set('n', '<C-j>', function() starter.update_current_item('next') end, { buffer = true })
                    vim.keymap.set('n', '<C-k>', function() starter.update_current_item('prev') end, { buffer = true })

                    return content
                end
                -- starter.gen_hook.aligning('center', 'center'),
            },
            header = header_art_1,
            footer = '',
        })
    end,
}
