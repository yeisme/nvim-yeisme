return {
  -- Tokyo Night 主题配置（支持浅色和深色模式）
  -- 作用：提供现代化、舒适的配色方案
  {
    "folke/tokyonight.nvim",
    lazy = false,                 -- 不延迟加载，必须在启动时立即加载以应用主题
    priority = 1000,              -- 加载优先级最高，确保在其他插件之前加载
    config = function()
      require("tokyonight").setup({
        style = "night",          -- 使用深色主题
        light_style = "day",      -- 浅色模式使用 day 主题
        transparent = false,      -- 不使用透明背景
        terminal_colors = true,   -- 应用主题颜色到终端
        -- 代码语法样式配置：控制不同元素的粗体、斜体等
        styles = {
          comments = { italic = true },        -- 注释显示为斜体
          keywords = { italic = true },        -- 关键字显示为斜体
          functions = { italic = false, bold = true },  -- 函数名加粗
          variables = { italic = false },      -- 变量使用正常样式
          numbers = { bold = true },           -- 数字加粗
          strings = { italic = true },         -- 字符串显示为斜体
          types = { italic = false },          -- 类型使用正常样式
        },
        sidebars = { "qf", "vista_kind", "terminal", "packer" },  -- 侧边栏类型列表
        day_brightness = 0.3,     -- 浅色模式的亮度调整
        hide_inactive_statusline = false,      -- 隐藏非活跃窗口的状态栏
        dim_inactive = false,      -- 不暗化非活跃窗口
        lualine_bold = true,       -- 状态栏文本加粗
        -- 自定义颜色配置
        on_colors = function(colors)
          colors.comment = "#565f89"           -- 修改注释颜色为更深的蓝灰色
          colors.function_param = "#7aa2f7"    -- 修改函数参数颜色
        end,
        -- 自定义高亮配置：微调不同元素的外观
        on_highlights = function(hl, c)
          hl.Search = { bg = c.yellow, fg = c.bg, bold = true }      -- 搜索结果：黄色背景
          hl.IncSearch = { bg = c.orange, fg = c.bg, bold = true }   -- 实时搜索：橙色背景
          hl.DiagnosticError = { fg = c.red }                        -- 错误：红色
          hl.DiagnosticWarn = { fg = c.warning }                     -- 警告：警告色
          hl.DiagnosticInfo = { fg = c.blue }                        -- 信息：蓝色
          hl.DiagnosticHint = { fg = c.cyan }                        -- 提示：青色
          hl.Pmenu = { bg = c.bg_popup, fg = c.fg }                  -- 补全菜单
          hl.PmenuSel = { bg = c.blue, fg = c.black, bold = true }   -- 补全菜单选中项
        end,
      })
      vim.cmd("colorscheme tokyonight")  -- 应用 tokyonight 主题
    end,
  },

  -- 状态栏增强（Lualine）：提供更美观、功能丰富的底部状态栏
  -- 作用：显示当前编辑模式、Git 信息、诊断、光标位置等
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",  -- 延迟加载，在有内容后才加载以加快启动
    opts = function()
      local custom_theme = vim.deepcopy(require("lualine.themes.tokyonight"))
      local colors = require("tokyonight.colors").setup()

      custom_theme.normal.a = { fg = colors.bg, bg = colors.blue, gui = "bold" }
      custom_theme.insert.a = { fg = colors.bg, bg = colors.green, gui = "bold" }
      custom_theme.visual.a = { fg = colors.bg, bg = colors.magenta, gui = "bold" }
      custom_theme.replace.a = { fg = colors.bg, bg = colors.red, gui = "bold" }
      custom_theme.command.a = { fg = colors.bg, bg = colors.yellow, gui = "bold" }
      custom_theme.terminal = custom_theme.terminal or {}
      custom_theme.terminal.a = { fg = colors.bg, bg = colors.cyan, gui = "bold" }

      custom_theme.normal.b.bg = colors.bg_highlight
      custom_theme.normal.b.fg = colors.fg
      custom_theme.normal.c.bg = colors.bg
      custom_theme.normal.c.fg = colors.fg

      for _, mode in ipairs({ "insert", "visual", "replace", "command", "terminal" }) do
        if custom_theme[mode] then
          custom_theme[mode].b = custom_theme[mode].b or {}
          custom_theme[mode].c = custom_theme[mode].c or {}
          custom_theme[mode].b.bg = colors.bg_highlight
          custom_theme[mode].b.fg = colors.fg
          custom_theme[mode].c.bg = colors.bg
          custom_theme[mode].c.fg = colors.fg
        end
      end

      custom_theme.inactive = custom_theme.inactive or {}
      custom_theme.inactive.a = { fg = colors.fg_gutter, bg = colors.bg_dark }
      custom_theme.inactive.b = { fg = colors.fg_gutter, bg = colors.bg_dark }
      custom_theme.inactive.c = { fg = colors.fg_gutter, bg = colors.bg_dark }

      local bubble_left = ""
      local bubble_right = ""
      local function bubble(component)
        local conf = {
          separator = { left = bubble_left, right = bubble_right },
          padding = { left = 1, right = 1 },
        }
        if type(component) == "string" then
          component = { component }
        end
        return vim.tbl_deep_extend("force", conf, component)
      end
      
      return {
        options = {
          theme = custom_theme,
          -- 使用 Powerline 风格的分隔符，实现圆弧过渡
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            -- 在这些文件类型中禁用状态栏显示
            statusline = { "dashboard", "lazy", "alpha" },
            winbar = {},  -- 窗口栏禁用类型（暂无）
          },
          globalstatus = true,  -- 全局状态栏：所有窗口共享一个状态栏
          always_divide_middle = true,  -- 总是在中间分割
        },
        sections = {
          -- 左侧显示内容
          lualine_a = {
            bubble({
              "mode",
              fmt = function(str)
                -- 为模式添加图标和美化
                local mode_icon = {
                  n = "🔷 ",
                  i = "✎ ",
                  c = "⌘ ",
                  v = "◆ ",
                  [""] = "◆ ",
                  V = "◆ ",
                  s = "◇ ",
                  S = "◇ ",
                  R = "◈ ",
                  r = "◇ ",
                  ["!"] = "⚡ ",
                  t = "📦 ",
                }
                return (mode_icon[vim.fn.mode()] or "❓ ") .. str
              end,
            }),
          },
          lualine_b = {
            bubble({
              "branch",
              icon = "",
              padding = { left = 2, right = 2 },
            }),
            bubble({
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
            }),
          },  -- 显示 Git 分支和文件变更情况
          lualine_c = {
            bubble({
              "filename",
              path = 1,
              symbols = { modified = " ", readonly = " ", unnamed = "[No Name]" },
            }),  -- 显示完整文件路径（path=1）
            -- 显示诊断信息（错误、警告等）及其自定义图标
            bubble({
              "diagnostics",
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
            }),
          },
          -- 右侧显示内容
          lualine_x = {
            bubble({ "encoding", show_bomb = true }),
            bubble("fileformat"),
            bubble("filetype"),
          },
          lualine_y = {
            bubble({
              "progress",
              fmt = function(str)
                return "⊙ " .. str
              end,
            }),
          },
          lualine_z = {
            bubble({
              "location",
              fmt = function(str)
                return "⟔ " .. str
              end,
            }),
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "neo-tree", "trouble", "lazy" },
      }
    end,
  },

  -- Treesitter 语法高亮（增量解析器）
  -- 作用：提供更准确的代码高亮和结构分析
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",  -- 每次安装/更新插件后运行此命令更新解析器
    event = "VeryLazy",   -- 延迟加载以加快启动
    cmd = { "TSInstall", "TSUpdate", "TSBufEnable" },  -- 支持的命令
    opts = {
      -- 指定要安装的语言解析器
      ensure_installed = {
        "bash", "c", "cmake", "cpp", "css", "dart", "dockerfile",
        "go", "html", "java", "javascript", "json", "json5", "jsonc",
        "latex", "lua", "markdown", "markdown_inline", "python",
        "regex", "rust", "sql", "toml", "tsx", "typescript",
        "vim", "vimdoc", "yaml",
      },
      highlight = {
        enable = true,  -- 启用 Treesitter 语法高亮
        additional_vim_regex_highlighting = false,  -- 不使用 Vim 正则表达式高亮（使用 Treesitter 替代）
        disable = function(_, buf)
          -- 禁用语法高亮的条件判断
          
          -- 禁用大文件的高亮：>100KB 的文件不使用 Treesitter（性能优化）
          local max_filesize = 100 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
          
          -- 禁用特定文件类型的高亮：某些文件不需要高亮
          local filetype = vim.bo[buf].filetype
          if filetype:match("^(fugitive|fugitiveblame|git|netrw|Trouble|notify|noice)") then
            return true
          end
        end,
      },
      indent = { enable = true },  -- 启用基于 Treesitter 的缩进计算
      incremental_selection = {    -- 增量选择：C-space 逐级扩展选区
        enable = true,
        keymaps = {
          init_selection = "<C-space>",    -- 开始选择
          node_incremental = "<C-space>",  -- 扩展选区到下一节点
          scope_incremental = "<C-s>",     -- 扩展选区到下一作用域
          node_decremental = "<bs>",       -- 缩小选区
        },
      },
    },
  },

  -- 彩虹括号（Rainbow Delimiters）
  -- 作用：用不同颜色标记配对的括号、花括号等，便于识别嵌套结构
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      require("rainbow-delimiters.setup")({
        strategy = {
          global = rainbow_delimiters.strategy["global"],    -- 全局策略
          query = rainbow_delimiters.strategy["query"],      -- 查询策略
        },
        highlight = {
          -- 定义配对括号的颜色序列，从左到右循环使用
          "RainbowDelimiterRed", "RainbowDelimiterYellow", "RainbowDelimiterBlue",
          "RainbowDelimiterOrange", "RainbowDelimiterGreen", "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },

  -- 滚动条（Nvim Scrollbar）
  -- 作用：在右边显示滚动条，还能显示搜索结果、诊断等标记
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    config = function()
      require("scrollbar").setup({
        handle = { text = " ", color = "#89ddff" },  -- 滚动条句柄样式和颜色
        marks = {
          Search = { color = "#ff9e64" },   -- 搜索结果标记：橙色
          Error = { color = "#f7768e" },    -- 错误标记：红色
          Warn = { color = "#e0af68" },     -- 警告标记：黄色
          Info = { color = "#0db9d7" },     -- 信息标记：青色
          Hint = { color = "#1abc9c" },     -- 提示标记：绿色
          Misc = { color = "#9ece6a" },     -- 其他标记：浅绿色
        },
        excluded_buftypes = { "terminal" },  -- 在终端缓冲区中不显示滚动条
        excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },  -- 在这些文件类型中不显示
      })
    end,
  },

  -- 缩进指引线（Indent Blankline）
  -- 作用：显示竖线标示代码缩进级别，便于快速定位代码块
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      -- 缩进线的字符和样式配置
      indent = { char = "▏", tab_char = "▏" },  -- 使用细竖线表示缩进
      scope = {
        enabled = true,           -- 启用作用域显示
        show_start = true,        -- 显示作用域开始位置
        show_end = true,          -- 显示作用域结束位置
        char = "▎",               -- 作用域线使用稍粗的竖线
      },
      -- 在这些文件类型和缓冲类型中禁用缩进指引，以提高性能
      exclude = {
        filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "lspinfo", "DAP", "terminal" },
        buftypes = { "terminal", "nofile", "quickfix", "prompt" },
      },
    },
  },

  -- 颜色高亮（Nvim Highlight Colors）
  -- 作用：在编辑器中直观显示颜色值（如 #ff0000 会显示为红色背景）
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",     -- 在背景显示颜色（而不是前景）
        enable_tailwind = true,    -- 支持 Tailwind CSS 颜色类名
      })
    end,
  },

  -- 空白字符可见化（Whitespace）
  -- 作用：显示制表符、空行等隐藏字符，帮助发现格式问题
  {
    "johnfrankmorgan/whitespace.nvim",
    event = "VeryLazy",
    config = function()
      require("whitespace-nvim").setup({
        highlight = "NonText",    -- 使用 NonText 颜色组显示空白字符
        ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "dashboard" },  -- 在这些文件类型中不显示
        ignore_terminal = true,   -- 在终端缓冲区中不显示
      })
    end,
  },
}
