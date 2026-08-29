local Creator = require("../modules/Creator")
local New = Creator.New
local CodeComponent = require("../components/ui/Code")
local VideoElement = require("./Video")

local Element = {}

local function trim(value)
	return (value:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function escapeRichText(value)
	return value:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
end

local function inline(value)
	value = escapeRichText(value)
	value = value:gsub("`([^`]+)`", '<font face="RobotoMono" color="#a5b4fc">%1</font>')
	value = value:gsub("%*%*([^*]+)%*%*", "<b>%1</b>")
	value = value:gsub("__([^_]+)__", "<b>%1</b>")
	value = value:gsub("~~([^~]+)~~", "<s>%1</s>")
	value = value:gsub("%*([^*]+)%*", "<i>%1</i>")
	value = value:gsub("_([^_]+)_", "<i>%1</i>")
	value = value:gsub("%[([^%]]+)%]%(([^%)]+)%)", '<u><font color="#60a5fa">%1</font></u>')
	return value
end

local function splitLines(content)
	local lines = {}
	content = content:gsub("\r\n", "\n"):gsub("\r", "\n")
	for line in (content .. "\n"):gmatch("(.-)\n") do
		table.insert(lines, line)
	end
	return lines
end

local function parseTableRow(line)
	line = trim(line)
	line = line:gsub("^|", ""):gsub("|$", "")
	local cells = {}
	for cell in (line .. "|"):gmatch("(.-)|") do
		table.insert(cells, trim(cell))
	end
	return cells
end

local function parseTableAlignments(line)
	local alignments = {}
	for _, cell in next, parseTableRow(line) do
		local left = cell:sub(1, 1) == ":"
		local right = cell:sub(-1) == ":"
		table.insert(alignments, left and right and "Center" or right and "Right" or "Left")
	end
	return alignments
end

local function isTableDivider(line)
	local found = false
	for cell in line:gmatch("[^|]+") do
		cell = trim(cell)
		if cell ~= "" then
			found = true
			if not cell:match("^:?-+:?$") then
				return false
			end
		end
	end
	return found
end

local function isBlockStart(lines, index)
	local line = lines[index] or ""
	local nextLine = lines[index + 1] or ""
	return line == ""
		or line:match("^%s*#")
		or line:match("^%s*```")
		or line:match("^%s*>%s?")
		or line:match("^%s*[-*+]%s+")
		or line:match("^%s*%d+[%.%)]%s+")
		or line:match("^%s*[-*_][-%*_][-%*_]+%s*$")
		or (line:find("|", 1, true) and isTableDivider(nextLine))
		or line:match("^!%b[]%b()$")
		or line:match("^%s*<video%s")
end

local function parse(content)
	local lines = splitLines(content)
	local blocks = {}
	local index = 1

	while index <= #lines do
		local line = lines[index]
		if trim(line) == "" then
			index = index + 1
		elseif line:match("^%s*```") then
			local language = trim(line:gsub("^%s*```", ""))
			local code = {}
			index = index + 1
			while index <= #lines and not lines[index]:match("^%s*```") do
				table.insert(code, lines[index])
				index = index + 1
			end
			table.insert(blocks, { Type = "Code", Language = language, Value = table.concat(code, "\n") })
			index = index + 1
		else
			local hashes, title = line:match("^%s*(#+)%s+(.+)$")
			if hashes then
				table.insert(blocks, { Type = "Heading", Level = #hashes, Value = trim(title) })
				index = index + 1
			elseif line:match("^%s*[-*_][-%*_][-%*_]+%s*$") then
				table.insert(blocks, { Type = "Divider" })
				index = index + 1
			elseif line:match("^!%b[]%b()$") then
				local alt, source = line:match("^!%[([^%]]*)%]%((.+)%)$")
				table.insert(blocks, { Type = "Image", Alt = alt or "Image", Source = source or "" })
				index = index + 1
			elseif line:match("^%s*<video%s") then
				local source = line:match('src%s*=%s*["\']([^"\']+)["\']')
				if source then
					table.insert(blocks, { Type = "Video", Source = source, Autoplay = line:match("%f[%a]autoplay%f[%A]") ~= nil, Looped = line:match("%f[%a]loop%f[%A]") ~= nil, Muted = line:match("%f[%a]muted%f[%A]") ~= nil })
				else
					table.insert(blocks, { Type = "Paragraph", Value = line })
				end
				index = index + 1
			elseif line:match("^%s*>%s?") then
				local quote = {}
				while index <= #lines and lines[index]:match("^%s*>%s?") do
					table.insert(quote, trim(lines[index]:gsub("^%s*>%s?", "")))
					index = index + 1
				end
				table.insert(blocks, { Type = "Quote", Value = table.concat(quote, "\n") })
			elseif line:match("^%s*[-*+]%s+") or line:match("^%s*%d+[%.%)]%s+") then
				local ordered = line:match("^%s*%d+[%.%)]%s+") ~= nil
				local items = {}
				while index <= #lines do
					local indent, marker, item
					if ordered then
						indent, marker, item = lines[index]:match("^(%s*)(%d+)[%.%)]%s+(.+)$")
					else
						indent, item = lines[index]:match("^(%s*)[-*+]%s+(.+)$")
					end
					if not item then break end
					local taskState, taskValue = item:match("^%[([xX ])%]%s*(.*)$")
					table.insert(items, {
						Value = taskValue or item,
						Level = math.floor(#(indent or "") / 2),
						Checked = taskState and taskState:lower() == "x" or nil,
					})
					index = index + 1
				end
				table.insert(blocks, { Type = "List", Ordered = ordered, Items = items })
			elseif line:find("|", 1, true) and isTableDivider(lines[index + 1] or "") then
				local header = parseTableRow(line)
				local alignments = parseTableAlignments(lines[index + 1])
				local rows = {}
				index = index + 2
				while index <= #lines and lines[index]:find("|", 1, true) and trim(lines[index]) ~= "" do
					table.insert(rows, parseTableRow(lines[index]))
					index = index + 1
				end
				table.insert(blocks, { Type = "Table", Header = header, Rows = rows, Alignments = alignments })
			else
				local paragraph = { trim(line) }
				index = index + 1
				while index <= #lines and trim(lines[index]) ~= "" and not isBlockStart(lines, index) do
					table.insert(paragraph, trim(lines[index]))
					index = index + 1
				end
				table.insert(blocks, { Type = "Paragraph", Value = table.concat(paragraph, "\n") })
			end
		end
	end

	return blocks
end

local function makeText(parent, text, options)
	options = options or {}
	return New("TextLabel", {
		Parent = parent,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
		Text = inline(text),
		TextWrapped = true,
		TextXAlignment = options.Alignment or "Left",
		TextYAlignment = options.VerticalAlignment or "Top",
		TextSize = options.Size or 16,
		TextTransparency = options.Transparency or 0,
		LineHeight = options.LineHeight or 1.2,
		FontFace = Font.new(Creator.Font, options.Weight or Enum.FontWeight.Medium),
		ThemeTag = { TextColor3 = options.Theme or "Text" },
	})
end

local function makeCard(parent, config, options)
	options = options or {}
	local card = Creator.NewRoundFrame(config.Radius or config.Window.ElementConfig.UICorner, "Squircle", {
		Parent = parent,
		Size = UDim2.new(1, 0, 0, options.Height or 0),
		AutomaticSize = options.Height and "None" or "Y",
		ImageTransparency = options.Transparency or 0.94,
		ThemeTag = { ImageColor3 = options.Theme or "Text" },
	})
	return card
end

local function setRowCorners(row, radius, top, bottom)
	local corner = New("UICorner", {
		Parent = row,
		CornerRadius = UDim.new(0, radius),
	})
	pcall(function()
		corner.TopLeftRadius = top and UDim.new(0, radius) or UDim.new(0, 0)
		corner.TopRightRadius = top and UDim.new(0, radius) or UDim.new(0, 0)
		corner.BottomLeftRadius = bottom and UDim.new(0, radius) or UDim.new(0, 0)
		corner.BottomRightRadius = bottom and UDim.new(0, radius) or UDim.new(0, 0)
	end)
end

local function renderTable(parent, block, config)
	local minimumCellWidth = config.TableCellWidth or 110
	local cellPadding = config.TableCellPadding or 16
	local textAlignment = config.TableTextAlignment
	local columns = #block.Header
	local rowHeight = config.TableRowHeight or 40
	local contentHeight = (#block.Rows + 1) * rowHeight
	local height = math.min(contentHeight, config.TableMaxHeight or 240)
	local card = makeCard(parent, config, { Height = height + 2, Transparency = 0.965 })
	local scroller = New("ScrollingFrame", {
		Parent = card,
		Size = UDim2.new(1, -2, 1, -2),
		Position = UDim2.new(0, 1, 0, 1),
		CanvasSize = UDim2.new(0, columns * minimumCellWidth, 0, height),
		ScrollingDirection = "XY",
		ElasticBehavior = "Never",
		ScrollBarThickness = 3,
		BackgroundTransparency = 1,
	})
	local holder = New("Frame", {
		Parent = scroller,
		Size = UDim2.new(0, columns * minimumCellWidth, 0, contentHeight),
		BackgroundTransparency = 1,
	})
	New("UIListLayout", { Parent = holder, FillDirection = "Vertical", Padding = UDim.new(0, 1) })
	local cells = {}

	local function addRow(values, isHeader, isLast)
		local row = New("Frame", {
			Parent = holder,
			Size = UDim2.new(1, 0, 0, rowHeight - 1),
			BackgroundTransparency = isHeader and 0.86 or 0.95,
			ThemeTag = { BackgroundColor3 = isHeader and "Primary" or "Text" },
		})
		setRowCorners(row, math.max((config.Radius or config.Window.ElementConfig.UICorner) - 3, 0), isHeader, isLast)
		New("UIListLayout", { Parent = row, FillDirection = "Horizontal", Padding = UDim.new(0, 1) })
		for column = 1, columns do
			local label = makeText(row, values[column] or "", {
				Size = 14,
				Weight = isHeader and Enum.FontWeight.SemiBold or Enum.FontWeight.Medium,
				Transparency = isHeader and 0 or 0.22,
				Alignment = textAlignment or block.Alignments[column] or "Left",
				VerticalAlignment = "Center",
			})
			label.Size = UDim2.new(0, minimumCellWidth - 1, 1, 0)
			label.AutomaticSize = "None"
			New("UIPadding", {
				Parent = label,
				PaddingLeft = UDim.new(0, cellPadding), PaddingRight = UDim.new(0, cellPadding),
				PaddingTop = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5),
			})
			table.insert(cells, label)
		end
	end

	addRow(block.Header, true, #block.Rows == 0)
	for rowIndex, row in next, block.Rows do addRow(row, false, rowIndex == #block.Rows) end

	local function updateWidth()
		local availableWidth = scroller.AbsoluteSize.X
		if availableWidth <= 0 then return end

		local tableWidth = math.max(availableWidth, columns * minimumCellWidth)
		local cellWidth = math.floor(tableWidth / columns)
		holder.Size = UDim2.new(0, tableWidth, 0, contentHeight)
		scroller.CanvasSize = UDim2.new(0, tableWidth, 0, contentHeight)
		for _, label in next, cells do
			label.Size = UDim2.new(0, cellWidth - 1, 1, 0)
		end
	end

	Creator.AddSignal(scroller:GetPropertyChangedSignal("AbsoluteSize"), updateWidth)
	task.defer(updateWidth)
	return card
end

function Element:New(config)
	local markdown = {
		__type = "Markdown",
		Content = config.Content or config.Markdown or "",
		Elements = {},
		Locked = config.Locked or false,
	}
	local root = New("Frame", {
		Parent = config.Parent,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
	})
	New("UIListLayout", { Parent = root, FillDirection = "Vertical", Padding = UDim.new(0, config.Gap or 10) })
	markdown.ElementFrame = root

	local function render(content)
		root:ClearAllChildren()
		New("UIListLayout", { Parent = root, FillDirection = "Vertical", Padding = UDim.new(0, config.Gap or 10) })
		markdown.Elements = {}
		for _, block in next, parse(content) do
			local object
			if block.Type == "Heading" then
				object = makeText(root, block.Value, {
					Size = ({ 28, 23, 20, 18, 17, 16 })[math.min(block.Level, 6)],
					Weight = Enum.FontWeight.Bold,
				})
			elseif block.Type == "Paragraph" then
				object = makeText(root, block.Value, { Transparency = 0.16 })
			elseif block.Type == "Divider" then
				object = New("Frame", { Parent = root, Size = UDim2.new(1, 0, 0, 1), BackgroundTransparency = 0.78, ThemeTag = { BackgroundColor3 = "Text" } })
			elseif block.Type == "Quote" then
				object = makeCard(root, config, { Transparency = 0.955 })
				New("UIPadding", { Parent = object, PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 12), PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10) })
				New("Frame", { Parent = object, Size = UDim2.new(0, 3, 1, -16), Position = UDim2.new(0, 7, 0, 8), BackgroundTransparency = 0, ThemeTag = { BackgroundColor3 = "Primary" } }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })
				makeText(object, block.Value, { Transparency = 0.12, LineHeight = 1.25 })
			elseif block.Type == "List" then
				object = New("Frame", { Parent = root, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = "Y", BackgroundTransparency = 1 })
				New("UIListLayout", { Parent = object, FillDirection = "Vertical", Padding = UDim.new(0, 5) })
				for itemIndex, item in next, block.Items do
					local prefix = string.rep("    ", item.Level or 0)
					if item.Checked ~= nil then
						prefix ..= item.Checked and "☑ " or "☐ "
					else
						prefix ..= block.Ordered and (itemIndex .. ". ") or "• "
					end
					makeText(object, prefix .. item.Value, { Transparency = 0.16 })
				end
			elseif block.Type == "Code" then
				local code = CodeComponent.New({ Title = block.Language ~= "" and block.Language or nil, Code = block.Value, CodeSize = 15, CanCopied = true }, config.Window, root, nil, config.UIScale)
				object = code.CodeFrame
			elseif block.Type == "Table" then
				object = renderTable(root, block, config)
			elseif block.Type == "Image" then
				object = makeCard(root, config, { Transparency = 0.965 })
				New("UIListLayout", { Parent = object, FillDirection = "Vertical", Padding = UDim.new(0, 8) })
				New("UIPadding", { Parent = object, PaddingTop = UDim.new(0, 7), PaddingBottom = UDim.new(0, 9), PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 7) })
				local image = Creator.Image(block.Source, block.Alt, math.max((config.Radius or config.Window.ElementConfig.UICorner) - 4, 0), config.Window.Folder, "Markdown", false)
				image.Parent = object
				image.Size = UDim2.new(1, 0, 0, config.ImageHeight or 220)
				if block.Alt ~= "" then
					local caption = makeText(object, block.Alt, { Size = 13, Transparency = 0.38 })
					New("UIPadding", { Parent = caption, PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3) })
				end
			elseif block.Type == "Video" then
				local _, video = VideoElement:New({
					Parent = root, Window = config.Window, Video = block.Source,
					AspectRatio = config.VideoAspectRatio or "16:9", Autoplay = block.Autoplay,
					Loop = block.Looped, Muted = block.Muted, Volume = config.VideoVolume or 0,
					Height = config.VideoHeight or 220,
				})
				object = video.ElementFrame
			end
			if object then table.insert(markdown.Elements, object) end
		end
	end

	function markdown:SetContent(content)
		markdown.Content = content or ""
		render(markdown.Content)
		return markdown
	end
	function markdown:Set(content) return markdown:SetContent(content) end
	function markdown:Destroy() root:Destroy() end

	render(markdown.Content)
	return markdown.__type, markdown
end

return Element
