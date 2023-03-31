vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
-- vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

vim.opt.autowrite = true -- enable auto write
vim.opt.clipboard = "unnamedplus" -- sync with system clipboard
vim.opt.cmdheight = 1
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.conceallevel = 3 -- Hide * markup for bold and italic
vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.hidden = true -- Enable modified buffers in background
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.joinspaces = false -- No double spaces with join after a dot
vim.opt.laststatus = 0
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.mouse = "a" -- enable mouse mode
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.number = true -- Print line number
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.showmode = false -- dont show mode since we have a statusline
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200 -- save swap file and trigger CursorHold
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.wrap = false -- Disable line wrap
vim.go.winminwidth = 5 -- minimum window width
vim.opt.swapfile = false -- Disable swap
vim.opt.iskeyword:append("-") -- consider string-string as whole word
vim.opt.shortmess:append({ W = true, I = true, c = true })

-- vim.opt.foldtext = "v:lua.folds_render()"
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

if vim.fn.has("nvim-0.9.0") == 1 then
	vim.opt.splitkeep = "screen"
	vim.opt.shortmess:append({ C = true })
	vim.o.statuscolumn = "%= "
		.. "%s" -- sign column FIXME: figure out how to put on the other side without having to do a lot of shifting
		.. "%{%" -- evaluate this, and then evaluate what it returns
		.. "&number ?"
		.. "(v:relnum ?"
		.. 'printf("%"..len(line("$")).."s", v:relnum)' -- when showing relative numbers, make sure to pad so things don't shift as you move the cursor
		.. ":"
		.. "v:lnum"
		.. ")"
		.. ":"
		.. '""'
		.. " " -- space between lines and fold
		.. "%}"
		.. "%= "
		.. "%#FoldColumn#" -- highlight group for fold
		.. "%{" -- expression for showing fold expand/colapse
		.. "foldlevel(v:lnum) > foldlevel(v:lnum - 1)" -- any folds?
		.. "? (foldclosed(v:lnum) == -1" -- currently open?
		.. '? ""' -- point down
		.. ':  ""' -- point to right
		.. ")"
		.. ': " "' -- blank for no fold, or inside fold
		.. "}"
		.. "%= " -- spacing between end of column and start of text
end

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- require("voitd.config.status")
