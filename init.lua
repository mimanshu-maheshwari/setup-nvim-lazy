-- Leader keys must be set before loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable unused built-in providers for faster startup
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

local opt = vim.opt
local keymap = vim.keymap

-----------------------------------------------------------
-- General
-----------------------------------------------------------

opt.history = 1000
opt.mouse = "a"
opt.confirm = true
opt.hidden = true
opt.updatetime = 250
opt.timeoutlen = 1000
opt.ttimeoutlen = 10

-- Neovim already runs in nocompatible mode.
-- Do not use: vim.opt.setnocompatible = true

-----------------------------------------------------------
-- UI
-----------------------------------------------------------
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
-- opt.colorcolumn = "80"
opt.showmode = false
opt.laststatus = 3
opt.showtabline = 2
opt.cmdheight = 1
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.pumheight = 10
opt.winborder = "rounded"

-----------------------------------------------------------
-- Tabs / Indentation
-----------------------------------------------------------

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftround = true
opt.smartindent = true
opt.autoindent = true
opt.breakindent = true

-----------------------------------------------------------
-- Search
-----------------------------------------------------------

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split"

-----------------------------------------------------------
-- Files / Undo / Backup
-----------------------------------------------------------

opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.autowrite = true
opt.autoread = true

-----------------------------------------------------------
-- Clipboard
-----------------------------------------------------------

-- Better for Linux desktop clipboard than only "unnamed"
opt.clipboard = "unnamedplus"

-----------------------------------------------------------
-- Completion
-----------------------------------------------------------

opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("c")

-----------------------------------------------------------
-- Wrapping / Invisible Characters
-----------------------------------------------------------

opt.wrap = false
opt.linebreak = true

opt.list = true
opt.listchars = {
    tab = "» ",
    trail = "·",
    extends = "›",
    precedes = "‹",
    nbsp = "␣",
}

-----------------------------------------------------------
-- Ignore files
-----------------------------------------------------------

opt.wildignore = {
    ".hg",
    ".svn",
    "*~",
    "*.png",
    "*.jpg",
    "*.jpeg",
    "*.gif",
    "*.min.js",
    "*.swp",
    "*.o",
    "vendor",
    "dist",
    "_site",
    "node_modules",
    ".git",
}

-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------

local opts = { noremap = true, silent = true }

-- Buffer navigation without bufferline
keymap.set("n", "H", "<cmd>bprevious<CR>", {
    noremap = true,
    silent = true,
    desc = "Previous buffer",
})

keymap.set("n", "L", "<cmd>bnext<CR>", {
    noremap = true,
    silent = true,
    desc = "Next buffer",
})

-- Clear search highlight
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize splits
keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Keep cursor centered while jumping
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

-- Move selected lines up/down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Better paste in visual mode: paste without replacing register
keymap.set("x", "<leader>p", [["_dP]], opts)

-- Copy to system clipboard explicitly
keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts)
keymap.set("n", "<leader>Y", [["+Y]], opts)

-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------

-- Highlight text after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    callback = function()
        vim.highlight.on_yank({ timeout = 150 })
    end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Return to last edit position",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line_count = vim.api.nvim_buf_line_count(0)

        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Auto reload files changed outside Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    desc = "Check if file changed outside Neovim",
    command = "checktime",
})

-----------------------------------------------------------
-- LSP Keymaps
-----------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP keymaps",
    group = vim.api.nvim_create_augroup("user_lsp_keymaps", { clear = true }),
    callback = function(event)
        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
                buffer = event.buf,
                silent = true,
                desc = desc,
            })
        end

        local ok, telescope_builtin = pcall(require, "telescope.builtin")

        if ok then
            map("n", "gd", telescope_builtin.lsp_definitions, "Go to definition")
            map("n", "gi", telescope_builtin.lsp_implementations, "Go to implementation")
            map("n", "gr", telescope_builtin.lsp_references, "Go to references")
            map("n", "<leader>D", telescope_builtin.lsp_type_definitions, "Type definition")
        else
            map("n", "gd", vim.lsp.buf.definition, "Go to definition")
            map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
            map("n", "gr", vim.lsp.buf.references, "Go to references")
            map("n", "<leader>D", vim.lsp.buf.type_definition, "Type definition")
        end

        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")

        map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        map("n", "<leader>d", vim.diagnostic.open_float, "Line diagnostic")
        map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostic list")
    end,
})

require("config.lazy")
require("codelens")
