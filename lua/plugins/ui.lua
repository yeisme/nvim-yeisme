return {
  -- Tokyonight theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        light_style = "day",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { italic = false, bold = true },
          variables = { italic = false },
          numbers = { bold = true },
          strings = { italic = true },
          types = { italic = false },
        },
        sidebars = { "qf", "vista_kind", "terminal", "packer" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = true,
        on_colors = function(colors)
          colors.comment = "#565f89"
          colors.function_param = "#7aa2f7"
        end,
        on_highlights = function(hl, c)
          hl.Search = { bg = c.yellow, fg = c.bg, bold = true }
          hl.IncSearch = { bg = c.orange, fg = c.bg, bold = true }
          hl.DiagnosticError = { fg = c.red }
          hl.DiagnosticWarn = { fg = c.warning }
          hl.DiagnosticInfo = { fg = c.blue }
          hl.DiagnosticHint = { fg = c.cyan }
          hl.Pmenu = { bg = c.bg_popup, fg = c.fg }
          hl.PmenuSel = { bg = c.blue, fg = c.black, bold = true }
        end,
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },

  -- Status line enhancement
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "tokyonight",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "dashboard", "lazy", "alpha" },
            winbar = {},
          },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = {
            { "filename", path = 1 },
            { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
          },
          lualine_x = { { "encoding", show_bomb = true }, "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      }
    end,
  },

  -- Treesitter syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    cmd = { "TSInstall", "TSUpdate", "TSBufEnable" },
    opts = {
      ensure_installed = {
        "bash", "c", "cmake", "cpp", "css", "dart", "dockerfile",
        "go", "html", "java", "javascript", "json", "json5", "jsonc",
        "latex", "lua", "markdown", "markdown_inline", "python",
        "regex", "rust", "sql", "toml", "tsx", "typescript",
        "vim", "vimdoc", "yaml",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(_, buf)
          local max_filesize = 100 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<C-s>",
          node_decremental = "<bs>",
        },
      },
    },
  },

  -- Rainbow brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      require("rainbow-delimiters.setup")({
        strategy = {
          global = rainbow_delimiters.strategy["global"],
          query = rainbow_delimiters.strategy["query"],
        },
        highlight = {
          "RainbowDelimiterRed", "RainbowDelimiterYellow", "RainbowDelimiterBlue",
          "RainbowDelimiterOrange", "RainbowDelimiterGreen", "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },

  -- Scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    config = function()
      require("scrollbar").setup({
        handle = { text = " ", color = "#89ddff" },
        marks = {
          Search = { color = "#ff9e64" },
          Error = { color = "#f7768e" },
          Warn = { color = "#e0af68" },
          Info = { color = "#0db9d7" },
          Hint = { color = "#1abc9c" },
          Misc = { color = "#9ece6a" },
        },
        excluded_buftypes = { "terminal" },
        excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
      })
    end,
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      indent = { char = "▏", tab_char = "▏" },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        char = "▎",
      },
      exclude = {
        filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
      },
    },
  },

  -- Color highlighting
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        enable_tailwind = true,
      })
    end,
  },

  -- Whitespace visibility
  {
    "johnfrankmorgan/whitespace.nvim",
    event = "VeryLazy",
    config = function()
      require("whitespace-nvim").setup({
        highlight = "NonText",
        ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "dashboard" },
        ignore_terminal = true,
      })
    end,
  },
}
