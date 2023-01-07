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

	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local snip = require("luasnip")
			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						snip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = function(_, item)
						local icons = require("voitd.config.icons").kinds
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						return item
					end,
				},
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
			})
		end,
	},

	-- comments
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	-- auto tag rename
	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
	-- repl like virtual line
	{
		"metakirby5/codi.vim",
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
		event = "VeryLazy",
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
}
