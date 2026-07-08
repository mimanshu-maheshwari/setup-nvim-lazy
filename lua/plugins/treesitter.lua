return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            "neovim-treesitter/treesitter-parser-registry",
        },

        config = function()
            local treesitter = require("nvim-treesitter")

            -----------------------------------------------------------
            -- Parser installation
            -----------------------------------------------------------

            local parsers = {
                "bash",
                "c",
                "fish",
                "go",
                "java",
                "javascript",
                "json",
                "kotlin",
                "lua",
                "markdown",
                "markdown_inline",
                "query",
                "rust",
                "solidity",
                "sql",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            }

            -- Optional, but keeps parsers/queries in Neovim's data dir.
            treesitter.setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            -- Install parsers. Already-installed parsers are skipped.
            treesitter.install(parsers)

            -----------------------------------------------------------
            -- Filetypes where Treesitter should start
            -----------------------------------------------------------

            local filetypes = {
                "lua",
                "vim",
                "help",
                "query",

                "rust",
                "toml",

                "java",
                "kotlin",
                "xml",

                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "json",

                "sh",
                "bash",
                "fish",
                "markdown",
                "yaml",
            }

            -----------------------------------------------------------
            -- Enable Treesitter per buffer
            -----------------------------------------------------------

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
                pattern = filetypes,
                callback = function(event)
                    local bufnr = event.buf

                    -- Start Treesitter highlighting.
                    -- Guarded so unsupported/missing parsers don't crash Neovim.
                    local ok = pcall(vim.treesitter.start, bufnr)
                    if not ok then
                        return
                    end

                    -- Treesitter folds.
                    -- These are window-local options.
                    vim.wo.foldmethod = "expr"
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo.foldlevel = 99

                    -- IMPORTANT:
                    -- foldlevelstart is global, not window-local.
                    -- Do not use vim.wo.foldlevelstart.
                    vim.o.foldlevelstart = 99

                    -- Treesitter indentation.
                    -- Guarded because not every parser has good indent support.
                    pcall(function()
                        vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end)
                end,
            })
        end,
    },
}
