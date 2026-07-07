return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",

            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
        keys = {
            {
                "<leader>ff",
                "<cmd>Telescope find_files<CR>",
                desc = "Find files",
            },
            {
                "<leader>fg",
                "<cmd>Telescope live_grep<CR>",
                desc = "Live grep",
            },
            {
                "<leader>fb",
                "<cmd>Telescope buffers<CR>",
                desc = "Find buffers",
            },
            {
                "<leader>fh",
                "<cmd>Telescope help_tags<CR>",
                desc = "Help tags",
            },
            {
                "<leader>fr",
                "<cmd>Telescope oldfiles<CR>",
                desc = "Recent files",
            },
            {
                "<leader>fc",
                "<cmd>Telescope grep_string<CR>",
                desc = "Find word under cursor",
            },
        },
        config = function()
            local telescope = require("telescope")

            telescope.setup({
                defaults = {
                    prompt_prefix = "   ",
                    selection_caret = "❯ ",
                    path_display = { "smart" },

                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                            ["<C-q>"] = "send_selected_to_qflist",
                            ["<Esc>"] = "close",
                        },
                    },
                },

                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    live_grep = {
                        additional_args = function()
                            return { "--hidden" }
                        end,
                    },
                },
            })

            pcall(telescope.load_extension, "fzf")
        end,
    },
}
