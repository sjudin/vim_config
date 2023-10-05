local arena = require("arena")
arena.setup{
    per_project = true
}

vim.keymap.set('n', '<C-a>', arena.toggle, {desc = "(arena) Toggle"})
