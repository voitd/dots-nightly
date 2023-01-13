local U = require("voitd.util")

vim.keymap.set("n", "Q", "<Nop>", { noremap = true })
vim.keymap.set("n", "q:", "<Nop>", { noremap = true })

-- Zero should go to the first non-blank character not to the first column (which could be blank)
vim.keymap.set("n", "0", "^")
-- when going to the end of the line in visual mode ignore whitespace characters
vim.keymap.set("v", "$", "g_")
vim.keymap.set("n", "$", "g_")

vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace visual" })
-- vim.keymap.set("v", "<leader>rw", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", { desc = "Replace visual" })
-- vim.keymap.set("n", "<leader>r", ":%s///gcI<Left><Left><Left><Left>", { desc = "Replace" })

-- vim.keymap.set("n", "<BS>", "<C-^>")

-- Copy to system clipboard
vim.keymap.set("v", "<C-c>", '"+y')
-- Paste from system clipboard with Ctrl + v
vim.keymap.set("i", "<C-v>", '<Esc>"+p')
-- Move to the end of yanked text after yank and paste
-- vim.keymap.set("v", "p", [["_dP`]])
-- vim.keymap.set("x", "p", [["_dP]])
vim.keymap.set("n", "x", '"_x')
--  vim.keymap.set("v", "y", "y`]")
--  vim.keymap.set("n", "p", "p`]")
--  vim.keymap.set("v", "p", "p`]")

-- Jump to definition in vertical split
vim.keymap.set("n", "gv", "<C-W>v<C-]>")

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
vim.keymap.set("o", "A", ":<C-U>normal! ggVG<CR>")
-- map c and d to black hole registers
-- vim.keymap.set("n", "d", '"_d', {})
vim.keymap.set("n", "c", '"_c', {}) -- greatest remap ever

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.cmd([[xnoremap <expr> p 'pgv"' . v:register . 'y`]']])

vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "<C-s>", ":noa w<CR>")

vim.keymap.set("n", "a", "empty(getline('.')) ? 'S' : 'a'", { expr = true })

vim.keymap.set(
	"n",
	"<leader>o",
	':<C-u>call append(line("."), repeat([""], v:count1))<CR>',
	{ desc = "Insert before line" }
)
vim.keymap.set(
	"n",
	"<leader>O",
	':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>',
	{ desc = "Isert after line" }
)

-- Important: Revert back to previous cursor position
vim.keymap.set("i", "<esc>", "<esc>`^")
-- Alt/Meta + u to capitalize the inner word
vim.keymap.set("n", "<A-u>", "gUiww", { desc = "Capitalize under cursor" })
vim.keymap.set("n", "<A-l>", "gUiww", { desc = "Lowercase under cursor" })

-- Keymaps for Nvim tree
vim.keymap.set("n", "<C-Left>", "<C-w><Left>")
vim.keymap.set("n", "<C-Right>", "<C-w><Right>")

-- Move to window using the <meta> movement keys
vim.keymap.set("n", "<A-left>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<A-down>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<A-up>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<A-right>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <shift> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
--
-- buffers
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Move Lines
-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
-- vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
--
-- Switch buffers with <ctrl>
-- vim.keymap.set("n", "<C-Left>", "<cmd>bprevious<cr>")
-- vim.keymap.set("n", "<C-Right>", "<cmd>bnext<cr>")
--
-- Easier pasting
vim.keymap.set("n", "[p", ":pu!<cr>")
vim.keymap.set("n", "]p", ":pu<cr>")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
vim.keymap.set("n", "gw", "*N")
vim.keymap.set("x", "gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

-- save in insert mode
vim.keymap.set("i", "<C-s>", "<cmd>:w<cr><esc>")
vim.keymap.set("n", "<C-s>", "<cmd>:w<cr><esc>")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- new file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- lazygit
-- vim.keymap.set("n", "<leader>gg", function()
-- 	require("voitd.util").float_term({ "lazygit" })
-- end, { desc = "Lazygit for cwd" })
-- vim.keymap.set("n", "<leader>gG", function()
-- 	local util = require("voitd.util")
-- 	util.float_term({ "lazygit" }, { cwd = util.get_root() })
-- end, { desc = "Lazygit for root dir" })

-- window management
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Centered split" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>wx", ":close<CR>", { desc = "Close split" }) -- close current split window
vim.keymap.set("n", "<leader>bp", ":BufferLinePick<CR>", { desc = "Pick buffer" }) -- close current split window

-- toggle options
vim.keymap.set("n", "<leader>tf", require("voitd.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
vim.keymap.set("n", "<leader>ts", function()
	U.toggle("spell")
end, { desc = "Toggle Spelling" })
vim.keymap.set("n", "<leader>tw", function()
	U.toggle("wrap")
end, { desc = "Toggle Word Wrap" })
vim.keymap.set("n", "<leader>tn", function()
	U.toggle("relativenumber", true)
	U.toggle("number")
end, { desc = "Toggle Line Numbers" })
vim.keymap.set("n", "<leader>tD", U.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
vim.keymap.set("n", "<leader>tc", function()
	U.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- floating terminal
-- vim.keymap.set("n", "<leader>ft", function()
-- 	U.float_term(nil, { cwd = U.get_root() })
-- end, { desc = "Terminal (root dir)" })
--
-- vim.keymap.set("n", "<leader>fT", function()
-- 	U.float_term()
-- end, { desc = "Terminal (cwd)" })
--
-- vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
