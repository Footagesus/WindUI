local RunService = game:GetService("RunService")
local RenderStepped = RunService.Heartbeat
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalizationService = game:GetService("LocalizationService")
local HttpService = game:GetService("HttpService")

local IconsURL = "https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"

local Icons = loadstring(
    game.HttpGetAsync and game:HttpGetAsync(IconsURL)
    or HttpService:GetAsync(IconsURL)
)()
Icons.SetIconsType("lucide")

local WindUI

local Creator = {
    Font = "rbxassetid://12187365364",
    Localization = nil,
    CanDraggable = true,
    Theme = nil,
    Themes = nil,
    Icons = Icons,
    Signals = {},
    Objects = {},
    LocalizationObjects = {},
    FontObjects = {},
    Language = string.match(LocalizationService.SystemLocaleId , "^[a-z]+"),
    Request = http_request or (syn and syn.request) or request,
    DefaultProperties = {
        ScreenGui = {
            ResetOnSpawn = false,
            ZIndexBehavior = "Sibling",
        },
        CanvasGroup = {
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.new(1,1,1),
        },
        Frame = {
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.new(1,1,1),
        },
        TextLabel = {
            BackgroundColor3 = Color3.new(1,1,1),
            BorderSizePixel = 0,
            Text = "",
            RichText = true,
            TextColor3 = Color3.new(1,1,1),
            TextSize = 14,
        }, TextButton = {
            BackgroundColor3 = Color3.new(1,1,1),
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor= false,
            TextColor3 = Color3.new(1,1,1),
            TextSize = 14,
        },
        TextBox = {
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderColor3 = Color3.new(0, 0, 0),
            ClearTextOnFocus = false,
            Text = "",
            TextColor3 = Color3.new(0, 0, 0),
            TextSize = 14,
        },
        ImageLabel = {
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderSizePixel = 0,
        },
        ImageButton = {
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderSizePixel = 0,
            AutoButtonColor = false,
        },
        UIListLayout = {
            SortOrder = "LayoutOrder",
        },
        ScrollingFrame = {
            ScrollBarImageTransparency = 1,
            BorderSizePixel = 0,
        },
        VideoFrame = {
            BorderSizePixel = 0,
        }
    },
    Colors = {
        Red = "#e53935",
        Orange = "#f57c00",
        Green = "#43a047",
        Blue = "#039be5",
        White = "#ffffff",
        Grey = "#484848",
    },
}

function Creator.Init(WindUITable)
    WindUI = WindUITable
end

function Creator.AddSignal(Signal, Function)
    local conn = Signal:Connect(Function)
    table.insert(Creator.Signals, conn)
    return conn
end

function Creator.DisconnectAll()
	for idx, signal in next, Creator.Signals do
		local Connection = table.remove(Creator.Signals, idx)
		Connection:Disconnect()
	end
end

function Creator.SafeCallback(Function, ...)
    if not Function then
        return
    end
    
    local Success, Event = pcall(Function, ...)
    if not Success then
        if WindUI and WindUI.Window and WindUI.Window.Debug then
            local _, i = Event:find(":%d+: ")
        
            warn("[ WindUI: DEBUG Mode ] " .. Event)
            
            return WindUI:Notify({
                Title = "DEBUG Mode: Error",
                Content = not i and Event or Event:sub(i + 1),
                Duration = 8,
            })
        end
    end
end

function Creator.Gradient(stops, props)
    if WindUI and WindUI.Gradient then
        return WindUI:Gradient(stops, props)
    end
    
    local colorSequence = {}
    local transparencySequence = {}

    for posStr, stop in next, stops do
        local position = tonumber(posStr)
        if position then
            position = math.clamp(position / 100, 0, 1)
            table.insert(colorSequence, ColorSequenceKeypoint.new(position, stop.Color))
            table.insert(transparencySequence, NumberSequenceKeypoint.new(position, stop.Transparency or 0))
        end
    end

    table.sort(colorSequence, function(a, b) return a.Time < b.Time end)
    table.sort(transparencySequence, function(a, b) return a.Time < b.Time end)

    if #colorSequence < 2 then
        error("ColorSequence requires at least 2 keypoints")
    end

    local gradientData = {
        Color = ColorSequence.new(colorSequence),
        Transparency = NumberSequence.new(transparencySequence),
    }

    if props then
        for k, v in pairs(props) do
            gradientData[k] = v
        end
    end

    return gradientData
end

function Creator.SetTheme(Theme)
    Creator.Theme = Theme
    Creator.UpdateTheme(nil, true)
end

function Creator.AddFontObject(Object)
    table.insert(Creator.FontObjects, Object)
    Creator.UpdateFont(Creator.Font)
end

function Creator.UpdateFont(FontId)
    Creator.Font = FontId
    for _,Obj in next, Creator.FontObjects do
        Obj.FontFace = Font.new(FontId, Obj.FontFace.Weight, Obj.FontFace.Style)
    end
end

function Creator.GetThemeProperty(Property, Theme)
    local value = Theme[Property] or Creator.Themes["Dark"][Property]
    
    if not value then return nil end
    
    if type(value) == "string" and string.sub(value, 1, 1) == "#" then
        return Color3.fromHex(value)
    end
    
    if typeof(value) == "Color3" then
        return value
    end
    
    if type(value) == "table" and value.Color and value.Transparency then
        return value
    end
    
    if type(value) == "function" then
        return value()
    end
    
    return nil
end

function Creator.AddThemeObject(Object, Properties)
    Creator.Objects[Object] = { Object = Object, Properties = Properties }
    Creator.UpdateTheme(Object, false)
    return Object
end

function Creator.AddLangObject(idx)
    local currentObj = Creator.LocalizationObjects[idx]
    local Object = currentObj.Object
    local TranslationId = currentObjTranslationId
    Creator.UpdateLang(Object, TranslationId)
    return Object
end

function Creator.UpdateTheme(TargetObject, isTween)
    local function ApplyTheme(objData)
        for Property, ColorKey in pairs(objData.Properties or {}) do
            local value = Creator.GetThemeProperty(ColorKey, Creator.Theme)
            if value then
                if typeof(value) == "Color3" then
                    local gradient = objData.Object:FindFirstChild("WindUIGradient")
                    if gradient then
                        gradient:Destroy()
                    end
                    
                    if not isTween then
                        objData.Object[Property] = value
                    else
                        Creator.Tween(objData.Object, 0.08, { [Property] = value }):Play()
                    end
                elseif type(value) == "table" and value.Color and value.Transparency then
                    objData.Object[Property] = Color3.new(1, 1, 1)
                    
                    local gradient = objData.Object:FindFirstChild("WindUIGradient")
                    if not gradient then
                        gradient = Instance.new("UIGradient")
                        gradient.Name = "WindUIGradient"
                        gradient.Parent = objData.Object
                    end
                    
                    gradient.Color = value.Color
                    gradient.Transparency = value.Transparency
                    
                    for prop, propValue in pairs(value) do
                        if prop ~= "Color" and prop ~= "Transparency" and gradient[prop] ~= nil then
                            gradient[prop] = propValue
                        end
                    end
                end
            else
                local gradient = objData.Object:FindFirstChild("WindUIGradient")
                if gradient then
                    gradient:Destroy()
                end
            end
        end
    end

    if TargetObject then
        local objData = Creator.Objects[TargetObject]
        if objData then
            ApplyTheme(objData)
        end
    else
        for _, objData in pairs(Creator.Objects) do
            ApplyTheme(objData)
        end
    end
end

function Creator.SetLangForObject(index)
    if Creator.Localization and Creator.Localization.Enabled then
        local data = Creator.LocalizationObjects[index]
        if not data then return end
        
        local obj = data.Object
        local translationId = data.TranslationId
        
        local translations = Creator.Localization.Translations[Creator.Language]
        if translations and translations[translationId] then
            obj.Text = translations[translationId]
        else
            local enTranslations = Creator.Localization and Creator.Localization.Translations and Creator.Localization.Translations.en or nil
            if enTranslations and enTranslations[translationId] then
                obj.Text = enTranslations[translationId]
            else
                obj.Text = "[" .. translationId .. "]"
            end
        end
    end
end

function Creator:ChangeTranslationKey(object, newKey)
    if Creator.Localization and Creator.Localization.Enabled then
        local ParsedKey = string.match(newKey, "^" .. Creator.Localization.Prefix .. "(.+)")
        if ParsedKey then
            for i, data in ipairs(Creator.LocalizationObjects) do
                if data.Object == object then
                    data.TranslationId = ParsedKey
                    Creator.SetLangForObject(i)
                    return
                end
            end
            
            table.insert(Creator.LocalizationObjects, {
                TranslationId = ParsedKey,
                Object = object
            })
            Creator.SetLangForObject(#Creator.LocalizationObjects)
        end
    end
end

function Creator.UpdateLang(newLang)
    if newLang then
        Creator.Language = newLang
    end
    
    for i = 1, #Creator.LocalizationObjects do
        local data = Creator.LocalizationObjects[i]
        if data.Object and data.Object.Parent ~= nil then
            Creator.SetLangForObject(i)
        else
            Creator.LocalizationObjects[i] = nil
        end
    end
end

function Creator.SetLanguage(lang)
    Creator.Language = lang
    Creator.UpdateLang()
end

function Creator.Icon(Icon)
    return Icons.Icon(Icon)
end

function Creator.AddIcons(packName, iconsData)
    return Icons.AddIcons(packName, iconsData)
end

function Creator.New(Name, Properties, Children)
    local Object = Instance.new(Name)
    
    for Name, Value in next, Creator.DefaultProperties[Name] or {} do
        Object[Name] = Value
    end
    
    for Name, Value in next, Properties or {} do
        if Name ~= "ThemeTag" then
            Object[Name] = Value
        end
        if Creator.Localization and Creator.Localization.Enabled and Name == "Text" then
            local TranslationId = string.match(Value, "^" .. Creator.Localization.Prefix .. "(.+)")
            if TranslationId then
                local currentId = #Creator.LocalizationObjects + 1
                Creator.LocalizationObjects[currentId] = { TranslationId = TranslationId, Object = Object }
                
                Creator.SetLangForObject(currentId)
            end
        end
    end
    
    for _, Child in next, Children or {} do
        Child.Parent = Object
    end
    
    if Properties and Properties.ThemeTag then
        Creator.AddThemeObject(Object, Properties.ThemeTag)
    end
    if Properties and Properties.FontFace then
        Creator.AddFontObject(Object)
    end
    return Object
end

function Creator.Tween(Object, Time, Properties, ...)
    return TweenService:Create(Object, TweenInfo.new(Time, ...), Properties)
end

function Creator.NewRoundFrame(Radius, Type, Properties, Children, isButton, ReturnTable)
    local function getImageForType(shapeType)
        return shapeType == "Squircle" and "rbxassetid://80999662900595"
             or shapeType == "SquircleOutline" and "rbxassetid://117788349049947" 
             or shapeType == "SquircleOutline2" and "rbxassetid://117817408534198" 
             or shapeType == "Squircle-Outline" and "rbxassetid://117817408534198" 
             or shapeType == "Shadow-sm" and "rbxassetid://84825982946844"
             or shapeType == "Squircle-TL-TR" and "rbxassetid://73569156276236"
             or shapeType == "Squircle-BL-BR" and "rbxassetid://93853842912264"
             or shapeType == "Squircle-TL-TR-Outline" and "rbxassetid://136702870075563"
             or shapeType == "Squircle-BL-BR-Outline" and "rbxassetid://75035847706564"
             or shapeType == "Square" and "rbxassetid://82909646051652"
             or shapeType == "Square-Outline" and "rbxassetid://72946211851948"
    end
    
    local function getSliceCenterForType(shapeType)
        return shapeType ~= "Shadow-sm" and Rect.new(
            512/2,
            512/2,
            512/2,
            512/2
        ) or Rect.new(512,512,512,512)
    end
    
    local Image = Creator.New(isButton and "ImageButton" or "ImageLabel", {
        Image = getImageForType(Type),
        ScaleType = "Slice",
        SliceCenter = getSliceCenterForType(Type),
        SliceScale = 1,
        BackgroundTransparency = 1,
        ThemeTag = Properties.ThemeTag and Properties.ThemeTag
    }, Children)
    
    for k, v in pairs(Properties or {}) do
        if k ~= "ThemeTag" then
            Image[k] = v
        end
    end

    local function UpdateSliceScale(newRadius)
        local sliceScale = Type ~= "Shadow-sm" and (newRadius / (512/2)) or (newRadius/512)
        Image.SliceScale = math.max(sliceScale, 0.0001)
    end
    
    local Wrapper = {}
    
    function Wrapper:SetRadius(newRadius)
        UpdateSliceScale(newRadius)
    end
    
    function Wrapper:SetType(newType)
        Type = newType
        Image.Image = getImageForType(newType)
        Image.SliceCenter = getSliceCenterForType(newType)
        UpdateSliceScale(Radius)
    end
    
    function Wrapper:UpdateShape(newRadius, newType)
        if newType then
            Type = newType
            Image.Image = getImageForType(newType)
            Image.SliceCenter = getSliceCenterForType(newType)
        end
        if newRadius then
            Radius = newRadius
        end
        UpdateSliceScale(Radius)
    end
    
    function Wrapper:GetRadius()
        return Radius
    end
    
    function Wrapper:GetType()
        return Type
    end
    
    UpdateSliceScale(Radius)

    return Image, ReturnTable and Wrapper or nil
end

local New = Creator.New
local Tween = Creator.Tween

function Creator.SetDraggable(can)
    Creator.CanDraggable = can
end

function Creator.Drag(mainFrame, dragFrames, ondrag)
    local currentDragFrame = nil
    local dragging, dragInput, dragStart, startPos
    local DragModule = {
        CanDraggable = true
    }
    
    if not dragFrames or type(dragFrames) ~= "table" then
        dragFrames = {mainFrame}
    end
    
    local function update(input)
        local delta = input.Position - dragStart
        Creator.Tween(mainFrame, 0.02, {Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )}):Play()
    end
    
    for _, dragFrame in pairs(dragFrames) do
        dragFrame.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and DragModule.CanDraggable then
                if currentDragFrame == nil then
                    currentDragFrame = dragFrame
                    dragging = true
                    dragStart = input.Position
                    startPos = mainFrame.Position
                    
                    if ondrag and type(ondrag) == "function" then 
                        ondrag(true, currentDragFrame)
                    end
                    
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                            currentDragFrame = nil
                            
                            if ondrag and type(ondrag) == "function" then 
                                ondrag(false, currentDragFrame)
                            end
                        end
                    end)
                end
            end
        end)
        
        dragFrame.InputChanged:Connect(function(input)
            if currentDragFrame == dragFrame and dragging then
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    dragInput = input
                end
            end
        end)
    end
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging and currentDragFrame ~= nil then
            if DragModule.CanDraggable then 
                update(input)
            end
        end
    end)
    
    function DragModule:Set(v)
        DragModule.CanDraggable = v
    end
    
    return DragModule
end

Icons.Init(New, "Icon")

function Creator.Image(Img, Name, Corner, Folder, Type, IsThemeTag, Themed)
    local function SanitizeFilename(str)
        str = str:gsub("[%s/\\:*?\"<>|]+", "-")
        str = str:gsub("[^%w%-_%.]", "")
        return str
    end
    
    Folder = Folder or "Temp"
    Name = SanitizeFilename(Name)
    
    local ImageFrame = New("Frame", {
        Size = UDim2.new(0,0,0,0),
        BackgroundTransparency = 1,
    }, {
        New("ImageLabel", {
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            ScaleType = "Crop",
            ThemeTag = (Creator.Icon(Img) or Themed) and {
                ImageColor3 = IsThemeTag and "Icon" or nil 
            } or nil,
        }, {
            New("UICorner", {
                CornerRadius = UDim.new(0,Corner)
            })
        })
    })
    if Creator.Icon(Img) then
        ImageFrame.ImageLabel:Destroy()
        
        local IconLabel = Icons.Image({ 
            Icon = Img, 
            Size = UDim2.new(1,0,1,0), 
            Colors = { 
                (IsThemeTag and "Icon" or false),
                "Button" 
            } 
        }).IconFrame
        IconLabel.Parent = ImageFrame
    elseif string.find(Img,"http") then
        local FileName = "WindUI/" .. Folder .. "/Assets/." .. Type .. "-" .. Name .. ".png"
        local success, response = pcall(function()
            task.spawn(function()
                if not isfile(FileName) then
                    local response = Creator.Request({
                        Url = Img,
                        Method = "GET",
                    }).Body
                    
                    writefile(FileName, response)
                end
                ImageFrame.ImageLabel.Image = getcustomasset(FileName)
            end)
        end)
        if not success then
            warn("[ WindUI.Creator ]  '" .. identifyexecutor() .. "' doesnt support the URL Images. Error: " .. response)
            
            ImageFrame:Destroy()
        end
    elseif Img == "" then
        ImageFrame.Visible = false
    else
        ImageFrame.ImageLabel.Image = Img
    end
    
    return ImageFrame
end

return Creator