-- peikk0's awesome 3 configuration file

-- {{{ Initial stuffs

ostype = io.popen("uname -s"):read()
hostname = io.popen("hostname -s"):read()

-- Call require or fail silently
function require_or_fail(lib)
  result, value = pcall(require, lib)
  if result then
    return value
  else
    return nil
  end
end

-- }}}

-- {{{ Libs

-- Standard awesome library
require("awful")
package.path  = awful.util.getdir("config") .. '/lib/?.lua;' .. package.path
package.cpath = awful.util.getdir("config") .. '/lib/?.so;' .. package.cpath
-- Autofocus library
require("awful.autofocus")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- MPD library
mpd = require_or_fail("mpd")
-- FreeBSD's sysctl library
if ostype == "FreeBSD" then
  sysctl = require_or_fail("sysctl")
end
-- Lua filesystem library
if ostype == "Linux" then
  lfs = require_or_fail("lfs")
end

-- }}}

-- {{{ Variable definitions

-- {{{ Paths

home       = os.getenv("HOME")
config_dir = awful.util.getdir("config")
themes_dir = config_dir .. "/themes/"

-- }}}

-- {{{ Theme

theme      = "akoya"
theme_path = themes_dir .. "/" .. theme .. ".lua"
beautiful.init(theme_path)

-- }}}

-- {{{ Programs

terminal      = "x-terminal-emulator"
terminal_exec = terminal .. " -e "
editor        = "vim"
editor_cmd    = terminal_exec .. editor
im            = "gajim"
-- xlock         = "xset dpms force off ; xtrlock"
xlock         = "xscreensaver-command -lock"
browser       = "sensible-browser"
mail          = terminal_exec .. "mutt"
xmail         = "thunderbird"
if ostype == "FreeBSD" then
  mixer_chan  = "pcm"
  mixer       = "mixer " .. mixer_chan .. " "
  sound_down  = mixer .. "-2"
  sound_up    = mixer .. "+2"
  sound_mute  = "mute" -- mute comes from aumix package
elseif ostype == "Linux" then -- Gentoo
  mixer_chan  = "Master"
  mixer       = "amixer -q set " .. mixer_chan .. " "
  sound_down  = mixer .. "2-"
  sound_up    = mixer .. "2+"
  sound_mute  = mixer .. "toggle"
end

if hostname == 'korriban' then
  setup_mono  = "xrandr --output LVDS --auto --output TMDS-1 --off"
  setup_dual  = "xrandr --output LVDS --auto --output TMDS-1 --auto --right-of LVDS"
elseif hostname == 'alderaan' then
  setup_mono  = "xrandr --output DVI-I-2 --auto --output DVI-I-3 --off"
  setup_dual  = "xrandr --output DVI-I-2 --auto --output DVI-I-3 --auto --right-of DVI-I-2"
else
  setup_mono  = ""
  setup_dual  = ""
end

-- }}}

-- {{{ MPD clients

if mpd then
  mpds = {
    add      = function (self, c) table.insert(self.list, c) end,
    current  = function (self) return self.list[self.current_idx] end,
    next     = function (self) self.current_idx = math.fmod(self.current_idx, #self.list) + 1; end,
    previous = function (self) self.current_idx = math.fmod(self.current_idx - 1, #self.list); if self.current_idx <= 0 then self.current_idx = #self.list end end,
    -- private stuff
    list        = { mpd.new({ desc = 'local', retry = 10 }) }, -- one (local) server by default
    current_idx = 1
  }
  if hostname ~= 'alderaan' then
    mpds:add(mpd.new { hostname = 'alderaan.home.poildetroll.net', desc = 'alderaan', retry = 10 })
  end
end

-- }}}

-- {{{ Naughty

if naughty then
  naughty.config.presets.normal.screen = screen.count()
  naughty.config.presets.normal.fg = beautiful.naughty_fg
  naughty.config.presets.normal.bg = beautiful.naughty_bg
  naughty.config.presets.critical.bg = beautiful.naughty_bg
  naughty.config.presets.critical.fg = beautiful.naughty_cri
end

-- }}}

-- {{{ Layouts

layouts =
{
  awful.layout.suit.tile,            -- 1
  awful.layout.suit.tile.left,       -- 2
  awful.layout.suit.tile.bottom,     -- 3
  awful.layout.suit.tile.top,        -- 4
  awful.layout.suit.fair,            -- 5
  awful.layout.suit.fair.horizontal, -- 6
  awful.layout.suit.max,             -- 7
  awful.layout.suit.max.fullscreen,  -- 8
  awful.layout.suit.floating         -- 9
}

layouts_abbr =
{
  ["tile"]       = "TR",
  ["tileleft"]   = "TL",
  ["tilebottom"] = "TB",
  ["tiletop"]    = "TT",
  ["fairv"]      = "FV",
  ["fairh"]      = "FH",
  ["max"]        = "MX",
  ["fullscreen"] = "FS",
  ["floating"]   = "FL"
}

-- }}}

-- {{{ Tags

gold_number    = 0.618033988769
default_mwfact = gold_number

tags_name   = { "foo", "bar", "baz", "qux", "quux", "corge", "grault", "garply", "waldo", "fred", "plugh", "xyzzy", "thud" }

-- }}}

-- {{{ Floating clients and clients tagging

floatapps =
{
  ['feh'] = true,
  ['gimp'] = true,
  ["MPlayer"] = true,
  ["mplayer2"] = true,
  ["pinentry"] = true,
  ["pinentry-gtk-2"] = true,
  ["plugin-container"] = true,
  ['SDL_App'] = true,
  ['sonata'] = true,
  ['wpa_gui'] = true,
  ['xine'] = true
}

apptags =
{
}

-- }}}

-- {{{ Keys

modkey = "Mod4"
k_n    = {}
k_m    = { modkey }
k_ms   = { modkey, "Shift" }
k_ma   = { modkey, "Alt" }
k_mc   = { modkey, "Control" }
k_mcs  = { modkey, "Control", "Shift" }
k_a    = { "Alt" }
k_ac   = { "Alt", "Control" }
k_as   = { "Alt", "Shift" }
k_c    = { "Control" }
k_cs   = { "Control", "Shift" }
k_s    = { "Shift" }

-- }}}

-- }}}

-- {{{ Functions

-- {{{ Utils

-- Set background color
function bg(color, text)
  return '<bg color="' .. color .. '" />' .. text
end

-- Set foreground color
function fg(color, text)
  return '<span color="' .. color .. '">' .. text .. '</span>'
end

-- Boldify text
function bold(text)
  return '<b>' .. text .. '</b>'
end

-- Mono font
function mono(text)
  return '<span font_desc=">' .. beautiful.font_mono .. '">' .. text .. '</span>'
end

-- Widget base
function widget_base(content)
  if content and content ~= "" then
    return fg(beautiful.text_hilight, " [ ") .. content .. fg(beautiful.text_hilight, " ] ")
  end
end

-- Widget section
function widget_section(label, content, next_section)
  local section
  if content and content ~= nil then
    if label and label ~= "" then
      section = bold(label .. ": ") .. content
    else
      section = content
    end
    if next_section and next_section ~= "" then
      section = section .. fg(beautiful.text_hilight, " | ") .. next_section
    end
  else
    section = next_section
  end
  return section
end

-- Widget value
function widget_value(content, next_value)
  local value
  if content and content ~= nil then
    value = content
    if next_value and next_value ~= "" then
      value = value .. fg(beautiful.text_hilight, ", ") .. next_value
    end
  else
    value = next_value
  end
  return value
end

-- Call sysctl.get() and return the value,
-- or return nil if any error happens
function sysctl_get(key)
  -- Ensure sysctl module is loaded
  if sysctl then
    result, value, type = pcall(sysctl.get, key)
    if result then
      return value
    else
      return nil
    end
  else
    return nil
  end
end

-- Read the first line of a file
function readline(file)
  local f = io.open(file, "r")
  if f ~= nil then
    local c = f:read("*l")
    f:close()
    return c
  else
    return nil
  end
end

-- }}}

-- {{{ Widgets

-- Just a clock, %d/%m/%Y %H:%M:%S
function widget_clock()
  return widget_base(os.date("%a %b %d %Y, " .. bold("%H:%M:%S")))
end

-- Get and format MPD status
-- (need the mpd lib for lua)
function widget_mpd()
  local function timeformat(t)
    if tonumber(t) >= 60 * 60 then -- more than one hour !
      return os.date("!%H:%M:%S", t)
    else
      return os.date("!%M:%S", t)
    end
  end

  local function unknownize(x)
    return awful.util.escape(x or "(unknown)")
  end

  local current_time, location, now_playing, state, status, times, total_time, volume

  if mpd then
    location = unknownize(mpds:current().desc)
    local status = mpds:current():send("status")

    if not status.state then
      state = "not running?"
    elseif status.state == "stop" then
      state = "stopped"
    else
      local song_stats = mpds:current():send("playlistid " .. status.songid)
      now_playing = string.format("%s - %s - %s",
          unknownize(song_stats.artist), unknownize(song_stats.album), unknownize(song_stats.title))

      if status.state == "play" then
        state = "playing"
      else
        state = 'paused'
      end

      current_time = timeformat(status.time:match("(%d+):"))
      total_time   = timeformat(status.time:match("%d+:(%d+)"))

      times = string.format("%s/%s", current_time, total_time)
    end

    if status.volume then
      volume = status.volume .. "%"
    end
  end

  return widget_base(
          widget_section("MPD", location,
          widget_section("State", state,
          widget_section("Track", now_playing,
          widget_section("Time", times,
          widget_section("Vol.", volume))))))
end

-- Get and format ACPI informations
function widget_acpi()
  local function urgent(text)
    if text then
      return bold(fg(beautiful.battery_low, text))
    else
      return nil
    end
  end

  if hostname == 'alderaan' then
    return widget_base('')
  end

  local acline, life, temp, time
  local ac_status, bat_status, bat_time, temp_status

  if ostype == "FreeBSD" and sysctl then

    life   = sysctl_get("hw.acpi.battery.life")
    temp   = sysctl_get("hw.acpi.thermal.tz0.temperature")
    acline = sysctl_get("hw.acpi.acline")

    if life then
      bat_status = life .. '%'
    end

    if acline == 1 then
      ac_status = 'on'
    else
      ac_status = 'off'
      if life and life ~= 100 then
        time  = sysctl_get("hw.acpi.battery.time")
        if time then
          bat_time = os.date("!%Hh %Mm", time * 60)
        end
        if life < 10 then
          bat_status = urgent(bat_status)
          bat_time   = urgent(bat_time)
        end
      end
    end

    if temp then
      temp = (temp - 2732.0) / 10
      temp_status = temp .. '°C'
      if temp >= 80 then
        temp_status = urgent(temp_status)
      end
    end

  elseif ostype == "Linux" and lfs then

    local power_path   = "/sys/class/power_supply"
    -- local thermal_path = "/sys/class/thermal"
    local coretemp_path = "/sys/devices/platform/coretemp.0"
    local attr, file, dev_path
    local battery, bat_charge_full, bat_charge_now, bat_current_now

    for file in lfs.dir(power_path) do
      dev_path = power_path .. "/" .. file
      attr = lfs.attributes(dev_path)
      assert(type(attr) == "table")
      if attr.mode == "directory" then
        if file:find("^AC") then
          -- AC status
          acline = readline(dev_path  .. "/online")
          if acline == "1" then
            ac_status = "on"
          elseif acline == "0" then
            ac_status = "off"
          end
          -- if ac is nil (because the file would be missing?), nothing is set and it's fine
        elseif file:find("^BAT") then
          -- Battery status
          battery = readline(dev_path  .. "/status")
          if battery then
            bat_charge_full = readline(dev_path .. "/charge_full") / 1000
            bat_charge_now  = readline(dev_path .. "/charge_now") / 1000
            bat_current_now = math.abs(readline(dev_path .. "/current_now")) / 1000
            life            = math.min(100, 100 * bat_charge_now / bat_charge_full)
            bat_status      = string.format("%.2f%%", life)
            if battery == "Charging" then
              time = 3600 * (bat_charge_full - bat_charge_now) / bat_current_now
            elseif battery == "Discharging" then
              time = 3600 * bat_charge_now / bat_current_now
            end
            if time then
              bat_time = os.date("!%Hh %Mm", time)
            end
            if life < 10 and battery == "Discharging" then
              bat_status = urgent(bat_status)
              bat_time   = urgent(bat_time)
            end
          end
        end
      end
    end

    -- Temp status
    -- for file in lfs.dir(thermal_path) do
    --   if file == "thermal_zone0" then
    --     dev_path = thermal_path .. "/" .. file
    --     attr = lfs.attributes (dev_path)
    --     assert(type(attr) == "table")
    --     if attr.mode == "directory" then
    --       temp = readline(dev_path .. "/temp")
    --       if temp then
    --         temp_status = temp / 1000 .. '°C'
    --       end
    --     end
    --   end
    -- end
    for file in lfs.dir(coretemp_path) do
      if file == "temp1_input" then
        temp = readline(coretemp_path .. "/" .. file)
        if temp then
          temp_status = temp / 1000 .. '°C'
        end
      end
    end

  end

  return widget_base(
          widget_section("AC", ac_status,
          widget_section("Bat.", widget_value(bat_status, bat_time),
          widget_section("T°", temp_status))))
end

-- A widget displaying system stats
local cpu_times_old
function widget_sys()

  local function pages_to_bytes(pages, pagesize)
    local mem
    mem = (pages * pagesize) / (1024.0 * 1024.0)
    return string.format("%.2f", mem)
  end

  local function percentages(times, times_old)
    local i, j, change, diffs, out, total_changes
    total_change = 0
    diffs = {}
    out = {}
    for i = 1, #times do
      change = times[i] - times_old[i]
      diffs[i] = change
      total_change = total_change + change
    end
    -- avoid divide by zero
    if not total_change then
      total_change = 1
    end
    if total_change then
      for j = 1, #times do
        out[j] = (diffs[j] * 100) / total_change
      end
    end
    return out
  end

  local i, j, boottime, freq, lastpid, loadavg, uptime, vm
  local cpu_percentages, cpu_times, cpu_times_sub, cpu_times_old_sub, per_cpu_times
  local pagesize, active_pages, total_pages
  local cpu_text, freq_text, load_text, mem_text, pid_text, proc_text, uptime_text

  -- Continue only if sysctl is loaded
  if sysctl then

    -- CPU usage
    -- user, nice, system, interrupt, idle
    cpu_times = sysctl_get("kern.cp_times")
    if cpu_times then
      if cpu_times_old then
        per_cpu_times = {}
        for i = 0, #cpu_times / 5 - 1 do
          -- no point in doing a loop here
          cpu_times_sub = {
            cpu_times[i*5+1],
            cpu_times[i*5+2],
            cpu_times[i*5+3],
            cpu_times[i*5+4],
            cpu_times[i*5+5],
          }
          cpu_times_old_sub = {
            cpu_times_old[i*5+1],
            cpu_times_old[i*5+2],
            cpu_times_old[i*5+3],
            cpu_times_old[i*5+4],
            cpu_times_old[i*5+5],
          }
          cpu_percentages = percentages(cpu_times_sub, cpu_times_old_sub)
          -- cumulate all times but idle
          per_cpu_times[i+1] = cpu_percentages[1] + cpu_percentages[2] + cpu_percentages[3] + cpu_percentages[4]
        end
        for j = #per_cpu_times, 1, -1 do
          cpu_text = widget_value(string.format("%.1f%%", per_cpu_times[j]), cpu_text)
        end
      end
      cpu_times_old = cpu_times
    end

    -- Uptime
    boottime = sysctl_get("kern.boottime")
    if boottime then
      uptime = os.difftime(os.time(), boottime.sec)
      uptime_text = os.date("!%H:%M", uptime)
      days = uptime / (3600 * 24)
      if days >= 1 then
        uptime_text = string.format("%id ", days) .. uptime_text
      end
    end

    -- CPU frequency
    freq = sysctl_get("dev.cpu.0.freq")
    if freq then
      if freq < 1000 then
        freq_text = freq .. ' Mhz'
      else
        freq_text = freq / 1000 .. ' Ghz'
      end
    end

    -- VM
    vm = sysctl_get("vm.vmtotal")
    if vm then
      proc_text = widget_value(vm['rq'],
                  widget_value(vm['dw'],
                  widget_value(vm['pw'],
                  widget_value(vm['sl']))))
    end
    pagesize = sysctl_get("vm.stats.vm.v_page_size")
    active_pages = sysctl_get("vm.stats.vm.v_active_count")
    total_pages  = sysctl_get("vm.stats.vm.v_page_count")
    if pagesize then
      if active_pages and total_pages then
        mem_text = pages_to_bytes(active_pages, pagesize) .. ' / ' .. pages_to_bytes(total_pages, pagesize) .. ' MiB'
      end
    end

    -- PID
    lastpid = sysctl_get("kern.lastpid")
    if lastpid then
      pid_text = lastpid
    end

    -- Load average
    loadavg = sysctl_get("vm.loadavg")
    if loadavg then
      for i, l in ipairs(loadavg) do
        load_text = widget_value(load_text, string.format("%.2f", l))
      end
    end

  end

  return widget_base(
          widget_section("CPU", cpu_text,
          widget_section("Freq", freq_text,
          widget_section("Proc", proc_text,
          widget_section("Mem", mem_text,
          widget_section("Load", load_text,
          widget_section("Uptime", uptime_text)))))))
--          widget_section("Last PID", pid_text))))))))
end

-- Return abbreviation for the given layout
function layout_abbr(layout)
  if layout then
    abbr = layouts_abbr[layout]
    if not abbr then
      abbr = "?"
    end
  else
    abbr = "x"
  end
  return widget_base(mono(abbr))
end

-- }}}

-- }}}

-- {{{ Tags

-- Define tags table
tags = {}
for s = 1, screen.count() do
  -- Each screen has its own tag table
  tags[s] = {}
  -- Create all tags on each screen
  for id, name in ipairs(tags_name) do
    tags[s][id] = tag { name = name }
    -- Add tags to screen one by one
    tags[s][id].screen = s
    awful.layout.set(layouts[1], tags[s][id])
    awful.tag.setmwfact(default_mwfact, tags[s][id])
  end
  -- I'm sure you want to see at least one tag.
  tags[s][1].selected = true
end

-- }}}

-- {{{ Wibox

-- {{{ Clock widget

clockbox = widget({ type = "textbox", align = "left" })
clockbox.text = widget_clock()

-- }}}

-- {{{ MPD widget

mpdbox = widget({ type = "textbox", align = "right" })
mpdbox.text = ""

-- }}}

-- {{{ ACPI widget

acpibox = widget({ type = "textbox", align = "right" })
acpibox.text = ""

-- }}}

-- {{{ System widget

sysbox = widget({ type = "textbox", align = "left" })
sysbox.text = ""

-- }}}

-- {{{ And the wibox itself

-- Create a wibox for each screen and add it
witop = {}
wibottom = {}

-- Prompt box
mypromptbox = {}

-- Layout box
mylayoutbox = {}

-- Tag list
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button(k_n, 1, awful.tag.viewonly),
                    awful.button(k_m, 1, awful.client.movetotag),
                    awful.button(k_n, 3, awful.tag.viewtoggle),
                    awful.button(k_m, 3, awful.client.toggletag)
                    )

function mytaglist.label_custom(t, args)
  if not args then args = {} end
  local theme = beautiful.get()
  local fg_focus = args.fg_focus or theme.taglist_fg_focus or theme.fg_focus
  local bg_focus = args.bg_focus or theme.taglist_bg_focus or theme.bg_focus
  local fg_urgent = args.fg_urgent or theme.taglist_fg_urgent or theme.fg_urgent
  local bg_urgent = args.bg_urgent or theme.taglist_bg_urgent or theme.bg_urgent
  local bg_color = nil
  local fg_color = nil

  local text = awful.util.escape(t.name)

  local sel = client.focus
  local cls = t:clients()

  if t.selected then
    bg_color = bg_focus
    fg_color = fg_focus
  end

  if not sel or not sel:tags()[t] then
    for k, c in pairs(t:clients()) do
      if c.urgent and not t.selected then
        if bg_urgent then bg_color = bg_urgent end
        if fg_urgent then fg_color = fg_urgent end
        break
      end
    end
  end

  if #cls > 0 then
    text = bold(text)
  end

  if bg_color and fg_color then
    text = fg(fg_color, text)
  end
  text = " " .. text .. " "
  return text, bg_color, nil, nil

end

for s = 1, screen.count() do
  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })

  -- Create one layoutbox per screen.
  mylayoutbox[s] = widget({ type = "textbox", align = "left" })
  mylayoutbox[s]:buttons(awful.util.table.join(
                          awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                          awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end)
                          ))

  -- Create a taglist widget
  mytaglist[s] = awful.widget.taglist(s, mytaglist.label_custom, mytaglist.buttons)

  -- Create wiboxes
  witop[s]    = awful.wibox({ position = "top",    screen = s, height = beautiful.wibox_height, fg = beautiful.fg_normal, bg = beautiful.bg_normal })
  wibottom[s] = awful.wibox({ position = "bottom", screen = s, height = beautiful.wibox_height, fg = beautiful.fg_normal, bg = beautiful.bg_normal })

  -- Add widgets to wiboxes - order matters
  witop[s].widgets = {
    {
      clockbox,
      mytaglist[s],
      mylayoutbox[s],
      mypromptbox[s],
      layout = awful.widget.layout.horizontal.leftright
    },
    mpdbox,
    layout = awful.widget.layout.horizontal.rightleft
  }

  wibottom[s].widgets = {
    {
      sysbox,
      layout = awful.widget.layout.horizontal.leftright
    },
    acpibox,
    layout = awful.widget.layout.horizontal.rightleft
  }
end

-- }}}

-- }}}

-- {{{ Mouse bindings

root.buttons(awful.util.table.join(
  awful.button(k_n, 3, function ()  awful.util.spawn(terminal) end)
))

clientbuttons = awful.util.table.join(
  awful.button(k_n, 1, function (c) client.focus = c; c:raise() end),
  awful.button(k_m, 1, awful.mouse.client.move),
  awful.button(k_m, 3, awful.mouse.client.resize)
)

-- }}}

-- {{{ Key bindings

globalkeys = awful.util.table.join(

-- {{{ Awesome quit/restart

  awful.key(k_mc, "r", awesome.restart),
  awful.key(k_ms, "q", awesome.quit),

-- }}}

-- {{{ Tags

  awful.key(k_m, "Left", awful.tag.viewprev),
  awful.key(k_m, "Prior", awful.tag.viewprev),
  awful.key(k_m, "Right", awful.tag.viewnext),
  awful.key(k_m, "Next", awful.tag.viewnext),
  awful.key(k_m, "Escape", awful.tag.history.restore),

-- }}}

-- {{{ Client manipulation, global part

  awful.key(k_m,  "j",   function () awful.client.focus.byidx( 1); if client.focus then client.focus:raise() end end),
  awful.key(k_m,  "k",   function () awful.client.focus.byidx(-1); if client.focus then client.focus:raise() end end),
  awful.key(k_ms, "j",   function () awful.client.swap.byidx( 1) end),
  awful.key(k_ms, "k",   function () awful.client.swap.byidx(-1) end),
  awful.key(k_mc, "j",   function () awful.screen.focus_relative( 1) end),
  awful.key(k_mc, "k",   function () awful.screen.focus_relative(-1) end),
  awful.key(k_m,  "u",   awful.client.urgent.jumpto),
  awful.key(k_m,  "Tab", function () awful.client.focus.history.previous() if client.focus then client.focus:raise() end end),

-- }}}

-- {{{ Layout manipulation

  awful.key(k_m, "l",      function () awful.tag.incmwfact( 0.05) end),
  awful.key(k_m, "h",      function () awful.tag.incmwfact(-0.05) end),
  awful.key(k_ms, "h",     function () awful.tag.incnmaster( 1) end),
  awful.key(k_ms, "l",     function () awful.tag.incnmaster(-1) end),
  awful.key(k_mc, "h",     function () awful.tag.incncol( 1) end),
  awful.key(k_mc, "l",     function () awful.tag.incncol(-1) end),
  awful.key(k_m,  "space", function () awful.layout.inc(layouts,  1) end),
  awful.key(k_ms, "space", function () awful.layout.inc(layouts, -1) end),

-- }}}

-- {{{ Programs

  awful.key(k_m,  "Return", function () awful.util.spawn(terminal) end),
  awful.key(k_m,  "b",      function () awful.util.spawn(browser) end),
  awful.key(k_m,  "e",      function () awful.util.spawn(editor_cmd) end),
  awful.key(k_m,  "m",      function () awful.util.spawn(mail) end),
  awful.key(k_ms, "m",      function () awful.util.spawn(xmail) end),
  awful.key(k_m,  "i",      function () awful.util.spawn(im) end),
  awful.key(k_mc, "End",    function () awful.util.spawn(xlock) end),
  awful.key(k_ms, "F5",     function () awful.util.spawn(setup_mono) end),
  awful.key(k_ms, "F6",     function () awful.util.spawn(setup_dual) end),

-- }}}

-- {{{ Mixer & MPD controls

  -- awful.key(k_n, "XF86AudioLowerVolume", function () awful.util.spawn(sound_down) end),
  -- awful.key(k_m, "F7", function () awful.util.spawn(sound_down) end),
  -- awful.key(k_n, "XF86AudioRaiseVolume", function () awful.util.spawn(sound_up) end),
  -- awful.key(k_m, "F8", function () awful.util.spawn(sound_up) end),
  awful.key(k_n, "XF86AudioLowerVolume", function () mpds:current():volume_down(2) end),
  awful.key(k_n, "XF86AudioRaiseVolume", function () mpds:current():volume_up(2) end),
  awful.key(k_m, "F7",                   function () mpds:current():volume_down(2) end),
  awful.key(k_m, "F8",                   function () mpds:current():volume_up(2) end),
  -- awful.key(k_n, "XF86AudioMute", function () awful.util.spawn(sound_mute) end),
  -- awful.key(k_m, "F6", function () awful.util.spawn(sound_mute) end),
  -- awful.key(k_n, "XF86AudioPlay", function () mpd:previous() end),
  -- awful.key(k_n, "XF86AudioStop", function () mpd:stop() end),
  -- awful.key(k_n, "XF86AudioPrev", function () mpd.toggle_play() end),
  -- awful.key(k_n, "XF86AudioNext", function () mpd:next() end),
  awful.key(k_m, "F9",   function () mpds:current():previous() end),
  awful.key(k_m, "F10",  function () mpds:current():stop() end),
  awful.key(k_m, "F11",  function () mpds:current():toggle_play() end),
  awful.key(k_m, "F12",  function () mpds:current():next() end),
  awful.key(k_ms, "F9",  function () mpds:previous() end),
  awful.key(k_ms, "F12", function () mpds:next() end),

-- }}}

-- {{{ Prompts

  awful.key(k_m, "F1", function () mypromptbox[mouse.screen]:run() end),
  awful.key(k_m, "F2", function ()
      awful.prompt.run({ prompt = "Open URL: " },
      mypromptbox[mouse.screen].widget,
      function (url)
          local result = awful.util.spawn(browser .. " " .. url)
          if type(result) == "string" then
              promptbox.widget.text = result
          end
      end,
      nil,
      awful.util.getdir("cache") .. "/history_url")
    end),

  awful.key(k_m, "F4", function ()
      awful.prompt.run({ prompt = "Run Lua code: " },
      mypromptbox[mouse.screen].widget,
      awful.util.eval, nil,
      awful.util.getdir("cache") .. "/history_eval")
    end)

-- }}}

)

-- {{{ Client manipulation, client part)

clientkeys = awful.util.table.join(
  awful.key(k_ms, "f",      function (c) c.fullscreen = not c.fullscreen  end),
  awful.key(k_ms, "c",      function (c) c:kill() end),
  awful.key(k_mc, "space",  awful.client.floating.toggle),
  awful.key(k_mc, "Return", function (c) c:swap(awful.client.getmaster()) end),
  awful.key(k_m,  "o",      awful.client.movetoscreen),
  awful.key(k_ms, "r",      function (c) c:redraw() end),
  awful.key(k_ms, "m",      function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical   = not c.maximized_vertical
    end)
)

-- }}}


-- {{{ Assign keys for each tag

-- Bind keyboard digits
-- Compute the maximum number of digit we need, limited to 13
keynumber = 0
for s = 1, screen.count() do
  keynumber = math.min(13, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
  if i == 11 then
    k = "minus"
  elseif i == 12 then
    k = "equal"
  elseif i == 13 then
    k = "backslash"
  else
    k = i % 10 -- 10 become 0
  end
  globalkeys = awful.util.table.join(globalkeys,
    awful.key(k_m, k,
      function ()
        local screen = mouse.screen
        if tags[screen][i] then
          awful.tag.viewonly(tags[screen][i])
        end
      end),
    awful.key(k_mc, k,
      function ()
        local screen = mouse.screen
        if tags[screen][i] then
          awful.tag.viewtoggle(tags[screen][i])
        end
      end),
    awful.key(k_ms, k,
      function ()
        if client.focus and tags[client.focus.screen][i] then
          awful.client.movetotag(tags[client.focus.screen][i])
        end
      end),
    awful.key(k_mcs, k,
      function ()
        if client.focus and tags[client.focus.screen][i] then
          awful.client.toggletag(tags[client.focus.screen][i])
        end
      end))
end

-- }}}

-- Set keys
root.keys(globalkeys)

-- }}}

-- {{{ Signals

-- Signal function to execute when focusing a client.
client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)

-- Signal function to execute when unfocusing a client.
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
  -- Set mouse bindings
  c:buttons(clientbuttons)

  -- Set key bindings
  c:keys(clientkeys)

  -- New client may not receive focus
  -- if they're not focusable, so set border anyway.
  c.border_width = beautiful.border_width
  c.border_color = beautiful.border_normal

  -- Honor size hints
  c.size_hints_honor = true

  -- Check if the application should be floating.
  local cls = c.class
  local inst = c.instance
  if floatapps[cls] then
    awful.client.floating.set(c, floatapps[cls])
  elseif floatapps[inst] then
    awful.client.floating.set(c, floatapps[inst])
  end

  -- Check application->screen/tag mappings.
  local target, screen
  if apptags[cls] then
    target = apptags[cls]
  elseif apptags[inst] then
    target = apptags[inst]
  end
  if target then
    if target.screen then
      screen = target.screen
    else
      screen = mouse.screen
    end
    c.screen = screen
    if target.tag then
      awful.client.movetotag(tags[screen][target.tag], c)
    else
      awful.client.movetoscreen(c, screen)
    end
  end

  -- Enable sloppy focus
  c:add_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
      and awful.client.focus.filter(c) then
      client.focus = c
    end
  end)

  if not startup then
    -- Put windows in a smart way, only if they does not set an initial position.
    if not c.size_hints.user_position and not c.size_hints.program_position then
      awful.placement.no_overlap(c)
      awful.placement.no_offscreen(c)
    end
  end

  -- Apply tags.
  awful.tag.withcurrent(c, startup)

  -- Do this after tag mapping, so you don't see it on the wrong tag for a split second.
  client.focus = c

end)

-- Signal function to execute when switching layout.
for s = 1, screen.count() do
  local function update_layoutbox(tag)
    mylayoutbox[tag.screen].text = layout_abbr(awful.layout.getname(awful.layout.get(tag.screen)))
  end
  awful.tag.attached_add_signal(s, "property::selected", update_layoutbox)
  awful.tag.attached_add_signal(s, "property::layout", update_layoutbox)
end

-- Timer updating clock and mpd widgets every 0.2 second
clock_timer = timer { timeout = 0.2 }
clock_timer:add_signal("timeout", function ()
  clockbox.text = widget_clock()
  mpdbox.text = widget_mpd()
end)
clock_timer:start()

-- Timer updating acpi and system widgets every 2 seconds
sys_timer = timer { timeout = 2 }
sys_timer:add_signal("timeout", function ()
  acpibox.text = widget_acpi()
  sysbox.text  = widget_sys()
end)
sys_timer:start()

-- }}}

-- vim:filetype=lua:tabstop=8:shiftwidth=2:fdm=marker:
