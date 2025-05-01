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
            },
            -- pyright
            pyright = {
                cmd = {"pyright-langserver", "--stdio"},
                filetypes = {"python"},
                root_dir = require("lspconfig").util.root_pattern(".git", "pyproject.toml", "setup.py",
                    "requirements.txt"),
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic", -- 可选: "off", "basic", "strict"
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace"
                        }
                    }
                }
            },
            -- golang
            gopls = {
                cmd = {"gopls"},
                filetypes = {"go", "gomod", "gowork", "gotmpl"},
                root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true
                        },
                        staticcheck = true,
                        gofumpt = true,
                        usePlaceholders = true,
                        completeUnimported = true,
                        -- 集成静态检查功能
                        experimentalPostfixCompletions = true,
                        -- golangci-lint集成
                        linksInHover = false,
                        codelenses = {
                            gc_details = false,
                            generate = true,
                            regenerate_cgo = true,
                            test = true,
                            tidy = true,
                            upgrade_dependency = true,
                            vendor = true
                        }
                    }
                }
            },
            -- cmake
            neocmake = {
                cmd = {"neocmakelsp", "--stdio"},
                filetypes = {"cmake"},
                root_dir = require("lspconfig").util.root_pattern("CMakeLists.txt", "cmake", ".git"),
                init_options = {
                    buildDirectory = "build"
                },
                settings = {
                    cmake = {
                        lint = {
                            enable = true
                        },
                        scan_cmake_in_package = true,
                        lsp = {
                            serverPath = "" -- 服务器路径默认为空，会自动查找
                        },
                        single_file_support = true,
                        diagnostics = {
                            cmake = true, -- 启用cmake诊断
                            parse = true, -- 启用解析诊断
                            ctest = true -- 启用ctest诊断
                        },
                        fileApi = {
                            autoRun = true -- 自动运行CMake文件API查询
                        },
                        status = {
                            debug = false -- 启用调试状态
                        }
                    }
                }
            },
            taplo = {
                cmd = { "taplo", "lsp", "stdio" },
                filetypes = { "toml" },
                root_dir = require("lspconfig").util.root_pattern(".git", "."),
                settings = {
                    -- 这里可以添加 taplo 的自定义设置
                }
            },

        }
    }
}
