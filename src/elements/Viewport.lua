local cloneref = (cloneref or clonereference or function(instance)
	return instance
end)

local UserInputService = cloneref(game:GetService("UserInputService"))

local Creator = require("../modules/Creator")
local New = Creator.New

local Element = {}

type ConfigType = {
	Object: Instance,
	Camera: Instance?,
	Interactive: boolean?,
	Height: number?,
	Focused: boolean,

	Window: any, -- later
	WindUI: any, -- later
	Tab: any, -- later
	Parent: Instance,
}

function Element:New(Config: ConfigType)
	local Viewport = {
		__type = "Viewport",
		Object = Config.Object,
		Camera = Config.Camera or Instance.new("Camera"),
		Interactive = Config.Interactive or false,
		Height = Config.Height or 200,
		Focused = Config.Focused ~= false,
	}

	local Dragging = false
	local Pinching = false
	local LastMousePos, LastPinchDist = nil, 0

	local Main = Creator.NewRoundFrame(Config.Window.ElementConfig.UICorner, "Squircle", {
		Size = UDim2.new(1, 0, 0, Viewport.Height),
		Parent = Config.Parent,
		ThemeTag = {
			ImageColor3 = "ViewportBackground",
			ImageTransparency = "ViewportBackgroundTransparency",
		},
	}, {
		New("CanvasGroup", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, Config.Window.ElementConfig.UICorner),
			}),
			New("ViewportFrame", {
				Name = "Viewport",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				CurrentCamera = Viewport.Camera,
				Active = Viewport.Interactive,
			}, {
				Viewport.Object,
			}),
		}),
	})

	local function IsTouchInsideViewport(Position)
		local AbsPos = Main.CanvasGroup.Viewport.AbsolutePosition
		local Size = Main.CanvasGroup.Viewport.AbsoluteSize

		return Position.X >= AbsPos.X
			and Position.X <= AbsPos.X + Size.X
			and Position.Y >= AbsPos.Y
			and Position.Y <= AbsPos.Y + Size.Y
	end

	local CurInput = Config.WindUI.GenerateGUID()

	Creator.AddSignal(Main.CanvasGroup.Viewport.MouseEnter, function()
		if Viewport.Interactive then
			Config.Tab.UIElements.ContainerFrame.ScrollingEnabled = false
		end
	end)

	Creator.AddSignal(Main.CanvasGroup.Viewport.InputEnded, function(Input)
		if
			Input.UserInputType == Enum.UserInputType.MouseMovement
			or Input.UserInputType == Enum.UserInputType.Touch
		then
			Config.Tab.UIElements.ContainerFrame.ScrollingEnabled = true
		end
	end)

	Creator.AddSignal(Main.CanvasGroup.Viewport.InputBegan, function(Input)
		if Viewport.Interactive then
			if
				(Input.UserInputType == Enum.UserInputType.MouseButton1)
				or (Input.UserInputType == Enum.UserInputType.Touch and not Pinching)
			then
				if Config.WindUI.CurrentInput and Config.WindUI.CurrentInput ~= CurInput then
					return
				end

				Config.WindUI.CurrentInput = CurInput

				Dragging = true
				LastMousePos = Input.Position
			end
		end
	end)

	Creator.AddSignal(UserInputService.InputEnded, function(Input)
		if Viewport.Interactive then
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				if Config.WindUI.CurrentInput and Config.WindUI.CurrentInput ~= CurInput then
					return
				end

				Config.WindUI.CurrentInput = nil

				Dragging = false
			end
		end
	end)

	Creator.AddSignal(UserInputService.InputChanged, function(Input)
		if Viewport.Interactive and Dragging and not Pinching then
			if
				Input.UserInputType == Enum.UserInputType.MouseMovement
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				local MouseDelta = Input.Position - LastMousePos
				LastMousePos = Input.Position

				local Position = Viewport.Object:GetPivot().Position
				local Camera = Viewport.Camera

				local RotationY = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -MouseDelta.X * 0.02)
				Camera.CFrame = CFrame.new(Position) * RotationY * CFrame.new(-Position) * Camera.CFrame

				local RotationX = CFrame.fromAxisAngle(Camera.CFrame.RightVector, -MouseDelta.Y * 0.02)
				local PitchedCFrame = CFrame.new(Position) * RotationX * CFrame.new(-Position) * Camera.CFrame

				if PitchedCFrame.UpVector.Y > 0.1 then
					Camera.CFrame = PitchedCFrame
				end
			end
		end
	end)

	Creator.AddSignal(Main.CanvasGroup.Viewport.InputChanged, function(Input)
		if Viewport.Interactive then
			if Input.UserInputType == Enum.UserInputType.MouseWheel then
				local ZoomAmount = Input.Position.Z * 2
				Viewport.Camera.CFrame += Viewport.Camera.CFrame.LookVector * ZoomAmount
			end
		end
	end)

	Creator.AddSignal(UserInputService.TouchPinch, function(touchPositions, scale, velocity, state)
		if not IsTouchInsideViewport(touchPositions[1]) or not IsTouchInsideViewport(touchPositions[2]) then
			return
		end
		if Viewport.Interactive then
			if state == Enum.UserInputState.Begin then
				Pinching = true
				Dragging = false
				LastPinchDist = (touchPositions[1] - touchPositions[2]).Magnitude
			elseif state == Enum.UserInputState.Change then
				if Pinching then
					local currentDist = (touchPositions[1] - touchPositions[2]).Magnitude
					local delta = (currentDist - LastPinchDist) * 0.03
					LastPinchDist = currentDist
					Viewport.Camera.CFrame += Viewport.Camera.CFrame.LookVector * delta
				end
			elseif state == Enum.UserInputState.End or state == Enum.UserInputState.Cancel then
				Pinching = false
			end
		end
	end)

	local function FocusCamera()
		local ModelSize = Viewport.Object:IsA("BasePart") and Viewport.Object.Size
			or select(2, Viewport.Object:GetBoundingBox(0))
		local MaxExtent = math.max(ModelSize.X, ModelSize.Y, ModelSize.Z)
		local CameraDistance = MaxExtent * 2
		local ModelPosition = Viewport.Object:GetPivot().Position

		Viewport.Camera.CFrame =
			CFrame.new(ModelPosition + Vector3.new(0, MaxExtent / 2, CameraDistance), ModelPosition)
	end

	if Viewport.Focused then
		FocusCamera()
	end

	function Viewport:SetObject(Object, IsClone)
		if IsClone then
			Object = Object:Clone()
		end
		if Viewport.Object then
			Viewport.Object:Destroy()
		end

		Viewport.Object = Object
		Viewport.Object.Parent = Main.CanvasGroup.Viewport
	end

	function Viewport:SetHeight(Height)
		Main.Size = UDim2.new(1, 0, 0, Height)
	end

	function Viewport:Focus()
		if Viewport.Object then
			FocusCamera()
		end
	end

	function Viewport:SetCamera(Camera)
		Viewport.Camera = Camera
		Main.CanvasGroup.Viewport.CurrentCamera = Camera
	end

	function Viewport:SetInteractive(Interactive)
		Viewport.Interactive = Interactive
		Main.CanvasGroup.Viewport.Active = Interactive
	end

	Viewport.Main = Main

	return Viewport.__type, Viewport
end

return Element
