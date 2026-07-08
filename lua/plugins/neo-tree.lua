return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        lazy = false,
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {
                "<leader>e",
                "<cmd>Neotree toggle filesystem reveal left<CR>",
                desc = "Toggle file explorer",
            },
            {
                "<leader>E",
                "<cmd>Neotree focus filesystem reveal left<CR>",
                desc = "Focus file explorer",
            },
        },
        opts = {
            close_if_last_window = true,

            popup_border_style = "rounded",

            enable_git_status = true,
            enable_diagnostics = true,

            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_by_name = {
                        "node_modules",
                        ".git",
                    },
                    never_show = {
                        ".DS_Store",
                        "thumbs.db",
                    },
                },

                follow_current_file = {
                    enabled = true,
                },

                use_libuv_file_watcher = true,
            },

            window = {
                position = "left",
                width = 32,
                mappings = {
                    ["<space>"] = "none",
                    ["o"] = "open",
                    ["<CR>"] = "open",
                    ["S"] = "open_split",
                    ["s"] = "open_vsplit",
                    ["t"] = "open_tabnew",
                    ["C"] = "close_node",
                    ["z"] = "close_all_nodes",
                    ["R"] = "refresh",
                    ["a"] = {
                        "add",
                        config = {
                            show_path = "relative",
                        },
                    },
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["x"] = "cut_to_clipboard",
                    ["c"] = "copy_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["y"] = "copy_selector",
                },
            },
        },
    },
}
