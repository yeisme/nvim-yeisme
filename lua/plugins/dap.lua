return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Basic DAP UI setup
    dapui.setup()

    -- DAP UI auto-open/close
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Setup Go debugging
    require("dap-go").setup()

    -- Setup Python debugging
    require("dap-python").setup("python")
  end,
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dn", function() require("dap").step_over() end, desc = "Step over" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step out" },
    { "<leader>dui", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
  },
}
