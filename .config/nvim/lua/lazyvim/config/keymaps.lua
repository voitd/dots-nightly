vim.keymap.set("n", "Q", "<Nop>", { noremap = true })
vim.keymap.set("n", "q:", "<Nop>", { noremap = true })

-- Zero should go to the first non-blank character not to the first column (which could be blank)
vim.keymap.set("n", "0", "^")
-- when going to the end of the line in visual mode ignore whitespace characters
vim.keymap.set("v", "$", "g_")
vim.keymap.set("n", "$", "g_")

vim.keymap.set("v", "<leader>rw", ":s//gcI<Left><Left><Left><Left>", { desc = "Replace visual" })

-- Move to window using the <meta> movement keys
vim.keymap.set("n", "<leader>r", ":%s//gcI<Left><Left><Left><Left>", { desc = "Replace" })

vim.keymap.set("n", "<BS>", "<C-^>")

-- Copy to system clipboard
vim.keymap.set("v", "<C-c>", '"+y')
-- Paste from system clipboard with Ctrl + v
vim.keymap.set("i", "<C-v>", '<Esc>"+p')
-- Move to the end of yanked text after yank and paste
vim.keymap.set("v", "p", [["_dP`]])
vim.keymap.set("x", "p", [["_dP]])
vim.keymap.set("n", "x", '"_x')
--  vim.keymap.set("v", "y", "y`]")
--  vim.keymap.set("n", "p", "p`]")
--  vim.keymap.set("v", "p", "p`]")

-- Jump to definition in vertical split
vim.keymap.set("n", "gv", "<C-W>v<C-]>")

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
vim.keymap.set("o", "A", ":<C-U>normal! ggVG<CR>")

vim.cmd([[xnoremap <expr> p 'pgv"' . v:register . 'y`]']])
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "<C-s>", ":noa w<CR>")

vim.keymap.set("n", "a", "empty(getline('.')) ? 'S' : 'a'", { expr = true })
vim.keymap.set("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>')
vim.keymap.set("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>')
local searching_google_in_normal =
	[[:lua vim.fn.system({'xdg-open', 'https://google.com/search?q=' .. vim.fn.expand("<cword>")})<CR>]]
vim.keymap.set("n", "<C-q><C-g>", searching_google_in_normal)

-- Important: Revert back to previous cursor position
vim.keymap.set("i", "<esc>", "<esc>`^")

-- Keymaps for Nvim tree
vim.keymap.set("n", "<leader>e", ":Neotree<cr>")
vim.keymap.set("n", "<C-Left>", "<C-w><Left>")
vim.keymap.set("n", "<C-Right>", "<C-w><Right>")

-- Move to window using the <meta> movement keys
vim.keymap.set("n", "<A-left>", "<C-w>h")
vim.keymap.set("n", "<A-down>", "<C-w>j")
vim.keymap.set("n", "<A-up>", "<C-w>k")
vim.keymap.set("n", "<A-right>", "<C-w>l")

-- Resize window using <shift> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

-- Move Lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Switch buffers with <ctrl>
vim.keymap.set("n", "<C-Left>", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>bnext<cr>")

-- Easier pasting
vim.keymap.set("n", "[p", ":pu!<cr>")
vim.keymap.set("n", "]p", ":pu<cr>")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
vim.keymap.set("n", "gw", "*N")
vim.keymap.set("x", "gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- save in insert mode
vim.keymap.set("i", "<C-s>", "<cmd>:w<cr><esc>")
vim.keymap.set("n", "<C-s>", "<cmd>:w<cr><esc>")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- new file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- lazygit
vim.keymap.set("n", "<leader>gg", function()
	require("lazyvim.util").float_term({ "lazygit" })
end, { desc = "Lazygit for cwd" })
vim.keymap.set("n", "<leader>gG", function()
	local util = require("lazyvim.util")
	util.float_term({ "lazygit" }, { cwd = util.get_root() })
end, { desc = "Lazygit for root dir" })

-- increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>") -- increment
vim.keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window
