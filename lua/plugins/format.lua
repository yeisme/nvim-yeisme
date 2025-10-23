return {
  -- Formatter plugin for LazyVim
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ruff = {
          command = "ruff",
          args = { "format", "--stdin-filename", "$FILENAME" },
          stdin = true,
        },
        ruff_fix = {
          command = "ruff",
          args = { "check", "--fix", "--stdin-filename", "$FILENAME" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        python = { "ruff_fix", "ruff" },
      },
    },
  },

  -- Optional: Linter plugin for additional linting
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
      linters = {
        ruff = {
          cmd = "ruff",
          args = { "check", "--output-format", "json" },
          stdin = false,
          append_fname = true,
          stream = "stdout",
          ignore_exitcode = true,
          parser = require("lint.parser").from_json,
        },
      },
    },
  },
}
