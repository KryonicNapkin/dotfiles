-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local lain = require("lain")
local vicious = require("vicious")
local wibox = require("wibox")
local away = require("away")
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
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")

-- Naughty notification config
naughty.config.padding = 6

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err) })
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/thinker/.config/awesome/theme.lua")

-- GAPS
beautiful.useless_gap = 3

-- AUTOSTART
awful.spawn.with_shell("/home/thinker/.fehbg")
awful.spawn.with_shell("picom --no-fading-openclose --config ~/.config/picom.awesome/picom_awesome.conf")
awful.spawn.with_shell("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
awful.spawn.with_shell("dunst")

-- Default Variables (Programs)
terminal = "alacritty"
browser = "brave"
filemanager = "pcmanfm"
editor = "lvim" or "nvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.max,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
-- }}}

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Widgets

-- TEMP widget
local temp_widget = lain.widget.temp {
  timeout = 15,
  settings = function()
    widget:set_markup(markup.fontfg(beautiful.font, "#e5c07b", "  " .. coretemp_now .. "°C "))
  end
}

-- CPU widget
local cpu_widget = lain.widget.cpu {
  timeout = 1,
  settings = function()
    widget:set_markup(markup.fontfg(beautiful.font, "#e06c75", "  " .. cpu_now.usage .. "% "))
  end
}

-- RAM widget
local ram_widget = lain.widget.mem {
  timeout = 1,
  settings = function()
    widget:set_markup(markup.fontfg(beautiful.font, "#98c379", "  " .. mem_now.perc .. "% "))
  end
}

-- Spacewidget
local space_widget = {
  text   = '  ',
  widget = wibox.widget.textbox
}

-- HDD usage
local my_disk_usage = lain.widget.fs({
  threshold = 90,
  settings  = function()
    widget:set_markup(markup.fontfg(beautiful.font, "#c678dd", "   " .. fs_now["/"].percentage .. "% "))
  end
})

-- BAT widget
local bat_widget = lain.widget.bat {
  timeout = 15,
  settings = function()
    widget:set_markup("  " .. bat_now.perc .. "% ")
  end
}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget {
  format = ' %a %d.%m.%y %H:%M:%S ',
  refresh = 1,
  widget = wibox.widget.textclock
}
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
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
  end))

awful.screen.connect_for_each_screen(function(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  }
  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mylayoutbox,
      s.mytaglist,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      temp_widget,
      cpu_widget,
      ram_widget,
      my_disk_usage,
      space_widget,
      volume_widget {
        timeout = 1,
        widget_type = 'icon_and_text'
      },
      space_widget,
      brightness_widget {
        percentage = false,
        type = 'icon_and_text',
        program = 'brightnessctl',
        step = 5
      },
      bat_widget,
      mykeyboardlayout,
      mytextclock,
      wibox.widget.systray(),
    },
  }
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
  awful.key({ modkey, }, "s", hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }),

  -- Awesome wm Keybindings

  awful.key({ modkey, "Control" }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Control" }, "q", awesome.quit,
    { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),

  -- Terminal Applications
  awful.key({ altkey, "Control" }, "c",
    function() awful.spawn.with_shell("alacritty --class tty-clock -e tty-clock -s -b -c",
        { floating = true, ontop = true }) end,
    { description = "Open Clock", group = "Terminal Applications" }),
  awful.key({ altkey, "Control" }, "g",
    function() awful.spawn.with_shell("alacritty --class gotop -e gotop", { floating = true, ontop = true }) end,
    { description = "Open Gotop", group = "Terminal Applications" }),

  -- Notify Applications
  awful.key({ modkey, altkey }, "u",
    function() awful.spawn("/home/thinker/Scripts/notify.sh", { floating = true, ontop = true }) end,
    { description = "Check for updates", group = "Notify Applications" }),

  -- Keyboard
  awful.key({ "Control" }, "F1", function() awful.spawn("setxkbmap us") end,
    { description = "Switch to US keyboard", group = "Keyboard" }),
  awful.key({ "Control" }, "F2", function() awful.spawn("setxkbmap sk") end,
    { description = "Switch to SK keyboard", group = "Keyboard" }),

  -- Brightness
  awful.key({}, "XF86MonBrightnessUp", function() brightness_widget:inc() end,
    { description = "Increase brightness", group = "Brightness" }),
  awful.key({}, "XF86MonBrightnessDown", function() brightness_widget:dec() end,
    { description = "Decrease Brightness", group = "Brightness" }),

  -- Volume

  awful.key({}, "XF86AudioRaiseVolume", function() volume_widget:inc(5) end,
    { description = "Increase volume", group = "Volume" }),
  awful.key({}, "XF86AudioLowerVolume", function() volume_widget:dec(5) end,
    { description = "Decrease volume", group = "Volume" }),
  awful.key({}, "XF86AudioMute", function() volume_widget:toggle() end,
    { description = "Turn on and off volume", group = "Volume" }),

  -- Applications

  awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
    { description = "Open a Alacritty", group = "Programs" }),
  awful.key({ modkey, "Shift" }, "w", function() awful.spawn(browser) end,
    { description = "Open a Brave", group = "Programs" }),
  awful.key({ modkey, "Shift" }, "m", function() awful.spawn(filemanager) end,
    { description = "Open a File Manager", group = "Programs" }),
  awful.key({ modkey, "Shift" }, "d", function() awful.spawn("discord") end,
    { description = "Open a Discord", group = "Programs" }),

  -- PROMPT (rofi)
  awful.key({ modkey }, "r", function()
    local grabber
    grabber =
    awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end

        if key == "r" then awful.spawn.with_shell("/home/thinker/.config/rofi.awesome/launchers/type-4/launcher.sh")
        elseif key == "p" then awful.spawn.with_shell("/home/thinker/.config/rofi.awesome/powermenu/type-1/powermenu.sh")
        elseif key == "n" then awful.spawn.with_shell("/home/thinker/.config/rofi.awesome/applets/bin/rofi-network-manager.sh")
        elseif key == "c" then awful.spawn.with_shell("/home/thinker/.config/rofi.awesome/applets/bin/rofi-calc.sh")
        elseif key == "e" then awful.spawn.with_shell("/home/thinker/.config/rofi.awesome/applets/bin/rofi-configs.sh")
        elseif key == "q" then awful.spawn.with_shell("/home/thinker/.config/rofi.awesome/applets/bin/quicklinks.sh")
        elseif key == "s" then awful.spawn.with_shell("/home/thinker/.config/rofi.awesome/applets/bin/screenshot.sh")
        end
        awful.keygrabber.stop(grabber)
      end
    )
  end,
    { description = "Rofi Menus", group = "Rofi Menus" }
  ),

  -- Client focus keybindings keybindings

  awful.key({ modkey }, "h", function() awful.client.focus.global_bydirection("left") end,
    { description = "Change focus to window in left", group = "client" }),
  awful.key({ modkey }, "j", function() awful.client.focus.global_bydirection("down") end,
    { description = "Change focus to window in left", group = "client" }),
  awful.key({ modkey }, "k", function() awful.client.focus.global_bydirection("up") end,
    { description = "Change focus to window in left", group = "client" }),
  awful.key({ modkey }, "l", function() awful.client.focus.global_bydirection("right") end,
    { description = "Change focus to window in left", group = "client" }),

  -- Client swap keybindings

  awful.key({ modkey, "Shift" }, "h", function() awful.client.swap.global_bydirection("left") end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.global_bydirection("down") end,
    { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.global_bydirection("up") end,
    { description = "swap window with the down window", group = "client" }),
  awful.key({ modkey, "Shift" }, "l", function() awful.client.swap.global_bydirection("right") end,
    { description = "decrease the number of master clients", group = "layout" }),

  -- Window resizing and geometry keybindings
  awful.key({ modkey, "Control" }, "h", function(c)
    if client.floating then
      client:relative_move(0, 0, -10, 0)
    else
      awful.tag.incmwfact(-0.02)
    end
  end,
    { description = "Resize window left", group = "client" }),
  awful.key({ modkey, "Control" }, "j", function(c)
    if client.floating then
      client:relative_move(0, 0, 0, 10)
    else
      awful.client.incwfact(-0.02)
    end
  end,
    { description = "Resize window down", group = "client" }),
  awful.key({ modkey, "Control" }, "k", function(c)
    if client.floating then
      client:relative_move(0, 0, 0, -10)
    else
      awful.client.incwfact(0.02)
    end
  end,
    { description = "Resize window up", group = "client" }),
  awful.key({ modkey, "Control" }, "l", function(c)
    if client.floating then
      client:relative_move(0, 0, 10, 0)
    else
      awful.tag.incmwfact(0.02)
    end
  end,
    { description = "Resize window right", group = "client" }),

  -- Other keybindings

  awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }),
  awful.key({ modkey, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "go back", group = "client" }),

  -- Standard program


  awful.key({ modkey, "Control" }, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal(
          "request::activate", "key.unminimize", { raise = true }
        )
      end
    end,
    { description = "restore minimized", group = "client" })
)

clientkeys = gears.table.join(
  awful.key({ modkey, }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, }, "c", function(c) c:kill() end,
    { description = "close", group = "client" }),
  awful.key({ modkey, "Control" }, "f", awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }),
  awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }),
  awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
    { description = "move to screen", group = "client" }),
  awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }),
  awful.key({ modkey, }, "n",
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    { description = "minimize", group = "client" }),
  awful.key({ modkey, }, "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "(un)maximize", group = "client" }),
  awful.key({ modkey, "Control" }, "m",
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    { description = "(un)maximize vertically", group = "client" }),
  awful.key({ modkey, "Shift" }, "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = {},
    properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA", -- Firefox addon DownThemAll.
      "copyq", -- Includes session name in class.
      "pinentry",
      "tty-clock",
      "gotop",
    },
    class = {
      "Arandr",
      "Gpick",
      "Kruler",
      "MessageWin", -- kalarm.
      "Sxiv",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "Wpa_gui",
      "veromix",
      "xtightvncviewer"
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
    }
  }, properties = { floating = true, placement = awful.placement.centered } },

  -- Set Firefox to always map on the tag named "2" on screen 1.
}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
