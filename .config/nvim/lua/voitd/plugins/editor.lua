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
		},
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
		end,
		config = {
			window = {
				position = "right",
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

	-- easily jump to any location and enhanced f/t motions for Leap
	{
		"ggandor/leap.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "ggandor/flit.nvim", config = { labeled_modes = "nv" } },
		},
		config = function()
			require("leap").add_default_mappings()
		end,
	},

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
		config = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "契" },
				topdelete = { text = "契" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
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
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
				},
			})
		end,
	},

	{
		"PatschD/zippy.nvim",
		event = "VeryLazy",
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
	{
		"metakirby5/codi.vim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>tc",
				"<cmd>Codi!! <CR>",
				desc = "Toggle Codi",
			},
			{
				"<leader>tce",
				"<cmd>CodiExpand <CR>",
				desc = "Toggle Codi Expand",
			},
		},
		-- config = function()
		-- 	vim.cmd([[
		--        highlight CodiVirtualText guifg=red
		--
		--        let g:codi#virtual_text_prefix = "❯ "
		--
		--        let g:codi#aliases = {
		--                  \ 'javascript.jsx': 'javascript',
		--                  \ }
		--
		--        let g:codi#aliases = {
		--                  \ 'javascriptreact': 'javascript',
		--                  \ }
		--    ]])
		-- end,
	},

	{
		"CRAG666/code_runner.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		keys = {
			{
				"<leader>rc",
				"<cmd>:RunCode<CR>",
				desc = "[R]un [C]ode",
			},
		},
		config = function()
			require("code_runner").setup({
				mode = "float",
				filetype = {
					javascript = "node",
					python = "python3 -u",
					-- typescript = "deno run",
				},
			})
		end,
	},

	{
		"narutoxy/dim.lua",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
		config = function()
			require("dim").setup({})
		end,
	},
}
