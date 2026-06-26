local ScrollSlider = {}

local cloneref = cloneref or clonereference or function(i)
	return i
end
local UserInputService = cloneref(game:GetService("UserInputService"))

local Creator = require("../../modules/Creator")
local New = Creator.New

function ScrollSlider.New(ScrollingFrame, Parent, Window, Thickness, WindUI)
	local Slider = New("Frame", {
		Size = UDim2.new(0, Thickness, 1, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, 0, 0, 0),
		AnchorPoint = Vector2.new(1, 0),
		Parent = Parent,
		ZIndex = 999,
		Active = true,
	})

	local Thumb = Creator.NewRoundFrame(Thickness / 2, "Squircle", {
		Size = UDim2.new(1, 0, 0, 0),
		ImageTransparency = 0.85,
		ThemeTag = { ImageColor3 = "Text" },
		Parent = Slider,
	})

	local Hitbox = New("Frame", {
		Size = UDim2.new(1, 12, 1, 12),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Active = true,
		ZIndex = 999,
		Parent = Thumb,
	})

	local ScrollSliderActionId = Creator:GenerateUniqueID()
	local isDragging = false
	local connectionMove, connectionEnd

	local function UpdateVisuals()
		local canvasY = ScrollingFrame.AbsoluteCanvasSize.Y
		local windowY = ScrollingFrame.AbsoluteWindowSize.Y

		if canvasY <= windowY then
			Thumb.Visible = false
			return
		end

		Thumb.Visible = true

		local sizeRatio = math.clamp(windowY / canvasY, 0.05, 1)
		Thumb.Size = UDim2.new(1, 0, sizeRatio, 0)

		local maxScroll = canvasY - windowY
		local maxThumbScale = 1 - sizeRatio

		if maxScroll > 0 then
			local scrollRatio = ScrollingFrame.CanvasPosition.Y / maxScroll
			Thumb.Position = UDim2.new(0, 0, math.clamp(scrollRatio * maxThumbScale, 0, maxThumbScale), 0)
		else
			Thumb.Position = UDim2.new(0, 0, 0, 0)
		end
	end

	local function StopDrag()
		if WindUI.CurrentInput == ScrollSliderActionId then
			WindUI.CurrentInput = nil
		end
		isDragging = false
		ScrollingFrame.ScrollingEnabled = true
		if connectionMove then
			connectionMove:Disconnect()
		end
		if connectionEnd then
			connectionEnd:Disconnect()
		end
	end

	Creator.AddSignal(Hitbox.InputBegan, function(input)
		if
			input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch
		then
			return
		end
		if isDragging then
			return
		end
		if WindUI.CurrentInput and WindUI.CurrentInput ~= ScrollSliderActionId then
			return
		end

		WindUI.CurrentInput = ScrollSliderActionId

		isDragging = true
		ScrollingFrame.ScrollingEnabled = false

		local startY = input.Position.Y
		local startCanvasY = ScrollingFrame.CanvasPosition.Y

		connectionMove = UserInputService.InputChanged:Connect(function(moveInput)
			if
				moveInput.UserInputType == Enum.UserInputType.MouseMovement
				or moveInput.UserInputType == Enum.UserInputType.Touch
			then
				local deltaY = moveInput.Position.Y - startY

				local canvasY = ScrollingFrame.AbsoluteCanvasSize.Y
				local windowY = ScrollingFrame.AbsoluteWindowSize.Y
				local maxScroll = math.max(canvasY - windowY, 0)

				local sliderPx = Slider.AbsoluteSize.Y
				local thumbPx = Thumb.AbsoluteSize.Y
				local maxThumbPx = math.max(sliderPx - thumbPx, 1)

				local scrollDelta = deltaY * (maxScroll / maxThumbPx)

				ScrollingFrame.CanvasPosition =
					Vector2.new(ScrollingFrame.CanvasPosition.X, math.clamp(startCanvasY + scrollDelta, 0, maxScroll))
			end
		end)

		connectionEnd = UserInputService.InputEnded:Connect(function(endInput)
			if endInput.UserInputType == input.UserInputType then
				if WindUI.CurrentInput and WindUI.CurrentInput ~= ScrollSliderActionId then
					return
				end

				WindUI.CurrentInput = nil

				StopDrag()
			end
		end)
	end)

	Creator.AddSignal(ScrollingFrame:GetPropertyChangedSignal("AbsoluteWindowSize"), UpdateVisuals)
	Creator.AddSignal(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"), UpdateVisuals)
	Creator.AddSignal(ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"), UpdateVisuals)

	UpdateVisuals()

	return Slider
end

return ScrollSlider
