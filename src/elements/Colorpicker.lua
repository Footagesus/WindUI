local Creator = require("../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween

local cloneref = (cloneref or clonereference or function(instance) return instance end)

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

function Element:Colorpicker(Config, Window, OnApply)
    local Colorpicker = {
        __type = "Colorpicker",
        Title = Config.Title,
        Desc = Config.Desc,
        Default = Config.Default,
        Callback = Config.Callback,
        Transparency = Config.Transparency,
        UIElements = Config.UIElements,
        
        TextPadding = 10,
    }
    
    function Colorpicker:SetHSVFromRGB(Color)
		local H, S, V = Color3.toHSV(Color)
		Colorpicker.Hue = H
		Colorpicker.Sat = S
		Colorpicker.Vib = V
	end

	Colorpicker:SetHSVFromRGB(Colorpicker.Default)
    
    local ColorpickerModule = require("../components/window/Dialog").Init(Window)
    local ColorpickerFrame = ColorpickerModule.Create()
    
    Colorpicker.ColorpickerFrame = ColorpickerFrame
    
    ColorpickerFrame.UIElements.Main.Size = UDim2.new(1,0,0,0)
    
    --ColorpickerFrame:Close()
    
    local Hue, Sat, Vib = Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib

    Colorpicker.UIElements.Title = New("TextLabel", {
        Text = Colorpicker.Title,
        TextSize = 20,
        FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
        TextXAlignment = "Left",
        Size = UDim2.new(1,0,0,0),
        AutomaticSize = "Y",
        ThemeTag = {
            TextColor3 = "Text"
        },
        BackgroundTransparency = 1,
        Parent = ColorpickerFrame.UIElements.Main
    }, {
        New("UIPadding", {
            PaddingTop = UDim.new(0,Colorpicker.TextPadding/2),
            PaddingLeft = UDim.new(0,Colorpicker.TextPadding/2),
            PaddingRight = UDim.new(0,Colorpicker.TextPadding/2),
            PaddingBottom = UDim.new(0,Colorpicker.TextPadding/2),
        })
    })
    
    -- Colorpicker.UIElements.Title:GetPropertyChangedSignal("TextBounds"):Connect(function()
    --     Colorpicker.UIElements.Title.Size = UDim2.new(1,0,0,Colorpicker.UIElements.Title.TextBounds.Y)
    -- end)

    local SatCursor = New("Frame", {
		Size = UDim2.new(0,14,0,14),
		AnchorPoint = Vector2.new(0.5,0.5),
		Position = UDim2.new(0.5,0,0,0),
		Parent = HueDragHolder,
		BackgroundColor3 = Colorpicker.Default
	}, {
        New("UIStroke", {
            Thickness = 2,
            Transparency = .1,
            ThemeTag = {
			    Color = "Text",
            },
        }),
        New("UICorner", {
            CornerRadius = UDim.new(1,0),
        })
	})

    Colorpicker.UIElements.SatVibMap = New("ImageLabel", {
        Size = UDim2.fromOffset(160, 182-24),
        Position = UDim2.fromOffset(0, 40+Colorpicker.TextPadding),
        Image = "rbxassetid://4155801252",
        BackgroundColor3 = Color3.fromHSV(Hue, 1, 1),
        BackgroundTransparency = 0,
        Parent = ColorpickerFrame.UIElements.Main,
      }, {
        New("UICorner", {
            CornerRadius = UDim.new(0,8),
        }),
        Creator.NewRoundFrame(8, "SquircleOutline", {
            ThemeTag = {
                ImageColor3 = "Outline",
            },
            Size = UDim2.new(1,0,1,0),
            ImageTransparency = .85,
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
                })
            })
        }),
    
        SatCursor,
      })
      
  	Colorpicker.UIElements.Inputs = New("Frame", {
  	    AutomaticSize = "XY",
  	    Size = UDim2.new(0,0,0,0),
  	    Position = UDim2.fromOffset(Colorpicker.Transparency and 160+10+10+10+10+10+10+20 or 160+10+10+10+20, 40 + Colorpicker.TextPadding),
  	    BackgroundTransparency = 1,
  	    Parent = ColorpickerFrame.UIElements.Main
  	}, {
  	    New("UIListLayout", {
  		    Padding = UDim.new(0, 4),
  		    FillDirection = "Vertical",
  	    })
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
		Position = UDim2.fromOffset(75+10, 40+182-24+10 + Colorpicker.TextPadding),
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
            Size = UDim2.new(1,0,1,0),
            ImageTransparency = .85,
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
                })
            })
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
  		Position = UDim2.fromOffset(0, 40+182-24+10 + Colorpicker.TextPadding),
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
            Size = UDim2.new(1,0,1,0),
            ImageTransparency = .85,
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
                })
            })
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
	
	local HueDragHolder = New("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0,0,0,0),
		BackgroundTransparency = 1,
	})

	local HueDrag = New("Frame", {
		Size = UDim2.new(0,14,0,14),
		AnchorPoint = Vector2.new(0.5,0.5),
		Position = UDim2.new(0.5,0,0,0),
		Parent = HueDragHolder,
		--Image = "rbxassetid://18747052224",
		--ScaleType = "Crop",
		BackgroundColor3 = Colorpicker.Default
	}, {
        New("UIStroke", {
            Thickness = 2,
            Transparency = .1,
            ThemeTag = {
			    Color = "Text",
            },
        }),
        New("UICorner", {
            CornerRadius = UDim.new(1,0),
        })
	})

	local HueSlider = New("Frame", {
		Size = UDim2.fromOffset(6, 182+10),
		Position = UDim2.fromOffset(160+10+10, 40 + Colorpicker.TextPadding),
		Parent = ColorpickerFrame.UIElements.Main,
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(1,0),
		}),
		HueSliderGradient,
		HueDragHolder,
	})
	
	
	function CreateNewInput(Title, Value)
	    local InputFrame = CreateInput(Title, nil, Colorpicker.UIElements.Inputs)
	    
	    New("TextLabel", {
	        BackgroundTransparency = 1,
	        TextTransparency = .4,
            TextSize = 17,
            FontFace = Font.new(Creator.Font, Enum.FontWeight.Regular),
            AutomaticSize = "XY",
            ThemeTag = {
                TextColor3 = "Placeholder",
            },
            AnchorPoint = Vector2.new(1,0.5),
            Position = UDim2.new(1,-12,0.5,0),
            Parent = InputFrame.Frame,
            Text = Title,
	    })
	    
	    New("UIScale", {
            Parent = InputFrame,
            Scale = .85,
        })
	    
	    InputFrame.Frame.Frame.TextBox.Text = Value
	    InputFrame.Size = UDim2.new(0,30*5,0,42)
	    
	    return InputFrame
	end
	
	local function ToRGB(color)
        return {
            R = math.floor(color.R * 255),
            G = math.floor(color.G * 255),
            B = math.floor(color.B * 255)
        }
    end
	
	local HexInput = CreateNewInput("Hex", "#" .. Colorpicker.Default:ToHex())
	
	local RedInput = CreateNewInput("Red", ToRGB(Colorpicker.Default)["R"])
	local GreenInput = CreateNewInput("Green", ToRGB(Colorpicker.Default)["G"])
	local BlueInput = CreateNewInput("Blue", ToRGB(Colorpicker.Default)["B"])
	local AlphaInput
	if Colorpicker.Transparency then
	    AlphaInput = CreateNewInput("Alpha", ((1 - Colorpicker.Transparency) * 100) .. "%")
	end
	
	local ButtonsContent = New("Frame", {
        Size = UDim2.new(1,0,0,40),
        AutomaticSize = "Y",
        Position = UDim2.new(0,0,0,40+8+182+24 + Colorpicker.TextPadding),
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
	
	local Buttons = {
	    {
	        Title = "Cancel",
	        Variant = "Secondary",
	        Callback = function() end
	    },
	    {
	        Title = "Apply",
	        Icon = "chevron-right",
	        Variant = "Primary",
	        Callback = function() OnApply(Color3.fromHSV(Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib), Colorpicker.Transparency) end
	    }
	}
	
	for _,Button in next, Buttons do
        local ButtonFrame = CreateButton(Button.Title, Button.Icon, Button.Callback, Button.Variant, ButtonsContent, ColorpickerFrame, false)
        ButtonFrame.Size = UDim2.new(0.5,-3,0,40)
        ButtonFrame.AutomaticSize = "None"
    end
        
	
	
	local TransparencySlider, TransparencyDrag, TransparencyColor
	if Colorpicker.Transparency then
		local TransparencyDragHolder = New("Frame", {
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.fromOffset(0, 0),
			BackgroundTransparency = 1,
		})

		TransparencyDrag = New("ImageLabel", {
		    Size = UDim2.new(0,14,0,14),
		    AnchorPoint = Vector2.new(0.5,0.5),
		    Position = UDim2.new(0.5,0,0,0),
		    ThemeTag = {
		        BackgroundColor3 = "Text",
		    },
			Parent = TransparencyDragHolder,
			
		}, {
            New("UIStroke", {
                Thickness = 2,
                Transparency = .1,
                ThemeTag = {
		            Color = "Text",
                },
            }),
            New("UICorner", {
                CornerRadius = UDim.new(1,0),
            })
		    
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
			Size = UDim2.fromOffset(6, 182+10),
			Position = UDim2.fromOffset(160+10+10+10+10+10, 40 + Colorpicker.TextPadding),
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
					CornerRadius = UDim.new(1,0),
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
        if color then Hue, Sat, Vib = Color3.toHSV(color) else Hue, Sat, Vib = Colorpicker.Hue,Colorpicker.Sat,Colorpicker.Vib end
            
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
        
        if transparency or Colorpicker.Transparency then
			NewDisplayFrame.BackgroundTransparency =  Colorpicker.Transparency or transparency
            TransparencyColor.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)
            TransparencyDrag.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)
			TransparencyDrag.BackgroundTransparency =  Colorpicker.Transparency or transparency
			TransparencyDrag.Position = UDim2.new(0.5, 0, 1 -  Colorpicker.Transparency or transparency, 0)
			AlphaInput.Frame.Frame.TextBox.Text = Colorpicker:Round((1 - Colorpicker.Transparency or transparency) * 100, 0) .. "%"
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
    
    if Colorpicker.Transparency then
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
    
    local SatVibMap = Colorpicker.UIElements.SatVibMap
    Creator.AddSignal(SatVibMap.InputBegan, function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
				local MinX = SatVibMap.AbsolutePosition.X
				local MaxX = MinX + SatVibMap.AbsoluteSize.X
				local MouseX = math.clamp(Mouse.X, MinX, MaxX)

				local MinY = SatVibMap.AbsolutePosition.Y
				local MaxY = MinY + SatVibMap.AbsoluteSize.Y
				local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

				Colorpicker.Sat = (MouseX - MinX) / (MaxX - MinX)
				Colorpicker.Vib = 1 - ((MouseY - MinY) / (MaxY - MinY))
				Colorpicker:Update()

				RenderStepped:Wait()
			end
		end
    end)

    Creator.AddSignal(HueSlider.InputBegan, function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
				local MinY = HueSlider.AbsolutePosition.Y
				local MaxY = MinY + HueSlider.AbsoluteSize.Y
				local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

				Colorpicker.Hue = ((MouseY - MinY) / (MaxY - MinY))
				Colorpicker:Update()

				RenderStepped:Wait()
			end
		end
    end)
    
    if Colorpicker.Transparency then
		Creator.AddSignal(TransparencySlider.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
					local MinY = TransparencySlider.AbsolutePosition.Y
					local MaxY = MinY + TransparencySlider.AbsoluteSize.Y
					local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

					Colorpicker.Transparency = 1 - ((MouseY - MinY) / (MaxY - MinY))
					Colorpicker:Update()

					RenderStepped:Wait()
				end
			end
		end)
    end
	
    return Colorpicker
end

function Element:New(Config) 
    local Colorpicker = {
        __type = "Colorpicker",
        Title = Config.Title or "Colorpicker",
        Desc = Config.Desc or nil,
        Locked = Config.Locked or false,
        LockedTitle = Config.LockedTitle,
        Default = Config.Default or Color3.new(1,1,1),
        Callback = Config.Callback or function() end,
        --Window = Config.Window,
        UIScale = Config.UIScale,
        Transparency = Config.Transparency,
        UIElements = {}
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
    })
    
    Colorpicker.UIElements.Colorpicker = Creator.NewRoundFrame(Element.UICorner, "Squircle",{
        ImageTransparency = 0,
        Active = true,
        ImageColor3 = Colorpicker.Default,
        Parent = Colorpicker.ColorpickerFrame.UIElements.Main,
        Size = UDim2.new(0,26,0,26),
        AnchorPoint = Vector2.new(1,0),
        Position = UDim2.new(1,0,0,0),
        ZIndex = 2
    }, nil, true)
    
    
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

    
    function Colorpicker:Update(Color,Transparency)
        Colorpicker.UIElements.Colorpicker.ImageTransparency = Transparency or 0
        Colorpicker.UIElements.Colorpicker.ImageColor3 = Color
        Colorpicker.Default = Color
        if Transparency then
            Colorpicker.Transparency = Transparency
        end
    end
    
    function Colorpicker:Set(c,t)
        return Colorpicker:Update(c,t)
    end
    
    Creator.AddSignal(Colorpicker.UIElements.Colorpicker.MouseButton1Click, function()
        if CanCallback then
            Element:Colorpicker(Colorpicker, Config.Window, function(color, transparency)
                Colorpicker:Update(color, transparency)
                Colorpicker.Default = color
                Colorpicker.Transparency = transparency
                Creator.SafeCallback(Colorpicker.Callback, color, transparency)
            end).ColorpickerFrame:Open()
        end
    end)
    
    return Colorpicker.__type, Colorpicker
end

return Element