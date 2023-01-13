local icons = require("voitd.config.icons")
local M = {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
}

local function clock()
	return " " .. os.date("%H:%M")
end

local colors = require("tokyonight.colors").setup()

function M.config()
	if vim.g.started_by_firenvim then
		return
	end

	require("lualine").setup({
		options = {
			section_separators = "",
			-- section_separators = { left = "", right = "" },
			component_separators = "",
			theme = {
				-- We are going to use lualine_c an lualine_x as left and
				-- right section. Both are highlighted by c theme .  So we
				-- are just setting default looks o statusline
				normal = { c = { fg = colors.fg, bg = "blend" } },
				inactive = { c = { fg = colors.fg, bg = "blend" } },
			},
			icons_enabled = true,
			globalstatus = true,
			disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
		},
		sections = {
			-- lualine_a = { { "mode", separator = { left = "" } } },
			-- lualine_a = { { "mode", icons_enabled = true } },
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					function()
						local mode_icon = {
							n = "",
							i = "",
							v = "﫦",
							[""] = "﫦",
							V = "﫦",
							c = "ﲵ",
							no = "",
							s = "",
							S = "",
							[""] = "",
							ic = "",
							R = "",
							Rv = "",
							cv = "",
							ce = "",
							r = "",
							rm = "",
							["r?"] = "",
							["!"] = "",
							t = "",
						}
						return mode_icon[vim.fn.mode()]
					end,
					color = function()
						-- auto change color according to neovims mode
						local mode_color = {
							n = colors.red,
							i = colors.green,
							v = colors.blue,
							[""] = colors.blue,
							V = colors.blue,
							c = colors.yellow,
							no = colors.red,
							s = colors.orange,
							S = colors.orange,
							[""] = colors.orange,
							ic = colors.yellow,
							R = colors.magenta,
							Rv = colors.magenta2,
							cv = colors.red,
							ce = colors.red,
							r = colors.cyan,
							rm = colors.cyan,
							["r?"] = colors.cyan,
							["!"] = colors.red,
							t = colors.red,
						}
						return { fg = mode_color[vim.fn.mode()] }
					end,
					padding = { right = 1, left = 2 },
				},
				{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				{
					"filename",
					path = 1,
					color = { fg = colors.blue, gui = "bold" },
					symbols = { modified = " ", readonly = " ", unnamed = "" },
				},
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = {
						error = icons.diagnostics.Error,
						warn = icons.diagnostics.Warn,
						info = icons.diagnostics.Info,
						hint = icons.diagnostics.Hint,
					},
				},
				{
					function()
						local navic = require("nvim-navic")
						local ret = navic.get_location()
						return ret:len() > 2000 and "navic error" or ret
					end,
					cond = function()
						if package.loaded["nvim-navic"] then
							local navic = require("nvim-navic")
							return navic.is_available()
						end
					end,
					color = { fg = "#ff9e64" },
				},
			},

			lualine_x = {
				{ "branch", icon = " ", color = { fg = "#ff9e64" } },
				{
					"diff",
					colored = true,
					-- diff_color = {
					-- 	added = { fg = "#28A745" },
					-- 	modified = { fg = "#DBAB09" },
					-- 	removed = { fg = "#D73A49" },
					-- },
					symbols = {
						added = icons.git.added,
						modified = icons.git.modified,
						removed = icons.git.removed,
					},
				},
				-- {
				--   require("noice").api.status.message.get_hl,
				--   cond = require("noice").api.status.message.has,
				-- },
				-- {
				-- 	function()
				-- 		return require("noice").api.status.mode.get()
				-- 	end,
				-- 	cond = function()
				-- 		if package.loaded["noice"] then
				-- 			return require("noice").api.status.mode.has()
				-- 		end
				-- 	end,
				-- 	-- color = { fg = "#ff9e64" },
				-- },
				-- {
				-- 	function()
				-- 		return require("noice").api.status.search.get()
				-- 	end,
				-- 	cond = function()
				-- 		if package.loaded["noice"] then
				-- 			return require("noice").api.status.search.has()
				-- 		end
				-- 	end,
				-- 	-- color = { fg = "#ff9e64" },
				-- },
				-- {
				-- 	function()
				-- 		return require("lazy.status").updates()
				-- 	end,
				-- 	cond = require("lazy.status").has_updates,
				-- 	-- color = { fg = "#ff9e64" },
				-- },
				-- {
				-- 	function()
				-- 		local stats = require("lazy").stats()
				-- 		local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				-- 		return " " .. ms .. "ms"
				-- 	end,
				-- 	-- color = { fg = "#ff9e64" },
				-- },
				-- -- function()
				-- --   return require("messages.view").status
				-- -- end,
				-- {
				-- 	function()
				-- 		return require("util.dashboard").status()
				-- 	end,
				-- },
				{
					function()
						return require("noice").api.status.command.get()
					end,
					cond = function()
						if package.loaded["noice"] then
							return require("noice").api.status.command.has()
						end
					end,
					-- color = { fg = "#ff9e64" },
				},
			},
			lualine_y = {},

			lualine_z = {},
			-- lualine_z = {
			-- 	{ "diff", separator = { left = "", right = " " } },
			-- 	{ "branch", separator = { left = " ", right = "" } },
			-- },
			-- lualine_z = { { clock, separator = { right = "" } } },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		-- winbar = {
		--   lualine_a = {},
		--   lualine_b = {},
		--   lualine_c = { "filename" },
		--   lualine_x = {},
		--   lualine_y = {},
		--   lualine_z = {},
		-- },
		--
		-- inactive_winbar = {
		--   lualine_a = {},
		--   lualine_b = {},
		--   lualine_c = { "filename" },
		--   lualine_x = {},
		--   lualine_y = {},
		--   lualine_z = {},
		-- },
		extensions = { "nvim-tree" },
	})
end

return M
