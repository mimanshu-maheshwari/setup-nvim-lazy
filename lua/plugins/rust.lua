return {
    {
        "mrcjkb/rustaceanvim",
        version = "^9",
        lazy = false,
        init = function()
            vim.g.rustaceanvim = {
                tools = {
                    test_executor = "background",
                },
                server = {
                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                            },
                            check = {
                                command = "clippy",
                            },
                            lens = {
                                enable = true,
                            },
                        },
                    },
                },
            }
        end,
        keys = {
            { "<leader>rr", "<cmd>RustLsp runnables<CR>",   desc = "Rust Runnables" },
            { "<leader>rR", "<cmd>RustLsp run<CR>",         desc = "Rust Run Under Cursor" },
            { "<leader>rt", "<cmd>RustLsp testables<CR>",   desc = "Rust Testables" },
            { "<leader>rd", "<cmd>RustLsp debuggables<CR>", desc = "Rust Debuggables" },
            { "<leader>rD", "<cmd>RustLsp debug<CR>",       desc = "Rust Debug Under Cursor" },
        },
    },
}
