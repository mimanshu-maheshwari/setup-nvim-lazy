return {
    {
        "Saghen/blink.cmp",
        version = "1.*",
        opts = {
            keymap = {
                preset = "default",
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 250,
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
            "Saghen/blink.cmp",
        },
        config = function()
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "if_many",
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "jdtls",
                },

                -- rust_analyzer is handled by rustaceanvim.
                -- jdtls is handled by nvim-java.
                automatic_enable = {
                    exclude = {
                        "rust_analyzer",
                        "jdtls",
                    },
                },
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
        end,
    },
}
