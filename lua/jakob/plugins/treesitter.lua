return {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').install {
            "c", "lua", "vim", "vimdoc", "python", "bash", "cpp"
        }

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
            desc = "Auto-install parsers and set tree-sitter based indent",
            callback = function(args)
                local buf = args.buf
                local ft = args.match

                -- Ignore completely empty filetypes
                if not ft or ft == "" then return end

                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return
                end

                local lang = vim.treesitter.language.get_lang(ft) or ft

                if type(lang) == "string" and lang ~= "" then
                    local installed = require('nvim-treesitter').get_installed()
                    local available = require('nvim-treesitter').get_available()

                    if vim.tbl_contains(installed, lang) then
                        pcall(vim.treesitter.start, buf, lang)
                        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    elseif vim.tbl_contains(available, lang) then
                        pcall(function()
                            require('nvim-treesitter').install({ lang })
                        end)
                    end
                end
            end
        })
    end
}
