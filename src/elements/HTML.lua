local Markdown = require("./Markdown")

local Element = {}

local function trim(value)
	return (value:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function convertTable(tableHtml)
	local rows = {}
	for row in tableHtml:gmatch("<tr[^>]*>(.-)</tr>") do
		local cells, header = {}, row:find("<th", 1, true) ~= nil
		local cellTag = header and "th" or "td"
		for value in row:gmatch("<" .. cellTag .. "[^>]*>(.-)</" .. cellTag .. ">") do
			value = value:gsub("<br%s*/?>", " "):gsub("<[^>]->", "")
			table.insert(cells, trim(value))
		end
		if #cells > 0 then table.insert(rows, { Cells = cells, Header = header }) end
	end
	if #rows == 0 then return "" end
	local output = { "| " .. table.concat(rows[1].Cells, " | ") .. " |" }
	table.insert(output, "|" .. string.rep(" --- |", #rows[1].Cells))
	for index = 2, #rows do table.insert(output, "| " .. table.concat(rows[index].Cells, " | ") .. " |") end
	return table.concat(output, "\n")
end

local function toMarkdown(html)
	local content = html or ""
	local videos = {}
	content = content:gsub("\r\n", "\n")
	content = content:gsub("<table[^>]*>(.-)</table>", convertTable)
	content = content:gsub('<img%s+([^>]-)>', function(attributes)
		local source = attributes:match('src%s*=%s*["\']([^"\']+)["\']') or ""
		local alt = attributes:match('alt%s*=%s*["\']([^"\']*)["\']') or "Image"
		return "\n![" .. alt .. "](" .. source .. ")\n"
	end)
	content = content:gsub("<video([^>]*)></video>", function(attributes)
		table.insert(videos, "<video" .. attributes .. "></video>")
		return "\n@@WINDUI_VIDEO_" .. #videos .. "@@\n"
	end)
	content = content:gsub('<a%s+[^>]-href%s*=%s*["\']([^"\']+)["\'][^>]*>(.-)</a>', "[%2](%1)")
	content = content:gsub("<strong[^>]*>(.-)</strong>", "**%1**"):gsub("<b[^>]*>(.-)</b>", "**%1**")
	content = content:gsub("<em[^>]*>(.-)</em>", "*%1*"):gsub("<i[^>]*>(.-)</i>", "*%1*")
	content = content:gsub("<del[^>]*>(.-)</del>", "~~%1~~"):gsub("<s[^>]*>(.-)</s>", "~~%1~~")
	content = content:gsub("<code[^>]*>(.-)</code>", "`%1`")
	for level = 6, 1, -1 do
		content = content:gsub("<h" .. level .. "[^>]*>(.-)</h" .. level .. ">", "\n" .. string.rep("#", level) .. " %1\n")
	end
	content = content:gsub("<callout[^>]*>(.-)</callout>", "\n> %1\n")
	content = content:gsub("<blockquote[^>]*>(.-)</blockquote>", "\n> %1\n")
	content = content:gsub("<li[^>]*>(.-)</li>", "\n- %1")
	content = content:gsub("<br%s*/?>", "\n")
	content = content:gsub("</?[pdivarticlesection][^>]*>", "\n")
	content = content:gsub("<[^>]->", "")
	for index, video in ipairs(videos) do
		content = content:gsub("@@WINDUI_VIDEO_" .. index .. "@@", video)
	end
	return trim(content)
end

function Element:New(config)
	local html = config.Content or config.HTML or ""
	local markdownConfig = {}
	for key, value in next, config do markdownConfig[key] = value end
	markdownConfig.Content = toMarkdown(html)
	local _, result = Markdown:New(markdownConfig)
	result.__type = "HTML"
	result.HTML = html
	result.Markdown = markdownConfig.Content
	local setContent = result.SetContent
	function result:SetHTML(value)
		result.HTML = value or ""
		result.Markdown = toMarkdown(result.HTML)
		setContent(result.Markdown)
		return result
	end
	function result:Set(value) return result:SetHTML(value) end
	return result.__type, result
end

return Element
