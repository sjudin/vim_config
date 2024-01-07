-- https://github.com/mattn/efm-langserver
-- Use efm (general-purpose language server) to get formatting for filetypes
-- where the LSP does not have documentFormatting=true. For examples of how this
-- works, have a look at
-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/init.lua

local lspconfig = require('lspconfig')
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
