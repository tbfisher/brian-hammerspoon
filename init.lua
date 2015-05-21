--[[
## install

1.  install [hammerspoon](http://www.hammerspoon.org/)
2.  install luarocks via [homebrew](http://brew.sh/)

    '''shell
    brew install lua luarocks
    ```

3.  install dependencies (none currently)

    '''shell
    luarocks install [dependency]
    ```

--]]

-- _ = require 'underscore'

--[[
## configuration

app names

    hs.fnutils.each(hs.application.runningApplications(), function(app) print(app:title()) end)

app id

    osascript -e 'id of app "iTerm"'
--]]

-- common window layouts
cell50L = { x = 0,  y = 0,  w = 6,  h = 12 }
cell50R = { x = 6,  y = 0,  w = 6,  h = 12 }
cell8Center = {
    workScreen = { x = 2,  y = 0,  w = 8,  h = 12 },
    laptopScreen = { x = 2,  y = 0,  w = 8,  h = 12 },
}
cellTerminal = {
    workScreen = { x = 0,  y = 0,  w = 4,  h = 12 },
    laptopScreen = { x = 0,  y = 0,  w = 4,  h = 12 },
}
cellIDE = {
    workScreen = { x = 2,  y = 0,  w = 10, h = 12 },
    laptopScreen = { x = 2,  y = 0,  w = 10, h = 12 },
}

local apps = {}
apps.airmail = {
    id = 'it.bloop.airmail2',
    name = 'Airmail 2',
    cell = {
        workScreen = cell50L,
        laptopScreen = { x = 0,  y = 0,  w = 8,  h = 12 },
    },
}
apps.dash = {
    id = 'com.kapeli.dash',
    name = 'Dash',
    cell = {
        workScreen = { x = 0,  y = 0,  w = 5,  h = 12 },
        laptopScreen = { x = 0,  y = 0,  w = 7,  h = 12 },
    },
}
apps.firefox = {
    id = 'org.mozilla.firefox',
    name = 'Firefox',
    cell = {
        workScreen = { x = 0,  y = 0,  w = 5,  h = 12 },
        laptopScreen = { x = 0,  y = 0,  w = 5,  h = 12 },
    },
}
apps.firefoxDev = {
    id = 'org.mozilla.firefoxdeveloperedition',
    name = 'FirefoxDeveloperEdition',
    cell = {
        workScreen = { x = 0,  y = 0,  w = 5,  h = 12 },
        laptopScreen = cell50L,
    },
}
apps.googleChrome = {
    id = 'com.google.Chrome',
    name = 'Google Chrome',
    cell = {
        workScreen = { x = 5,  y = 0,  w = 6,  h = 12 },
        laptopScreen = { x = 5,  y = 0,  w = 7,  h = 12 },
    },
}
apps.hammerspoon = {
    id = 'org.hammerspoon.Hammerspoon',
    name = 'Hammerspoon',
    cell = cellTerminal,
}
apps.iTunes = {
    id = 'com.apple.iTunes',
    name = 'iTunes',
    cell = {
        workScreen = cell50L,
        laptopScreen = { x = 0,  y = 0,  w = 8,  h = 12 },
    },
}
apps.merge = {
    id = 'com.araxis.merge',
    name = 'Araxis Merge',
    cell = cell8Center,
}
apps.omniFocus = {
    id = 'com.omnigroup.OmniFocus2',
    name = 'OmniFocus',
    cell = {
        workScreen = { x = 0,  y = 0,  w = 5,  h = 12 },
        laptopScreen = cell50L,
    },
}
apps.pathFinder = {
    id = 'com.cocoatech.PathFinder',
    name = 'Path Finder',
    cell = {
        workScreen = { x = 3,  y = 1,  w = 6,  h = 10 },
        laptopScreen = { x = 3,  y = 1,  w = 6,  h = 10 },
    },
}
apps.oxygenXML = {
    id = 'ro.sync.exml.Oxygen',
    name = 'Oxygen XML Editor',
    cell = cellIDE,
}
apps.phpStorm = {
    id = 'com.jetbrains.PhpStorm',
    name = 'PhpStorm',
    cell = cellIDE,
}
apps.phpStormEAP = {
    id = 'com.jetbrains.PhpStorm-EAP',
    name = 'PhpStorm-EAP',
    cell = {
        workScreen = { x = 2,  y = 0,  w = 10, h = 12 },
        laptopScreen = { x = 2,  y = 0,  w = 10, h = 12 },
    },
}
apps.readKit = {
    id = 'com.webinhq.ReadKit',
    name = 'ReadKit',
    cell = {
        workScreen = { x = 0,  y = 0,  w = 7,  h = 12 },
        laptopScreen = { x = 0,  y = 0,  w = 8,  h = 12 },
    },
}
apps.slack = {
    id = 'com.tinyspeck.slackmacgap',
    name = 'Slack',
    cell = {
        workScreen = { x = 0,  y = 0,  w = 5,  h = 12 },
        laptopScreen = { x = 0,  y = 0,  w = 5,  h = 12 },
    },
}
apps.sourceTree = {
    id = 'com.torusknot.SourceTreeNotMAS',
    name = 'SourceTree',
    cell = {
        workScreen = cell50R,
        laptopScreen = cell50R,
    },
}
apps.sublimeText = {
    id = 'com.sublimetext.3',
    name = 'Sublime Text',
    cell = {
        workScreen = { x = 4,  y = 0,  w = 5,  h = 12 },
        laptopScreen = { x = 4,  y = 0,  w = 6,  h = 12 },
    },
}
apps.terminal = {
    id = 'com.googlecode.iterm2',
    name = 'iTerm',
    cell = cellTerminal,
}

function appGetFromName(name)
    for key,conf in pairs(apps) do
        if conf.name == name then return conf end
    end
end

function appGetFrombundleID(id)
    for key,conf in pairs(apps) do
        if conf.id == id then return conf end
    end
end

--[[
## window management
--]]

-- hs.screen.allScreens()[1]:name()
local workScreen = 'DELL U2711'
local laptopScreen = "Color LCD"
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 12
hs.grid.GRIDHEIGHT = 12

function rearrangeApp(conf)
    local screen = hs.screen.mainScreen()
    if (screen:name() == workScreen) then
        cell = conf.cell.workScreen
    else
        cell = conf.cell.laptopScreen
    end
    local grid = conf.cell[screen:name()]
    for i,a in ipairs(hs.application.applicationsForBundleID(conf.id)) do
        for j,w in ipairs(a:allWindows()) do
            hs.grid.set(w, cell, screen)
        end
    end
end

function rearrangeSpace()
    for key,conf in pairs(apps) do
        rearrangeApp(conf)
    end
end

function rearrangeCurrentApp()
    local app = hs.application.frontmostApplication()
    conf = appGetFrombundleID(app:bundleID())
    if conf then
        rearrangeApp(conf)
    end
end

function verticalTile(n)
    local windows = hs.window.orderedWindows()
    local width = 12/n
    for i = 0, n-1 do
        cell = { x = 0+i*width, y = 0, w = width,  h = 12 }
        hs.grid.set(windows[i+1], cell, hs.screen.mainScreen())
    end
end
function verticalTile2() return verticalTile(2) end
function verticalTile3() return verticalTile(3) end

--[[
## UI
--]]

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "r", rearrangeSpace)

-- ⇧⌃⌥⌘
local menuTable = {
    { title = "Re-arrange Space        ⌃⌥⌘r", fn = rearrangeSpace },
    { title = "Re-arrange App", fn = rearrangeCurrentApp },
    { title = "2 Tiled Vertically", fn = verticalTile2 },
    { title = "3 Tiled Vertically", fn = verticalTile3 },
    -- { title = "-" },
}

local menubar = hs.menubar.new()
if menubar then
    menubar:setTitle("b")
    menubar:setMenu(menuTable)
end

--[[
## misc
--]]

-- load config on save
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local reloaded = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
