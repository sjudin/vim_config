-- Neodev, needs to be setup before other lsp stuff

require('neodev').setup {}
-- Mason, note that this must be setup before lsp-zero
require("mason").setup {}
require("mason-lspconfig").setup {
    ensure_installed = { "clangd", "efm", "pyright", "cmake", "lua_ls", "jsonls" },
}
require('mason-tool-installer').setup {
    ensure_installed = {
        "misspell",
        "black",
        "flake8",
        "isort",
        "cpplint",
    }
}
require('mason-nvim-dap').setup {
    ensure_installed = {
        "python" -- debugpy
    }
}

local lsp = require('lsp-zero').preset({
    setup_servers_on_start = true,
    set_lsp_keymaps = false,
    configure_diagnostics = true,
    manage_nvim_cmp = true,
    call_servers = 'local',
})
lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
})

vim.diagnostic.config({
    virtual_text = false
})

require("nvim-lightbulb").setup({
    autocmd = { enabled = true, updatetime = 10 },
    sign = { enabled = false },
    virtual_text = {
        enabled = true,
        -- Text to show in the virt_text.
        text = "🔨",
        -- Position of virtual text given to |nvim_buf_set_extmark|.
        -- Can be a number representing a fixed column (see `virt_text_pos`).
        -- Can be a string representing a position (see `virt_text_win_col`).
        pos = "eol",
        -- Highlight group to highlight the virtual text.
        hl = "LightBulbVirtualText",
        -- How to combine other highlights with text highlight.
        -- See `hl_mode` of |nvim_buf_set_extmark|.
        hl_mode = "combine",
    },
})

lsp.on_attach(function(client, bufnr)
    -- print(string.format("Attaching %s to buffer %d", client.name, bufnr))
    require "lsp_signature".on_attach({}, bufnr)

    -- LSP actions
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "(lsp) [c]ode [a]ction" })

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "(lsp) [r]e[n]ame" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "(lsp) [K]hover doc" })

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "(lsp) [g]o [d]efinition" })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "(lsp) [g]oto [D]eclaration" })
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { desc = "(lsp) [go] type definition" })
    vim.keymap.set('n', 'gr', function() vim.cmd.Telescope { args = { 'lsp_references' } } end,
        { desc = "(lsp) [g]oto [r]eferences" })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "(lsp) [<C-k>] signature help" })

    -- Diagnostics
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "(lsp) [gl]ine diagnostics" })
    vim.keymap.set('n', 'gj', vim.diagnostic.goto_next, { desc = "(lsp) [gj] diagnostic jump next" })
    vim.keymap.set('n', 'gk', vim.diagnostic.goto_prev, { desc = "(lsp) [gk] diagnostic jump previous" })

    -- Disabled because thats why
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "(lsp) [g]oto [i]mplementation" })

    -- Formatting
    vim.keymap.set('n', 'gm', vim.lsp.buf.format, { desc = "(lsp) [g]o for[m]at" })
end
)

-- https://github.com/mattn/efm-langserver
-- Use efm (general-purpose language server) to get formatting for filetypes
-- where the LSP does not have documentFormatting=true. For examples of how this
-- works, have a look at
-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/init.lua

-- Custom setup for language servers
local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
lspconfig.clangd.setup({
    -- For C++ files we want "gi" to use the clangd functionality to switch
    -- between source and header files.
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "gi", vim.cmd.ClangdSwitchSourceHeader, { desc = "(lsp, C++) [gi] switch source/header" },
            { noremap = true })
    end,

    cmd = { "clangd", "--header-insertion=never" },
    capabilities = capabilities
})

local sourceText = require('efmls-configs.utils').sourceText
local fs = require('efmls-configs.fs')

local misspell = {
    lintCommand = "misspell",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
    lintSource = "misspell",
}

local cppcheck = {
    prefix = 'cppcheck',
    lintSource = sourceText('cppcheck'),
    lintCommand = string.format(
        '%s --quiet --force --language=c++ --enable=warning,style,performance,portability --error-exitcode=1  "${INPUT}"',
        fs.executable('cppcheck')
    ),
    lintStdin = false,
    lintFormats = { '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m' },
    rootMarkers = { 'CmakeLists.txt', 'compile_commands.json', '.git' },
}

lspconfig.efm.setup({
    init_options = { documentFormatting = true },
    -- filetypes = { "python" },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            ["="] = { misspell },
            python = {
                require('efmls-configs.formatters.black'),
                require('efmls-configs.linters.flake8'),
                {
                    formatCommand = "isort --stdout ${-l:lineLength} --profile black -",
                    formatStdin = true,
                }
            },
            cpp = {
                -- require('efmls-configs.linters.cppcheck'),
                cppcheck,
                require('efmls-configs.linters.cpplint'),
            },
            c = {
                require('efmls-configs.linters.gcc'),
            }
        }
    }
})

lsp.setup()

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',  -- show only symbol annotations
            maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        })
    },
    mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),

    }
})

-- Buffer number and window id for the floating window
local bufnr
local winid
local spinner = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' }
local idx = 0
-- Progress is done or not
local isDone = true

-- Get the progress message for all clients. The format is
-- "65%: [lua_ls] Loading Workspace: 123/1500 | [client2] xxx | [client3] xxx"
local function get_lsp_progress_msg()
    -- Most code is grabbed from the source of vim.lsp.status()
    -- Ref: https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp.lua
    local percentage = nil
    local all_messages = {}
    isDone = true
    for _, client in ipairs(vim.lsp.get_clients()) do
        local messages = {}
        for progress in client.progress do
            local value = progress.value
            if type(value) == 'table' and value.kind then
                if value.kind ~= 'end' then
                    isDone = false
                end
                local message = value.message and (value.title .. ': ' .. value.message) or value.title
                messages[#messages + 1] = message
                if value.percentage then
                    percentage = math.max(percentage or 0, value.percentage)
                end
            end
        end
        if next(messages) ~= nil then
            table.insert(all_messages, '[' .. client.name .. '] ' .. table.concat(messages, ', '))
        end
    end
    local message = table.concat(all_messages, ' | ')
    -- Show percentage
    if percentage then
        message = string.format('%3d%%: %s', percentage, message)
    end
    -- Show spinner
    idx = idx == #spinner * 4 and 1 or idx + 1
    message = spinner[math.ceil(idx / 4)] .. message
    return message
end

vim.api.nvim_create_autocmd({ 'LspProgress' }, {
    pattern = '*',
    callback = function()
        -- The row position of the floating window. Just right above the status line.
        local win_row = vim.o.lines - vim.o.cmdheight - 4
        local message = get_lsp_progress_msg()
        if
            winid == nil
            or not vim.api.nvim_win_is_valid(winid)
            or vim.api.nvim_win_get_tabpage(winid) ~= vim.api.nvim_get_current_tabpage()
        then
            bufnr = vim.api.nvim_create_buf(false, true)
            winid = vim.api.nvim_open_win(bufnr, false, {
                relative = 'editor',
                width = #message,
                height = 1,
                row = win_row,
                col = vim.o.columns - #message,
                style = 'minimal',
                noautocmd = true,
                border = vim.g.border_style,
            })
        else
            vim.api.nvim_win_set_config(winid, {
                relative = 'editor',
                width = #message,
                row = win_row,
                col = vim.o.columns - #message,
            })
        end
        vim.wo[winid].winhl = 'Normal:Normal'
        vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, { message })
        if isDone then
            if vim.api.nvim_win_is_valid(winid) then
                vim.api.nvim_win_close(winid, true)
            end
            if vim.api.nvim_buf_is_valid(bufnr) then
                vim.api.nvim_buf_delete(bufnr, { force = true })
            end
            winid = nil
            idx = 0
        end
    end,
})
