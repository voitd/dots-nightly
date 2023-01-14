local config = require("luasnip.config")
return {
	-- better vim.notify
	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	keys = {
	-- 		{
	-- 			"<leader>nc",
	-- 			function()
	-- 				require("notify").dismiss({ silent = true, pending = true })
	-- 			end,
	-- 			desc = "Clear all Notifications",
	-- 		},
	-- 	},
	-- 	config = {
	-- 		timeout = 3000,
	-- 		max_height = function()
	-- 			return math.floor(vim.o.lines * 0.75)
	-- 		end,
	-- 		max_width = function()
	-- 			return math.floor(vim.o.columns * 0.75)
	-- 		end,
	-- 	},
	-- },

	-- better vim.ui
	{
		"stevearc/dressing.nvim",
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	-- bufferline
	{
		"akinsho/nvim-bufferline.lua",
		event = "BufAdd",
		config = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("voitd.config.icons").diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},

	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = {
			-- char = "▏",
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
			show_trailing_blankline_indent = false,
			show_current_context = true,
			-- show_current_context_start = true,
			-- char_highlight_list = {
			-- 	"IndentBlanklineIndent1",
			-- 	"IndentBlanklineIndent2",
			-- 	"IndentBlanklineIndent3",
			-- 	"IndentBlanklineIndent4",
			-- 	"IndentBlanklineIndent5",
			-- 	"IndentBlanklineIndent6",
			-- },
		},
	},

	-- noicer ui
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = false,
			},
			cmdline = {
				enabled = true,
				view = "cmdline",
			},
			popupmenu = {
				---@type 'nui'|'cmp'
				backend = "nui", -- backend to use to show regular cmdline completions
				kind_icons = {},
			},
			messages = {
				enabled = true,
			},
		},
	},

	-- dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[

          ███╗   ██╗██╗   ██╗██╗███╗   ███╗         Z
          ████╗  ██║██║   ██║██║████╗ ████║      Z
          ██╔██╗ ██║██║   ██║██║██╔████╔██║   z
          ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ z
          ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
          ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", " " .. " Config", ":e ~/.dots-nightly/.config/nvim/init.lua <CR>"),
				-- dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
				dashboard.button("p", " " .. " Playgrounds", ":e ~/Playgrounds/playground.js <CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.opts.layout[1].val = 8

			local alpha = require("alpha")
			if vim.o.filetype == "lazy" then
				-- close and re-open Lazy after showing alpha
				vim.cmd.close()
				alpha.setup(dashboard.opts)
				require("lazy").show()
			else
				alpha.setup(dashboard.opts)
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},

	-- auto-resize windows
	{
		"anuvyklack/windows.nvim",
		event = "WinNew",
		dependencies = {
			{ "anuvyklack/middleclass" },
			{ "anuvyklack/animation.nvim", enabled = false },
		},
		keys = { { "<leader>Z", "<cmd>WindowsMaximize<cr>", desc = "Zoom Window" } },
		config = function()
			vim.o.winwidth = 5
			vim.o.equalalways = false
			require("windows").setup({
				animation = { enable = false, duration = 150 },
			})
		end,
	},

	-- floating winbar
	-- {
	-- 	"b0o/incline.nvim",
	-- 	event = "BufReadPre",
	-- 	config = function()
	-- 		local colors = require("tokyonight.colors").setup()
	-- 		require("incline").setup({
	-- 			highlight = {
	-- 				groups = {
	-- 					InclineNormal = { guibg = "#FC56B1", guifg = colors.black },
	-- 					InclineNormalNC = { guifg = "#FC56B1", guibg = colors.black },
	-- 				},
	-- 			},
	-- 			window = { margin = { vertical = 0, horizontal = 1 } },
	-- 			render = function(props)
	-- 				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
	-- 				local icon, color = require("nvim-web-devicons").get_icon_color(filename)
	-- 				return { { icon, guifg = color }, { " " }, { filename } }
	-- 			end,
	-- 		})
	-- 	end,
	-- },

	-- colorizer
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		config = {
			filetypes = { "*", "!lazy" },
			buftype = { "*", "!prompt", "!nofile" },
			user_default_options = {
				names = true, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes: foreground, background
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "background", -- Set the display mode.
				tailwind = "both",
				-- tailwind = "lsp",
				sass = { enable = false, parsers = { css } },
				virtualtext = "■",
			},
		},
	},
	{
		"Wansmer/treesj",
		keys = {
			{ "J", "<cmd>TSJToggle<cr>" },
		},
		config = { use_default_keymaps = false, max_join_length = 150 },
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPre",
		-- event = "VeryLazy",
		dependencies = { "kevinhwang91/promise-async" },
		keys = {
			{
				"K",
				function()
					local current_window = 0
					local current_line, _ = unpack(vim.api.nvim_win_get_cursor(current_window))

					if require("ufo.utils").foldClosed(current_window, current_line) > 0 then
						require("ufo").peekFoldedLinesUnderCursor()
					else
						vim.lsp.buf.hover()
					end
				end,
				desc = "Zoom Window",
			},
		},
		config = {
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		},
	},

	-- { "folke/twilight.nvim" },
	-- {
	-- 	"folke/zen-mode.nvim",
	-- 	cmd = "ZenMode",
	-- 	config = {
	-- 		plugins = {
	-- 			gitsigns = true,
	-- 			tmux = true,
	-- 			kitty = { enabled = false, font = "+2" },
	-- 		},
	-- 	},
	-- 	keys = { { "<leader>tz", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	-- },
}
