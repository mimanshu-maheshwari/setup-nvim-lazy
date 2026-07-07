return {
    {
        "mrcjkb/rustaceanvim",
        version = "^9",
        lazy = true,
        init = function()
            vim.g.rustaceanvim = {
                server = {
                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                            },
                            check = {
                                command = "clippy",
                            },
                        },
                    },
                },
            }
        end,
    },
}
