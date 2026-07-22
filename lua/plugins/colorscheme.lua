return {
  "tinted-theming/tinted-vim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true, -- Enables transparency for the main editor window
    styles = {
      -- sidebars = "transparent", -- Makes sidebars (like neo-tree, nvim-tree) transparent
      -- floats = "transparent",   -- Makes floating windows transparent
    },
  },
  config = function(_, opts)
    -- require("tokyonight").setup(opts)
    vim.cmd([[colorscheme base16-atelier-forest]])
  end,
}
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {
--     transparent = true, -- Enables transparency for the main editor window
--     styles = {
--       -- sidebars = "transparent", -- Makes sidebars (like neo-tree, nvim-tree) transparent
--       -- floats = "transparent",   -- Makes floating windows transparent
--     },
--   },
--   config = function(_, opts)
--     require("tokyonight").setup(opts)
--     vim.cmd([[colorscheme tokyonight]])
--   end,
-- }
