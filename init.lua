--[[
## install

1.  install [hammerspoon](http://www.hammerspoon.org/)
2.  install luarocks via [homebrew](http://brew.sh/)

    '''shell
    brew install lua luarocks
    ```

3.  install dependencies

    '''shell
    luarocks install underscore.lua
    ```

--]]

-- _ = require 'underscore'

--[[
## applications

app names

    hs.fnutils.each(hs.application.runningApplications(), function(app) print(app:title()) end)

app id

    osascript -e 'id of app "iTerm"'
--]]

local apps = {
    -- key             = { id      = '',
    --                     name    = '' },
    airmail         = { id      = 'it.bloop.airmail2',
                        name    = 'Airmail 2' },
    dash            = { id      = 'com.kapeli.dash',
                        name    = 'Dash' },
    firefix         = { id      = 'org.mozilla.firefox',
                        name    = 'Firefox' },
    firefoxDev      = { id      = 'org.mozilla.firefoxdeveloperedition',
                        name    = 'FirefoxDeveloperEdition' },
    googleChrome    = { id      = 'com.google.Chrome',
                        name    = 'Google Chrome' },
    pathFinder      = { id      = 'com.cocoatech.PathFinder',
                        name    = 'Path Finder' },
    phpStorm        = { id      = 'com.jetbrains.PhpStorm',
                        name    = 'PhpStorm' },
    phpStormEAP     = { id      = 'com.jetbrains.PhpStorm-EAP',
                        name    = 'PhpStorm-EAP' },
    slack           = { id      = 'com.tinyspeck.slackmacgap',
                        name    = 'Slack' },
    sourceTree      = { id      = 'com.torusknot.SourceTreeNotMAS',
                        name    = 'SourceTree' },
    sublimeText     = { id      = 'com.sublimetext.3',
                        name    = 'Sublime Text' },
    terminal        = { id      = 'com.googlecode.iterm2',
                        name    = 'iTerm' },
}

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

function rearrangeApp(app, grid)
    for i,a in ipairs(hs.application.applicationsForBundleID(app.id)) do
        for j,w in ipairs(a:allWindows()) do
            hs.grid.set(w, grid, hs.screen.mainScreen())
        end
    end
end

function rearrangeAll()
    rearrangeApp(apps.airmail,              { x = 0,  y = 0,  w = 6,  h = 12 })
    rearrangeApp(apps.dash,                 { x = 0,  y = 0,  w = 5,  h = 12 })
    rearrangeApp(apps.firefoxDev,           { x = 0,  y = 0,  w = 5,  h = 12 })
    rearrangeApp(apps.googleChrome,         { x = 5,  y = 0,  w = 6,  h = 12 })
    rearrangeApp(apps.pathFinder,           { x = 3,  y = 1,  w = 6,  h = 10 })
    rearrangeApp(apps.phpStorm,             { x = 2,  y = 0,  w = 10, h = 12 })
    rearrangeApp(apps.phpStormEAP,          { x = 2,  y = 0,  w = 10, h = 12 })
    rearrangeApp(apps.slack,                { x = 0,  y = 0,  w = 5,  h = 12 })
    rearrangeApp(apps.sourceTree,           { x = 6,  y = 0,  w = 6,  h = 12 })
    rearrangeApp(apps.sublimeText,          { x = 4,  y = 0,  w = 5,  h = 12 })
    rearrangeApp(apps.terminal,             { x = 0,  y = 0,  w = 4,  h = 12 })
end

-- @todo implement
-- -    http://www.hammerspoon.org/docs/hs.screen.watcher.html
-- -    http://www.hammerspoon.org/docs/hs.application.watcher.html
-- -    http://www.hammerspoon.org/docs/hs.uielement.watcher.html

--[[
## vm management
--]]

function shutdownVMs()
    local apps = {
        'SourceTree',
        'PhpStorm-EAP',
        'PhpStorm',
    }
    local ids = {
        'com.torusknot.SourceTreeNotMAS',
        -- 'com.jetbrains.PhpStorm',
        -- 'com.jetbrains.PhpStorm-EAP',
    }
    for i = 1, #ids do
        print(apps[i])
        local app = hs.appfinder.appFromName(apps[i])
        -- apps = hs.application.applicationsForBundleID(ids[i])
        -- if app then
        --     print("killing...")
        --     app.kill()
        -- end
    end
end

--[[
## menubar
--]]

local b = hs.menubar.new()

local menuTable = {
    { title = "Re-arrange All", fn = rearrangeAll },
    { title = "-" },

    -- { title = "Shutdown VMs", fn = shutdownVMs },

    -- { title = "test", fn = testmenu },

    -- { title = "my menu item", fn = function() print("you clicked my menu item!") end },
    -- { title = "-" },
    -- { title = "other item", fn = some_function },
    -- { title = "disabled item", disabled = true },
    -- { title = "checked item", checked = true },
}

if b then
    b:setTitle("b")
    b:setMenu(menuTable)
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
