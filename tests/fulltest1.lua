-- loadstring(game:HttpGet("http://localhost:8642/dist/main.lua"))()

local cloneref = (cloneref or clonereference or function(instance)
	return instance
end)

local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local RunService = cloneref(game:GetService("RunService"))

local WindUI

do
	local ok, result = pcall(function()
		return require("../src/Init")
	end)

	if ok then
		WindUI = result
	else
		if RunService:IsStudio() or not writefile then
			WindUI = require(ReplicatedStorage:WaitForChild("WindUI"):WaitForChild("Init"))
		else
			WindUI =
				loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/beta/dist/main.lua"))()
		end
	end
end

local Window = WindUI:CreateWindow({
	Title = "WindUI Test Suite",
	Icon = "flask-conical",
	Author = "by Test Suite",
	Folder = "WindUITests",
	Size = UDim2.fromOffset(580, 460),
	MinSize = Vector2.new(560, 350),
	MaxSize = Vector2.new(850, 560),
	Transparent = true,
	Theme = "Dark",
	Resizable = true,
	SideBarWidth = 200,
	HideSearchBar = false,
	ScrollBarEnabled = true,
	User = {
		Enabled = true,
		Anonymous = false,
		Callback = function()
			print("[Window] User icon clicked")
		end,
	},
})

Window:OnOpen(function()
	print("[Window] Opened")
end)

Window:OnClose(function()
	print("[Window] Closed")
end)

Window:OnDestroy(function()
	print("[Window] Destroyed")
end)

Window:SetToggleKey(Enum.KeyCode.RightShift)
--Window:SetTransparency(true)
--Window:SetResizable(true)

-- local AllElements = Window:GetAllElements()
-- local LockedElements = Window:GetLockedElements()
-- local UnlockedElements = Window:GetUnlockedElements()

-- print("[Window] All elements:", #AllElements)
-- print("[Window] Locked elements:", #LockedElements)
-- print("[Window] Unlocked elements:", #UnlockedElements)

-- Window:Open()
-- Window:Close()
-- Window:Toggle()

local TabSectionMain = Window:Section({
	Title = "Main",
	Icon = "layout-dashboard",
	Opened = true,
})

local TabSectionExtras = Window:Section({
	Title = "Extras",
	Icon = "sparkles",
	Opened = true,
})

local TabButtons = Window:Tab({
	Title = "Buttons",
	Icon = "mouse-pointer-click",
	Locked = false,
})

local TabToggles = Window:Tab({
	Title = "Toggles",
	Icon = "toggle-right",
	Locked = false,
})

local TabSliders = Window:Tab({
	Title = "Sliders",
	Icon = "sliders-horizontal",
	Locked = false,
})

local TabDropdowns = Window:Tab({
	Title = "Dropdowns",
	Icon = "chevrons-up-down",
	Locked = false,
})

local TabInputs = Window:Tab({
	Title = "Inputs",
	Icon = "keyboard",
	Locked = false,
})

local TabColorpickers = Window:Tab({
	Title = "Colors",
	Icon = "palette",
	Locked = false,
})

local TabKeybinds = Window:Tab({
	Title = "Keybinds",
	Icon = "command",
	Locked = false,
})

local TabMisc = Window:Tab({
	Title = "Misc",
	Icon = "box",
	Locked = false,
})

TabButtons:Select()

Window:Divider()
--Window:Space()

-- ══════════════════════════════════════════
--               BUTTONS TAB
-- ══════════════════════════════════════════

local SectionButtons = TabButtons:Section({
	Title = "Button Tests",
	Box = false,
	FontWeight = Enum.FontWeight.SemiBold,
	TextTransparency = 0.05,
	TextXAlignment = "Left",
	TextSize = 17,
	Opened = true,
})

local ButtonBasic = SectionButtons:Button({
	Title = "Basic Button",
	Desc = "A simple default button",
	Locked = false,
	Callback = function()
		print("[Button] Basic clicked")
	end,
})

ButtonBasic:SetTitle("Basic Button (Updated)")
ButtonBasic:SetDesc("Description updated")

local ButtonLockTest = TabButtons:Button({
	Title = "Lock Test Button",
	Desc = "Will be locked then unlocked",
	Locked = false,
	Callback = function()
		print("[Button] Lock test clicked")
	end,
})

ButtonLockTest:Lock()
ButtonLockTest:Unlock()

local ButtonDestroyTest = TabButtons:Button({
	Title = "Destroy Test Button",
	Desc = "This button will be destroyed",
	Locked = false,
	Callback = function()
		print("[Button] Destroy test clicked")
	end,
})

ButtonDestroyTest:Destroy()

local ButtonIconed = TabButtons:Button({
	Title = "Icon Button",
	Desc = "Button with icon",
	Icon = "zap",
	Locked = false,
	Callback = function()
		print("[Button] Iconed clicked")
	end,
})

TabButtons:Divider()
TabButtons:Space()

local ParagraphBasic = TabButtons:Paragraph({
	Title = "Paragraph Title",
	Desc = "This is a paragraph description element for testing.",
	Color = "Blue",
	Locked = false,
})

ParagraphBasic:SetTitle("Paragraph Title (Updated)")
ParagraphBasic:SetDesc("Paragraph description updated")
ParagraphBasic:SetImage("rbxassetid://0")
ParagraphBasic:SetThumbnail("rbxassetid://0")

local ParagraphWithButtons = TabButtons:Paragraph({
	Title = "Paragraph With Buttons",
	Desc = "Paragraph that has inline buttons",
	Color = "Green",
	Buttons = {
		{
			Icon = "check",
			Title = "Accept",
			Callback = function()
				print("[Paragraph] Accept clicked")
			end,
		},
		{
			Icon = "x",
			Title = "Decline",
			Callback = function()
				print("[Paragraph] Decline clicked")
			end,
		},
	},
})

ParagraphWithButtons:Destroy()

local ParagraphRed = TabButtons:Paragraph({
	Title = "Red Paragraph",
	Desc = "Error style paragraph",
	Color = "Red",
})

local ParagraphYellow = TabButtons:Paragraph({
	Title = "Yellow Paragraph",
	Desc = "Warning style paragraph",
	Color = Color3.fromHex("#ffe330"),
})

local CodeBasic = TabButtons:Code({
	Title = "Code Block",
	Code = [[print("Hello from WindUI Code block!")]],
})

CodeBasic:SetCode([[print("Code updated!")]])

-- lie

-- CodeBasic:OnCopy(function()
-- 	print("[Code] Copied: " .. CodeBasic.Title)
-- end)

CodeBasic:Destroy()

-- ══════════════════════════════════════════
--               TOGGLES TAB
-- ══════════════════════════════════════════

local SectionToggles = TabToggles:Section({
	Title = "Toggle Tests",
	Opened = true,
})

local ToggleBasic = SectionToggles:Toggle({
	Title = "Basic Toggle",
	Desc = "A standard toggle switch",
	Value = false,
	Callback = function(State)
		print("[Toggle] Basic state:", State)
	end,
})

ToggleBasic:SetTitle("Basic Toggle (Updated)")
ToggleBasic:SetDesc("Toggle description updated")
ToggleBasic:Set(true)
ToggleBasic:Set(false)

local ToggleCheckbox = TabToggles:Toggle({
	Title = "Checkbox Toggle",
	Desc = "Toggle rendered as a checkbox",
	Type = "Checkbox",
	Value = false,
	Callback = function(State)
		print("[Toggle] Checkbox state:", State)
	end,
})

ToggleCheckbox:Set(true)

local ToggleWithIcon = TabToggles:Toggle({
	Title = "Toggle With Icon",
	Desc = "Toggle that has a lucide icon",
	Icon = "bird",
	Value = true,
	Callback = function(State)
		print("[Toggle] Icon toggle state:", State)
	end,
})

local ToggleLockTest = TabToggles:Toggle({
	Title = "Lock Toggle",
	Desc = "Will be locked then unlocked",
	Value = false,
	Callback = function(State)
		print("[Toggle] Lock test state:", State)
	end,
})

ToggleLockTest:Lock()
ToggleLockTest:Unlock()

local ToggleDestroyTest = TabToggles:Toggle({
	Title = "Destroy Toggle",
	Desc = "This toggle will be destroyed",
	Value = false,
	Callback = function(State)
		print("[Toggle] Destroy test state:", State)
	end,
})

ToggleDestroyTest:Destroy()

-- ══════════════════════════════════════════
--               SLIDERS TAB
-- ══════════════════════════════════════════

local SectionSliders = TabSliders:Section({
	Title = "Slider Tests",
	Opened = true,
})

local SliderBasic = SectionSliders:Slider({
	Title = "Basic Slider",
	Desc = "Integer step slider",
	Step = 1,
	Value = {
		Min = 0,
		Max = 100,
		Default = 50,
	},
	Callback = function(Value)
		print("[Slider] Basic value:", Value)
	end,
})

SliderBasic:SetTitle("Basic Slider (Updated)")
SliderBasic:SetDesc("Slider description updated")
SliderBasic:Set(75)
SliderBasic:SetMax(200)
SliderBasic:SetMin(10)

local SliderFloat = TabSliders:Slider({
	Title = "Float Slider",
	Desc = "Float step slider (0.1 steps)",
	Step = 0.1,
	Value = {
		Min = 0,
		Max = 1,
		Default = 0.5,
	},
	Callback = function(Value)
		print("[Slider] Float value:", Value)
	end,
})

SliderFloat:Set(0.8)

local SliderLockTest = TabSliders:Slider({
	Title = "Lock Slider",
	Desc = "Will be locked then unlocked",
	Step = 1,
	Value = {
		Min = 0,
		Max = 100,
		Default = 25,
	},
	Callback = function(Value)
		print("[Slider] Lock test value:", Value)
	end,
})

SliderLockTest:Lock()
SliderLockTest:Unlock()

local SliderDestroyTest = TabSliders:Slider({
	Title = "Destroy Slider",
	Desc = "This slider will be destroyed",
	Step = 5,
	Value = {
		Min = 0,
		Max = 50,
		Default = 20,
	},
	Callback = function(Value)
		print("[Slider] Destroy test value:", Value)
	end,
})

SliderDestroyTest:Destroy()

-- ══════════════════════════════════════════
--             DROPDOWNS TAB
-- ══════════════════════════════════════════

local SectionDropdowns = TabDropdowns:Section({
	Title = "Dropdown Tests",
	Opened = true,
})

local DropdownSingle = SectionDropdowns:Dropdown({
	Title = "Single Dropdown",
	Desc = "Pick one option",
	Values = { "Option A", "Option B", "Option C", "Option D" },
	Value = { "Option A" },
	Multi = false,
	AllowNone = false,
	Callback = function(Option)
		print("[Dropdown] Single selected:", Option)
	end,
})

DropdownSingle:SetTitle("Single Dropdown (Updated)")
DropdownSingle:SetDesc("Dropdown description updated")
DropdownSingle:Select("Option B")
DropdownSingle:Refresh({ "New Option 1", "New Option 2", "New Option 3" })
DropdownSingle:Select("New Option 1")

local DropdownMulti = TabDropdowns:Dropdown({
	Title = "Multi Dropdown",
	Desc = "Pick multiple options",
	Values = { "Alpha", "Beta", "Gamma", "Delta", "Epsilon" },
	Value = { "Alpha" },
	Multi = true,
	AllowNone = true,
	Callback = function(Options)
		print("[Dropdown] Multi selected:", game:GetService("HttpService"):JSONEncode(Options))
	end,
})

DropdownMulti:Select({ "Alpha", "Gamma" })
DropdownMulti:Refresh({ "One", "Two", "Three", "Four" })
DropdownMulti:Select({ "One", "Three" })

local DropdownLockTest = TabDropdowns:Dropdown({
	Title = "Lock Dropdown",
	Desc = "Will be locked then unlocked",
	Values = { "X", "Y", "Z" },
	Value = { "X" },
	Multi = false,
	Callback = function(Option)
		print("[Dropdown] Lock test selected:", Option)
	end,
})

DropdownLockTest:Lock()
DropdownLockTest:Unlock()

local DropdownDestroyTest = TabDropdowns:Dropdown({
	Title = "Destroy Dropdown",
	Desc = "This dropdown will be destroyed",
	Values = { "A", "B" },
	Value = { "A" },
	Multi = false,
	Callback = function(Option)
		print("[Dropdown] Destroy test selected:", Option)
	end,
})

DropdownDestroyTest:Destroy()

-- ══════════════════════════════════════════
--               INPUTS TAB
-- ══════════════════════════════════════════

local SectionInputs = TabInputs:Section({
	Title = "Input Tests",
	Opened = true,
})

local InputBasic = SectionInputs:Input({
	Title = "Basic Input",
	Desc = "Standard single-line input",
	Value = "Default text",
	InputIcon = "pencil",
	Type = "Input",
	Placeholder = "Type something...",
	Callback = function(Input)
		print("[Input] Basic value:", Input)
	end,
})

InputBasic:SetTitle("Basic Input (Updated)")
InputBasic:SetDesc("Input description updated")
InputBasic:Set("New default value")
InputBasic:SetPlaceholder("Updated placeholder...")

local InputTextarea = TabInputs:Input({
	Title = "Textarea Input",
	Desc = "Multi-line textarea input",
	Value = "",
	Type = "Textarea",
	Placeholder = "Enter multiple lines...",
	Callback = function(Input)
		print("[Input] Textarea value:", Input)
	end,
})

InputTextarea:Set("Line one\nLine two")
InputTextarea:SetPlaceholder("Write a lot here...")

local InputLockTest = TabInputs:Input({
	Title = "Lock Input",
	Desc = "Will be locked then unlocked",
	Value = "",
	Type = "Input",
	Placeholder = "Locked input...",
	Callback = function(Input)
		print("[Input] Lock test value:", Input)
	end,
})

InputLockTest:Lock()
InputLockTest:Unlock()

local InputDestroyTest = TabInputs:Input({
	Title = "Destroy Input",
	Desc = "This input will be destroyed",
	Value = "",
	Type = "Input",
	Placeholder = "Will be gone...",
	Callback = function(Input)
		print("[Input] Destroy test value:", Input)
	end,
})

InputDestroyTest:Destroy()

-- ══════════════════════════════════════════
--            COLORPICKERS TAB
-- ══════════════════════════════════════════

local SectionColors = TabColorpickers:Section({
	Title = "Colorpicker Tests",
	Opened = true,
})

local ColorpickerBasic = SectionColors:Colorpicker({
	Title = "Basic Colorpicker",
	Desc = "Pick any color",
	Default = Color3.fromRGB(255, 0, 0),
	Transparency = 0,
	Locked = false,
	Callback = function(Color)
		print("[Colorpicker] Basic color:", tostring(Color))
	end,
})

ColorpickerBasic:SetTitle("Basic Colorpicker (Updated)")
ColorpickerBasic:SetDesc("Colorpicker description updated")

local ColorpickerGreen = TabColorpickers:Colorpicker({
	Title = "Green Default",
	Desc = "Starts with green",
	Default = Color3.fromRGB(0, 255, 0),
	Transparency = 0.5,
	Locked = false,
	Callback = function(Color)
		print("[Colorpicker] Green picker color:", tostring(Color))
	end,
})

local ColorpickerBlue = TabColorpickers:Colorpicker({
	Title = "Blue Default",
	Desc = "Starts with blue",
	Default = Color3.fromRGB(0, 0, 255),
	Transparency = 0,
	Locked = false,
	Callback = function(Color)
		print("[Colorpicker] Blue picker color:", tostring(Color))
	end,
})

local ColorpickerLockTest = TabColorpickers:Colorpicker({
	Title = "Lock Colorpicker",
	Desc = "Will be locked then unlocked",
	Default = Color3.fromRGB(128, 128, 128),
	Transparency = 0,
	Locked = false,
	Callback = function(Color)
		print("[Colorpicker] Lock test color:", tostring(Color))
	end,
})

ColorpickerLockTest:Lock()
ColorpickerLockTest:Unlock()

local ColorpickerDestroyTest = TabColorpickers:Colorpicker({
	Title = "Destroy Colorpicker",
	Desc = "This colorpicker will be destroyed",
	Default = Color3.fromRGB(255, 255, 0),
	Transparency = 0,
	Locked = false,
	Callback = function(Color)
		print("[Colorpicker] Destroy test color:", tostring(Color))
	end,
})

ColorpickerDestroyTest:Destroy()

-- ══════════════════════════════════════════
--              KEYBINDS TAB
-- ══════════════════════════════════════════

local SectionKeybinds = TabKeybinds:Section({
	Title = "Keybind Tests",
	Opened = true,
})

local KeybindBasic = SectionKeybinds:Keybind({
	Title = "Basic Keybind",
	Desc = "Press a key to bind it",
	Value = "G",
	Callback = function(V)
		print("[Keybind] Basic key:", V)
		Window:SetToggleKey(Enum.KeyCode[V])
	end,
})

KeybindBasic:SetTitle("Basic Keybind (Updated)")
KeybindBasic:SetDesc("Keybind description updated")

local KeybindSecondary = TabKeybinds:Keybind({
	Title = "Secondary Keybind",
	Desc = "Another keybind for testing",
	Value = "H",
	Callback = function(V)
		print("[Keybind] Secondary key:", V)
	end,
})

local KeybindLockTest = TabKeybinds:Keybind({
	Title = "Lock Keybind",
	Desc = "Will be locked then unlocked",
	Value = "J",
	Callback = function(V)
		print("[Keybind] Lock test key:", V)
	end,
})

KeybindLockTest:Lock()
KeybindLockTest:Unlock()

local KeybindDestroyTest = TabKeybinds:Keybind({
	Title = "Destroy Keybind",
	Desc = "This keybind will be destroyed",
	Value = "K",
	Callback = function(V)
		print("[Keybind] Destroy test key:", V)
	end,
})

KeybindDestroyTest:Destroy()

-- ══════════════════════════════════════════
--                 MISC TAB
-- ══════════════════════════════════════════

local SectionMisc = TabMisc:Section({
	Title = "Misc Tests",
	Box = true,
	FontWeight = Enum.FontWeight.Bold,
	TextTransparency = 0,
	TextXAlignment = "Left",
	TextSize = 17,
	Opened = true,
})

SectionMisc:SetTitle("Misc Tests (Updated)")

local SectionDestroyTest = TabMisc:Section({
	Title = "Destroy Section",
	Opened = true,
})

SectionDestroyTest:Destroy()

TabMisc:Divider()
TabMisc:Space()

TabMisc:Button({
	Title = "Show Basic Dialog",
	Desc = "Opens the confirm dialog",
	Callback = function()
        Window:Dialog({
            Icon = "info",
            Title = "Basic Dialog",
            Content = "This is a test dialog with two actions.",
            Buttons = {
                {
                    Title = "Confirm",
                    Icon = "check",
                    Variant = "Primary",
                    Callback = function()
                        print("[Dialog] Confirmed")
                    end,
                },
                {
                    Title = "Cancel",
                    Icon = "x",
                    Variant = "Tertiary",
                    Callback = function()
                        print("[Dialog] Cancelled")
                    end,
                },
            },
        })
	end,
})

TabMisc:Button({
	Title = "Show Destructive Dialog",
	Desc = "Opens the destructive dialog",
	Callback = function()
		Window:Dialog({
            Icon = "triangle-alert",
            Title = "Destructive Dialog",
            Content = "Are you sure you want to proceed?",
            Buttons = {
                {
                    Title = "Delete",
                    Variant = "Danger",
                    Callback = function()
                        print("[Dialog] Deleted")
                    end,
                },
                {
                    Title = "Cancel",
                    Variant = "Secondary",
                    Callback = function()
                        print("[Dialog] Cancelled")
                    end,
                },
            },
        })
	end,
})

TabMisc:Button({
	Title = "Show Notification (Info)",
	Desc = "Fires an info notification",
	Callback = function()
		WindUI:Notify({
			Title = "Info Notification",
			Content = "This is an informational notification.",
			Duration = 4,
			Icon = "info",
		})
	end,
})

TabMisc:Button({
	Title = "Show Notification (Success)",
	Desc = "Fires a success notification",
	Callback = function()
		WindUI:Notify({
			Title = "Success Notification",
			Content = "Operation completed successfully.",
			Duration = 4,
			Icon = "circle-check",
		})
	end,
})

TabMisc:Button({
	Title = "Show Notification (Warning)",
	Desc = "Fires a warning notification",
	Callback = function()
		WindUI:Notify({
			Title = "Warning Notification",
			Content = "Something may need your attention.",
			Duration = 4,
			Icon = "triangle-alert",
		})
	end,
})

TabMisc:Button({
	Title = "Show Notification (Error)",
	Desc = "Fires an error notification",
	Callback = function()
		WindUI:Notify({
			Title = "Error Notification",
			Content = "Something went wrong during execution.",
			Duration = 4,
			Icon = "circle-x",
		})
	end,
})

TabMisc:Button({
	Title = "Show Popup",
	Desc = "Opens a global popup",
	Callback = function()
		WindUI:Popup({
			Title = "Test Popup",
			Icon = "flask-conical",
			Content = "This popup tests the WindUI Popup component.",
			Buttons = {
				{
					Title = "Cancel",
					Variant = "Secondary",
					Callback = function()
						print("[Popup] Cancelled")
					end,
				},
				{
					Title = "Continue",
					Icon = "arrow-right",
					Variant = "Primary",
					Callback = function()
						print("[Popup] Continued")
					end,
				},
			},
		})
	end,
})

TabMisc:Button({
	Title = "Lock All Elements",
	Desc = "Locks every element in the window",
	Callback = function()
		Window:LockAllElements()
		print("[Window] All elements locked")
	end,
})

TabMisc:Button({
	Title = "Unlock All Elements",
	Desc = "Unlocks every element in the window",
	Callback = function()
		Window:UnlockAllElements()
		print("[Window] All elements unlocked")
	end,
})

TabMisc:Button({
	Title = "Window Toggle",
	Desc = "Toggles the window open or closed",
	Callback = function()
		Window:Toggle()
	end,
})

TabMisc:Button({
	Title = "Window Open",
	Desc = "Forces window open",
	Callback = function()
		Window:Open()
	end,
})

TabMisc:Button({
	Title = "Window Close",
	Desc = "Forces window closed",
	Callback = function()
		Window:Close()
	end,
})

TabMisc:Button({
	Title = "Set Transparent ON",
	Desc = "Enables transparency",
	Callback = function()
		Window:ToggleTransparency(true)
	end,
})

TabMisc:Button({
	Title = "Set Transparent OFF",
	Desc = "Disables transparency",
	Callback = function()
		Window:ToggleTransparency(false)
	end,
})

TabMisc:Button({
	Title = "Set Resizable ON",
	Desc = "Enables window resizing",
	Callback = function()
		Window:IsResizable(true)
	end,
})

TabMisc:Button({
	Title = "Set Resizable OFF",
	Desc = "Disables window resizing",
	Callback = function()
		Window:IsResizable(false)
	end,
})

TabMisc:Button({
	Title = "Set Background Transparency 0.5",
	Callback = function()
		Window:SetBackgroundTransparency(0.5)
	end,
})

TabMisc:Button({
	Title = "Set Background Transparency 0",
	Callback = function()
		Window:SetBackgroundTransparency(0)
	end,
})

TabMisc:Button({
	Title = "Print Element Counts",
	Desc = "Prints all, locked, unlocked element counts",
	Callback = function()
		print("[Window] All:", #Window:GetAllElements())
		print("[Window] Locked:", #Window:GetLockedElements())
		print("[Window] Unlocked:", #Window:GetUnlockedElements())
	end,
})

print("[WindUI Tests] All tests loaded successfully.")