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

theme.username = "Maroka"
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
	mantle = "#181825",
	overlay_0 = "#6c7086",
	surface_0 = "#313244"
}

theme.colors.typography = {
	text = "#cdd6f4",
	subtext_1 = "#bac2de"
}

theme.colors.regular = {
	red = "#f38ba8",
	yellow = "#f9e2af",
	teal = "#94e2d5"
}



-- ███████╗░█████╗░███╗░░██╗████████╗░██████╗
-- ██╔════╝██╔══██╗████╗░██║╚══██╔══╝██╔════╝
-- █████╗░░██║░░██║██╔██╗██║░░░██║░░░╚█████╗░
-- ██╔══╝░░██║░░██║██║╚████║░░░██║░░░░╚═══██╗
-- ██║░░░░░╚█████╔╝██║░╚███║░░░██║░░░██████╔╝
-- ╚═╝░░░░░░╚════╝░╚═╝░░╚══╝░░░╚═╝░░░╚═════╝░

theme.fonts = {
	primary = "CaskaydiaCove Nerd Font",
	secondary = "Annie Use Your Telescope",
	icons = "CaskaydiaCove Nerd Font"
}



-- ██████╗░░█████╗░███╗░░██╗███████╗██╗░░░░░░██████╗
-- ██╔══██╗██╔══██╗████╗░██║██╔════╝██║░░░░░██╔════╝
-- ██████╔╝███████║██╔██╗██║█████╗░░██║░░░░░╚█████╗░
-- ██╔═══╝░██╔══██║██║╚████║██╔══╝░░██║░░░░░░╚═══██╗
-- ██║░░░░░██║░░██║██║░╚███║███████╗███████╗██████╔╝
-- ╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚══╝╚══════╝╚══════╝╚═════╝░

theme.panels = {
	border = {
		width = dpi(4),
		color = theme.colors.background.base .. "bb"
	}
}

-- ===================================================================
-- Main Panel
-- ===================================================================

theme.panels.main = {
	bg_color = theme.colors.background.base,
	width = dpi(32),
	widget_spacing = dpi(10),
	section_1 = {
		padding = dpi(2),
	},
	section_2 = {
		padding = dpi(5),
	},
	section_3 = {
		padding = dpi(5),
	}
}

-- ===================================================================
-- Menu Panel
-- ===================================================================

theme.panels.menu = {
	bg_color = theme.colors.background.base,
	width = dpi(400),
	widget_spacing = dpi(10),
	margin = dpi(5),
	padding = dpi(20),
	corner_radius = dpi(20),
	border = theme.panels.border
}

theme.panels.menu.profile = {
	pfp_size = dpi(200),
	text = {
		markup = theme.username,
		font = theme.fonts.secondary,
		font_size = dpi(40),
		color = theme.colors.typography.text,
	},
	subtext = {
		markup = "@maroka-chan",
		font = theme.fonts.secondary,
		font_size = dpi(26),
		color = theme.colors.background.overlay_0
	}
}



-- ░██╗░░░░░░░██╗██╗██████╗░░██████╗░███████╗████████╗░██████╗
-- ░██║░░██╗░░██║██║██╔══██╗██╔════╝░██╔════╝╚══██╔══╝██╔════╝
-- ░╚██╗████╗██╔╝██║██║░░██║██║░░██╗░█████╗░░░░░██║░░░╚█████╗░
-- ░░████╔═████║░██║██║░░██║██║░░╚██╗██╔══╝░░░░░██║░░░░╚═══██╗
-- ░░╚██╔╝░╚██╔╝░██║██████╔╝╚██████╔╝███████╗░░░██║░░░██████╔╝
-- ░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░░╚═════╝░╚══════╝░░░╚═╝░░░╚═════╝░

theme.widgets = {}

-- ===================================================================
-- Tasklist
-- ===================================================================

theme.widgets.tasklist = {
	spacer = {
		width = theme.panels.main.width - dpi(8),
		color = theme.colors.background.overlay_0,
		thickness = dpi(1)
	},
	spacing = dpi(3),
	icon_margin = dpi(3)
}

theme.tasklist_bg_normal = theme.colors.background.base
theme.tasklist_bg_focus = theme.colors.background.surface_0

-- ===================================================================
-- Taglist
-- ===================================================================

theme.widgets.taglist = {
	font = theme.fonts.icons,
	font_size = 10,
	spacing = dpi(5),
	text = {
		selected = "",
		urgent = "",
		occupied = "",
		empty = ""
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

-- ===================================================================
-- Date
-- ===================================================================

theme.widgets.date = {
	format = "%a, %d %b",
	font = theme.fonts.primary,
	font_size = 13,
	text_color = theme.colors.typography.text,
	align = "left"
}

-- ===================================================================
-- Usage Arc
-- ===================================================================

theme.widgets.usage_arc = {
	percentage_font = theme.fonts.primary,
	font_size = 14,
	bg_color = theme.colors.background.surface_0,
	corner_radius = dpi(15),
	margin = dpi(4),
	arc = {
		bg_color = theme.colors.background.mantle,
		thickness = dpi(11)
	}
}

-- ===================================================================
-- CPU
-- ===================================================================

theme.widgets.cpu = {
	markup = '',
	icon_font = theme.fonts.icons,
	font_size = 34,
	color = theme.colors.regular.teal,
	size = dpi(110),
	update_interval = 2
}

-- ===================================================================
-- RAM
-- ===================================================================

theme.widgets.ram = {
	markup = '',
	icon_font = theme.fonts.icons,
	font_size = 25,
	color = theme.colors.regular.red,
	size = dpi(110),
	update_interval = 5
}

-- ===================================================================
-- Disk
-- ===================================================================

theme.widgets.disk = {
	markup = '',
	icon_font = theme.fonts.icons,
	font_size = 25,
	color = theme.colors.regular.yellow,
	size = dpi(110),
	partition = "/"  -- This can either be the partition or the mount point
}

-- ===================================================================
-- Weather
-- ===================================================================

theme.widgets.weather = {
	altitude = "12",
	lat = "55.67064",
	lon = "12.534599",
	font = theme.fonts.primary,
	font_size = 14,
	icon_font = theme.fonts.icons,
	icon_size = 24,
	color = theme.colors.typography.text
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

theme.border_width = dpi(3)
theme.border_color_normal = theme.colors.background.base .. "bb"
theme.border_color_active = theme.colors.regular.yellow
theme.useless_gap = dpi(2)



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
