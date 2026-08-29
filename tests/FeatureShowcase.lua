local WindUI = require("../src/Init")

local BackgroundImage = "https://a.storyblok.com/f/178900/1000x563/f3bbac17df/wistoria-wand-and-sword-elfaria-trailer-screen.jpg/m/filters:quality(95)format(webp)"

local Window = WindUI:CreateWindow({
	Title = "WindUI Feature Showcase",
	Author = "Markdown, media and mobile UI",
	Folder = "WindUI_Feature_Showcase",
	Size = UDim2.fromOffset(760, 560),
	Background = BackgroundImage,
	BackgroundImageTransparency = 0,
	BackgroundOverlayTransparency = 0.5,
	SidebarBackgroundTransparency = 0.22,
	Mobile = {
		SideBarWidth = 250,
		Padding = 8,
		Gap = 8,
	},
})

local ShowcasePlugin = WindUI:GetPlugin("Showcase Tools") or WindUI:AddPlugin({
	Name = "Showcase Tools",
	Version = "1.0.0",
	Init = function(api)
		api.ShowcasePluginLoaded = true
	end,
})

local Overview = Window:Tab({ Title = "Overview", Icon = "layout-dashboard" })
Overview:Paragraph({
	Title = "Complete feature preview",
	Desc = "The window background is dimmed, while the mobile sidebar uses its own animated surface.",
})
Overview:Button({
	Title = "Open command palette",
	Icon = "search",
	Callback = function()
		Window:OpenCommandPalette()
	end,
})

local ElementsTab = Window:Tab({ Title = "Elements", Icon = "blocks" })
ElementsTab:Paragraph({ Title = "Core controls", Desc = "Every common interactive element is available in this test." })
ElementsTab:Button({ Title = "Button", Desc = "Callback test", Icon = "mouse-pointer-click", Callback = function() print("[WindUI/Showcase] button pressed") end })
ElementsTab:Toggle({ Title = "Toggle", Desc = "Boolean state", Value = true, Flag = "showcase_toggle" })
ElementsTab:Slider({
	Title = "Slider",
	Value = { Min = 0, Max = 100, Default = 42 },
	Step = 1,
	Flag = "showcase_slider",
})
ElementsTab:ProgressBar({ Title = "Progress bar", Value = { Min = 0, Max = 100, Default = 68 } })
ElementsTab:Input({ Title = "Input", Desc = "Text value", Value = "WindUI", Placeholder = "Enter text", Flag = "showcase_input" })
ElementsTab:Dropdown({ Title = "Dropdown", Values = { "Dark", "Light", "Rose" }, Value = "Dark", Flag = "showcase_dropdown" })
ElementsTab:Keybind({ Title = "Keybind", Value = "K", Flag = "showcase_keybind" })
ElementsTab:Colorpicker({ Title = "Colorpicker", Default = Color3.fromHex("#8B5CF6"), Flag = "showcase_color" })
ElementsTab:Divider()
ElementsTab:Code({ Title = "Code", Code = "print('WindUI showcase')", CodeSize = 14 })
ElementsTab:Space({ Columns = 1 })

local LayoutSection = ElementsTab:Section({
	Title = "Layout elements",
	Desc = "Section, stacks and grouped controls are rendered here.",
	Icon = "layout-panel-top",
	Box = true,
	Opened = true,
})
local Actions = LayoutSection:HStack({ AutoSpace = true })
Actions:Button({ Title = "Left action", Icon = "chevron-left", Callback = function() end })
Actions:Button({ Title = "Right action", Icon = "chevron-right", Callback = function() end })
local Vertical = LayoutSection:VStack()
Vertical:Paragraph({ Title = "VStack", Desc = "Vertical content keeps the regular responsive width." })
local Group = LayoutSection:Group()
Group:Toggle({ Title = "Grouped toggle", Value = false })
Group:Button({ Title = "Grouped button", Callback = function() end })

local ViewportPart = Instance.new("Part")
ViewportPart.Name = "ShowcasePart"
ViewportPart.Size = Vector3.new(4, 4, 4)
ViewportPart.Color = Color3.fromHex("#8B5CF6")
ViewportPart.Material = Enum.Material.Neon
ElementsTab:Viewport({ Object = ViewportPart, Height = 150, Interactive = true })
ElementsTab:Image({ Image = "https://raw.githubusercontent.com/Footagesus/WindUI/main/docs/banner-dark.png", AspectRatio = "16:9" })
ElementsTab:Video({ Video = "rbxassetid://5608384572", Height = 160, Autoplay = false })
Overview:Button({
	Title = "Toggle sidebar",
	Desc = "Works on desktop and mobile",
	Icon = "panel-left",
	Callback = function()
		Window:ToggleSidebar()
	end,
})

local MarkdownTab = Window:Tab({ Title = "Markdown", Icon = "file-text" })
MarkdownTab:Markdown({
	ImageHeight = 190,
	Content = [[
# WindUI Markdown

Native **bold**, _italic_, ~~strikethrough~~ and `inline code`.

> Tables, images and responsive layout use WindUI surfaces.

| Feature | Status |
|:--|--:|
| Markdown | Ready |
| HTML-lite | Ready |
| Mobile sidebar | Ready |

![WindUI banner](https://raw.githubusercontent.com/Footagesus/WindUI/main/docs/banner-dark.png)
]],
})

local HtmlTab = Window:Tab({ Title = "HTML", Icon = "code-xml" })
HtmlTab:HTML({
	ImageHeight = 190,
	Content = [[
<h1>HTML-lite</h1>
<p>HTML is converted into WindUI-native blocks with <strong>theme-aware</strong> styling.</p>
<table><tr><th>Renderer</th><th>Available</th></tr><tr><td>Image</td><td>Yes</td></tr><tr><td>Video block</td><td>Yes</td></tr></table>
<img src="https://raw.githubusercontent.com/Footagesus/WindUI/main/docs/banner-dark.png" alt="WindUI banner">
]],
})

local function getThemeNames()
	local names = {}
	for name in next, WindUI:GetThemes() do table.insert(names, name) end
	table.sort(names)
	return names
end

local ThemeTab = Window:Tab({ Title = "Theme", Icon = "palette" })
ThemeTab:Paragraph({ Title = "Theme workspace", Desc = "Select, create, tune and apply themes without leaving the window." })
ThemeTab:Dropdown({
	Title = "Active theme",
	Values = getThemeNames(),
	Value = WindUI:GetCurrentTheme(),
	Callback = function(name)
		WindUI:SetTheme(name)
		print("[WindUI/Showcase] applied theme " .. tostring(name))
	end,
})
ThemeTab:Colorpicker({
	Title = "Active accent",
	Default = Color3.fromHex("#8B5CF6"),
	Callback = function(color)
		WindUI:EditTheme(WindUI:GetCurrentTheme(), { Primary = color, Slider = color })
	end,
})
ThemeTab:Slider({
	Title = "Element background opacity",
	Desc = "Keeps the window image visible behind every surface.",
	Value = { Min = 0, Max = 100, Default = math.floor((Window.BackgroundElementTransparency or 0) * 100) },
	Callback = function(value)
		Window.BackgroundElementTransparency = value / 100
		Window:ApplyBackgroundElementTransparency()
	end,
})
local ThemeActions = ThemeTab:HStack({ AutoSpace = true })
ThemeActions:Button({
	Title = "Create violet",
	Icon = "sparkles",
	Callback = function()
		if not WindUI:GetThemes()["Showcase Violet"] then
			WindUI:CreateTheme("Showcase Violet", WindUI:GetCurrentTheme())
		end
		WindUI:EditTheme("Showcase Violet", { Primary = Color3.fromHex("#8B5CF6"), Slider = Color3.fromHex("#8B5CF6") })
		WindUI:SetTheme("Showcase Violet")
	end,
})
ThemeActions:Button({ Title = "Restore Dark", Icon = "moon", Callback = function() WindUI:SetTheme("Dark") end })
ThemeTab:Button({
	Title = "Save active theme",
	Desc = "Writes the active theme to WindUI/themes.",
	Icon = "download",
	Callback = function()
		local ok, err = WindUI:SaveTheme()
		print("[WindUI/Showcase] theme save", ok, err)
	end,
})

local ProfilesTab = Window:Tab({ Title = "Profiles", Icon = "folder-cog" })
ProfilesTab:Paragraph({ Title = "Profile workspace", Desc = "Create, select, save, load and rename stored profiles." })
local profileName = "showcase"
local ProfileStatus = ProfilesTab:Paragraph({ Title = "No profile selected", Desc = "Use a profile action below." })
local ProfileTable = ProfilesTab:Markdown({ Content = "## Stored profiles\n\n| Profile | Current |\n|:--|:--:|\n| Loading | — |", TableRowHeight = 34, TableMaxHeight = 150 })
local function refreshProfileTable()
	local manager = Window.ConfigManager
	if not manager then return end
	local rows = { "## Stored profiles", "", "| Profile | Current |", "|:--|:--:|" }
	for _, name in next, manager:ListProfiles() do
		table.insert(rows, "| " .. name:gsub("|", "/") .. " | " .. (manager:GetCurrentProfile() == name and "Yes" or "") .. " |")
	end
	ProfileTable:SetContent(table.concat(rows, "\n"))
end
ProfilesTab:Input({ Title = "Profile name", Value = profileName, Placeholder = "profile name", Callback = function(value) profileName = value end })
local ProfileActions = ProfilesTab:HStack({ AutoSpace = true })
ProfileActions:Button({
	Title = "Create / select",
	Icon = "folder-plus",
	Callback = function()
		local manager = Window.ConfigManager
		if not manager then return end
		local profile = manager:GetConfig(profileName) or manager:CreateProfile(profileName) or manager:SelectProfile(profileName)
		if profile then ProfileStatus:SetTitle("Selected: " .. profileName) refreshProfileTable() end
	end,
})
ProfileActions:Button({
	Title = "Save",
	Icon = "save",
	Callback = function()
		local manager = Window.ConfigManager
		if not manager then return end
		local profile = manager:GetConfig(profileName) or manager:CreateProfile(profileName)
		if profile then
			profile:Set("lastOpened", os.time())
			manager:SaveProfile(profileName)
			ProfileStatus:SetTitle("Saved: " .. profileName)
			refreshProfileTable()
		end
	end,
})
local ProfileLoadActions = ProfilesTab:HStack({ AutoSpace = true })
ProfileLoadActions:Button({ Title = "Load", Icon = "folder-open", Callback = function() local manager = Window.ConfigManager if manager then manager:LoadProfile(profileName) ProfileStatus:SetTitle("Loaded: " .. profileName) end end })
ProfileLoadActions:Button({ Title = "Rename to showcase-v2", Icon = "pencil", Callback = function() local manager = Window.ConfigManager if manager and manager:RenameProfile(profileName, "showcase-v2") then profileName = "showcase-v2" ProfileStatus:SetTitle("Renamed: showcase-v2") end end })
ProfilesTab:Button({ Title = "Set selected as autoload", Icon = "power", Callback = function() local manager = Window.ConfigManager if manager then manager:SetProfileAutoLoad(profileName, true) ProfileStatus:SetTitle("Autoload: " .. profileName) end end })
refreshProfileTable()

local PluginsTab = Window:Tab({ Title = "Plugins", Icon = "puzzle" })
PluginsTab:Paragraph({ Title = "Plugin workspace", Desc = "Plugins can initialize, expose their own state and clean up when removed." })
local PluginStatus = PluginsTab:Paragraph({ Title = ShowcasePlugin.Name .. " " .. ShowcasePlugin.Version, Desc = "Registered and initialized." })
local PluginTable = PluginsTab:Markdown({
	Content = "## Installed plugins\n\n| Plugin | Version | Status |\n|:--|:--|:--|\n| Loading | — | — |",
	TableRowHeight = 34,
	TableMaxHeight = 180,
	TableCellWidth = 130,
})
local function refreshPluginTable()
	local rows = { "## Installed plugins", "", "| Plugin | Version | Status |", "|:--|:--|:--|" }
	for _, plugin in next, WindUI:ListPlugins() do
		local safeName = plugin.Name:gsub("|", "/")
		table.insert(rows, "| " .. safeName .. " | " .. tostring(plugin.Version or "0.0.0") .. " | " .. (plugin.Enabled and "Enabled" or "Disabled") .. " |")
	end
	PluginTable:SetContent(table.concat(rows, "\n"))
end
local pluginName = "Showcase Utility"
PluginsTab:Input({ Title = "Plugin name", Value = pluginName, Placeholder = "plugin name", Callback = function(value) pluginName = value end })
local PluginActions = PluginsTab:HStack({ AutoSpace = true })
PluginActions:Button({
	Title = "Install plugin",
	Icon = "plus",
	Callback = function()
		if not WindUI:GetPlugin(pluginName) then
			WindUI:AddPlugin({ Name = pluginName, Version = "1.0.0", Init = function(api) api.ShowcaseUtilityReady = true end })
		end
		PluginStatus:SetTitle("Installed: " .. pluginName)
		refreshPluginTable()
	end,
})
PluginActions:Button({
	Title = "Remove plugin",
	Icon = "trash-2",
	Callback = function()
		local removed = WindUI:RemovePlugin(pluginName)
		PluginStatus:SetTitle(removed and ("Removed: " .. pluginName) or ("Not found: " .. pluginName))
		refreshPluginTable()
	end,
})
local PluginStateActions = PluginsTab:HStack({ AutoSpace = true })
PluginStateActions:Button({
	Title = "Enable selected",
	Icon = "circle-play",
	Callback = function()
		local plugin = WindUI:EnablePlugin(pluginName)
		PluginStatus:SetTitle(plugin and ("Enabled: " .. pluginName) or ("Not found: " .. pluginName))
		refreshPluginTable()
	end,
})
PluginStateActions:Button({
	Title = "Disable selected",
	Icon = "circle-pause",
	Callback = function()
		local plugin = WindUI:DisablePlugin(pluginName)
		PluginStatus:SetTitle(plugin and ("Disabled: " .. pluginName) or ("Not found: " .. pluginName))
		refreshPluginTable()
	end,
})
local PluginStorageActions = PluginsTab:HStack({ AutoSpace = true })
PluginStorageActions:Button({ Title = "Save state", Icon = "save", Callback = function() local ok, err = WindUI:SavePluginState() PluginStatus:SetTitle(ok and "Plugin state saved" or ("Save failed: " .. tostring(err))) end })
PluginStorageActions:Button({ Title = "Load disk plugins", Icon = "folder-input", Callback = function() local loaded, errors = WindUI:LoadPlugins() PluginStatus:SetTitle("Loaded " .. tostring(#loaded) .. ", errors " .. tostring(#errors)) refreshPluginTable() end })
PluginsTab:Button({
	Title = "Refresh plugin table",
	Desc = "Refreshes the installed plugin list and verifies its registry state.",
	Icon = "shield-check",
	Callback = function()
		assert(WindUI:GetPlugin("Showcase Tools") == ShowcasePlugin, "Plugin registry failed")
		local count = 0
		for _ in next, WindUI:GetPlugins() do count += 1 end
		PluginStatus:SetTitle("Registry verified: " .. tostring(count) .. " plugin(s)")
		refreshPluginTable()
		print("[WindUI/Showcase] plugin registry passed")
	end,
})
refreshPluginTable()

Window:ThemeEditor({
	Title = "Theme editor",
	Theme = WindUI:GetCurrentTheme(),
})

assert(WindUI:GetPlugin("Showcase Tools") == ShowcasePlugin, "Showcase plugin was not registered")
assert(WindUI.ShowcasePluginLoaded, "Showcase plugin did not initialize")
local DisposablePlugin = WindUI:AddPlugin({ Name = "Disposable Showcase Plugin" })
assert(WindUI:GetPlugins()[DisposablePlugin.Name] == DisposablePlugin, "Plugin list did not include the new plugin")
assert(#WindUI:ListPlugins() >= 2, "Plugin list did not return registered plugins")
assert(WindUI:DisablePlugin(DisposablePlugin.Name), "Plugin was not disabled")
assert(not DisposablePlugin.Enabled, "Disabled plugin is still enabled")
assert(WindUI:EnablePlugin(DisposablePlugin.Name), "Plugin was not re-enabled")
assert(DisposablePlugin.Enabled, "Re-enabled plugin is still disabled")
assert(WindUI:RemovePlugin(DisposablePlugin.Name), "Plugin was not removed")
assert(WindUI:GetPlugin(DisposablePlugin.Name) == nil, "Removed plugin is still registered")
assert(Window:SetSidebarOpen(false) == false, "Sidebar did not close")
assert(Window:SetSidebarOpen(true) == true, "Sidebar did not reopen")
Window:ApplyBackgroundElementTransparency()
print("[WindUI/Showcase] full feature test opened")

return Window
