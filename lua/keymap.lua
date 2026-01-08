local opts = { noremap = true, silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

-- jjでインサート脱出
keymap("i", "jj", "<ESC>", opts)
keymap("t", "jj", "<C-\\><C-n>", opts)
-- no highlightを簡略化
keymap("n", "nh", ":<c-u>noh<CR>", opts)

-- 分割した画面間の移動をCtrl+hjklに置き換え
keymap("n", "<C-h>", "<C-w><Left>", opts)
keymap("n", "<C-j>", "<C-w><Down>", opts)
keymap("n", "<C-k>", "<C-w><Up>", opts)
keymap("n", "<C-l>", "<C-w><Right>", opts)

-- ウィンドウ最大化を再マッピング
keymap("n", "<C-w>h", "<C-w>H", opts)
keymap("n", "<C-w>j", "<C-w>J", opts)
keymap("n", "<C-w>k", "<C-w>K", opts)
keymap("n", "<C-w>l", "<C-w>L", opts)

-- タブ移動をマッピング
keymap("n", "<c-n>", "<C-PageUp>", opts)

-- yの挙動をdと合わせる
keymap("n", "Y", "v$hy", opts)

vim.g.mapleader = " "
