local Creator

local DynamicShapeModule = {
	New = nil,
	Init = nil,
	Shapes = {
		Circle = {
			Image = "rbxassetid://111665032676235",
			Rect = Rect.new(1024 / 2, 1024 / 2, 1024 / 2, 1024 / 2),
			Radius = 1024 / 2,
		},
		CircleOutline = {
			Image = "rbxassetid://108556680453287",
			Rect = Rect.new(1024 / 2, 1024 / 2, 1024 / 2, 1024 / 2),
			Radius = 1024 / 2,
		},
		CircleGlass = {
			Image = "rbxassetid://95600044758841",
			Rect = Rect.new(1024 / 2, 1024 / 2, 1024 / 2, 1024 / 2),
			Radius = 1024 / 2,
		},

		-- * Apple Squircles * --
		-- * For horizontally/vertically stretched elements * --
		SquircleH = {
			Image = "rbxassetid://125083578015333",
			Rect = Rect.new(1024 / 2, 650 / 2, 1024 / 2, 650 / 2),
			Radius = 650 / 2,
		},
		SquircleHOutline = {
			Image = "rbxassetid://107043713170567",
			Rect = Rect.new(1024 / 2, 650 / 2, 1024 / 2, 650 / 2),
			Radius = 650 / 2,
		},
		SquircleHGlass = {
			Image = "rbxassetid://84819521201001",
			Rect = Rect.new(1024 / 2, 650 / 2, 1024 / 2, 650 / 2),
			Radius = 650 / 2,
		},
		["SquircleH-TL-TR"] = {
			Image = "rbxassetid://90680657206619",
			Rect = Rect.new(807, 1024 / 2, 807, 1024 / 2),
			Radius = 650 / 2,
			AutoChange = false,
		},
		["SquircleH-BL-BR"] = {
			Image = "rbxassetid://99216342056719",
			Rect = Rect.new(0, 1024 / 2, 0, 1024 / 2),
			Radius = 650 / 2,
			AutoChange = false,
		},

		SquircleV = {
			Image = "rbxassetid://124965260437653",
			Rect = Rect.new(650 / 2, 1024 / 2, 650 / 2, 1024 / 2),
			Radius = 650 / 2,
		},
		SquircleVOutline = {
			Image = "rbxassetid://88808835404198",
			Rect = Rect.new(650 / 2, 1024 / 2, 650 / 2, 1024 / 2),
			Radius = 650 / 2,
		},
		SquircleVGlass = {
			Image = "rbxassetid://124982801466667",
			Rect = Rect.new(650 / 2, 1024 / 2, 650 / 2, 1024 / 2),
			Radius = 650 / 2,
		},

		Squircle = {
			Image = "rbxassetid://89641024074289",
			Rect = Rect.new(460, 460, 460, 460),
			Radius = 620 / 2,
		},
		SquircleOutline = {
			Image = "rbxassetid://74029063732681",
			Rect = Rect.new(1024 / 2, 1024 / 2, 1024 / 2, 1024 / 2),
			Radius = 620 / 2,
		},
		SquircleGlass = {
			Image = "rbxassetid://131126436897551",
			Rect = Rect.new(1024 / 2, 1024 / 2, 1024 / 2, 1024 / 2),
			Radius = 620 / 2,
		},

		["Squircle-TL-TR"] = {
			Image = "rbxassetid://75712142040725",
			Rect = Rect.new(1024 / 2, 1024 / 2, 1024 / 2, 1024 / 2),
			Radius = 620 / 2,
			AutoChange = false,
		},
		["Squircle-BL-BR"] = {
			Image = "rbxassetid://83676684425544",
			Rect = Rect.new(1024 / 2, 0, 1024 / 2, 0),
			Radius = 620 / 2,
			AutoChange = false,
		},
		["Square"] = {
			Image = "rbxassetid://82909646051652",
			Rect = Rect.new(1024 / 2, 1024 / 2, 1024 / 2, 1024 / 2),
			Radius = 1024 / 2,
			AutoChange = false,
		},
	},
}

function DynamicShapeModule:Init(CreatorObj)
	Creator = CreatorObj
	return self.New
end

function DynamicShapeModule:New(Radius, Type, Properties, Children, IsButton, IsSlice)
	local Wrapper = {
		Radius = Radius or 0,
		Type = Type or "Circle",
		GetRadius = nil,
		GetType = nil,
		SetRadius = nil,
		SetType = nil,
	}

	local ShapeFallbacks = {
		["Glass-0.7"] = "SquircleGlass",
		["Glass-1"] = "SquircleGlass",
		["Glass-1.4"] = "SquircleGlass",
		["Squircle-Outline"] = "SquircleOutline",
	}

	local function GetShape(Type)
		return DynamicShapeModule.Shapes[ShapeFallbacks[Type] or Type] or DynamicShapeModule.Shapes.Circle
	end

	local ImageLabel = Creator.New(IsButton and "ImageButton" or "ImageLabel", {
		Image = "",
		ScaleType = IsSlice ~= false and "Slice" or nil,
		SliceCenter = Wrapper.Type ~= "Squircle" and Rect.new(512, 512, 512, 512) or nil,
		SliceScale = 1,
		ThemeTag = Properties and Properties.ThemeTag or nil,
		BackgroundTransparency = 1,
	}, Children)

	for Property, Value in next, Properties do
		if not table.find({ "ThemeTag" }, Property) then
			ImageLabel[Property] = Value
		end
	end

	function Wrapper:SetRadius(NewRadius)
		Wrapper.Radius = NewRadius
		ImageLabel.SliceScale = math.max(NewRadius / GetShape(Wrapper.Type).Radius, 0.0001)
		return Wrapper
	end

	function Wrapper:SetType(NewType)
		Wrapper.Type = NewType
		local Shape = GetShape(NewType)
		ImageLabel.Image = Shape.Image
		ImageLabel.SliceCenter = Shape.Rect
		Wrapper:SetRadius(Wrapper.Radius)
		return Wrapper
	end

	function Wrapper:GetRadius()
		return Wrapper.Radius
	end

	function Wrapper:GetType()
		return Wrapper.Type
	end

	Wrapper:SetRadius(Radius)
	Wrapper:SetType(Type)

	Creator.AddSignal(ImageLabel:GetPropertyChangedSignal("AbsoluteSize"), function()
		local Shape = GetShape(Wrapper.Type)
		if Shape.AutoChange == false then
			return
		end

		if string.find(Wrapper.Type, "Squircle") then
			local Glass = string.find(Wrapper.Type, "Glass") and "Glass" or nil
			local Outline = string.find(Wrapper.Type, "Outline") and "Outline" or nil

			local X = math.round(ImageLabel.AbsoluteSize.X / Creator.UIScale)
			local Y = math.round(ImageLabel.AbsoluteSize.Y / Creator.UIScale)

			local effectiveRadius = Wrapper.Radius ~= 0 and Wrapper.Radius or math.min(X, Y) / 2
			local SquircleRatio = DynamicShapeModule.Shapes.Squircle.Radius / 1024
			local RadiusRatio = effectiveRadius / math.min(X, Y)

			local newType

			if X > Y then
				if RadiusRatio >= SquircleRatio then
					newType = "SquircleH" .. (Outline or Glass or "")
				else
					newType = "Squircle" .. (Outline or Glass or "")
				end
			elseif X < Y then
				if RadiusRatio >= SquircleRatio then
					newType = "SquircleV" .. (Outline or Glass or "")
				else
					newType = "Squircle" .. (Outline or Glass or "")
				end
			else
				if RadiusRatio >= SquircleRatio then
					newType = "Circle" .. (Outline or Glass or "")
				else
					newType = "Squircle" .. (Outline or Glass or "")
				end
			end

			Wrapper:SetType(newType)
		end
	end)

	return ImageLabel, Wrapper
end

return DynamicShapeModule
