return {
  -- 平滑滚动体验
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = "cubic",
        pre_hook = nil,
        post_hook = nil,
        performance_mode = true,  -- Enable performance mode for smoother scrolling
        ignored_events = { "WinScrolled", "TermEnter" },
      })
    end,
  },

  -- 更强大的文本对象导航
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = {
      n_lines = 50,
    },
  },

  -- 文本对齐助手 mini.align
  {
    "nvim-mini/mini.align",
    event = "VeryLazy",
    opts = {},
  },

  -- 自动补全括号与引号
  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },

  -- 在单行与多行结构间切换
  {
    "nvim-mini/mini.splitjoin",
    event = "VeryLazy",
    opts = {
      mappings = {
        toggle = "gS",
        split = "gSs",
        join = "gSj",
      },
    },
  },

  -- 中文友好的注释管理
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      padding = true,
      sticky = true,
      ignore = "^$",
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      opleader = {
        line = "gc",
        block = "gb",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = nil,
      post_hook = nil,
    },
  },

  -- 树状可视化增强撤销重做
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" },
    },
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_SplitWidth = 40
      vim.g.undotree_DiffpanelHeight = 10
    end,
  },

  -- 沉浸式写作模式
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    dependencies = "folke/twilight.nvim",
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.95,
          width = 120,
          height = 1,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = "0",
            list = false,
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
            showmode = false,
          },
          twilight = { enabled = true },
          gitsigns = { enabled = false },
          tmux = { enabled = false },
          kitty = {
            enabled = false,
            font = "+2",
          },
          alacritty = {
            enabled = false,
            font = "12",
          },
          wezterm = {
            enabled = false,
            font = "+1",
          },
        },
        on_open = function(win)
        end,
        on_close = function()
        end,
      })
    end,
  },

  -- Twilight 负责柔化背景
  {
    "folke/twilight.nvim",
    event = "VeryLazy",
    opts = {
      dimming = {
        alpha = 0.25,
        color = { "Normal", "#ffffff" },
        term_bg = "#000000",
        inactive = true,
      },
      context = 10,
      treesitter = true,
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {},
    },
  },

  -- 更直观的标记列表
  {
    "kshenoy/vim-signature",
    event = "VeryLazy",
    config = function()
      vim.g.SignatureMarkTextHL = "Search"
      vim.g.SignaturePurgeConfirmation = 1
    end,
  },

  -- 会话持久化
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
      pre_save = nil,
      save_empty = false,
      need_nofold = false,
    },
  },

  -- 增强文本对象与移动
  {
    "wellle/targets.vim",
    event = "VeryLazy",
  },

  -- 更智能的折叠体验
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })

      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    end,
  },

  -- 类似 VSCode 的引用查看窗口 (Shift+F12)
  {
    "dnlhc/glance.nvim",
    event = "VeryLazy",
    config = function()
      require("glance").setup({
        detectors = {
          treesitter = true,
          lsp = true,
        },
        theme = {
          enable = true,
          mode = "auto",
        },
        indent = {
          guides = true,
          size = 2,
        },
        mappings = {
          list = {},
          preview = {},
        },
        folds = {
          folded = false,
        },
        offset = {
          rwidth = 0,
          hwidth = 0,
        },
        winbar = {
          enable = true,
        },
      })

    end,
  },
}
