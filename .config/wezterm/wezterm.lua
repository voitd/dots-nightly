local wezterm = require("wezterm")

return {
	font = wezterm.font("VictorMono Nerd Font"),
	font_size = 16.0,
	color_scheme = "tokyonight-storm",
	window_background_opacity = 0.95,
	text_background_opacity = 1,
	window_decorations = "RESIZE",
	inactive_pane_hsb = {
		-- NOTE: these values are multipliers, applied on normal pane values
		saturation = 0.9,
		brightness = 0.6,
	},
	enable_tab_bar = false, -- I use tmux
	default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-A", "-s", "main" },
}
-- local function isViProcess(pane)
-- 	-- get_foreground_process_name On Linux, macOS and Windows,
-- 	-- the process can be queried to determine this path. Other operating systems
-- 	-- (notably, FreeBSD and other unix systems) are not currently supported
-- 	return pane:get_foreground_process_name():find("n?vim") ~= nil
-- 	-- return pane:get_title():find("n?vim") ~= nil
-- end

-- local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
-- 	if isViProcess(pane) then
-- 		window:perform_action(
-- 			-- This should match the keybinds you set in Neovim.
-- 			act.SendKey({ key = vim_direction, mods = "CTRL" }),
-- 			pane
-- 		)
-- 	else
-- 		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
-- 	end
-- end

-- wezterm.on("ActivatePaneDirection-right", function(window, pane)
-- 	conditionalActivatePane(window, pane, "Right", "l")
-- end)
-- wezterm.on("ActivatePaneDirection-left", function(window, pane)
-- 	conditionalActivatePane(window, pane, "Left", "h")
-- end)
-- wezterm.on("ActivatePaneDirection-up", function(window, pane)
-- 	conditionalActivatePane(window, pane, "Up", "k")
-- end)
-- wezterm.on("ActivatePaneDirection-down", function(window, pane)
-- 	conditionalActivatePane(window, pane, "Down", "j")
-- end)

-- wezterm.on("update-right-status", function(window, pane)
-- 	local datetime = "  " .. wezterm.strftime("%e %b, %H:%M  ")
--
-- 	window:set_right_status(wezterm.format({
-- 		-- { Attribute = { Underline = "Single" } },
-- 		{ Attribute = { Italic = true } },
-- 		{ Foreground = { Color = "#abe9b3" } },
-- 		{ Text = datetime },
-- 	}))
-- end)

-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
-- 	local background = "#24283b"
-- 	local foreground = "#c0caf5"
-- 	local symbolic = " ○ "
--
-- 	if tab.is_active then
-- 		background = "#7aa2f7"
-- 		foreground = "#24283b"
-- 		symbolic = " 綠 "
-- 	elseif hover then
-- 		background = "#3b3052"
-- 		foreground = "#909090"
-- 	end
--
-- 	local edge_background = background
-- 	local edge_foreground = "#7aa2f7"
-- 	local separator = " | "
--
-- 	-- ensure that the titles fit in the available space,
-- 	-- and that we have room for the edges.
-- 	local title = wezterm.truncate_right(tab.active_pane.title, max_width - 2)
--
-- 	return {
-- 		-- Logo
-- 		--  { Background = { Color = "#c7c9fd" } },
-- 		--  { Foreground = { Color = "#1e1d2f" } },
-- 		--  { Text = "   " },
-- 		-- Separator
-- 		{ Background = { Color = edge_background } },
-- 		{ Foreground = { Color = edge_foreground } },
-- 		-- Active / Inactive
-- 		{ Background = { Color = background } },
-- 		{ Foreground = { Color = foreground } },
-- 		{ Text = symbolic .. title .. " " },
-- 		-- Separator
-- 		{ Background = { Color = edge_background } },
-- 		{ Foreground = { Color = edge_foreground } },
-- 		{ Text = separator },
-- 	}
-- end)
-- wezterm.on("open-uri", function(window, pane, uri)
-- 	local start, match_end = uri:find("file://")
-- 	if start == 1 then
-- 		local file = uri:sub(match_end + 1)
-- 		window:perform_action(
-- 			wezterm.action({ SpawnCommandInNewWindow = { args = { "nu", "-c", "nvim " .. file } } }),
-- 			pane
-- 		)
-- 		return false
-- 	end
-- end)
--
-- return {
-- 	font = wezterm.font("VictorMono Nerd Font"),
-- 	font_size = 16.0,
-- 	color_scheme = "tokyonight-storm",
-- 	use_fancy_tab_bar = false,
-- 	tab_bar_at_bottom = true,
-- 	window_background_opacity = 0.95,
-- 	text_background_opacity = 1,
-- 	window_decorations = "RESIZE",
-- 	inactive_pane_hsb = {
-- 		-- NOTE: these values are multipliers, applied on normal pane values
-- 		saturation = 0.9,
-- 		brightness = 0.6,
-- 	},
-- 	-- keys
-- 	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 },
-- 	keys = {
-- 		{
-- 			key = "q",
-- 			mods = "ALT",
-- 			action = wezterm.action.CloseCurrentPane({ confirm = true }),
-- 		},
-- 		{
-- 			key = "s",
-- 			mods = "ALT",
-- 			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
-- 		},
-- 		{
-- 			key = "v",
-- 			mods = "ALT",
-- 			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
-- 		},
-- 		{
-- 			key = "f",
-- 			mods = "ALT",
-- 			action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|TABS|DOMAINS|LAUNCH_MENU_ITEMS" }),
-- 		},
-- 		{
-- 			key = "t",
-- 			mods = "ALT",
-- 			action = wezterm.action.SpawnCommandInNewTab({ domain = "CurrentPaneDomain", cwd = "~" }),
-- 		},
-- 		{
-- 			key = "T",
-- 			mods = "ALT",
-- 			action = wezterm.action.SpawnTab("CurrentPaneDomain"),
-- 		},
-- 		{
-- 			key = "Enter",
-- 			mods = "ALT",
-- 			action = wezterm.action.SpawnCommandInNewWindow({ domain = "DefaultDomain", cwd = "~" }),
-- 		},
-- 		{
-- 			key = "n",
-- 			mods = "ALT",
-- 			action = wezterm.action.ActivateTabRelative(1),
-- 		},
-- 		{
-- 			key = "p",
-- 			mods = "ALT",
-- 			action = wezterm.action.ActivateTabRelative(-1),
-- 		},
-- 	},
-- 	mouse_bindings = {
-- 		{
-- 			event = { Down = { streak = 1, button = "Right" } },
-- 			mods = "NONE",
-- 			action = wezterm.action({ PasteFrom = "Clipboard" }),
-- 		},
-- 		-- Change the default click behavior so that it only selects
-- 		-- text and doesn't open hyperlinks
-- 		{
-- 			event = { Up = { streak = 1, button = "Left" } },
-- 			mods = "NONE",
-- 			action = wezterm.action({ CompleteSelection = "PrimarySelection" }),
-- 		},
-- 		-- and make CTRL-Click open hyperlinks
-- 		{
-- 			event = { Up = { streak = 1, button = "Left" } },
-- 			mods = "CTRL",
-- 			action = "OpenLinkAtMouseCursor",
-- 		},
-- 	},
-- }
