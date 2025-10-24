return {
  "neovim/nvim-lspconfig",
  opts = {
    -- LSP performance optimization
    diagnostics = {
      underline = true,
      virtual_text = { prefix = "●" },  -- Show as inline virtual text with icon
      float = { border = "rounded" },
      severity_sort = true,
      -- Only update diagnostics after 500ms of inactivity
      update_in_insert = false,
    },
    servers = {
      -- Python: Pyright (type checking and analysis)
      pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_dir = require("lspconfig").util.root_pattern("pyproject.toml", "setup.py", "requirements.txt"),
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      },

      -- Python: Ruff (fast linter and formatter)
      ruff_lsp = {
        cmd = { "ruff", "server" },
        filetypes = { "python" },
        root_dir = require("lspconfig").util.root_pattern("pyproject.toml", "setup.py", "requirements.txt", ".git"),
        settings = {
          ruff = {
            args = {},
            lint = {
              args = {},
              enable = true,
            },
            format = {
              args = {},
            },
          },
        },
      },

      -- Go: Gopls
      gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod"),
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            experimentalPostfixCompletions = true,
            linksInHover = false,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
          },
        },
      },

      -- CMake: Neocmake
      neocmake = {
        cmd = { "neocmakelsp", "--stdio" },
        filetypes = { "cmake" },
        root_dir = require("lspconfig").util.root_pattern("CMakeLists.txt", "cmake"),
        init_options = {
          buildDirectory = "build",
        },
        settings = {
          cmake = {
            lint = {
              enable = true,
            },
            scan_cmake_in_package = true,
            lsp = {
              serverPath = "",
            },
            single_file_support = true,
            diagnostics = {
              cmake = true,
              parse = true,
              ctest = true,
            },
            fileApi = {
              autoRun = true,
            },
            status = {
              debug = false,
            },
          },
        },
      },

      -- Lua: Lua LS
      lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_dir = require("lspconfig").util.root_pattern(".luarc.json", ".luarc.jsonc", ".git"),
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim", "describe", "it", "assert", "before_each", "after_each" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      },

      -- TOML: Taplo
      taplo = {
        cmd = { "taplo", "lsp", "stdio" },
        filetypes = { "toml" },
        root_dir = require("lspconfig").util.root_pattern("."),
        settings = {},
      },

      -- YAML: yamlls
      yamlls = {
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml", "yml" },
        root_dir = require("lspconfig").util.root_pattern(".git", "."),
        settings = {
          yaml = {
            keyOrdering = false,
            format = {
              enable = true,
            },
            validate = true,
            hover = true,
            completion = true,
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
          },
        },
      },

      -- C/C++ Configuration with Clangd
      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "-j=12",
          "--clang-tidy",
          "--clang-tidy-checks=performance-*,bugprone-*,readability-*",
          "--all-scopes-completion",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
          "--header-insertion-decorators",
          "--pch-storage=disk",
          "--import-insertions",
          "--enable-config",
          "--suggest-missing-includes",
          "--inlay-hints",
          "--inlay-hints-hover",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        root_markers = {
          ".clangd",
          ".clang-tidy",
          ".clang-format",
          "compile_commands.json",
          "compile_flags.txt",
          "configure.ac",
          ".git",
        },
        capabilities = {
          offsetEncoding = "utf-16",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },

      -- Bash/Shell: Bash-ls
      bashls = {
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "bash", "zsh" },
        root_dir = require("lspconfig").util.root_pattern("."),
        settings = {
          bashIde = {
            backgroundAnalysisMaxFiles = 500,
            enableSourceErrorDiagnostics = false,
            globPattern = "**/*@(.sh|.inc|.bash|.command)",
            includeAllWorkspaceSymbols = false,
            logLevel = "info",
            shellcheckPath = "shellcheck",
            shellcheckArguments = "",
            explainshellEndpoint = "",
            shfmt = {
              path = "shfmt",
              ignoreEditorconfig = false,
              simplifyCode = false,
              languageDialect = "auto",
            },
          },
        },
      },

      -- JavaScript/TypeScript: Biome
      biome = {
        cmd = { "biome", "lsp-proxy" },
        filetypes = { "astro", "css", "graphql", "javascript", "javascriptreact", "json", "jsonc", "svelte",
          "typescript", "typescript.tsx", "typescriptreact", "vue" },
        root_dir = require("lspconfig").util.root_pattern("biome.json", "biome.jsonc"),
        settings = {
          biome = {
            format = {
              enable = true,
            },
            lint = {
              enable = true,
            },
          },
        },
      },

      -- TypeScript/JavaScript: TSServer
      tsserver = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
        root_dir = require("lspconfig").util.root_pattern("tsconfig.json", "jsconfig.json"),
        settings = {
          typescript = {
            format = {
              enable = true,
            },
            suggest = {
              autoImports = true,
            },
          },
          javascript = {
            format = {
              enable = true,
            },
            suggest = {
              autoImports = true,
            },
          },
        },
      },

      -- ESLint
      eslint = {
        cmd = { "vscode-eslint-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_dir = require("lspconfig").util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json"),
        settings = {},
      },

      -- Rust Configuration
      rust_analyzer = {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_dir = require("lspconfig").util.root_pattern("Cargo.toml", "rust-project.json"),
        settings = {
          ["rust-analyzer"] = {
            -- Assist
            assist = {
              importMergeBehavior = "last",
              importPrefix = "by_self",
              importEnforceGranularity = true,
            },
            -- Cargo
            cargo = {
              loadOutDirsFromCheck = true,
              allFeatures = true,
              features = "all",
              runBuildScripts = true,
              extraEnv = {},
            },
            -- Completion
            completion = {
              privateEditable = false,
              postfix = {
                enable = true,
              },
              autoimport = {
                enable = true,
              },
              autoself = {
                enable = true,
              },
            },
            -- Diagnostics
            diagnostics = {
              enable = true,
              disabled = {},
              warningsAsHint = {},
              warningsAsInfo = {},
            },
            -- Hover
            hover = {
              actions = {
                enable = true,
                implementations = {
                  enable = true,
                },
                references = {
                  enable = true,
                },
                run = {
                  enable = true,
                },
              },
              documentation = {
                enable = true,
              },
            },
            -- Inlay Hints
            inlayHints = {
              bindingModeHints = {
                enable = false,
              },
              chainingHints = {
                enable = true,
              },
              closureCaptureHints = {
                enable = false,
              },
              closureReturnTypeHints = {
                enable = false,
              },
              lifetimeElisionHints = {
                enable = false,
                useParameterNames = false,
              },
              maxLength = 25,
              parameterHints = {
                enable = true,
              },
              reborrowHints = {
                enable = false,
              },
              renderColons = true,
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
            -- Lens
            lens = {
              enable = true,
              implementations = {
                enable = true,
              },
              references = {
                adt = {
                  enable = false,
                },
                enumVariant = {
                  enable = false,
                },
                method = {
                  enable = false,
                },
                trait = {
                  enable = false,
                },
              },
              run = {
                enable = true,
              },
            },
            -- Macro Expansion
            macroExpansion = {
              enable = true,
              maxDepth = 32,
              recursive = true,
            },
            -- Proc Macros
            procMacro = {
              attributes = {
                enable = true,
              },
              enable = true,
              ignored = {},
            },
            -- Semantic Tokens
            semanticTokens = {
              enable = true,
            },
            -- Type Definition
            typing = {
              autoClosingAngleBrackets = {
                enable = true,
              },
            },
          },
        },
      },
    },
    setup = {
      -- Clangd setup with formatExpr
      clangd = function(_, opts)
        opts.capabilities.offsetEncoding = "utf-16"
        return false -- Let the default setup handle it
      end,
    },
  },
  config = function(_, opts)
    -- Setup LSP servers
    local lspconfig = require("lspconfig")

    for server, config in pairs(opts.servers) do
      -- Skip if server is not available in lspconfig
      if not lspconfig[server] or type(lspconfig[server]) ~= "table" or not lspconfig[server].setup then
        goto continue
      end

      -- Check if there's a custom setup handler for this server
      if opts.setup[server] then
        -- Call the setup handler and check if it handled setup (returns true) or needs default setup
        local ok, should_skip = pcall(function()
          return opts.setup[server](_, config)
        end)
        if ok and should_skip then
          goto continue
        end
      end

      -- Default setup
      local ok, err = pcall(function()
        lspconfig[server].setup(config)
      end)

      if not ok then
        vim.notify("Error setting up LSP server '" .. server .. "': " .. (err or "unknown error"), vim.log.levels.ERROR)
      end

      ::continue::
    end
  end,
}
