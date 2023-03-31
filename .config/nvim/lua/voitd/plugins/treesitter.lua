return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- PERF: no need to load the plugin, if we only need its queries for mini.ai
					local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
					local opts = require("lazy.core.plugin").values(plugin, "opts", false)
					local enabled = false
					if opts.textobjects then
						for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
							if opts.textobjects[mod] and opts.textobjects[mod].enable then
								enabled = true
								break
							end
						end
					end
					if not enabled then
						require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
					end
				end,
			},
		},
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			require("nvim-treesitter.configs").setup({
				sync_install = false,
				ensure_installed = {
					"bash",
					"help",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"query",
					"regex",
					"tsx",
					"typescript",
					"vim",
					"vue",
				},
				highlight = { enable = true },
				indent = { enable = true },
				context_commentstring = { enable = true, enable_autocmd = false },
				textobjects = {
					select = {
						enable = false,
					},
					move = {
						enable = false,
					},
					lsp_interop = {
						enable = false,
					},
				},
				-- incremental_selection = {
				-- 	enable = true,
				-- 	keymaps = {
				-- 		init_selection = "<C-space>",
				-- 		node_incremental = "<C-space>",
				-- 		scope_incremental = "<C-s>",
				-- 		node_decremental = "<C-bs>",
				-- 	},
				-- },
				query_linter = {
					enable = true,
					use_virtual_text = true,
					lint_events = { "BufWrite", "CursorHold" },
				},
				autotag = {
					enable = true,
				},
				matchup = {
					enable = true, -- mandatory, false will disable the whole extension
				},
			})
		end,
	},
	-- { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPost" },
}
