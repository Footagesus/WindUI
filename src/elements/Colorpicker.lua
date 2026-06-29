local Creator = require("../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween

local cloneref = (cloneref or clonereference or function(instance)
	return instance
end)

local UserInputService = cloneref(game:GetService("UserInputService"))
local TouchInputService = cloneref(game:GetService("TouchInputService"))
local RunService = cloneref(game:GetService("RunService"))
local Players = cloneref(game:GetService("Players"))

local RenderStepped = RunService.RenderStepped
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local CreateButton = require("../components/ui/Button").New
local CreateInput = require("../components/ui/Input").New

local Element = {
	UICorner = 9,
	--UIPadding = 8
}

local ActiveSlider = nil

function Element:Colorpicker(Config, Window, WindUI, OnApply)
	local Colorpicker = {
		__type = "Colorpicker",
		Title = Config.Title,
		Desc = Config.Desc,
		Default = Config.Value or Config.Default,
		Callback = Config.Callback,
		Transparency = Config.Transparency,
		UIElements = Config.UIElements,

		TextPadding = 10,
	}

	local Connections = {}
	local IsTransparency = Colorpicker.Transparency ~= nil

	function Colorpicker:SetHSVFromRGB(Color)
		local H, S, V = Color3.toHSV(Color)
		Colorpicker.Hue = H
		Colorpicker.Sat = S
		Colorpicker.Vib = V
	end

	Colorpicker:SetHSVFromRGB(Colorpicker.Default)

	local ColorpickerModule = require("../components/window/Dialog")
	local ColorpickerFrame = ColorpickerModule.Create(nil, "Dialog", Window, WindUI, Window.UIElements.Main.Main)

	Colorpicker.ColorpickerFrame = ColorpickerFrame

	ColorpickerFrame.UIElements.Main.Size = UDim2.new(1, 0, 0, 0)

	--ColorpickerFrame:Close()

	local Hue, Sat, Vib = Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib

	Colorpicker.UIElements.Title = New("TextLabel", {
		Text = Colorpicker.Title,
		TextSize = 20,
		FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
		TextXAlignment = "Left",
		Size = UDim2.new(0, 0, 0, 0),
		AutomaticSize = "Y",
		ThemeTag = {
			TextColor3 = "Text",
		},
		BackgroundTransparency = 1,
		Parent = ColorpickerFrame.UIElements.Main,
	}, {
		New("UIPadding", {
			PaddingTop = UDim.new(0, Colorpicker.TextPadding / 2),
			PaddingLeft = UDim.new(0, Colorpicker.TextPadding / 2),
			PaddingRight = UDim.new(0, Colorpicker.TextPadding / 2),
			PaddingBottom = UDim.new(0, Colorpicker.TextPadding / 2),
		}),
	})

	-- Colorpicker.UIElements.Title:GetPropertyChangedSignal("TextBounds"):Connect(function()
	--     Colorpicker.UIElements.Title.Size = UDim2.new(1,0,0,Colorpicker.UIElements.Title.TextBounds.Y)
	-- end)

	local HueDragHolder = New("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1,
	})

	local SatCursor = New("Frame", {
		Size = UDim2.new(0, 14, 0, 14),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0, 0),
		Parent = HueDragHolder,
		BackgroundColor3 = Colorpicker.Default,
	}, {
		New("UIStroke", {
			Thickness = 2,
			Transparency = 0.1,
			ThemeTag = {
				Color = "Text",
			},
		}),
		New("UICorner", {
			CornerRadius = UDim.new(1, 0),
		}),
	})

	Colorpicker.UIElements.SatVibMap = New("ImageLabel", {
		Size = UDim2.fromOffset(160, 182 - 24),
		Position = UDim2.fromOffset(0, 40 + Colorpicker.TextPadding),
		Image = "rbxassetid://4155801252",
		BackgroundColor3 = Color3.fromHSV(Hue, 1, 1),
		BackgroundTransparency = 0,
		Parent = ColorpickerFrame.UIElements.Main,
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),
		Creator.NewRoundFrame(8, "SquircleOutline", {
			ThemeTag = {
				ImageColor3 = "Outline",
			},
			Size = UDim2.new(1, 0, 1, 0),
			ImageTransparency = 0.85,
			ZIndex = 99999,
		}, {
			New("UIGradient", {
				Rotation = 45,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 255, 255)),
				}),
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0.0, 0.1),
					NumberSequenceKeypoint.new(0.5, 1),
					NumberSequenceKeypoint.new(1.0, 0.1),
				}),
			}),
		}),

		SatCursor,
	})

	Colorpicker.UIElements.Inputs = New("Frame", {
		AutomaticSize = "XY",
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.fromOffset(
			IsTransparency and 160 + 10 + 10 + 10 + 10 + 10 + 10 + 20 or 160 + 10 + 10 + 10 + 20,
			40 + Colorpicker.TextPadding
		),
		BackgroundTransparency = 1,
		Parent = ColorpickerFrame.UIElements.Main,
	}, {
		New("UIListLayout", {
			Padding = UDim.new(0, 4),
			FillDirection = "Vertical",
		}),
	})

	--	Colorpicker.UIElements.Inputs.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	--         Colorpicker.UIElements.Inputs.Size = UDim2.new(0,Colorpicker.UIElements.Inputs.UIListLayout.AbsoluteContentSize.X,0,Colorpicker.UIElements.Inputs.UIListLayout.AbsoluteContentSize.Y)
	--     end)

	local OldColorFrame = New("Frame", {
		BackgroundColor3 = Colorpicker.Default,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = Colorpicker.Transparency,
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),
	})

	local OldColorFrameChecker = New("ImageLabel", {
		Image = "http://www.roblox.com/asset/?id=14204231522",
		ImageTransparency = 0.45,
		ScaleType = Enum.ScaleType.Tile,
		TileSize = UDim2.fromOffset(40, 40),
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(75 + 10, 40 + 182 - 24 + 10 + Colorpicker.TextPadding),
		Size = UDim2.fromOffset(75, 24),
		Parent = ColorpickerFrame.UIElements.Main,
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),
		Creator.NewRoundFrame(8, "SquircleOutline", {
			ThemeTag = {
				ImageColor3 = "Outline",
			},
			Size = UDim2.new(1, 0, 1, 0),
			ImageTransparency = 0.85,
			ZIndex = 99999,
		}, {
			New("UIGradient", {
				Rotation = 60,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 255, 255)),
				}),
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0.0, 0.1),
					NumberSequenceKeypoint.new(0.5, 1),
					NumberSequenceKeypoint.new(1.0, 0.1),
				}),
			}),
		}),
		--		New("UIStroke", {
		--			Thickness = 1,
		--			Transparency = 0.8,
		--			ThemeTag = {
		--			    Color = "Text"
		--			}
		--		}),
		OldColorFrame,
	})

	local NewDisplayFrame = New("Frame", {
		BackgroundColor3 = Colorpicker.Default,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 0,
		ZIndex = 9,
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),
	})

	local NewDisplayFrameChecker = New("ImageLabel", {
		Image = "http://www.roblox.com/asset/?id=14204231522",
		ImageTransparency = 0.45,
		ScaleType = Enum.ScaleType.Tile,
		TileSize = UDim2.fromOffset(40, 40),
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, 40 + 182 - 24 + 10 + Colorpicker.TextPadding),
		Size = UDim2.fromOffset(75, 24),
		Parent = ColorpickerFrame.UIElements.Main,
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),
		--		New("UIStroke", {
		--			Thickness = 1,
		--			Transparency = 0.8,
		--			ThemeTag = {
		--			    Color = "Text"
		--			}
		--		}),
		Creator.NewRoundFrame(8, "SquircleOutline", {
			ThemeTag = {
				ImageColor3 = "Outline",
			},
			Size = UDim2.new(1, 0, 1, 0),
			ImageTransparency = 0.85,
			ZIndex = 99999,
		}, {
			New("UIGradient", {
				Rotation = 60,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 255, 255)),
				}),
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0.0, 0.1),
					NumberSequenceKeypoint.new(0.5, 1),
					NumberSequenceKeypoint.new(1.0, 0.1),
				}),
			}),
		}),
		NewDisplayFrame,
	})

	local SequenceTable = {}

	for Color = 0, 1, 0.1 do
		table.insert(SequenceTable, ColorSequenceKeypoint.new(Color, Color3.fromHSV(Color, 1, 1)))
	end

	local HueSliderGradient = New("UIGradient", {
		Color = ColorSequence.new(SequenceTable),
		Rotation = 90,
	})

	local HueDrag = New("Frame", {
		Size = UDim2.new(0, 14, 0, 14),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0, 0),
		Parent = HueDragHolder,
		--Image = "rbxassetid://18747052224",
		--ScaleType = "Crop",
		BackgroundColor3 = Colorpicker.Default,
	}, {
		New("UIStroke", {
			Thickness = 2,
			Transparency = 0.1,
			ThemeTag = {
				Color = "Text",
			},
		}),
		New("UICorner", {
			CornerRadius = UDim.new(1, 0),
		}),
	})

	local HueSlider = New("Frame", {
		Size = UDim2.fromOffset(6, 182 + 10),
		Position = UDim2.fromOffset(160 + 10 + 10, 40 + Colorpicker.TextPadding),
		Parent = ColorpickerFrame.UIElements.Main,
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(1, 0),
		}),
		HueSliderGradient,
		HueDragHolder,
	})

	local function CreateNewInput(Title, Value)
		local InputFrame = CreateInput(Title, nil, Colorpicker.UIElements.Inputs, nil, nil, nil, nil, nil, true)

		New("TextLabel", {
			BackgroundTransparency = 1,
			TextTransparency = 0.4,
			TextSize = 17,
			FontFace = Font.new(Creator.Font, Enum.FontWeight.Regular),
			AutomaticSize = "XY",
			ThemeTag = {
				TextColor3 = "Placeholder",
			},
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -12, 0.5, 0),
			Parent = InputFrame.Frame,
			Text = Title,
		})

		New("UIScale", {
			Parent = InputFrame,
			Scale = 0.85,
		})

		InputFrame.Frame.Frame.TextBox.Text = Value
		InputFrame.Size = UDim2.new(0, 30 * 5, 0, 42)

		return InputFrame
	end

	local function ToRGB(color)
		return {
			R = math.floor(color.R * 255),
			G = math.floor(color.G * 255),
			B = math.floor(color.B * 255),
		}
	end

	local HexInput = CreateNewInput("Hex", "#" .. Colorpicker.Default:ToHex())

	local RedInput = CreateNewInput("Red", ToRGB(Colorpicker.Default)["R"])
	local GreenInput = CreateNewInput("Green", ToRGB(Colorpicker.Default)["G"])
	local BlueInput = CreateNewInput("Blue", ToRGB(Colorpicker.Default)["B"])
	local AlphaInput
	if IsTransparency then
		AlphaInput = CreateNewInput("Alpha", ((1 - Colorpicker.Transparency) * 100) .. "%")
	end

	local ButtonsContent = New("Frame", {
		Size = UDim2.new(0, 0, 0, 40),
		AutomaticSize = "Y",
		Position = UDim2.new(0, 0, 0, 40 + 8 + 182 + 24 + Colorpicker.TextPadding),
		BackgroundTransparency = 1,
		Parent = ColorpickerFrame.UIElements.Main,
		LayoutOrder = 4,
	}, {
		New("UIListLayout", {
			Padding = UDim.new(0, 6),
			FillDirection = "Horizontal",
			HorizontalAlignment = "Right",
		}),
		-- New("UIPadding", {
		--         PaddingTop = UDim.new(0, Colorpicker.TextPadding/2),
		--         PaddingLeft = UDim.new(0, Colorpicker.TextPadding/2),
		--         PaddingRight = UDim.new(0, Colorpicker.TextPadding/2),
		--         PaddingBottom = UDim.new(0, Colorpicker.TextPadding/2),
		--     })
	})

	Creator.AddSignal(ColorpickerFrame.UIElements.Main:GetPropertyChangedSignal("AbsoluteSize"), function()
		Colorpicker.UIElements.Title.Size = UDim2.new(
			0,
			ColorpickerFrame.UIElements.Main.AbsoluteSize.X / Config.UIScale - (ColorpickerFrame.UIPadding * 2),
			0,
			0
		)
		ButtonsContent.Size = UDim2.new(
			0,
			ColorpickerFrame.UIElements.Main.AbsoluteSize.X / Config.UIScale - ColorpickerFrame.UIPadding * 2,
			0,
			40
		)
	end)

	local Buttons = {
		{
			Title = "Cancel",
			Variant = "Secondary",
			Callback = function()
				Config.IsShowed = false
				for _, Conn in next, Connections do
					Conn:Disconnect()
				end
				Connections = {}
			end,
		},
		{
			Title = "Apply",
			--Icon = "chevron-right",
			Variant = "Primary",
			Callback = function()
				Config.IsShowed = false
				for _, Conn in next, Connections do
					Conn:Disconnect()
				end
				Connections = {}

				OnApply(Color3.fromHSV(Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib), Colorpicker.Transparency)
			end,
		},
	}

	for _, Button in next, Buttons do
		local ButtonFrame = CreateButton(
			Button.Title,
			Button.Icon,
			Button.Callback,
			Button.Variant,
			ButtonsContent,
			ColorpickerFrame,
			true
		)
		ButtonFrame.Size = UDim2.new(0.5, -3, 0, 40)
		ButtonFrame.AutomaticSize = "None"
	end

	local TransparencySlider, TransparencyDrag, TransparencyColor
	if IsTransparency then
		local TransparencyDragHolder = New("Frame", {
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.fromOffset(0, 0),
			BackgroundTransparency = 1,
		})

		TransparencyDrag = New("ImageLabel", {
			Size = UDim2.new(0, 14, 0, 14),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 0),
			ThemeTag = {
				BackgroundColor3 = "Text",
			},
			Parent = TransparencyDragHolder,
		}, {
			New("UIStroke", {
				Thickness = 2,
				Transparency = 0.1,
				ThemeTag = {
					Color = "Text",
				},
			}),
			New("UICorner", {
				CornerRadius = UDim.new(1, 0),
			}),
		})

		TransparencyColor = New("Frame", {
			Size = UDim2.fromScale(1, 1),
		}, {
			New("UIGradient", {
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0),
					NumberSequenceKeypoint.new(1, 1),
				}),
				Rotation = 270,
			}),
			New("UICorner", {
				CornerRadius = UDim.new(0, 6),
			}),
		})

		TransparencySlider = New("Frame", {
			Size = UDim2.fromOffset(6, 182 + 10),
			Position = UDim2.fromOffset(160 + 10 + 10 + 10 + 10 + 10, 40 + Colorpicker.TextPadding),
			Parent = ColorpickerFrame.UIElements.Main,
			BackgroundTransparency = 1,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(1, 0),
			}),
			New("ImageLabel", {
				Image = "rbxassetid://14204231522",
				ImageTransparency = 0.45,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(40, 40),
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
			}),
			TransparencyColor,
			TransparencyDragHolder,
		})
	end

	function Colorpicker:Round(Number, Factor)
		if Factor == 0 then
			return math.floor(Number)
		end
		Number = tostring(Number)
		return Number:find("%.") and tonumber(Number:sub(1, Number:find("%.") + Factor)) or Number
	end

	function Colorpicker:Update(color, transparency)
		if color then
			Hue, Sat, Vib = Color3.toHSV(color)
		else
			Hue, Sat, Vib = Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib
		end

		Colorpicker.UIElements.SatVibMap.BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)
		SatCursor.Position = UDim2.new(Sat, 0, 1 - Vib, 0)
		SatCursor.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)
		NewDisplayFrame.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)
		HueDrag.BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)
		HueDrag.Position = UDim2.new(0.5, 0, Hue, 0)

		HexInput.Frame.Frame.TextBox.Text = "#" .. Color3.fromHSV(Hue, Sat, Vib):ToHex()
		RedInput.Frame.Frame.TextBox.Text = ToRGB(Color3.fromHSV(Hue, Sat, Vib))["R"]
		GreenInput.Frame.Frame.TextBox.Text = ToRGB(Color3.fromHSV(Hue, Sat, Vib))["G"]
		BlueInput.Frame.Frame.TextBox.Text = ToRGB(Color3.fromHSV(Hue, Sat, Vib))["B"]

		if transparency or IsTransparency then
			NewDisplayFrame.BackgroundTransparency = Colorpicker.Transparency or transparency
			TransparencyColor.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)
			TransparencyDrag.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)
			TransparencyDrag.BackgroundTransparency = Colorpicker.Transparency or transparency
			TransparencyDrag.Position = UDim2.new(0.5, 0, 1 - Colorpicker.Transparency or transparency, 0)
			AlphaInput.Frame.Frame.TextBox.Text = Colorpicker:Round(
				(1 - Colorpicker.Transparency or transparency) * 100,
				0
			) .. "%"
		end
	end

	Colorpicker:Update(Colorpicker.Default, Colorpicker.Transparency)

	local function GetRGB()
		local Value = Color3.fromHSV(Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib)
		return { R = math.floor(Value.r * 255), G = math.floor(Value.g * 255), B = math.floor(Value.b * 255) }
	end

	-- oh no!

	local function clamp(val, min, max)
		return math.clamp(tonumber(val) or 0, min, max)
	end

	table.insert(
		Connections,
		Creator.AddSignal(HexInput.Frame.Frame.TextBox.FocusLost, function(Enter)
			if Enter then
				local hex = HexInput.Frame.Frame.TextBox.Text:gsub("#", "")
				local Success, Result = pcall(Color3.fromHex, hex)
				if Success and typeof(Result) == "Color3" then
					Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib = Color3.toHSV(Result)
					Colorpicker:Update()
					Colorpicker.Default = Result
				end
			end
		end)
	)

	local function updateColorFromInput(inputBox, component)
		Creator.AddSignal(inputBox.Frame.Frame.TextBox.FocusLost, function(Enter)
			if Enter then
				local textBox = inputBox.Frame.Frame.TextBox
				local current = GetRGB()
				local clamped = clamp(textBox.Text, 0, 255)
				textBox.Text = tostring(clamped)

				current[component] = clamped
				local Result = Color3.fromRGB(current.R, current.G, current.B)
				Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib = Color3.toHSV(Result)
				Colorpicker:Update()
			end
		end)
	end

	updateColorFromInput(RedInput, "R")
	updateColorFromInput(GreenInput, "G")
	updateColorFromInput(BlueInput, "B")

	if IsTransparency then
		Creator.AddSignal(AlphaInput.Frame.Frame.TextBox.FocusLost, function(Enter)
			if Enter then
				local textBox = AlphaInput.Frame.Frame.TextBox
				local clamped = clamp(textBox.Text, 0, 100)
				textBox.Text = tostring(clamped)

				Colorpicker.Transparency = 1 - clamped * 0.01
				Colorpicker:Update(nil, Colorpicker.Transparency)
			end
		end)
	end

	-- fu

	local function UpdateSatVib(SatVibMap, Colorpicker)
		local MinX = SatVibMap.AbsolutePosition.X
		local MaxX = MinX + SatVibMap.AbsoluteSize.X
		local MinY = SatVibMap.AbsolutePosition.Y
		local MaxY = MinY + SatVibMap.AbsoluteSize.Y

		local MouseX = math.clamp(Mouse.X, MinX, MaxX)
		local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

		Colorpicker.Sat = (MouseX - MinX) / (MaxX - MinX)
		Colorpicker.Vib = 1 - ((MouseY - MinY) / (MaxY - MinY))

		Colorpicker:Update()
	end

	local function UpdateHue(HueSlider, Colorpicker)
		local MinY = HueSlider.AbsolutePosition.Y
		local MaxY = MinY + HueSlider.AbsoluteSize.Y

		local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

		Colorpicker.Hue = (MouseY - MinY) / (MaxY - MinY)

		Colorpicker:Update()
	end

	local function UpdateTransparency(TransparencySlider, Colorpicker)
		local MinY = TransparencySlider.AbsolutePosition.Y
		local MaxY = MinY + TransparencySlider.AbsoluteSize.Y

		local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

		Colorpicker.Transparency = 1 - ((MouseY - MinY) / (MaxY - MinY))

		Colorpicker:Update()
	end

	local CurInput = WindUI.GenerateGUID()

	table.insert(
		Connections,
		UserInputService.InputChanged:Connect(function(input)
			if
				input.UserInputType ~= Enum.UserInputType.MouseMovement
				and input.UserInputType ~= Enum.UserInputType.Touch
			then
				return
			end

			if ActiveSlider == "SatVib" then
				UpdateSatVib(Colorpicker.UIElements.SatVibMap, Colorpicker)
			elseif ActiveSlider == "Hue" then
				UpdateHue(HueSlider, Colorpicker)
			elseif ActiveSlider == "Transparency" then
				UpdateTransparency(TransparencySlider, Colorpicker)
			end
		end)
	)

	table.insert(
		Connections,
		Colorpicker.UIElements.SatVibMap.InputBegan:Connect(function(input)
			if
				input.UserInputType ~= Enum.UserInputType.MouseButton1
				and input.UserInputType ~= Enum.UserInputType.Touch
			then
				return
			end

			if WindUI.CurrentInput and WindUI.CurrentInput ~= CurInput then
				return
			end
			WindUI.CurrentInput = CurInput

			if ActiveSlider and ActiveSlider ~= "SatVib" then
				return
			end

			ActiveSlider = "SatVib"

			UpdateSatVib(Colorpicker.UIElements.SatVibMap, Colorpicker)
		end)
	)

	table.insert(
		Connections,
		HueSlider.InputBegan:Connect(function(input)
			if
				input.UserInputType ~= Enum.UserInputType.MouseButton1
				and input.UserInputType ~= Enum.UserInputType.Touch
			then
				return
			end

			if WindUI.CurrentInput and WindUI.CurrentInput ~= CurInput then
				return
			end
			WindUI.CurrentInput = CurInput

			if ActiveSlider and ActiveSlider ~= "Hue" then
				return
			end

			ActiveSlider = "Hue"

			UpdateHue(HueSlider, Colorpicker)
		end)
	)

	if TransparencySlider then
		table.insert(
			Connections,
			TransparencySlider.InputBegan:Connect(function(input)
				if
					input.UserInputType ~= Enum.UserInputType.MouseButton1
					and input.UserInputType ~= Enum.UserInputType.Touch
				then
					return
				end

				if WindUI.CurrentInput and WindUI.CurrentInput ~= CurInput then
					return
				end
				WindUI.CurrentInput = CurInput

				if ActiveSlider and ActiveSlider ~= "Transparency" then
					return
				end

				ActiveSlider = "Transparency"

				UpdateTransparency(TransparencySlider, Colorpicker)
			end)
		)
	end

	table.insert(
		Connections,
		UserInputService.InputEnded:Connect(function(input)
			ActiveSlider = nil

			if WindUI.CurrentInput and WindUI.CurrentInput ~= CurInput then
				return
			end
			WindUI.CurrentInput = nil
		end)
	)

	return Colorpicker
end

function Element:New(Config)
	local Colorpicker = {
		__type = "Colorpicker",
		Title = Config.Title or "Colorpicker",
		Desc = Config.Desc or nil,
		Locked = Config.Locked or false,
		LockedTitle = Config.LockedTitle,
		Default = Config.Default or Color3.new(1, 1, 1),
		Callback = Config.Callback or function() end,
		--Window = Config.Window,
		UIScale = Config.UIScale,
		Transparency = Config.Transparency,
		UIElements = {},

		IsShowed = false,
	}

	local CanCallback = true

	--if Config.Window.NewElements then Element.UICorner = 14 end

	Colorpicker.ColorpickerFrame = require("../components/window/Element")({
		Title = Colorpicker.Title,
		Desc = Colorpicker.Desc,
		Parent = Config.Parent,
		TextOffset = 40,
		Hover = false,
		Tab = Config.Tab,
		Index = Config.Index,
		Window = Config.Window,
		ElementTable = Colorpicker,
		ParentConfig = Config,
		Tags = Config.Tags,
	})

	Colorpicker.UIElements.Colorpicker = Creator.NewRoundFrame(Element.UICorner, "Squircle", {
		ImageTransparency = 0,
		Active = true,
		ImageColor3 = Colorpicker.Default,
		Parent = Colorpicker.ColorpickerFrame.UIElements.Main,
		Size = UDim2.new(0, 26, 0, 26),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 0),
		ZIndex = 2,
	}, {
		Creator.NewRoundFrame(Element.UICorner, "SquircleGlass", {
			Size = UDim2.new(1, 0, 1, 0),
			ThemeTag = {
				ImageColor3 = "Outline",
			},
			ImageTransparency = 0.55,
		}),
	}, true)

	function Colorpicker:Lock()
		Colorpicker.Locked = true
		CanCallback = false
		return Colorpicker.ColorpickerFrame:Lock(Colorpicker.LockedTitle)
	end
	function Colorpicker:Unlock()
		Colorpicker.Locked = false
		CanCallback = true
		return Colorpicker.ColorpickerFrame:Unlock()
	end

	if Colorpicker.Locked then
		Colorpicker:Lock()
	end

	function Colorpicker:Update(Color, Transparency)
		Colorpicker.UIElements.Colorpicker.ImageTransparency = Transparency or 0
		Colorpicker.UIElements.Colorpicker.ImageColor3 = Color
		Colorpicker.Default = Color
		if Transparency then
			Colorpicker.Transparency = Transparency
		end
	end

	function Colorpicker:Set(c, t)
		return Colorpicker:Update(c, t)
	end

	Creator.AddSignal(Colorpicker.UIElements.Colorpicker.MouseButton1Click, function()
		if CanCallback and not Colorpicker.IsShowed then
			Colorpicker.IsShowed = true

			Element:Colorpicker(Colorpicker, Config.Window, Config.WindUI, function(color, transparency)
				Colorpicker:Update(color, transparency)
				Colorpicker.Default = color
				Colorpicker.Transparency = transparency
				Creator.SafeCallback(Colorpicker.Callback, color, transparency)
			end).ColorpickerFrame
				:Open()
		end
	end)

	return Colorpicker.__type, Colorpicker
end

return Element
