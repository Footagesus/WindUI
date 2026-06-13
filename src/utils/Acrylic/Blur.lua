-- Credits: Fluent - Dawid

local cloneref = (cloneref or clonereference or function(instance) return instance end)


local Creator = require("../../modules/Creator")
local New = Creator.New


local viewportPointToWorld, getOffset = unpack(require("./Utils"))
local BlurFolder = Instance.new("Folder", cloneref(game:GetService("Workspace")).CurrentCamera)


local function createAcrylic()
	local Part = New("Part", {
		Name = "Body",
		Color = Color3.new(0, 0, 0),
		Material = Enum.Material.Glass,
		Size = Vector3.new(1, 1, 0),
		Anchored = true,
		CanCollide = false,
		Locked = true,
		CastShadow = false,
		Transparency = 0.98,
	}, {
		New("SpecialMesh", {
			MeshType = Enum.MeshType.Brick,
			Offset = Vector3.new(0, 0, -0.000001),
		}),
	})

	return Part
end


local function createAcrylicBlur(distance)
	local cleanups = {}

	distance = distance or 0.001
	local positions = {
		topLeft = Vector2.new(),
		topRight = Vector2.new(),
		bottomRight = Vector2.new(),
	}
	local model = createAcrylic()
	model.Parent = BlurFolder

	local function updatePositions(size, position)
		positions.topLeft = position
		positions.topRight = position + Vector2.new(size.X, 0)
		positions.bottomRight = position + size
	end

	local function render()
		local res = cloneref(game:GetService("Workspace")).CurrentCamera
		if res then
			res = res.CFrame
		end
		local cond = res
		if not cond then
			cond = CFrame.new()
		end

		local camera = cond
		local topLeft = positions.topLeft
		local topRight = positions.topRight
		local bottomRight = positions.bottomRight

		local topLeft3D = viewportPointToWorld(topLeft, distance)
		local topRight3D = viewportPointToWorld(topRight, distance)
		local bottomRight3D = viewportPointToWorld(bottomRight, distance)

		local width = (topRight3D - topLeft3D).Magnitude
		local height = (topRight3D - bottomRight3D).Magnitude

		model.CFrame =
			CFrame.fromMatrix((topLeft3D + bottomRight3D) / 2, camera.XVector, camera.YVector, camera.ZVector)
		model.Mesh.Scale = Vector3.new(width, height, 0)
	end

	local function onChange(rbx)
		local offset = getOffset()
		local size = rbx.AbsoluteSize - Vector2.new(offset, offset)
		local position = rbx.AbsolutePosition + Vector2.new(offset / 2, offset / 2)

		updatePositions(size, position)
		task.spawn(render)
	end

	local function renderOnChange()
		local camera = cloneref(game:GetService("Workspace")).CurrentCamera
		if not camera then
			return
		end

		table.insert(cleanups, camera:GetPropertyChangedSignal("CFrame"):Connect(render))
		table.insert(cleanups, camera:GetPropertyChangedSignal("ViewportSize"):Connect(render))
		table.insert(cleanups, camera:GetPropertyChangedSignal("FieldOfView"):Connect(render))
		task.spawn(render)
	end

	model.Destroying:Connect(function()
		for _, item in cleanups do
			pcall(function()
				item:Disconnect()
			end)
		end
	end)

	renderOnChange()

	return onChange, model
end

return function(distance)
	local Blur = {}
	local onChange, model = createAcrylicBlur(distance)

	local comp = New("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
	})

	Creator.AddSignal(comp:GetPropertyChangedSignal("AbsolutePosition"), function()
		onChange(comp)
	end)

	Creator.AddSignal(comp:GetPropertyChangedSignal("AbsoluteSize"), function()
		onChange(comp)
	end)

	Blur.AddParent = function(Parent)
		Creator.AddSignal(Parent:GetPropertyChangedSignal("Visible"), function()
			--Blur.SetVisibility(Parent.Visible)
		end)
	end

	Blur.SetVisibility = function(Value)
		model.Transparency = Value and 0.98 or 1
	end

	Blur.Frame = comp
	Blur.Model = model

	return Blur
end