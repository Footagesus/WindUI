local Creator = require("../modules/Creator")
local New = Creator.New

-- local Highlighter = require("../Highlighter")
local CodeComponent = require("../components/ui/Code")

local Element = {}

function Element:New(Config)
	local Code = {
		__type = "Code",
		Title = Config.Title,
		Code = Config.Code,
		CodeSize = Config.CodeSize or 18,
		Height = Config.Height,
		CodeTheme = Config.CodeTheme,
		Locked = false,
		CanCopied = Config.CanCopied ~= false,
		OnCopy = Config.OnCopy,

		Index = Config.Index,
	}

	local CanCallback = not Code.Locked

	-- Code.CodeFrame = require("../Components/Element")({
	--     Title = Code.Title,
	--     Desc = Code.Code,
	--     Parent = Config.Parent,
	--     TextOffset = 40,
	--     Hover = false,
	-- })

	-- Code.CodeFrame.UIElements.Main.Title.Desc:Destroy()

	local CodeElement = CodeComponent.New(Code, Config.Window, Config.Parent, function()
		if CanCallback then
			local NewTitle = Code.Title or "code"
			local success, result = pcall(function()
				if toclipboard then
					toclipboard(Code.Code)
				end
				if setclipboard then
					setclipboard(Code.Code)
				end

				if Code.OnCopy then
					Code.OnCopy()
				end
			end)
			if not success then
				Config.WindUI:Notify({
					Title = "Error",
					Content = "The " .. NewTitle .. " is not copied. Error: " .. result,
					Icon = "x",
					Duration = 5,
				})
			end
		end
	end, Config.WindUI.UIScale)

	function Code:SetCode(code)
		CodeElement.Set(code)
		Code.Code = code
	end

	function Code:Set(code)
		return Code.SetCode(code)
	end

	function Code:Destroy()
		CodeElement.Destroy()
		Code = nil
	end

	function Code.UpdateShape(Tab)
		if Config.Window.NewElements then
			local newShape = Creator:GetElementPosition(
				Tab.Elements,
				Code.Index,
				Config.ParentType == "HStack" or Config.ParentType == "Group"
			)

			if newShape and CodeElement.CodeFrameModule then
				CodeElement.CodeFrameModule:SetType(newShape)
				--CodeElement.BackgroundFrameModule:SetType(newShape)
				print(newShape)
				CodeElement.TopbarFrameModule:SetType(
					table.find({ "Squircle-BL-BR", "SquircleH-BL-BR" }, newShape) ~= nil and "Square" or newShape
				)
			end
		end
	end

	Code.UIElements = { Main = CodeElement.CodeFrame }
	Code.ElementFrame = CodeElement.CodeFrame

	return Code.__type, Code
end

return Element
