return {
	{
		"nvim-treesitter/nvim-treesitter",
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
				},
				highlight = { enable = true },
				indent = { enable = true },
				context_commentstring = { enable = true, enable_autocmd = false },
				autotag = {
					enable = true,
				},
				matchup = {
					enable = true, -- mandatory, false will disable the whole extension
				},
			})
		end,
	},
}
