local opt = vim.opt
local keymap = vim.keymap

-----------------------------------------------------------
-- Folding
-----------------------------------------------------------

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Safe global fallback.
-- Treesitter-specific folding should be enabled per buffer/filetype
-- from your treesitter.lua config.
opt.foldmethod = "indent"

-----------------------------------------------------------
-- Fold Keymaps
-----------------------------------------------------------

keymap.set("n", "zO", "<cmd>normal! zO<CR>", { desc = "Open folds recursively" })
keymap.set("n", "zC", "<cmd>normal! zC<CR>", { desc = "Close folds recursively" })

keymap.set("n", "zR", "<cmd>normal! zR<CR>", { desc = "Open all folds" })
keymap.set("n", "zM", "<cmd>normal! zM<CR>", { desc = "Close all folds" })

keymap.set("n", "za", "<cmd>normal! za<CR>", { desc = "Toggle fold" })
keymap.set("n", "zo", "<cmd>normal! zo<CR>", { desc = "Open fold" })
keymap.set("n", "zc", "<cmd>normal! zc<CR>", { desc = "Close fold" })

keymap.set("n", "<leader>z", "<cmd>normal! za<CR>", { desc = "Toggle fold" })
