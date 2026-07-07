return {
    {
        "nvim-java/nvim-java",
        ft = "java",
        dependencies = {
            "mfussenegger/nvim-dap",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("java").setup()
            vim.lsp.enable("jdtls")

            local function map_java_keys(bufnr)
                local map = function(lhs, rhs, desc)
                    vim.keymap.set("n", lhs, rhs, {
                        buffer = bufnr,
                        silent = true,
                        desc = desc,
                    })
                end

                map("<leader>jr", "<cmd>JavaRunnerRunMain<CR>", "Java Run Main")
                map("<leader>jS", "<cmd>JavaRunnerStopMain<CR>", "Java Stop Main")
                map("<leader>jl", "<cmd>JavaRunnerToggleLogs<CR>", "Java Toggle Logs")

                map("<leader>jt", "<cmd>JavaTestRunCurrentMethod<CR>", "Java Test Method")
                map("<leader>jT", "<cmd>JavaTestRunCurrentClass<CR>", "Java Test Class")
                map("<leader>ja", "<cmd>JavaTestRunAllTests<CR>", "Java Test All")

                map("<leader>jd", "<cmd>JavaTestDebugCurrentMethod<CR>", "Java Debug Test Method")
                map("<leader>jD", "<cmd>JavaTestDebugCurrentClass<CR>", "Java Debug Test Class")
                map("<leader>jA", "<cmd>JavaTestDebugAllTests<CR>", "Java Debug All Tests")

                map("<leader>jp", "<cmd>JavaTestViewLastReport<CR>", "Java Test Report")
                map("<leader>jb", "<cmd>JavaBuildBuildWorkspace<CR>", "Java Build Workspace")
                map("<leader>jc", "<cmd>JavaBuildCleanWorkspace<CR>", "Java Clean Workspace")
            end

            map_java_keys(0)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = function(event)
                    map_java_keys(event.buf)
                end,
            })
        end,
    },
}
