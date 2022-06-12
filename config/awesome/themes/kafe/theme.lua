local xresources  = require "beautiful.xresources"
local gears		  = require "gears"
local dpi 		  = xresources.apply_dpi
local config_path = gears.filesystem.get_configuration_dir()

local theme = {}

-- ===================================================================
-- Theme Variables
-- ===================================================================

theme.name = "Catppuccin Mocha"
theme.dpi = dpi

theme.pfp = config_path .. "images/pfp.jpg"



-- ░█████╗░░█████╗░██╗░░░░░░█████╗░██████╗░░██████╗
-- ██╔══██╗██╔══██╗██║░░░░░██╔══██╗██╔══██╗██╔════╝
-- ██║░░╚═╝██║░░██║██║░░░░░██║░░██║██████╔╝╚█████╗░
-- ██║░░██╗██║░░██║██║░░░░░██║░░██║██╔══██╗░╚═══██╗
-- ╚█████╔╝╚█████╔╝███████╗╚█████╔╝██║░░██║██████╔╝
-- ░╚════╝░░╚════╝░╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░

-- The colors are taken from the Catppuccin Mocha theme
-- https://github.com/catppuccin/catppuccin

theme.colors = {}

theme.colors.background = {
	base = "#1e1e2e",
	overlay_0 = "#6c7086"
}

theme.colors.typography = {
	text = "#cdd6f4",
	subtext_1 = "#bac2de"
}

theme.colors.regular = {
	red = "#f38ba8",
	yellow = "f9e2af"
}



-- ███████╗░█████╗░███╗░░██╗████████╗░██████╗
-- ██╔════╝██╔══██╗████╗░██║╚══██╔══╝██╔════╝
-- █████╗░░██║░░██║██╔██╗██║░░░██║░░░╚█████╗░
-- ██╔══╝░░██║░░██║██║╚████║░░░██║░░░░╚═══██╗
-- ██║░░░░░╚█████╔╝██║░╚███║░░░██║░░░██████╔╝
-- ╚═╝░░░░░░╚════╝░╚═╝░░╚══╝░░░╚═╝░░░╚═════╝░

theme.fonts = {
	primary = "CaskaydiaCove Nerd Font",
	icons = "Font Awesome"
}



-- ██████╗░░█████╗░███╗░░██╗███████╗██╗░░░░░░██████╗
-- ██╔══██╗██╔══██╗████╗░██║██╔════╝██║░░░░░██╔════╝
-- ██████╔╝███████║██╔██╗██║█████╗░░██║░░░░░╚█████╗░
-- ██╔═══╝░██╔══██║██║╚████║██╔══╝░░██║░░░░░░╚═══██╗
-- ██║░░░░░██║░░██║██║░╚███║███████╗███████╗██████╔╝
-- ╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚══╝╚══════╝╚══════╝╚═════╝░

theme.panels = {}

-- ===================================================================
-- Main Panel
-- ===================================================================

theme.panels.main = {
	bg_color = theme.colors.background.base,
	width = dpi(40),
	widget_spacing = dpi(10),
	margin = dpi(5),
	padding = dpi(5),
	corner_radius = dpi(5)
}

-- ===================================================================
-- Menu Panel
-- ===================================================================

theme.panels.menu = {
	bg_color = theme.colors.background.base,
	width = dpi(400),
	widget_spacing = dpi(10),
	margin = dpi(5),
	padding = dpi(5),
	corner_radius = dpi(20)
}

theme.panels.menu.profile = {
	size = dpi(200)
}



-- ░██╗░░░░░░░██╗██╗██████╗░░██████╗░███████╗████████╗░██████╗
-- ░██║░░██╗░░██║██║██╔══██╗██╔════╝░██╔════╝╚══██╔══╝██╔════╝
-- ░╚██╗████╗██╔╝██║██║░░██║██║░░██╗░█████╗░░░░░██║░░░╚█████╗░
-- ░░████╔═████║░██║██║░░██║██║░░╚██╗██╔══╝░░░░░██║░░░░╚═══██╗
-- ░░╚██╔╝░╚██╔╝░██║██████╔╝╚██████╔╝███████╗░░░██║░░░██████╔╝
-- ░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░░╚═════╝░╚══════╝░░░╚═╝░░░╚═════╝░

theme.widgets = {}

-- ===================================================================
-- Taglist
-- ===================================================================

theme.widgets.taglist = {
	font = theme.fonts.icons,
	font_size = 13,
	spacing = dpi(5),
	text = {
		selected = "",
		urgent = "⚡",
		occupied = "",
		empty = ""
	},
	colors = {
		selected = theme.colors.regular.red,
		urgent = theme.colors.regular.yellow,
		occupied = theme.colors.typography.subtext_1,
		empty = theme.colors.background.overlay_0
	}
}

-- ===================================================================
-- Clock
-- ===================================================================

theme.widgets.clock = {
	format = "%H%M",
	font = theme.fonts.primary,
	font_size = 13,
	text_color = theme.colors.typography.text,
	line_height = 1.2
}



-- ██╗░█████╗░░█████╗░███╗░░██╗░██████╗
-- ██║██╔══██╗██╔══██╗████╗░██║██╔════╝
-- ██║██║░░╚═╝██║░░██║██╔██╗██║╚█████╗░
-- ██║██║░░██╗██║░░██║██║╚████║░╚═══██╗
-- ██║╚█████╔╝╚█████╔╝██║░╚███║██████╔╝
-- ╚═╝░╚════╝░░╚════╝░╚═╝░░╚══╝╚═════╝░

-- ===================================
-- Layout Icons
-- ===================================
local gfs = require("gears.filesystem")
local config_path = gfs.get_configuration_dir()

local function layoutimg(name)
	return config_path..'images/layouts/'..name
end

theme.layout_fairh = layoutimg("fairhw.png")
theme.layout_fairv = layoutimg("fairvw.png")
theme.layout_floating  = layoutimg("floatingw.png")
theme.layout_magnifier = layoutimg("magnifierw.png")
theme.layout_max = layoutimg("maxw.png")
theme.layout_fullscreen = layoutimg("fullscreenw.png")
theme.layout_tilebottom = layoutimg("tilebottomw.png")
theme.layout_tileleft   = layoutimg("tileleftw.png")
theme.layout_tile = layoutimg("tilew.png")
theme.layout_tiletop = layoutimg("tiletopw.png")
theme.layout_spiral  = layoutimg("spiralw.png")
theme.layout_dwindle = layoutimg("dwindlew.png")
theme.layout_cornernw = layoutimg("cornernww.png")
theme.layout_cornerne = layoutimg("cornernew.png")
theme.layout_cornersw = layoutimg("cornersww.png")
theme.layout_cornerse = layoutimg("cornersew.png")



-- ░█████╗░██╗░░░░░██╗███████╗███╗░░██╗████████╗
-- ██╔══██╗██║░░░░░██║██╔════╝████╗░██║╚══██╔══╝
-- ██║░░╚═╝██║░░░░░██║█████╗░░██╔██╗██║░░░██║░░░
-- ██║░░██╗██║░░░░░██║██╔══╝░░██║╚████║░░░██║░░░
-- ╚█████╔╝███████╗██║███████╗██║░╚███║░░░██║░░░
-- ░╚════╝░╚══════╝╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░

theme.client = {
	border = {
		width = dpi(4),
		color = theme.colors.background.base .. "bb"
	}
}
theme.useless_gap = dpi(3)



-- ██╗░░██╗░█████╗░████████╗██╗░░██╗███████╗██╗░░░██╗░██████╗
-- ██║░░██║██╔══██╗╚══██╔══╝██║░██╔╝██╔════╝╚██╗░██╔╝██╔════╝
-- ███████║██║░░██║░░░██║░░░█████═╝░█████╗░░░╚████╔╝░╚█████╗░
-- ██╔══██║██║░░██║░░░██║░░░██╔═██╗░██╔══╝░░░░╚██╔╝░░░╚═══██╗
-- ██║░░██║╚█████╔╝░░░██║░░░██║░╚██╗███████╗░░░██║░░░██████╔╝
-- ╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═════╝░

-- The hotkeys help menu

theme.hotkeys_bg = theme.colors.background.base
theme.hotkeys_fg = theme.colors.typography.text
theme.hotkeys_modifiers_fg = theme.colors.background.overlay_0



-- return theme
return theme
