return {
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		config = {
			history = true,
			delete_check_events = "TextChanged",
		},
		init = function()
			local function jump(key, dir)
				vim.keymap.set({ "i", "s" }, key, function()
					return require("luasnip").jump(dir) or key
				end, { expr = true })
			end
			jump("<tab>", 1)
			jump("<s-tab>", -1)
		end,
	},

	-- comments
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	-- auto tag rename
	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
	-- repl like virtual line
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
			-- config = function()
			--        highlight CodiVirtualText guifg=red
			--
			--        vim.g.codi#virtual_text_prefix = "❯ "
			--
			--        vim.g.codi#aliases = {
			--                  \ 'javascript.jsx': 'javascript',
			--                  \ }
			--
			--        vim.g.codi#aliases = {
			--                  \ 'javascriptreact': 'javascript',
			--                  \ }
			-- end,
		},
	},
	-- code runer
	{
		"CRAG666/code_runner.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>cr",
				"<cmd>:RunCode<CR>",
				desc = "Code Run",
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
				float = {
					border = "single",
				},
			})
		end,
	},
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>gc",
				function()
					require("neogen").generate({})
				end,
				desc = "Neogen Comment",
			},
		},
		opts = { snippet_engine = "luasnip" },
	},
	{
		"jackMort/ChatGPT.nvim",
		cmd = { "ChatGPTActAs", "ChatGPT" },
		config = {
			keymaps = {
				submit = "<C-e>",
				close = { "<C-c>" },
				yank_last = "<C-y>",
				yank_last_code = "<C-k>",
				scroll_up = "<C-u>",
				scroll_down = "<C-d>",
				toggle_settings = "<C-o>",
				new_session = "<C-n>",
				cycle_windows = "<Tab>",
				-- in the Sessions pane
				select_session = "<Space>",
				rename_session = "r",
				delete_session = "d",
			},
		},
		opts = {},
	},
}
