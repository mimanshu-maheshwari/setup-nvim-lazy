return {
    {
        "nvim-java/nvim-java",
        ft = "java",
        lazy = true,
        config = function()
            require("java").setup()
            vim.lsp.enable("jdtls")
        end,
    },
}
