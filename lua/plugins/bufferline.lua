return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "H",          "<cmd>BufferLineCyclePrev<CR>",   desc = "Previous buffer" },
            { "L",          "<cmd>BufferLineCycleNext<CR>",   desc = "Next buffer" },
            { "<leader>bd", "<cmd>bdelete<CR>",               desc = "Delete buffer" },
            { "<leader>bp", "<cmd>BufferLineTogglePin<CR>",   desc = "Pin buffer" },
            { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
        },
        opts = {
            options = {
                mode = "buffers",
                numbers = "none",
                close_command = "bdelete! %d",
                right_mouse_command = "bdelete! %d",
                left_mouse_command = "buffer %d",
                middle_mouse_command = nil,

                indicator = {
                    style = "icon",
                    icon = "▎",
                },

                buffer_close_icon = "󰅖",
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",

                max_name_length = 18,
                max_prefix_length = 15,
                truncate_names = true,
                tab_size = 18,

                diagnostics = "nvim_lsp",

                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true,
                    },
                },

                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = false,
                show_tab_indicators = true,

                separator_style = "thin",
                always_show_bufferline = true,

                sort_by = "insert_after_current",
            },
        },
    },
}
