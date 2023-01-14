local wezterm = require("wezterm")

wezterm.on("open-uri", function(window, pane, uri)
	local start, match_end = uri:find("file://")
	if start == 1 then
		local file = uri:sub(match_end + 1)
		window:perform_action(
			wezterm.action({ SpawnCommandInNewWindow = { args = { "nu", "-c", "nvim " .. file } } }),
			pane
		)
		return false
	end
end)

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
