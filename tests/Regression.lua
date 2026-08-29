local WindUI = require("../src/Init")

local Window = WindUI:CreateWindow({
	Title = "WindUI Regression",
	Folder = "WindUI_Regression",
	Background = "https://raw.githubusercontent.com/Footagesus/WindUI/main/docs/banner-dark.png",
	BackgroundOverlayTransparency = 0.55,
	BackgroundElementTransparency = 0.2,
	Mobile = { Force = true, SideBarWidth = 250, Padding = 8, Gap = 8 },
})

local Tab = Window:Tab({ Title = "Regression", Icon = "flask-conical" })
local Markdown = Tab:Markdown({
	Content = [[
# Regression

- [x] Markdown renderer
  - Nested list item
- [ ] Video asset upload

| Area | State |
|:--|:--:|
| Mobile sidebar | Ready |
]],
})
assert(#Markdown.Elements == 3, "Markdown task-list regression failed")

assert(Window:SetMobileNavigation(true) == true, "Mobile sidebar did not open")
assert(Window:SetMobileNavigation(false) == false, "Mobile sidebar did not close")

local Plugin = WindUI:AddPlugin({
	Name = "Regression Plugin",
	Version = "1.0.0",
	AutoStart = false,
	Init = function(api) api.RegressionPluginStarted = true end,
	Destroy = function(api) api.RegressionPluginStopped = true end,
})
assert(not Plugin.Enabled, "AutoStart false plugin started")
assert(WindUI:EnablePlugin(Plugin.Name), "Plugin enable failed")
assert(Plugin.Enabled and WindUI.RegressionPluginStarted, "Plugin init did not run")
assert(WindUI:DisablePlugin(Plugin.Name), "Plugin disable failed")
assert(not Plugin.Enabled and WindUI.RegressionPluginStopped, "Plugin destroy did not run")
assert(WindUI:RemovePlugin(Plugin.Name), "Plugin remove failed")

if writefile and readfile and isfile and isfolder and makefolder then
	local root = "WindUI/.codex-regression"
	local themesPath = root .. "/themes"
	local pluginsPath = root .. "/plugins"
	if not isfolder("WindUI") then makefolder("WindUI") end
	if not isfolder(root) then makefolder(root) end

	local theme = WindUI:CreateTheme("Regression Theme", "Dark")
	WindUI:EditTheme(theme.Name, { Primary = Color3.fromHex("#14B8A6") })
	assert(WindUI:SaveTheme(theme.Name, themesPath), "Theme save failed")
	assert(WindUI:LoadTheme(themesPath .. "/Regression Theme.json"), "Theme load failed")

	if not isfolder(pluginsPath) then makefolder(pluginsPath) end
	writefile(pluginsPath .. "/manifest.lua", [[
return {
    Name = "Disk Regression Plugin",
    Version = "1.0.0",
    Init = function(api) api.DiskPluginLoaded = true end,
}
]])
	local loaded, errors = WindUI:LoadPlugins(pluginsPath)
	assert(#errors == 0 and #loaded == 1, "Disk plugin loader failed")
	assert(WindUI.DiskPluginLoaded, "Disk plugin did not initialize")
	assert(WindUI:SavePluginState(pluginsPath), "Plugin state save failed")
	if delfile then
		delfile(themesPath .. "/Regression Theme.json")
		delfile(pluginsPath .. "/manifest.lua")
		delfile(pluginsPath .. "/state.json")
	end
end

print("[WindUI/Regression] desktop/mobile, markdown, persistence and plugin loader passed")
return Window
