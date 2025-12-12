pylance_path = vim.fn.expand("~/.vscode/extensions/ms-python.vscode-pylance-2025.10.4/dist/server_nvim.js")

local function int_to_bool(int)
    if int == 1 then
        return true
    end
    return false
end

function pylance_available()
    return int_to_bool(vim.fn.filereadable(pylance_path))
end

require("jakob")
