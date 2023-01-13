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
			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
					col_offset = -3, -- align the abbr and word on cursor (due to fields order below)
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
					format = function(entry, item)
						local icons = require("voitd.config.icons").kinds
						local blackOrWhiteFg = function(r, g, b)
							return ((r * 0.299 + g * 0.587 + b * 0.114) > 186) and "#000000" or "#ffffff"
						end
						if icons[item.kind] then
							if item.kind == "Color" and entry.completion_item.documentation then
								local _, _, r, g, b =
									string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
								if r then
									local color = string.format("%02x", r)
										.. string.format("%02x", g)
										.. string.format("%02x", b)
									local group = "Tw_" .. color
									if vim.fn.hlID(group) < 1 then
										vim.api.nvim_set_hl(
											0,
											group,
											{ fg = blackOrWhiteFg(r, g, b), bg = "#" .. color }
										)
									end
									item.kind_hl_group = group
								end
							end
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
