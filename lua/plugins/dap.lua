return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<F5>",       function() require("dap").continue() end,          desc = "Debug: Start/Continue" },
            { "<F10>",      function() require("dap").step_over() end,         desc = "Debug: Step Over" },
            { "<F11>",      function() require("dap").step_into() end,         desc = "Debug: Step Into" },
            { "<F12>",      function() require("dap").step_out() end,          desc = "Debug: Step Out" },

            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            {
                "<leader>dB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                desc = "Conditional Breakpoint",
            },
            { "<leader>dc", function() require("dap").continue() end,  desc = "Debug Continue" },
            { "<leader>dr", function() require("dap").repl.open() end, desc = "Debug REPL" },
            { "<leader>dl", function() require("dap").run_last() end,  desc = "Run Last Debug" },
        },
        config = function()
            local dap = require("dap")

            vim.fn.sign_define("DapBreakpoint", {
                text = "●",
                texthl = "DiagnosticSignError",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapBreakpointCondition", {
                text = "◆",
                texthl = "DiagnosticSignWarn",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapStopped", {
                text = "▶",
                texthl = "DiagnosticSignInfo",
                linehl = "Visual",
                numhl = "DiagnosticSignInfo",
            })
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        keys = {
            { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle Debug UI" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

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
        end,
    },

    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        opts = {},
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            ensure_installed = {
                "codelldb",
            },
            handlers = {},
        },
    },
}
