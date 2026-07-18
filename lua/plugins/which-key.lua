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
        { "<leader>c", group = "Code" },
        { "<leader>cc", group = "Crates" },
        { "<leader>d", group = "Debug" },
        { "<leader>l", group = "LSP" },
        { "<leader>r", group = "Rust" },
        { "<leader>j", group = "Java" },
        { "<leader>b", group = "Buffers" },
      },
    },
  },
}
