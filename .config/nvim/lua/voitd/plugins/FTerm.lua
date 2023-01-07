return {
	{
		"numToStr/FTerm.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>tt",
				function()
					require("FTerm").toggle()
				end,
				desc = "Toggle FTerm",
				mode = "n",
			},
			{
				"<leader>tt",
				'<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>',
				desc = "Toggle FTerm",
				mode = "t",
			},
		},
		config = function()
			require("FTerm").setup({
				border = "single",
				dimensions = {
					height = 0.3,
					width = 1,
					x = 0.5, -- X axis of the terminal window
					y = 1, -- Y axis of the terminal window
				},
			})
		end,
	},
}
