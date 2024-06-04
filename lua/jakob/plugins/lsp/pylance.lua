-- cd ~/.vscode/extensions/ms-python.vscode-pylance-*/dist &&awk 'BEGIN{RS=ORS=";"} /if\(!process/ && !found {sub(/return!0x1/, "return!0x0"); found=1} 1' server.bundle.js |awk 'BEGIN{RS=ORS=";"} /throw new/ && !found {sub(/throw new/, ""); found=1} 1' > server_nvim.js
-- Tested for pylance 2024.2.1

-- cd ~/.vscode/extensions/ms-python.vscode-pylance-*/dist &&perl -pe 's/if\(!process.*?\)return!\[\];/if(false)return false;/g; s/throw new//g' server.bundle.js > server_nvim.js 
-- Tested for pylance 2024.5.1

local util = require("lspconfig.util")

local root_files = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
}

local function exepath(expr)
    local ep = vim.fn.exepath(expr)
    return ep ~= "" and ep or nil
end

local function int_to_bool(int)
    if int == 1 then
        return true
    end
    return false
end

local pylance_path = vim.fn.expand("~/.vscode/extensions/ms-python.vscode-pylance-2024.5.1/dist/server_nvim.js")

return {
    default_config = {
        before_init = function(_, config)
            if not config.settings.python then
                config.settings.python = {}
            end
            if not config.settings.python.pythonPath then
                config.settings.python.pythonPath = exepath("python3") or exepath("python") or "python"
            end
        end,
        cmd = { "node", pylance_path, "--stdio" },
        filetypes = { "python" },
        autostart = int_to_bool(vim.fn.filereadable(pylance_path)),
        single_file_support = true,
        root_dir = util.root_pattern(unpack(root_files)),
        settings = {
            python = {
                analysis = {
                    typeCheckingMode="basic",
                    inlayHints = {
                        variableTypes = true,
                        functionReturnTypes = false,
                        callArgumentNames = true,
                        pytestParameters = true,
                    },
                },
            },
        },
    },
}
