local vars = require("variables")
require("hypr-unbinds")

-- Grayscale config
hl.config({
    decoration = {
        -- screen_shader = "~/.config/caelestia/grayscale.glsl",
        screen_shader = "",
    },
})

-- Custom execs
hl.on("hyprland.start", function()
    -- Auto-Start setup
    hl.exec_cmd("sleep 2 && caelestia shell lock lock")
    -- hl.exec_cmd("/home/chujo/.config/caelestia/scripts/start-keyring.sh")
    hl.exec_cmd("wluma -c ~/.config/wluma/config.toml")
    hl.exec_cmd("arch-update --tray")
    hl.exec_cmd("/home/chujo/.config/caelestia/scripts/launch_overview.sh")
    hl.exec_cmd("/home/chujo/.config/caelestia/scripts/copy.sh")
end)

-- Monitor Setup
hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "auto",
    scale = "1.33",
})

hl.monitor({
    output = "DP-3",
    mode = "preferred",
    position = "auto-left",
    scale = "1",
})

-- Gestures
hl.gesture({
    fingers = vars.gestureFingers,
    direction = "up",
    action = function()
        hl.exec_cmd("caelestia shell hypr cycleSpecialWorkspace prev")
    end,
})

hl.gesture({
    fingers = vars.gestureFingers,
    direction = "up",
    mods = "ALT + SHIFT",
    action = function()
        hl.dispatch(hl.dsp.window.move({ workspace = "special:special" }))
    end,
})

hl.gesture({
    fingers = vars.gestureFingers,
    direction = "down",
    mods = "ALT + SHIFT",
    action = function()
        hl.dispatch(hl.dsp.window.move({ workspace = "e+0" }))
    end,
})

hl.gesture({
    fingers = vars.gestureFingers,
    direction = "swipe",
    action = "move",
})

hl.gesture({
    fingers = vars.gestureFingersMore,
    direction = "pinch",
    action = "float",
})

hl.gesture({
    fingers = vars.gestureFingersMore,
    direction = "up",
    action = function()
        hl.exec_cmd("qs ipc -c overview call overview toggle")
    end,
})

hl.gesture({
    fingers = vars.gestureFingersMore,
    direction = "down",
    action = function()
        hl.exec_cmd("qs ipc -c overview call overview toggle")
    end,
})

-- Keyboard Input
hl.config({ input = {
    kb_layout = "us,ca",
    kb_options = "grp:win_space_toggle",
} })

-- Custom Keybinds
-- Closing lid
-- When the lid is CLOSED (Switch turns ON)
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("/home/chujo/.config/caelestia/scripts/lid-dpms.sh"), {
    locked = true,
})

-- When the lid is OPENED (Switch turns OFF)
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("/home/chujo/.config/caelestia/scripts/lid-dpms.sh"), {
    locked = true,
})

hl.bind("CTRL + ALT + SUPER + R", hl.dsp.exec_cmd("/home/chujo/.config/caelestia/scripts/reload_caelestia.sh"))

hl.bind("SUPER + ALT + RIGHT", hl.dsp.window.move({ workspace = "+1" }))
hl.bind("SUPER + ALT + LEFT", hl.dsp.window.move({ workspace = "-1" }))

hl.bind("SUPER + TAB", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"))

hl.bind("CTRL + SUPER + UP", hl.dsp.exec_cmd("caelestia shell hypr cycleSpecialWorkspace prev"))
hl.bind("CTRL + SUPER + DOWN", hl.dsp.exec_cmd("caelestia shell hypr cycleSpecialWorkspace next"))

-- Bind for the grayscale toggle
hl.bind("SUPER + F12", function()
    local shader = hl.get_config("decoration.screen_shader")
    if shader == "" or shader == "[[EMPTY]]" then
        hl.exec_cmd(
            [[hyprctl eval 'hl.config({ decoration = { screen_shader = "]]
                .. os.getenv("HOME")
                .. [[/.config/caelestia/grayscale.glsl" } })']]
        )
    else
        hl.exec_cmd([[hyprctl eval 'hl.config({ decoration = { screen_shader = "" } })']])
    end
end)

-- Scrolling layout fit active window
hl.bind("SUPER + ALT + X", hl.dsp.layout("fit active"))

-- Monocle keybinds
hl.bind("SUPER + UP", hl.dsp.layout("cyclenext"))
hl.bind("SUPER + DOWN", hl.dsp.layout("cycleprev"))

-- Workspace keybinds
hl.bind(vars.kbSteamWs, hl.dsp.exec_cmd("caelestia toggle steam"))
hl.bind(vars.kbOnTogetherWs, hl.dsp.exec_cmd("caelestia toggle on_together"))

-- Utilities keybinds
hl.bind(vars.kbSettings, hl.dsp.exec_cmd("caelestia shell nexus open"))
hl.bind(vars.kbKeepAwake, hl.dsp.exec_cmd("caelestia shell idleInhibitor toggle"))
hl.bind(vars.kbRandomWallpaper, hl.dsp.exec_cmd("caelestia wallpaper -r"))
hl.bind("SUPER + SHIFT + A", hl.dsp.exec_cmd("/home/chujo/.config/caelestia/scripts/snip_to_search.sh"))
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("/home/chujo/.config/caelestia/scripts/snip_to_select.sh"))
hl.bind("SUPER + SHIFT + CTRL + S", hl.dsp.global("caelestia:screenshotFreezeClip"))
hl.bind("SUPER + SHIFT + S", hl.dsp.global("caelestia:screenshotFreeze"))

-- Workspace Rules
hl.workspace_rule({ workspace = "special:special", layout = "scrolling" })
hl.workspace_rule({ workspace = "special:communication", layout = "scrolling" })
hl.workspace_rule({ workspace = "special:music", layout = "monocle" })
hl.workspace_rule({ workspace = "special:sysmon", layout = "monocle" })

-- Window Rules
hl.window_rule({ match = { class = "^(Zoom)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^Chat$" }, float = true })

hl.window_rule({ match = { class = "^(slack|com.rtosta.zapzap)$" }, workspace = "special:communication" })
hl.window_rule({ match = { class = "thunar", workspace = "special:communication" }, float = true, size = { 1200, 800 } })

hl.window_rule({ match = { class = "Todoist|cohesion|obsidian" }, workspace = "special:todo" })
hl.window_rule({ match = { initial_title = "On-Together" }, workspace = "special:on_together" })
