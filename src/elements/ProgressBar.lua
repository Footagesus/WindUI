local Creator = require("../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween

local Element = {}

local function ToFiniteNumber(Value)
	local Number = tonumber(Value)
	if Number == nil or Number ~= Number or math.abs(Number) == math.huge then
		return nil
	end

	return Number
end

local function FormatNumber(Value)
	if Value % 1 == 0 then
		return tostring(Value)
	end

	return tostring(tonumber(string.format("%.2f", Value)))
end

function Element:New(Config)
	local ValueConfig = typeof(Config.Value) == "table" and Config.Value or {}
	local Min = ToFiniteNumber(ValueConfig.Min) or ToFiniteNumber(Config.Min) or 0
	local Max = ToFiniteNumber(ValueConfig.Max) or ToFiniteNumber(Config.Max) or 100

	if Min > Max then
		Min, Max = Max, Min
	end

	local DefaultValue = typeof(Config.Value) == "number" and Config.Value
		or ToFiniteNumber(ValueConfig.Default)
		or ToFiniteNumber(Config.Default)
		or Min
	DefaultValue = ToFiniteNumber(DefaultValue) or Min

	local Indeterminate = Config.Indeterminate == true

	local ShowValue = Config.ShowValue
	if ShowValue == nil then
		ShowValue = not Indeterminate
	end

	local ValueWidth = math.max(ToFiniteNumber(Config.ValueWidth) or 44, 0)

	local ProgressBar = {
		__type = "ProgressBar",
		Title = Config.Title or "Progress",
		Desc = Config.Desc or nil,
		Value = {
			Min = Min,
			Max = Max,
			Default = math.clamp(DefaultValue, Min, Max),
		},
		ShowValue = ShowValue,
		DisplayMode = Config.DisplayMode or "Percent",
		Format = Config.Format,
		Animate = Config.Animate ~= false,
		AnimationDuration = math.max(ToFiniteNumber(Config.AnimationDuration) or 0.15, 0),
		Indeterminate = Indeterminate,
		IndeterminateText = Config.IndeterminateText or "",
		Speed = math.max(ToFiniteNumber(Config.Speed) or 1, 0.01),
		ControlGap = math.max(ToFiniteNumber(Config.ControlGap) or 16, 0),
		UIElements = {},

		Width = math.max(ToFiniteNumber(Config.Width) or 160, 0),
		ValueWidth = ValueWidth,
	}

	local function GetRatio(Value)
		if ProgressBar.Value.Max == ProgressBar.Value.Min then
			return Value >= ProgressBar.Value.Max and 1 or 0
		end

		return math.clamp((Value - ProgressBar.Value.Min) / (ProgressBar.Value.Max - ProgressBar.Value.Min), 0, 1)
	end

	local function GetValueText(Value, Ratio)
		if ProgressBar.Indeterminate then
			return tostring(ProgressBar.IndeterminateText)
		end

		local Percentage = Ratio * 100

		if typeof(ProgressBar.Format) == "function" then
			local Success, Result =
				pcall(ProgressBar.Format, Value, Percentage, ProgressBar.Value.Min, ProgressBar.Value.Max)

			if Success and Result ~= nil then
				return tostring(Result)
			end
		end

		if ProgressBar.DisplayMode == "Value" then
			return FormatNumber(Value)
		elseif ProgressBar.DisplayMode == "Fraction" then
			return FormatNumber(Value) .. "/" .. FormatNumber(ProgressBar.Value.Max)
		end

		return tostring(math.floor(Percentage + 0.5)) .. "%"
	end

	ProgressBar.ProgressBarFrame = require("../components/window/Element")({
		Title = ProgressBar.Title,
		Desc = ProgressBar.Desc,
		Parent = Config.Parent,
		TextOffset = ProgressBar.Width + ProgressBar.ControlGap,
		Hover = false,
		Tab = Config.Tab,
		Index = Config.Index,
		Window = Config.Window,
		ElementTable = ProgressBar,
		ParentConfig = Config,
		Tags = Config.Tags,
	})

	ProgressBar.UIElements.Fill = Creator.NewRoundFrame(99, "Squircle", {
		Name = "Fill",
		Size = ProgressBar.Indeterminate and UDim2.new(0.3, 0, 1, 0)
			or UDim2.new(GetRatio(ProgressBar.Value.Default), 0, 1, 0),
		Position = ProgressBar.Indeterminate and UDim2.new(-0.3, 0, 0, 0) or UDim2.new(0, 0, 0, 0),
		ThemeTag = {
			ImageColor3 = "ProgressBar",
		},
	})

	ProgressBar.UIElements.Bar = Creator.NewRoundFrame(99, "Squircle", {
		Name = "Bar",
		Size = UDim2.new(1, ProgressBar.ShowValue and -(ProgressBar.ValueWidth + 8) or 0, 0, 6),
		ClipsDescendants = true,
		ImageTransparency = 0.9,
		ThemeTag = {
			ImageColor3 = "ProgressBarTrack",
			ImageTransparency = "ProgressBarTrackTransparency",
		},
	}, {
		ProgressBar.UIElements.Fill,
	})

	ProgressBar.UIElements.Value = New("TextLabel", {
		Name = "Value",
		Size = UDim2.new(0, ProgressBar.ValueWidth, 0, 20),
		BackgroundTransparency = 1,
		FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
		Text = GetValueText(ProgressBar.Value.Default, GetRatio(ProgressBar.Value.Default)),
		TextSize = 14,
		TextTransparency = 0.25,
		TextTruncate = "AtEnd",
		TextXAlignment = "Right",
		Visible = ProgressBar.ShowValue,
		ThemeTag = {
			TextColor3 = "ProgressBarText",
		},
	})

	ProgressBar.UIElements.Container = New("Frame", {
		Name = "ProgressBarContainer",
		Size = UDim2.new(0, ProgressBar.Width, 0, 36),
		Position = UDim2.new(1, 0, Config.Window.NewElements and 0 or 0.5, 0),
		AnchorPoint = Vector2.new(1, Config.Window.NewElements and 0 or 0.5),
		BackgroundTransparency = 1,
		Parent = ProgressBar.ProgressBarFrame.UIElements.Main,
	}, {
		New("UIListLayout", {
			Padding = UDim.new(0, 8),
			FillDirection = "Horizontal",
			HorizontalAlignment = "Right",
			VerticalAlignment = "Center",
		}),
		ProgressBar.UIElements.Bar,
		ProgressBar.UIElements.Value,
	})

	if ProgressBar.Indeterminate then
		local IndeterminateTween = Tween(
			ProgressBar.UIElements.Fill,
			1 / ProgressBar.Speed,
			{ Position = UDim2.new(1, 0, 0, 0) },
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.InOut,
			-1
		)
		Creator.AddSignal(ProgressBar.UIElements.Bar.Destroying, function()
			IndeterminateTween:Cancel()
		end)
		IndeterminateTween:Play()
	end

	local function Update(Value, Instant)
		local NumericValue = ToFiniteNumber(Value)
		if NumericValue == nil then
			return ProgressBar.Value.Default
		end

		NumericValue = math.clamp(NumericValue, ProgressBar.Value.Min, ProgressBar.Value.Max)
		ProgressBar.Value.Default = NumericValue

		local Ratio = GetRatio(NumericValue)
		local Size = UDim2.new(Ratio, 0, 1, 0)

		if ProgressBar.UIElements.Fill and not ProgressBar.Indeterminate then
			if Instant or not ProgressBar.Animate or ProgressBar.AnimationDuration <= 0 then
				ProgressBar.UIElements.Fill.Size = Size
			else
				Tween(
					ProgressBar.UIElements.Fill,
					ProgressBar.AnimationDuration,
					{ Size = Size },
					Enum.EasingStyle.Quint,
					Enum.EasingDirection.Out
				):Play()
			end
		end

		ProgressBar.UIElements.Value.Text = GetValueText(NumericValue, Ratio)

		return NumericValue
	end

	function ProgressBar:Set(Value)
		return Update(Value, false)
	end

	function ProgressBar:Get()
		return ProgressBar.Value.Default
	end

	function ProgressBar:GetPercentage()
		return GetRatio(ProgressBar.Value.Default) * 100
	end

	function ProgressBar:SetRange(NewMin, NewMax)
		NewMin = ToFiniteNumber(NewMin)
		NewMax = ToFiniteNumber(NewMax)

		if NewMin == nil or NewMax == nil then
			return ProgressBar.Value.Min, ProgressBar.Value.Max
		end

		if NewMin > NewMax then
			NewMin, NewMax = NewMax, NewMin
		end

		ProgressBar.Value.Min = NewMin
		ProgressBar.Value.Max = NewMax
		Update(ProgressBar.Value.Default, false)

		return NewMin, NewMax
	end

	function ProgressBar:SetMin(NewMin)
		NewMin = ToFiniteNumber(NewMin)
		if NewMin == nil then
			return ProgressBar.Value.Min
		end

		ProgressBar:SetRange(NewMin, math.max(NewMin, ProgressBar.Value.Max))
		return ProgressBar.Value.Min
	end

	function ProgressBar:SetMax(NewMax)
		NewMax = ToFiniteNumber(NewMax)
		if NewMax == nil then
			return ProgressBar.Value.Max
		end

		ProgressBar:SetRange(math.min(ProgressBar.Value.Min, NewMax), NewMax)
		return ProgressBar.Value.Max
	end

	Update(ProgressBar.Value.Default, true)

	return ProgressBar.__type, ProgressBar
end

return Element
