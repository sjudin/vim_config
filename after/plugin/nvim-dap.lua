local dap, dapui = require("dap"), require("dapui")

require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
dapui.setup{}

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "(debugging) Continue/start debugging" })
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "(debugging) Toggle breakpoint" })
vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = "(debugging) Step over" })
vim.keymap.set('n', '<leader>ds', dap.step_into, { desc = "(debugging) Step into" })
vim.keymap.set('n', '<leader>do', dap.step_out, { desc = "(debugging) Step out" })
vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = "(debugging) Terminate" })
