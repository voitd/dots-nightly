return {
	{ "tpope/vim-obsession", event = "VeryLazy" },
	-- file explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = {
			{
				"<leader>ft",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = require("voitd.util").get_root() })
				end,
				desc = "NeoTree",
			},
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = require("voitd.util").get_root() })
				end,
				desc = "NeoTree",
			},
		},
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			vim.cmd.highlight({ "NeoTreeNormal", "guibg=none" })
		end,
		config = {
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = false,
			sources = {
				"filesystem",
				"git_status",
			},
			source_selector = {
				winbar = true,
				statusline = false,
				highlight_tab = "blend",
				highlight_tab_active = "blend",
				highlight_background = "blend",
				separator = " ",
				-- separator = "▕",
				separator_active = nil,
				highlight_separator = "blend",
				highlight_separator_active = "blend",
			},
			window = {
				position = "float",
				popup = {
					size = function(state)
						local root_name = vim.fn.fnamemodify(state.path, ":~")
						local root_len = string.len(root_name) + 4
						return {
							width = math.max(root_len, 50),
							height = vim.o.lines - 3,
							-- height = vim.o.lines - 6,
						}
					end,
					-- size = {
					-- 	height = "95%",
					-- 	width = "50%",
					-- },
					position = "98%",
				},
			},
			filesystem = {
				close_if_last_window = true,
				sort_case_insensitive = true,
				follow_current_file = true,
				hijack_netrw_behavior = "open_current",
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		},
	},

	-- search/replace in multiple files
	{
		"windwp/nvim-spectre",
		keys = {
			{
				"<leader>sr",
				function()
					require("spectre").open()
				end,
				desc = "Replace in files (Spectre)",
			},
		},
	},

	{
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		keys = {
			{
				"<leader>td",
				"<cmd>TroubleToggle<cr>",
				desc = "Trouble",
			},
		},

		config = function()
			require("trouble").setup({})
		end,
	},

	-- {
	-- 	"andymass/vim-matchup",
	-- 	event = "BufReadPost",
	-- 	config = function()
	-- 		vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
	-- 	end,
	-- },

	-- which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({
				show_help = false,
				plugins = { spelling = true },
				key_labels = { ["<leader>"] = "SPC" },
			})
			wk.register({
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>h"] = { name = "+help" },
				["<leader>w"] = { name = "+window" },
				["<leader>s"] = { name = "+search" },
				["<leader>t"] = { name = "+toggle" },
				["<leader>x"] = { name = "+diagnostics" },
			})
		end,
	},

	-- git signs
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "契" },
				topdelete = { text = "契" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

        -- stylua: ignore start
        map("n", "]g", gs.next_hunk, "Next Hunk")
        map("n", "[g", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghs", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},

	-- git conflict resolve
	{
		"akinsho/git-conflict.nvim",
		config = function()
			require("git-conflict").setup()
		end,
	},

	-- references
	{
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		config = function()
			require("illuminate").configure({ delay = 200 })
		end,
		keys = {
			{
				"]]",
				function()
					require("illuminate").goto_next_reference(false)
				end,
				desc = "Next Reference",
			},
			{
				"[[",
				function()
					require("illuminate").goto_prev_reference(false)
				end,
				desc = "Prev Reference",
			},
		},
	},

	-- better increase/descrease
	{
		"monaqa/dial.nvim",
		keys = {
			{
				"<C-a>",
				function()
					return require("dial.map").inc_normal()
				end,
				expr = true,
			},
			{
				"<C-x>",
				function()
					return require("dial.map").dec_normal()
				end,
				expr = true,
			},
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal, -- 100
					augend.integer.alias.hex, -- 0xAB
					augend.date.alias["%Y/%m/%d"], -- 2020/01/01
					augend.date.alias["%Y-%m-%d"], -- 2020-01-01
					augend.constant.alias.bool, -- true
					augend.semver.alias.semver, -- 1.0.1
					augend.date.alias["%m/%d"], -- 12/01
					augend.date.alias["%H:%M"], -- 14:30
				},
				typescript = {
					augend.constant.new({ elements = { "let", "const" } }),
				},
			})
		end,
	},

	{
		"PatschD/zippy.nvim",
		keys = {
			{
				"<leader>pl",
				function()
					require("zippy").insert_print()
				end,
				desc = "Print in console",
			},
		},
	},
}
