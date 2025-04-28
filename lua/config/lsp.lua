return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")

        -- Configure custom LSP server

        -- lua
        lspconfig.custom_lsp.setup({
            -- mode type, 0 is run cmd, 1 is local rpc, 2 is socket rpc
            -- git clone https://github.com/Tencent/LuaHelper.git and build it
            cmd = {"luahelper-lsp", "-mode", "0"},
            filetypes = {"customtype"},
            root_dir = lspconfig.util.root_pattern(".git", "stylua.toml"),
            settings = {
                -- LSP specific settings
            }
        })
    end,
    opts = {
        servers = {
            -- ruff 
            ruff = {
                cmd = {"ruff", "server"},
                filetypes = {"python"},
                -- 这样配置就能同时支持两种项目结构
                root_dir = require("lspconfig").util.root_pattern(".git", "pyproject.toml", "setup.py"),
                -- 其余配置保持不变
                init_options = { -- 添加 init_options 配置
                    settings = {
                        -- Ruff 语言服务器特定设置
                    }
                },
                settings = {
                    ruff = {
                        format = {
                            enable = true
                        }
                        -- 你可以在这里添加更多 ruff 设置
                    }
                }
            }
        }
    }

}

