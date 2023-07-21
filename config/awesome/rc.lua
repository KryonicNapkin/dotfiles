-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local lain = require("lain")
local wibox = require("wibox")
local markup = lain.util.markup
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")

-- Naughty notification config
naughty.config.padding = 0
naughty.config.spacing = 3
naughty.config.icon_dirs = "/usr/share/icons/Papirus-Dark/"
naughty.config.presets.low.bg = "#282c34"
naughty.config.presets.low.fg = "#abb2bf"
naughty.config.presets.low.timeout = 5
naughty.config.presets.normal.bg = "#282c34"
naughty.config.presets.normal.fg = "#abb2bf"
naughty.config.presets.normal.timeout = 10
naughty.config.presets.critical.bg = "#e06c75"
naughty.config.presets.critical.fg = "#000000"
naughty.config.presets.critical.timeout = 15

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}
-- Colors definition
local bg = "#282c34" -- normal background color
local wbg = "#373b41" -- widget backgroudn color
local green = "#98c379"
local blue = "#61afef"
local yellow = "#e5c07b"
local black = "#000000"
local white = "#abb2bf" -- forground white
local cwhite = "#ffffff" -- clear white
local red = "#e06c75"
local pink = "#c678dd"
local cyan = "#56b6c2"

-- Constants definition
local HOMEDIR = "/home/oizero/"
local WORKDIR = HOMEDIR .. ".config/awesome/"
local CONFDIR = HOMEDIR .. ".config/"
local SCRIPTD = HOMEDIR .. ".local/bin/"

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(WORKDIR .. "theme.lua")

-- GAPS
beautiful.useless_gap = 0
beautiful.gap_single_client = false

-- Fix window snapping
awful.mouse.snap.edge_enabled = false

-- Keys definition
local mod = "Mod4"
local alt = "Mod1"

-- Variables declaration
local rssreader = "newsflash"
local virtmngr = "virt-manager"
local browser = "brave"
local steam = "steam"
local discord = "discord"
local thndbird = "thunderbird"
local filebrw = "pcmanfm"
local terminal = "alacritty"
local inkscape = "inkscape"
local hptoolbox = "hp-toolbox"
local dispplan = "feh " .. HOMEDIR .. "Screenshots/Rozvrch_9.B.png"
local updates = SCRIPTD .. "updates.sh" -- Table of layouts to cover with awful.layout.inc, order matters.
local restartprocs = SCRIPTD .. "prep.sh" -- Table of layouts to cover with awful.layout.inc, order matters.
local dunstclose = SCRIPTD .. "dunst-close.sh" -- Table of layouts to cover with awful.layout.inc, order matters.
local mutemic = SCRIPTD .. "mice-mute.sh" -- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	awful.layout.suit.max,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.fair,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Widgets

-- TEMP widget
local temp_widget = lain.widget.temp({
	timeout = 15,
	settings = function()
		widget:set_markup(markup.fontfg(beautiful.font, yellow, " " .. coretemp_now .. "°C "))
	end,
})

local temp_widget_icon = wibox.widget({
	{
		{
			text = "  ",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		top = 5,
		bottom = 5,
		right = 0,
		color = bg,
		widget = wibox.container.margin,
	},
	fg = black,
	bg = yellow,
	widget = wibox.container.background,
})

temp_widget_icon.font = beautiful.icon_font .. beautiful.icon_size_temp

-- CPU widget
local cpu_widget = lain.widget.cpu({
	timeout = 1,
	settings = function()
		widget:set_markup(markup.fontfg(beautiful.font, red, " " .. cpu_now.usage .. "% "))
	end,
})

local cpu_widget_icon = wibox.widget({
	{
		{
			text = "  ",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		top = 5,
		bottom = 5,
		right = 0,
		color = bg,
		widget = wibox.container.margin,
	},
	fg = black,
	bg = red,
	widget = wibox.container.background,
})

cpu_widget_icon.font = beautiful.icon_font .. beautiful.icon_size

-- RAM widget
local ram_widget = lain.widget.mem({
	timeout = 1,
	settings = function()
		widget:set_markup(markup.fontfg(beautiful.font, green, " " .. mem_now.perc .. "% "))
	end,
})

local ram_widget_icon = wibox.widget({
	{
		{
			text = "  ",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		top = 5,
		bottom = 5,
		right = 0,
		color = bg,
		widget = wibox.container.margin,
	},
	fg = black,
	bg = green,
	widget = wibox.container.background,
})

ram_widget_icon.font = beautiful.icon_font .. beautiful.icon_size

-- HDD usage
local disk_widget = lain.widget.fs({
	threshold = 90,
	settings = function()
		widget:set_markup(markup.fontfg(beautiful.font, pink, " " .. fs_now["/"].percentage .. "% "))
	end,
})

local disk_widget_icon = wibox.widget({
	{
		{
			text = "  ",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		top = 5,
		bottom = 5,
		right = 0,
		color = bg,
		widget = wibox.container.margin,
	},
	fg = black,
	bg = pink,
	widget = wibox.container.background,
})

disk_widget_icon.font = beautiful.icon_font .. beautiful.icon_size_disk

-- Net
local netdown = wibox.widget.textbox()
local netup = wibox.widget.textbox()

local net = lain.widget.net({
	settings = function()
		netup:set_markup(markup.fontfg(beautiful.font, blue, " " .. net_now.sent .. " "))
		netdown:set_markup(markup.fontfg(beautiful.font, blue, "" .. net_now.received .. " "))
	end,
})

local net_icon = wibox.widget({
	{
		{
			text = "  ",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		top = 5,
		bottom = 5,
		right = 0,
		color = bg,
		widget = wibox.container.margin,
	},
	fg = black,
	bg = blue,
	widget = wibox.container.background,
})

net_icon.font = beautiful.icon_font .. beautiful.icon_size

local netup_icon = wibox.widget({
	{
		text = " ",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	},
	fg = blue,
	widget = wibox.container.background,
})

netup_icon.font = beautiful.icon_font .. beautiful.icon_size

-- Spacewidget
local space = wibox.widget({
	text = " ",
	widget = wibox.widget.textbox,
})

local cw = calendar_widget({
	theme = "onedark",
	placement = "top_right",
	radius = 0,
})
-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget({
	refresh = 1,
	format = "%H:%M:%S ",
	widget = wibox.widget.textclock,
})

mytextclock:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		cw.toggle()
	end
end)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ mod }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ mod }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

awful.screen.connect_for_each_screen(function(s)
	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }, s, awful.layout.layouts[1])

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox({
		screen = s,
	})

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})
	-- Create the wibox
	s.mywibox =
	awful.wibar({ position = "top", screen = s, width = 1600, height = 26, margins = { top = 0, bottom = 0 } })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			{
				s.mylayoutbox,
				left = 5,
				right = 2,
				top = 5,
				bottom = 5,
				widget = wibox.container.margin,
			},
			{
				s.mytaglist,
				left = 3,
				bottom = 3,
				right = 3,
				top = 3,
				widget = wibox.container.margin,
			},
		},
		{
			s.mytasklist, -- Middle widget
			bottom = 3,
			left = 0,
			top = 3,
			right = 3,
			widget = wibox.container.margin,
		},
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			temp_widget_icon,
			{
				{
					temp_widget,
					bg = beautiful.bg_widget,
					widget = wibox.container.background,
				},
				top = 5,
				bottom = 5,
				right = 5,
				color = bg,
				widget = wibox.container.margin,
			},
			cpu_widget_icon,
			{
				{
					cpu_widget,
					bg = beautiful.bg_widget,
					widget = wibox.container.background,
				},
				top = 5,
				bottom = 5,
				right = 5,
				color = b,
				widget = wibox.container.margin,
			},
			ram_widget_icon,
			{
				{
					ram_widget,
					bg = beautiful.bg_widget,
					widget = wibox.container.background,
				},
				top = 5,
				bottom = 5,
				right = 5,
				color = bg,
				widget = wibox.container.margin,
			},
			disk_widget_icon,
			{
				{
					disk_widget,
					bg = beautiful.bg_widget,
					widget = wibox.container.background,
				},
				top = 5,
				bottom = 5,
				right = 5,
				color = bg,
				widget = wibox.container.margin,
			},
			net_icon,
			{
				{
					netup,
					bg = beautiful.bg_widget,
					widget = wibox.container.background,
				},
				top = 5,
				bottom = 5,
				right = 0,
				color = bg,
				widget = wibox.container.margin,
			},
			{
				{
					netdown,
					bg = beautiful.bg_widget,
					widget = wibox.container.background,
				},
				top = 5,
				bottom = 5,
				right = 5,
				color = bg,
				widget = wibox.container.margin,
			},
			volume_widget({
				timeout = 1,
				widget_type = "icon_and_text",
			}),
			space,
			brightness_widget({
				percentage = false,
				type = "icon_and_text",
				program = "brightnessctl",
				step = 5,
			}),
			space,
			battery_widget({
				show_current_level = true,
				display_notification = true,
				enable_battery_warning = true,
				warning_msg_title = "Battery status",
				warning_msg_text = "Battery is dying",
				warning_msg_position = "top_right",
			}),
			mykeyboardlayout,
			mytextclock,
			{
				wibox.widget.systray(),
				bottom = 4,
				top = 4,
				left = 0,
				right = 4,
				widget = wibox.container.margin,
			},
		},
	})
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
--awful.button({ }, 4, awful.tag.viewnext),
--awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(

    -- Awesome's help window
	awful.key({ mod }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	-- AwesomeWM restart (procs if needed) and quit
	awful.key({ mod, "Control" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ mod, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ mod, "Control" }, "t", function ()
        awful.spawn(restartprocs)
	end, { description = "quit awesome", group = "awesome" }),

	awful.key({ mod }, "", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),

	-- Widget keybindings
	awful.key({ alt, "Shift" }, "c", function()
		cw:toggle()
	end, { description = "Open Calendar", group = "Widgets" }),

	-- Terminal Applications
	awful.key({ alt }, "1", function()
		awful.spawn.with_shell(
			"alacritty --config-file " .. CONFDIR .. "alacritty/alacritty_scratchpad.yml --class term",
			{ floating = true, ontop = true }
		)
	end, { description = "Open Floating Alacritty term", group = "Terminal Applications" }),
	awful.key({ alt }, "2", function()
		awful.spawn.with_shell(
			"alacritty --config-file " .. CONFDIR .. "alacritty/alacritty_scratchpad.yml --class htop -e htop",
			{ floating = true, ontop = true }
		)
	end, { description = "Open Floating htop", group = "Terminal Applications" }),
	awful.key({ alt }, "3", function()
		awful.spawn.with_shell(
			"alacritty --config-file " .. CONFDIR .. "alacritty/alacritty_scratchpad.yml --class ttyc -e tty-clock -s -b -c -f '%a %d.%m.%y'",
			{ floating = true, ontop = true }
		)
	end, { description = "Open Clock", group = "Terminal Applications" }),
	awful.key({ alt }, "4", function()
		awful.spawn.with_shell(
			"alacritty --config-file " .. CONFDIR .. "alacritty/alacritty_scratchpad.yml --class battop -e battop",
			{ floating = true, ontop = true }
		)
	end, { description = "Open battop", group = "Terminal Applications" }),
	awful.key({ alt }, "5", function()
		awful.spawn.with_shell(
			"alacritty --config-file " .. CONFDIR .. "alacritty/alacritty_scratchpad.yml --class qalc -e qalc",
			{ floating = true, ontop = true }
		)
	end, { description = "Open Calculator", group = "Terminal Applications" }),

    -- Misc
	awful.key({ alt, "Control" }, "r", function()
		awful.spawn.with_shell(dispplan, { floating = true, ontop = true })
	end, { description = "Open Rozvrch", group = "Terminal Applications" }),

	-- Notify Applications
	awful.key({ mod, alt }, "u", function()
		awful.spawn(updates)
	end, { description = "Check for updates", group = "Notify Applications" }),
	awful.key({ mod, alt }, "c", function()
		awful.spawn(dunstclose)
	end, { description = "Close dunst notification", group = "Notify Applications" }),
	awful.key({ mod, alt }, "m", function()
		awful.spawn(mutemic)
	end, { description = "Mutes mice", group = "Notify Applications" }),

	-- Function keys keybindings
	awful.key({}, "XF86MonBrightnessUp", function()
		brightness_widget:inc(5)
	end, { description = "Increase brightness", group = "Brightness" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		brightness_widget:dec(5)
	end, { description = "Decrease Brightness", group = "Brightness" }),
	awful.key({}, "XF86AudioRaiseVolume", function()
		volume_widget:inc(5)
	end, { description = "Increase volume", group = "Audio" }),
	awful.key({}, "XF86AudioLowerVolume", function()
		volume_widget:dec(5)
	end, { description = "Decrease volume", group = "Audio" }),
	awful.key({}, "XF86AudioMute", function()
		volume_widget:toggle()
	end, { description = "Turn on and off volume", group = "Audio" }),

	-- Used apps
	awful.key({ mod }, "Return", function()
		awful.spawn(terminal)
	end, { description = "Open Alacritty", group = "Programs" }),
	awful.key({ mod, "Shift" }, "r", function()
		awful.spawn(rssreader)
	end, { description = "Open Newsflash", group = "Programs" }),
	awful.key({ mod, "Shift" }, "w", function()
		awful.spawn(browser)
	end, { description = "Open Brave", group = "Programs" }),
	awful.key({ mod, "Shift" }, "i", function()
		awful.spawn(inkscape)
	end, { description = "Open Inkscape", group = "Programs" }),
	awful.key({ mod, "Shift" }, "f", function()
		awful.spawn(filebrw)
	end, { description = "Open PCManFM", group = "Programs" }),
	awful.key({ mod, "Shift" }, "d", function()
		awful.spawn(discord)
	end, { description = "Open Discord", group = "Programs" }),
	awful.key({ mod, "Shift" }, "s", function()
		awful.spawn(steam)
	end, { description = "Open Steam", group = "Programs" }),
	awful.key({ mod, "Shift" }, "v", function()
		awful.spawn(virtmngr)
	end, { description = "Open Open Virt-manager", group = "Programs" }),
	awful.key({ mod, "Shift" }, "p", function()
		awful.spawn(hptoolbox)
	end, { description = "Open HP Toolbox", group = "Programs" }),
	awful.key({ mod, "Shift" }, "t", function()
		awful.spawn(thndbird)
	end, { description = "Open Thunderbird", group = "Programs" }),

	-- ROFI keybindigns
	awful.key({ mod }, "r", function()
		local grabber
		grabber = awful.keygrabber.run(function(_, key, event)
			if event == "release" then
				return
			end

			if key == "r" then
				awful.spawn.with_shell(SCRIPTD .. "rf-run.sh")
			elseif key == "b" then
				awful.spawn.with_shell(SCRIPTD .. "rf-bin.sh")
			elseif key == "p" then
				awful.spawn.with_shell(SCRIPTD .. "rf-pwr.sh")
			elseif key == "w" then
				awful.spawn.with_shell(SCRIPTD .. "rf-wiki.sh")
			elseif key == "c" then
				awful.spawn.with_shell(SCRIPTD .. "rf-clip.sh")
			elseif key == "d" then
				awful.spawn.with_shell(SCRIPTD .. "rf-win.sh")
			elseif key == "e" then
				awful.spawn.with_shell(SCRIPTD .. "rf-dots.sh")
			elseif key == "i" then
				awful.spawn.with_shell(SCRIPTD .. "rf-pkginf.sh")
			elseif key == "q" then
				awful.spawn.with_shell(SCRIPTD .. "rf-qkl.sh")
			elseif key == "s" then
				awful.spawn.with_shell(SCRIPTD .. "rf-scrt.sh")
			elseif key == "k" then
				awful.spawn.with_shell(SCRIPTD .. "rf-scpwiki.sh")
			elseif key == "n" then
				awful.spawn.with_shell(SCRIPTD .. "rf-man.sh")
			elseif key == "m" then
				awful.spawn.with_shell(SCRIPTD .. "rf-wmch.sh")
			end
			awful.keygrabber.stop(grabber)
		end)
	end, { description = "Rofi Menus", group = "Rofi Menus" })
)

local clientkeys = gears.table.join(

-- Client focus keybindings keybindings
	awful.key({ mod }, "h", function()
		awful.client.focus.global_bydirection("left")
		client.focus:raise()
	end, { description = "Change focus to window in left", group = "client" }),
	awful.key({ mod }, "j", function()
		awful.client.focus.global_bydirection("down")
		client.focus:raise()
	end, { description = "Change focus to window in left", group = "client" }),
	awful.key({ mod }, "k", function()
		awful.client.focus.global_bydirection("up")
		client.focus:raise()
	end, { description = "Change focus to window in left", group = "client" }),
	awful.key({ mod }, "l", function()
		awful.client.focus.global_bydirection("right")
		client.focus:raise()
	end, { description = "Change focus to window in left", group = "client" }),

	-- Client swap keybindings
	awful.key({ mod, "Shift" }, "h", function()
		awful.client.swap.global_bydirection("left")
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ mod, "Shift" }, "j", function()
		awful.client.swap.global_bydirection("down")
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ mod, "Shift" }, "k", function()
		awful.client.swap.global_bydirection("up")
	end, { description = "swap window with the down window", group = "client" }),
	awful.key({ mod, "Shift" }, "l", function()
		awful.client.swap.global_bydirection("right")
	end, { description = "decrease the number of master clients", group = "layout" }),

	-- Window resizing and geometry keybindings
	awful.key({ mod, "Control" }, "h", function(c)
		if client.floating then
			client:relative_move(0, 0, -10, 0)
		else
			awful.tag.incmwfact(-0.02)
		end
	end, { description = "Resize window left", group = "client" }),
	awful.key({ mod, "Control" }, "j", function(c)
		if client.floating then
			client:relative_move(0, 0, 0, 10)
		else
			awful.client.incwfact(-0.02)
		end
	end, { description = "Resize window down", group = "client" }),
	awful.key({ mod, "Control" }, "k", function(c)
		if client.floating then
			client:relative_move(0, 0, 0, -10)
		else
			awful.client.incwfact(0.02)
		end
	end, { description = "Resize window up", group = "client" }),
	awful.key({ mod, "Control" }, "l", function(c)
		if client.floating then
			client:relative_move(0, 0, 10, 0)
		else
			awful.tag.incmwfact(0.02)
		end
	end, { description = "Resize window right", group = "client" }),

	-- Other keybindings
	awful.key({ mod }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ mod }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ mod, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	awful.key({ mod }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ mod }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ mod, "Control" },
		"f",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ mod, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ mod }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ mod }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ mod }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ mod }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ mod, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ mod, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ mod }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ mod, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ mod, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ mod, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

local clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ mod }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ mod }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules =
{
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
				"ttyc",
				"qalc",
				"battop",
				"term",
				"htop",
				"rozvrch",
                "Xdialog",
			},
			class = {
				"Arandr",
				"Gcolor3",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
				"feh",
			},
			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true, placement = awful.placement.centered },
	},

	{ rule = { class = "thunderbird" }, properties = { screen = 1, tag = "8" } },
	{ rule = { class = "discord" }, properties = { screen = 1, tag = "9" } },
	{ rule = { class = "Steam" }, properties = { screen = 1, tag = "0" } },

	-- Set Firefox to always map on the tag named "2" on screen 1.
},
		-- {{{ Signals
		-- Signal function to execute when a new client appears.
		client.connect_signal("manage", function(c)
			-- Set the windows at the slave,
			-- i.e. put it at the end of others instead of setting it master.
			if not awesome.startup then
				awful.client.setslave(c)
			end

			if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
				-- Prevent clients from being unreachable after screen count changes.
				awful.placement.no_offscreen(c)
			end
		end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
--
-- Save the current tag when AwesomeWM is restarted
local current_tag = screen[1].selected_tag

-- Set the current tag when AwesomeWM starts
awesome.connect_signal("reload", function()
	screen[1].selected_tag = current_tag
end)
-- }}}
return {}
