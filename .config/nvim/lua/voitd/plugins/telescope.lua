local util = require("voitd.util")

-- fuzzy finder
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{
			"debugloop/telescope-undo.nvim",
			config = function()
				require("telescope").load_extension("undo")
			end,
		},
		{
			"nvim-telescope/telescope-file-browser.nvim",
			config = function()
				require("telescope").load_extension("file_browser")
			end,
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
		{
			"benfowler/telescope-luasnip.nvim",
			module = "telescope._extensions.luasnip",
			config = function()
				require("telescope").load_extension("luasnip")
			end,
		},
	},
	cmd = "Telescope",
	version = false,
	keys = {
		{ "<leader>/", util.telescope("live_grep"), desc = "Find in Files (Grep)" },
		{
			"<leader><space>",
			util.telescope("find_files"),
			desc = "Find Files",
		},
		{ "<leader>fb", util.telescope("buffers"), desc = "Buffers" },
		{ "<leader>fr", util.telescope("resume"), desc = "Resume" },
		{ "<leader>ff", util.telescope("find_files"), desc = "Find Files" },
		{ "<leader>fo", util.telescope("oldfiles"), desc = "Recent" },
		{ "<leader>gc", util.telescope("git_commits"), desc = "commits" },
		{ "<leader>gs", util.telescope("git_status"), desc = "status" },
		{ "<leader>ha", util.telescope("autocommands"), desc = "Auto Commands" },
		{ "<leader>hc", util.telescope("commands"), desc = "Commands" },
		{ "<leader>hf", util.telescope("filetypes"), desc = "File Types" },
		{ "<leader>hh", util.telescope("help_tags"), desc = "Help Pages" },
		{ "<leader>hk", util.telescope("keymaps"), desc = "Key Maps" },
		{ "<leader>hm", util.telescope("man_pages"), desc = "Man Pages" },
		{ "<leader>ho", util.telescope("vim_options"), desc = "Options" },
		{ "<leader>ht", util.telescope("builtin"), desc = "Telescope" },
		{ "<leader>sb", util.telescope("current_buffer_fuzzy_find"), desc = "Buffer" },
		{ "<leader>sc", util.telescope("command_history"), desc = "Command History" },
		{ "<leader>sh", util.telescope("smart_history"), desc = "Smart History" },
		{ "<leader>sg", util.telescope("live_grep"), desc = "Grep" },
		{ "<leader>sw", util.telescope("grep_string"), desc = "Grep Word" },
		{ "<leader>sm", util.telescope("marks"), desc = "Jump to Mark" },
		{ "<leader>,", util.telescope("buffers show_all_buffers=true"), desc = "Switch Buffer" },
		{ "<leader>:", util.telescope("command_history"), desc = "Command History" },
		{
			"<leader>fe",
			function()
				require("telescope").extensions.file_browser.file_browser({
					path = "%:p:h",
					cwd = vim.fn.expand("%:p:h"),
					respect_gitignore = false,
					hidden = true,
					grouped = true,
					-- previewer = false,
					initial_mode = "normal",
					-- layout_config = { height = 40 },
				})
			end,
			desc = "File browser",
		},
		{
			"<leader>fl",
			function()
				require("telescope").extensions.luasnip.luasnip({})
			end,
			desc = "Snippets",
		},
		{
			"<leader>fu",
			function()
				require("telescope").extensions.undo.undo()
			end,
			desc = "File undo",
		},

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
	opts = {
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			layout_strategy = "vertical",
			layout_config = { prompt_position = "top", width = 0.5 },
			sorting_strategy = "ascending",
			color_devicons = true,
			file_ignore_patterns = { "node_modules", "^.git/" },
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--trim",
				"--glob=!.git/",
				"--glob=!.yarn/",
				"--glob=!package-lock.json",
				"--glob=!yarn.lock",
			},
			mappings = {
				i = {
					["<C-t>"] = function(...)
						return require("trouble.providers.telescope").open_with_trouble(...)
					end,
					["<C-i>"] = function()
						util.telescope("find_files", { no_ignore = true })()
					end,
					["<C-h>"] = function()
						util.telescope("find_files", { hidden = true })()
					end,
					["<C-Down>"] = function(...)
						return require("telescope.actions").cycle_history_next(...)
					end,
					["<C-Up>"] = function(...)
						return require("telescope.actions").cycle_history_prev(...)
					end,
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
			file_browser = {
				theme = "dropdown",
				hijack_netrw = true,
				mappings = {
					n = {
						-- ["a"] = require("telescope").extensions.file_browser.actions.create,
					},
				},
			},
			undo = {
				use_delta = false,
				use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
				side_by_side = false,
				diff_context_lines = vim.o.scrolloff,
				entry_format = "state #$ID, $STAT, $TIME",
				mappings = {
					["i"] = {
						-- ["<CR>"] = require("telescope-undo.actions").restore,
					},
					-- i = {
					-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
					-- you want to replicate these defaults and use the following actions. This means
					-- installing as a dependency of telescope in it's `requirements` and loading this
					-- extension from there instead of having the separate plugin definition as outlined
					-- above.

					-- ["<cr>"] = require("telescope").extensions.undo.actions.yank_additions,
					-- ["<cr>"] = require("telescope-undo.actions").yank_additions,
					-- ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
					-- ["<C-cr>"] = require("telescope-undo.actions").restore,
					-- },
				},
			},
		},
		extensions_list = { "file_browser", "undo", "fzf", "luasnip" },
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.load_extension("fzf")
			-- telescope.load_extension("luasnip")
			-- telescope.load_extension("file_browser")
			-- telescope.load_extension("undo")
			-- telescope.setup(opts)
		end,
	},
}
