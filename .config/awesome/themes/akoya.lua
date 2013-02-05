-------------------------
-- Akoya awesome theme --
-------------------------

require("awful")

theme = {}

theme.font          = "Dejavu Sans 8"
theme.font_mono     = "Dejavu Sans Mono 8"

theme.bg_normal     = "#111111"
theme.bg_focus      = "#aacc88"
theme.bg_urgent     = "#111111"

theme.fg_normal     = "#cccccc"
theme.fg_focus      = "#000000"
theme.fg_urgent     = "#cc7766"

theme.border_width  = "1"
theme.border_normal = "#111111"
theme.border_focus  = "#333333"

theme.naughty_fg    = "#aacc88"
theme.naughty_bg    = "#222222"
theme.naughty_cri   = "#cc7766"

theme.battery_low   = "#ff4444"

theme.text_hilight  = "#aacc88"

theme.wibox_height  = "14"

themes_dir = awful.util.getdir("config") .. "/themes/"
wallpaper_mono = themes_dir .. "wallpaper-mono"
wallpaper_dual = themes_dir .. "wallpaper-dual"

if screen.count() > 1 then
  theme.wallpaper_cmd = { "awsetbg " .. wallpaper_dual }
else
  theme.wallpaper_cmd = { "awsetbg " .. wallpaper_mono }
end

return theme

-- vim:filetype=conf:tabstop=8:shiftwidth=2:fdm=marker:
