local util = require("voitd.util")

-- fuzzy finder
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>/", util.telescope("live_grep"), desc = "Find in Files (Grep)" },
		{
			"<leader><space>",
			util.telescope("find_files"),
			desc = "Find Files",
		},
		{ "<leader>fb", util.telescope("buffers"), desc = "Buffers" },
		{ "<leader>ff", util.telescope("find_files"), desc = "Find Files" },
		{ "<leader>fr", util.telescope("oldfiles"), desc = "Recent" },
		{ "<leader>gc", util.telescope("git_commits"), desc = "commits" },
		{ "<leader>gs", util.telescope("git_status"), desc = "status" },
		{ "<leader>ha", util.telescope("autocommands"), desc = "Auto Commands" },
		{ "<leader>hc", util.telescope("commands"), desc = "Commands" },
		{ "<leader>hf", util.telescope("filetypes"), desc = "File Types" },
		{ "<leader>hh", util.telescope("help_tags"), desc = "Help Pages" },
		{ "<leader>hk", util.telescope("keymaps"), desc = "Key Maps" },
		{ "<leader>hm", util.telescope("man_pages"), desc = "Man Pages" },
		{ "<leader>ho", util.telescope("vim_options"), desc = "Options" },
		{ "<leader>ht", util.telescope(" builtin"), desc = "Telescope" },
		{ "<leader>sb", util.telescope("current_buffer_fuzzy_find"), desc = "Buffer" },
		{ "<leader>sc", util.telescope("command_history"), desc = "Command History" },
		{ "<leader>sg", util.telescope("live_grep"), desc = "Grep" },
		{ "<leader>sm", util.telescope("marks"), desc = "Jump to Mark" },
		{ "<leader>,", util.telescope("buffers show_all_buffers=true"), desc = "Switch Buffer" },
		{ "<leader>:", util.telescope("command_history"), desc = "Command History" },
		{
			"<leader>ss",
			util.telescope("lsp_document_symbols", {
				symbols = {
					"Class",
					"Function",
					"Method",
					"Constructor",
					"Interface",
					"Module",
					"Struct",
					"Trait",
					"Field",
					"Property",
				},
			}),
			desc = "Goto Symbol",
		},
	},
	config = true,
	-- config = function(plugin)
	-- 	local telescope = require("telescope")
	-- 	telescope.setup(vim.tbl_deep_extend("force", plugin._.super.config, {
	-- 		defaults = {
	-- 			layout_strategy = "horizontal",
	-- 			layout_config = { prompt_position = "top" },
	-- 			sorting_strategy = "ascending",
	-- 			winblend = 0,
	-- 		},
	-- 	}))
	-- 	telescope.load_extension("fzf")
	-- end,
}
