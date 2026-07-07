return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            preset = "modern",

            delay = function(ctx)
                return ctx.plugin and 0 or 300
            end,

            spec = {
                { "<leader>f", group = "Find / Files" },
                { "<leader>g", group = "Git" },
                { "<leader>l", group = "LSP" },
                { "<leader>c", group = "Code" },
                { "<leader>b", group = "Buffers" },
                { "<leader>w", group = "Windows" },
                { "<leader>e", group = "Explorer" },
            },
        },
    },
}
