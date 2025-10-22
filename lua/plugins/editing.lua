return {
  -- Smooth scrolling
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
        performance_mode = false,
        ignored_events = { "WinScrolled", "TermEnter" },
      })
    end,
  },

  -- Better navigation and text objects
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = {
      n_lines = 50,
    },
  },

  -- Alignable with mini.align
  {
    "nvim-mini/mini.align",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto-pairs
  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },

  -- Split/Join operations
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

  -- Better comment handling
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

  -- Better undo/redo with tree visualization
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

  -- Live search and replace
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("spectre").setup({
        color_devicons = true,
        highlight = {
          ui = "String",
          search = "DiffChange",
          replace = "DiffDelete",
        },
        mapping = {
          ["toggle_line"] = {
            map = "dd",
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = "Toggle current item",
          },
          ["enter_file"] = {
            map = "<cr>",
            cmd = "<cmd>lua require('spectre.actions').enter_file()<CR>",
            desc = "Go to file",
          },
          ["send_to_qf"] = {
            map = "<leader>sq",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "Send all items to quickfix",
          },
          ["replace_cmd"] = {
            map = "<leader>sc",
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = "Input replace command",
          },
          ["show_option_menu"] = {
            map = "<leader>so",
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = "Show options",
          },
          ["run_current_replace"] = {
            map = "<leader>rc",
            cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
            desc = "Replace current item",
          },
          ["run_replace"] = {
            map = "<leader>R",
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = "Replace all",
          },
          ["change_view_mode"] = {
            map = "<leader>sv",
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = "Change result view mode",
          },
          ["toggle_live_update"] = {
            map = "tu",
            cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
            desc = "Update results on every text change",
          },
          ["toggle_ignore_case"] = {
            map = "ti",
            cmd = "<cmd>lua require('spectre').toggle_ignore_case()<CR>",
            desc = "Toggle ignore case",
          },
          ["toggle_ignore_hidden"] = {
            map = "th",
            cmd = "<cmd>lua require('spectre').toggle_hidden()<CR>",
            desc = "Toggle search hidden files",
          },
          ["resume_last_search"] = {
            map = "<leader>l",
            cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
            desc = "Resume last search",
          },
          ["select_all"] = {
            map = "<leader>sa",
            cmd = "<cmd>lua require('spectre.actions').select_all()<CR>",
            desc = "Select all items",
          },
        },
      })
    end,
  },

  -- Distraction-free writing mode
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

  -- Twilight for highlighting
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

  -- Improved marks visualization
  {
    "kshenoy/vim-signature",
    event = "VeryLazy",
    config = function()
      vim.g.SignatureMarkTextHL = "Search"
      vim.g.SignaturePurgeConfirmation = 1
    end,
  },

  -- Session management
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

  -- Better text objects and movements
  {
    "wellle/targets.vim",
    event = "VeryLazy",
  },

  -- Improved folding
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
}
