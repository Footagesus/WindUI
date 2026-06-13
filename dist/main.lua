--[[
     _      ___         ____  ______
    | | /| / (_)__  ___/ / / / /  _/
    | |/ |/ / / _ \/ _  / /_/ // /  
    |__/|__/_/_//_/\_,_/\____/___/
    
    v1.6.65  |  2026-06-13  |  Roblox UI Library for scripts
    
    To view the source code, see the `src/` folder on the official GitHub repository.
    
    Author: Footagesus (Footages, .ftgs, oftgs)
    Github: https://github.com/Footagesus/WindUI
    Discord: https://discord.gg/ftgs-development-hub-1300692552005189632
    License: MIT
]]

type ConfigType__DARKLUA_TYPE_a={
Object:Instance,
Camera:Instance?,
Interactive:boolean?,
Height:number?,
Focused:boolean,

Window:any,
Tab:any,
Parent:Instance,
}local a a={cache={}, load=function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}end return a.cache[b].c end}do function a.a()

local b

local d={
New=nil,
Init=nil,
Shapes={
Circle={
Image="rbxassetid://111665032676235",
Rect=Rect.new(512,512,512,512),
Radius=512,
},
CircleOutline={
Image="rbxassetid://108556680453287",
Rect=Rect.new(512,512,512,512),
Radius=512,
},
CircleGlass={
Image="rbxassetid://95600044758841",
Rect=Rect.new(512,512,512,512),
Radius=512,
},



SquircleH={
Image="rbxassetid://125083578015333",
Rect=Rect.new(512,325,512,325),
Radius=325,
},
SquircleHOutline={
Image="rbxassetid://107043713170567",
Rect=Rect.new(512,325,512,325),
Radius=325,
},
SquircleHGlass={
Image="rbxassetid://84819521201001",
Rect=Rect.new(512,325,512,325),
Radius=325,
},
["SquircleH-TL-TR"]={
Image="rbxassetid://90680657206619",
Rect=Rect.new(807,512,807,512),
Radius=325,
AutoChange=false,
},
["SquircleH-BL-BR"]={
Image="rbxassetid://99216342056719",
Rect=Rect.new(0,512,0,512),
Radius=325,
AutoChange=false,
},

SquircleV={
Image="rbxassetid://124965260437653",
Rect=Rect.new(325,512,325,512),
Radius=325,
},
SquircleVOutline={
Image="rbxassetid://88808835404198",
Rect=Rect.new(325,512,325,512),
Radius=325,
},
SquircleVGlass={
Image="rbxassetid://124982801466667",
Rect=Rect.new(325,512,325,512),
Radius=325,
},

Squircle={
Image="rbxassetid://89641024074289",
Rect=Rect.new(460,460,460,460),
Radius=310,
},
SquircleOutline={
Image="rbxassetid://74029063732681",
Rect=Rect.new(512,512,512,512),
Radius=310,
},
SquircleGlass={
Image="rbxassetid://131126436897551",
Rect=Rect.new(512,512,512,512),
Radius=310,
},

["Squircle-TL-TR"]={
Image="rbxassetid://75712142040725",
Rect=Rect.new(512,512,512,512),
Radius=310,
AutoChange=false,
},
["Squircle-BL-BR"]={
Image="rbxassetid://83676684425544",
Rect=Rect.new(512,0,512,0),
Radius=310,
AutoChange=false,
},Square=
{
Image="rbxassetid://82909646051652",
Rect=Rect.new(512,512,512,512),
Radius=512,
AutoChange=false,
},
},
}

function d.Init(e,f)
b=f
return e.New
end

function d.New(e,f,g,h,i,j,l)
local m={
Radius=f or 0,
Type=g or"Circle",
GetRadius=nil,
GetType=nil,
SetRadius=nil,
SetType=nil,
}

local p={
["Glass-0.7"]="SquircleGlass",
["Glass-1"]="SquircleGlass",
["Glass-1.4"]="SquircleGlass",
["Squircle-Outline"]="SquircleOutline",
}

local function GetShape(r)
return d.Shapes[p[r]or r]or d.Shapes.Circle
end

local r=b.New(j and"ImageButton"or"ImageLabel",{
Image="",
ScaleType=l~=false and"Slice"or nil,
SliceCenter=m.Type~="Squircle"and Rect.new(512,512,512,512)or nil,
SliceScale=1,
ThemeTag=h and h.ThemeTag or nil,
BackgroundTransparency=1,
},i)

for u,v in next,h do
if not table.find({"ThemeTag"},u)then
r[u]=v
end
end

function m.SetRadius(u,v)
m.Radius=v
r.SliceScale=math.max(v/GetShape(m.Type).Radius,0.0001)
return m
end

function m.SetType(u,v)
m.Type=v
local x=GetShape(v)
r.Image=x.Image
r.SliceCenter=x.Rect
m:SetRadius(m.Radius)
return m
end

function m.GetRadius(u)
return m.Radius
end

function m.GetType(u)
return m.Type
end

m:SetRadius(f)
m:SetType(g)

b.AddSignal(r:GetPropertyChangedSignal"AbsoluteSize",function()
local u=GetShape(m.Type)
if u.AutoChange==false then
return
end

if string.find(m.Type,"Squircle")then
local v=string.find(m.Type,"Glass")and"Glass"or nil
local x=string.find(m.Type,"Outline")and"Outline"or nil

local z=math.round(r.AbsoluteSize.X/b.UIScale)
local A=math.round(r.AbsoluteSize.Y/b.UIScale)

local B=m.Radius~=0 and m.Radius or math.min(z,A)/2
local C=d.Shapes.Squircle.Radius/1024
local F=B/math.min(z,A)

local G

if z>A then
if F>=C then
G="SquircleH"..(x or v or"")
else
G="Squircle"..(x or v or"")
end
elseif z<A then
if F>=C then
G="SquircleV"..(x or v or"")
else
G="Squircle"..(x or v or"")
end
else
if F>=C then
G="Circle"..(x or v or"")
else
G="Squircle"..(x or v or"")
end
end

m:SetType(G)
end
end)

return r,m
end

return d end function a.b()

local b=(cloneref or clonereference or function(b)return b end)

local d=b(game:GetService"ReplicatedStorage":WaitForChild("GetIcons",99999):InvokeServer())

local function parseIconString(e)
if type(e)=="string"then
local f=e:find":"
if f then
local g=e:sub(1,f-1)
local h=e:sub(f+1)
return g,h
end
end
return nil,e
end

function d.AddIcons(e,f)
if type(e)~="string"or type(f)~="table"then
error"AddIcons: packName must be string, iconsData must be table"
return
end

if not d.Icons[e]then
d.Icons[e]={
Icons={},
Spritesheets={}
}
end

for g,h in pairs(f)do
if type(h)=="number"or(type(h)=="string"and h:match"^rbxassetid://")then
local i=h
if type(h)=="number"then
i="rbxassetid://"..tostring(h)
end

d.Icons[e].Icons[g]={
Image=i,
ImageRectSize=Vector2.new(0,0),
ImageRectPosition=Vector2.new(0,0),
Parts=nil
}
d.Icons[e].Spritesheets[i]=i

elseif type(h)=="table"then
if h.Image and h.ImageRectSize and h.ImageRectPosition then
local i=h.Image
if type(i)=="number"then
i="rbxassetid://"..tostring(i)
end

d.Icons[e].Icons[g]={
Image=i,
ImageRectSize=h.ImageRectSize,
ImageRectPosition=h.ImageRectPosition,
Parts=h.Parts
}

if not d.Icons[e].Spritesheets[i]then
d.Icons[e].Spritesheets[i]=i
end
else
warn("AddIcons: Invalid spritesheet data format for icon '"..g.."'")
end
else
warn("AddIcons: Unsupported data type for icon '"..g.."': "..type(h))
end
end
end

function d.SetIconsType(e)
d.IconsType=e
end

local e
function d.Init(f,g)
d.New=f
d.IconThemeTag=g

e=f
return d
end

function d.Icon(f,g,h)
h=h~=false
local i,j=parseIconString(f)

local l=i or g or d.IconsType
local m=j

local p=d.Icons[l]

if p and p.Icons and p.Icons[m]then
return{
p.Spritesheets[tostring(p.Icons[m].Image)],
p.Icons[m],
}
elseif p and p[m]and string.find(p[m],"rbxassetid://")then
return h and{
p[m],
{ImageRectSize=Vector2.new(0,0),ImageRectPosition=Vector2.new(0,0)}
}or p[m]
end
return nil
end

function d.GetIcon(f,g)
return d.Icon(f,g,false)
end


function d.Icon2(f,g,h)
return d.Icon(f,g,true)
end

function d.Image(f)
local g={
Icon=f.Icon or nil,
Type=f.Type,
Colors=f.Colors or{(d.IconThemeTag or Color3.new(1,1,1)),Color3.new(1,1,1)},
Transparency=f.Transparency or{0,0},
Size=f.Size or UDim2.new(0,24,0,24),

IconFrame=nil,
}

local h={}
local i={}

for j,l in next,g.Colors do
h[j]={
ThemeTag=typeof(l)=="string"and l,
Color=typeof(l)=="Color3"and l,
}
end

for j,l in next,g.Transparency do
i[j]={
ThemeTag=typeof(l)=="string"and l,
Value=typeof(l)=="number"and l,
}
end


local j=d.Icon2(g.Icon,g.Type)
local l=typeof(j)=="string"and string.find(j,'rbxassetid://')

if d.New then
local m=e or d.New



local p=m("ImageLabel",{
Size=g.Size,
BackgroundTransparency=1,
ImageColor3=h[1].Color or nil,
ImageTransparency=i[1].Value or nil,
ThemeTag=h[1].ThemeTag and{
ImageColor3=h[1].ThemeTag,
ImageTransparency=i[1].ThemeTag,
},
Image=l and j or j[1],
ImageRectSize=l and nil or j[2].ImageRectSize,
ImageRectOffset=l and nil or j[2].ImageRectPosition,
})


if not l and j[2].Parts then
for r,u in next,j[2].Parts do
local v=d.Icon(u,g.Type)

m("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ImageColor3=h[1+r].Color or nil,
ImageTransparency=i[1+r].Value or nil,
ThemeTag=h[1+r].ThemeTag and{
ImageColor3=h[1+r].ThemeTag,
ImageTransparency=i[1+r].ThemeTag,
},
Image=v[1],
ImageRectSize=v[2].ImageRectSize,
ImageRectOffset=v[2].ImageRectPosition,
Parent=p,
})
end
end

g.IconFrame=p
else
local m=Instance.new"ImageLabel"
m.Size=g.Size
m.BackgroundTransparency=1
m.ImageColor3=h[1].Color
m.ImageTransparency=i[1].Value or nil
m.Image=l and j or j[1]
m.ImageRectSize=l and nil or j[2].ImageRectSize
m.ImageRectOffset=l and nil or j[2].ImageRectPosition


if not l and j[2].Parts then
for p,r in next,j[2].Parts do
local u=d.Icon(r,g.Type)

local v=Instance.New"ImageLabel"
v.Size=UDim2.new(1,0,1,0)
v.BackgroundTransparency=1
v.ImageColor3=h[1+p].Color
v.ImageTransparency=i[1+p].Value or nil
v.Image=u[1]
v.ImageRectSize=u[2].ImageRectSize
v.ImageRectOffset=u[2].ImageRectPosition
v.Parent=m
end
end

g.IconFrame=m
end


return g
end

return d end function a.c()
return function(b)
return{


Primary="Icon",

White=Color3.new(1,1,1),
Black=Color3.new(0,0,0),

Dialog="Accent",

Background="Accent",
BackgroundTransparency=0,
Hover="Text",

PanelBackground="White",
PanelBackgroundTransparency=0.95,

WindowBackground="Background",

WindowShadow="Black",


WindowTopbarTitle="Text",
WindowTopbarAuthor="Text",
WindowTopbarIcon="Icon",
WindowTopbarButtonIcon="Icon",


WindowSearchBarBackground="Dialog",

TabBackground="Hover",
TabBackgroundHover="Hover",
TabBackgroundHoverTransparency=0.97,
TabBackgroundActive="Hover",
TabBackgroundActiveTransparency=0.93,
TabText="Text",
TabTextTransparency=0.3,
TabTextTransparencyActive=0,
TabTitle="Text",
TabIcon="Icon",
TabIconTransparency=0.4,
TabIconTransparencyActive=0.1,
TabBorderTransparency=1,
TabBorderTransparencyActive=0.75,
TabBorder="White",

ElementBackground="Text",
ElementBackgroundTransparency=0.93,
ElementBackgroundHover=b:AddColor("ElementBackground","#ffffff",0.1),
ElementTitle="Text",
ElementDesc="Text",
ElementIcon="Icon",

PopupBackground="Background",
PopupBackgroundTransparency="BackgroundTransparency",
PopupTitle="Text",
PopupContent="Text",
PopupIcon="Icon",

DialogBackground="Dialog",
DialogBackgroundTransparency="BackgroundTransparency",
DialogTitle="Text",
DialogContent="Text",
DialogIcon="Icon",

Toggle="Button",
ToggleBar="White",

Checkbox="Primary",
CheckboxIcon="White",
CheckboxBorder="White",
CheckboxBorderTransparency=0.75,

SliderIcon="Icon",

Slider="Primary",
SliderThumb="White",
SliderIconFrom="SliderIcon",
SliderIconTo="SliderIcon",

Tooltip=Color3.fromHex"4C4C4C",
TooltipText="White",
TooltipSecondary="Primary",
TooltipSecondaryText="White",

TabSectionIcon="Icon",

SectionIcon="Icon",

SectionExpandIcon="White",
SectionExpandIconTransparency=0.4,
SectionBox="White",
SectionBoxTransparency=0.95,
SectionBoxBorder="White",
SectionBoxBorderTransparency=0.75,
SectionBoxBackground="White",
SectionBoxBackgroundTransparency=0.97,

SearchBarBorder="White",
SearchBarBorderTransparency=0.75,

Notification="Background",
Notification2="White",
Notification2Transparency=0.92,
NotificationTitle="Text",
NotificationTitleTransparency=0,
NotificationContent="Text",
NotificationContentTransparency=0.4,
NotificationDuration="White",
NotificationDurationTransparency=0.95,
NotificationBorder="White",
NotificationBorderTransparency=0.75,

DropdownTabBorder="White",
DropdownTabBackground="ElementBackground",
DropdownBackground="Background",

LabelBackground="White",
LabelBackgroundTransparency=0.95,

ViewportBackground="ElementBackground",
ViewportBackgroundTransparency="ElementBackgroundTransparency",
}
end end function a.d()

local b=(cloneref or clonereference or function(b)
return b
end)

local d=b(game:GetService"RunService")
local e=b(game:GetService"UserInputService")
local f=b(game:GetService"TweenService")
local g=b(game:GetService"LocalizationService")
local h=b(game:GetService"HttpService")

local i=a.load'a'local j=

d.Heartbeat

local l="https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"

local m
if d:IsStudio()or not writefile then
m=a.load'b'
else
m=loadstring(
game.HttpGetAsync and game:HttpGetAsync(l)or h:GetAsync(l)
)()
end

m.SetIconsType"lucide"

local p

local r
r={
Font="rbxassetid://12187365364",
Localization=nil,
CanDraggable=true,
Theme=nil,
Themes=nil,
Icons=m,
Signals={},
Objects={},
LocalizationObjects={},
UIScale=1,
FontObjects={},
Language=string.match(g.SystemLocaleId,"^[a-z]+"),
Request=http_request or(syn and syn.request)or request,
DefaultProperties={
ScreenGui={
ResetOnSpawn=false,
ZIndexBehavior="Sibling",
},
CanvasGroup={
BorderSizePixel=0,
BackgroundColor3=Color3.new(1,1,1),
},
Frame={
BorderSizePixel=0,
BackgroundColor3=Color3.new(1,1,1),
},
TextLabel={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Text="",
RichText=true,
TextColor3=Color3.new(1,1,1),
TextSize=14,
},
TextButton={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Text="",
AutoButtonColor=false,
TextColor3=Color3.new(1,1,1),
TextSize=14,
},
TextBox={
BackgroundColor3=Color3.new(1,1,1),
BorderColor3=Color3.new(0,0,0),
ClearTextOnFocus=false,
Text="",
TextColor3=Color3.new(0,0,0),
TextSize=14,
},
ImageLabel={
BackgroundTransparency=1,
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
},
ImageButton={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AutoButtonColor=false,
},
UIListLayout={
SortOrder="LayoutOrder",
},
ScrollingFrame={
ScrollBarImageTransparency=1,
BorderSizePixel=0,
},
VideoFrame={
BorderSizePixel=0,
},
},
Colors={
Red="#e53935",
Orange="#f57c00",
Green="#43a047",
Blue="#039be5",
White="#ffffff",
Grey="#484848",
},
ThemeFallbacks=nil,





















ThemeChangeCallbacks={},
}

function r.Init(u)
p=u

r.ThemeFallbacks=a.load'c'(r)

r.UIScale=u.UIScale

i:Init(r)
end

function r.AddSignal(u,v)
local x=u:Connect(v)
table.insert(r.Signals,x)
return x
end

function r.DisconnectAll()
for u,v in next,r.Signals do
local x=table.remove(r.Signals,u)
x:Disconnect()
end
end

function r.SafeCallback(u,...)
if not u then
return
end

local v,x=pcall(u,...)
if not v then
if p and p.Window and p.Window.Debug then local
z, A=x:find":%d+: "

warn("[ WindUI: DEBUG Mode ] "..x)

return p:Notify{
Title="DEBUG Mode: Error",
Content=not A and x or x:sub(A+1),
Duration=8,
}
end
end
end

function r.Gradient(u,v)
if p and p.Gradient then
return p:Gradient(u,v)
end

local x={}
local z={}

for A,B in next,u do
local C=tonumber(A)
if C then
C=math.clamp(C/100,0,1)
table.insert(x,ColorSequenceKeypoint.new(C,B.Color))
table.insert(z,NumberSequenceKeypoint.new(C,B.Transparency or 0))
end
end

table.sort(x,function(A,B)
return A.Time<B.Time
end)
table.sort(z,function(A,B)
return A.Time<B.Time
end)

if#x<2 then
error"ColorSequence requires at least 2 keypoints"
end

local A={
Color=ColorSequence.new(x),
Transparency=NumberSequence.new(z),
}

if v then
for B,C in pairs(v)do
A[B]=C
end
end

return A
end

function r.SetTheme(u)
local v=r.Theme
r.Theme=u
r.UpdateTheme(nil,false)

for x,z in next,r.ThemeChangeCallbacks do
r.SafeCallback(z,u,v)
end
end

function r.AddFontObject(u)
table.insert(r.FontObjects,u)
r.UpdateFont(r.Font)
end

function r.UpdateFont(u)
r.Font=u
for v,x in next,r.FontObjects do
x.FontFace=Font.new(u,x.FontFace.Weight,x.FontFace.Style)
end
end

function r.GetThemeProperty(u,v)
local function getValue(x,z)
local A=z[x]

if A==nil then
return nil
end

if typeof(A)=="string"and string.sub(A,1,1)=="#"then
return Color3.fromHex(A)
end

if typeof(A)=="Color3"then
return A
end

if typeof(A)=="number"then
return A
end

if typeof(A)=="table"and A.Color and A.Transparency then
return A
end

if typeof(A)=="function"then
return A(z)
end

return A
end

local x=getValue(u,v)
if x~=nil then
if typeof(x)=="string"and string.sub(x,1,1)~="#"then
local z=r.GetThemeProperty(x,v)
if z~=nil then
return z
end
else
return x
end
end

local z=r.ThemeFallbacks[u]
if z~=nil then
if typeof(z)=="string"and string.sub(z,1,1)~="#"then
return r.GetThemeProperty(z,v)
else
return getValue(u,{[u]=z})
end
end

x=getValue(u,r.Themes.Dark)
if x~=nil then
if typeof(x)=="string"and string.sub(x,1,1)~="#"then
local A=r.GetThemeProperty(x,r.Themes.Dark)
if A~=nil then
return A
end
else
return x
end
end

if z~=nil then
if typeof(z)=="string"and string.sub(z,1,1)~="#"then
return r.GetThemeProperty(z,r.Themes.Dark)
else
return getValue(u,{[u]=z})
end
end

return nil
end

function r.AddThemeObject(u,v,x)
if r.Objects[u]then
for z,A in pairs(v)do
r.Objects[u].Properties[z]=A
end
else
r.Objects[u]={Object=u,Properties=v}
end

if not x then
r.UpdateTheme(u,false)
end
return u
end

function r.AddLangObject(u)
local v=r.LocalizationObjects[u]
if not v then
return
end

local x=v.Object

r.SetLangForObject(u)

return x
end

function r.UpdateTheme(u,v,x,z,A,B)
local function ApplyTheme(C)
for F,G in pairs(C.Properties or{})do
local H=r.GetThemeProperty(G,r.Theme)
if H~=nil then
if typeof(H)=="Color3"then
local J=C.Object:FindFirstChild"LibraryGradient"
if J then
J:Destroy()
end

if x then
r.Tween(
C.Object,
z or 0.2,
{[F]=H},
A or Enum.EasingStyle.Quint,
B or Enum.EasingDirection.Out
):Play()
elseif v then
r.Tween(C.Object,0.08,{[F]=H}):Play()
else
C.Object[F]=H
end
elseif typeof(H)=="table"and H.Color and H.Transparency then
C.Object[F]=Color3.new(1,1,1)

local J=C.Object:FindFirstChild"LibraryGradient"
if not J then
J=Instance.new"UIGradient"
J.Name="LibraryGradient"
J.Parent=C.Object
end

J.Color=H.Color
J.Transparency=H.Transparency

for L,M in pairs(H)do
if L~="Color"and L~="Transparency"and J[L]~=nil then
J[L]=M
end
end
elseif typeof(H)=="number"then
if x then
r.Tween(
C.Object,
z or 0.2,
{[F]=H},
A or Enum.EasingStyle.Quint,
B or Enum.EasingDirection.Out
):Play()
elseif v then
r.Tween(C.Object,0.08,{[F]=H}):Play()
else
C.Object[F]=H
end
end
else
local J=C.Object:FindFirstChild"LibraryGradient"
if J then
J:Destroy()
end
end
end
end

if u then
local C=r.Objects[u]
if C then
ApplyTheme(C)
end
else
for C,F in pairs(r.Objects)do
ApplyTheme(F)
end
end
end

function r.SetThemeTag(u,v,x,z,A)
r.AddThemeObject(u,v)
r.UpdateTheme(u,false,true,x,z,A)
end

function r.SetLangForObject(u)
if r.Localization and r.Localization.Enabled then
local v=r.LocalizationObjects[u]
if not v then
return
end

local x=v.Object
local z=v.TranslationId

local A=r.Localization.Translations[r.Language]
if A and A[z]then
x.Text=A[z]
else
local B=r.Localization
and r.Localization.Translations
and r.Localization.Translations.en
or nil
if B and B[z]then
x.Text=B[z]
else
x.Text="["..z.."]"
end
end
end
end

function r.ChangeTranslationKey(u,v,x)
if r.Localization and r.Localization.Enabled then
local z=string.match(x,"^"..r.Localization.Prefix.."(.+)")
if z then
for A,B in ipairs(r.LocalizationObjects)do
if B.Object==v then
B.TranslationId=z
r.SetLangForObject(A)
return
end
end

table.insert(r.LocalizationObjects,{
TranslationId=z,
Object=v,
})
r.SetLangForObject(#r.LocalizationObjects)
end
end
end

function r.UpdateLang(u)
if u then
r.Language=u
end

for v=1,#r.LocalizationObjects do
local x=r.LocalizationObjects[v]
if x.Object and x.Object.Parent~=nil then
r.SetLangForObject(v)
else
r.LocalizationObjects[v]=nil
end
end
end

function r.SetLanguage(u)
r.Language=u
r.UpdateLang()
end

function r.Icon(u,v)
return m.Icon2(u,nil,v~=false)
end

function r.AddIcons(u,v)
return m.AddIcons(u,v)
end

function r.New(u,v,x)
local z=Instance.new(u)

for A,B in next,r.DefaultProperties[u]or{}do
z[A]=B
end

for A,B in next,v or{}do
if A~="ThemeTag"then
z[A]=B
end
if r.Localization and r.Localization.Enabled and A=="Text"then
local C=string.match(B,"^"..r.Localization.Prefix.."(.+)")
if C then
local F=#r.LocalizationObjects+1
r.LocalizationObjects[F]={TranslationId=C,Object=z}

r.SetLangForObject(F)
end
end
end

for A,B in next,x or{}do
B.Parent=z
end

if v and v.ThemeTag then
r.AddThemeObject(z,v.ThemeTag)
end
if v and v.FontFace then
r.AddFontObject(z)
end
return z
end

function r.Tween(u,v,x,...)
return f:Create(u,TweenInfo.new(v,...),x)
end








































































function r.NewRoundFrame(u,v,x,z,A,B)
return i:New(u,v,x,z,A,nil)
end

local u=r.New local v=
r.Tween

function r.SetDraggable(x)
r.CanDraggable=x
end

function r.Drag(x,z,A)
local B=p.GenerateGUID()

local C
local F,G,H
local J={
CanDraggable=true,
}

if not z or typeof(z)~="table"then
z={x}
end

local function update(L)
if not F or not J.CanDraggable then
return
end

local M=L.Position-G
r.Tween(x,0.02,{
Position=UDim2.new(
H.X.Scale,
H.X.Offset+M.X,
H.Y.Scale,
H.Y.Offset+M.Y
),
}):Play()
end

for L,M in pairs(z)do
M.InputBegan:Connect(function(N)
if
(
N.UserInputType==Enum.UserInputType.MouseButton1
or N.UserInputType==Enum.UserInputType.Touch
)and J.CanDraggable
then
if p and p.CurrentInput and p.CurrentInput~=B then
return
end
p.CurrentInput=B

if C==nil then
C=M
F=true
G=N.Position
H=x.Position

if A and typeof(A)=="function"then
A(true,C)
end

N.Changed:Connect(function()
if N.UserInputState==Enum.UserInputState.End then
if p and p.CurrentInput and p.CurrentInput~=B then
return
end

p.CurrentInput=nil
F=false
C=nil

if A and typeof(A)=="function"then
A(false,nil)
end
end
end)
end
end
end)

M.InputChanged:Connect(function(N)
if F and C==M then
if
N.UserInputType==Enum.UserInputType.MouseMovement
or N.UserInputType==Enum.UserInputType.Touch
then
update(N)
end
end
end)
end

e.InputChanged:Connect(function(L)
if F and C~=nil then
if
L.UserInputType==Enum.UserInputType.MouseMovement
or L.UserInputType==Enum.UserInputType.Touch
then
update(L)
end
end
end)

function J.Set(L,M)
J.CanDraggable=M
end

return J
end

m.Init(u,"Icon")

function r.SanitizeFilename(x)
local z=x:match"([^/]+)$"or x

z=z:gsub("%.[^%.]+$","")

z=z:gsub("[^%w%-_]","_")

if#z>50 then
z=z:sub(1,50)
end

return z
end

function r.Image(x,z,A,B,C,F,G,H)
B=B or"Temp"
z=r.SanitizeFilename(z)

local J=u("Frame",{
Size=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
},{
u("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ScaleType="Crop",
ThemeTag=(r.Icon(x)or G)and{
ImageColor3=F and(H or"Icon")or nil,
}or nil,
},{
u("UICorner",{
CornerRadius=UDim.new(0,A),
}),
}),
})
if r.Icon(x)then
J.ImageLabel:Destroy()

local L=m.Image{
Icon=x,
Size=UDim2.new(1,0,1,0),
Colors={
(F and(H or"Icon")or false),
"Button",
},
}.IconFrame
L.Parent=J
elseif string.find(x,"http")and not string.find(x,"roblox.com")then
local L="WindUI/"..B.."/assets/."..C.."-"..z..".png"
local M,N=pcall(function()
task.spawn(function()
local M=r.Request
and r.Request{
Url=x,
Method="GET",
}.Body
or{}

if not d:IsStudio()and writefile then
writefile(L,M)
end


local N,O=pcall(getcustomasset,L)
if N then
J.ImageLabel.Image=O
else
warn(
string.format(
"[ WindUI.Creator ] Failed to load custom asset '%s': %s",
L,
tostring(O)
)
)
J:Destroy()

return
end
end)
end)
if not M then
warn(
"[ WindUI.Creator ]  '"..identifyexecutor()
or"Studio".."' doesnt support the URL Images. Error: "..N
)

J:Destroy()
end
elseif x==""then
J.Visible=false
else
J.ImageLabel.Image=x
end

return J
end

function r.Color3ToHSB(x)
local z,A,B=x.R,x.G,x.B
local C=math.max(z,A,B)
local F=math.min(z,A,B)
local G=C-F

local H=0
if G~=0 then
if C==z then
H=(A-B)/G%6
elseif C==A then
H=(B-z)/G+2
else
H=(z-A)/G+4
end
H=H*60
else
H=0
end

local J=(C==0)and 0 or(G/C)
local L=C

return{
h=math.floor(H+0.5),
s=J,
b=L,
}
end

function r.GetPerceivedBrightness(x)
local z=x.R
local A=x.G
local B=x.B
return 0.299*z+0.587*A+0.114*B
end

function r.GetTextColorForHSB(x,z)
local A=r.Color3ToHSB(x)local
B, C, F=A.h, A.s, A.b
if r.GetPerceivedBrightness(x)>(z or 0.5)then
return Color3.fromHSV(B/360,0,0.05)
else
return Color3.fromHSV(B/360,0,0.98)
end
end

function r.GetAverageColor(x)
local z,A,B=0,0,0
local C=x.Color.Keypoints
for F,G in ipairs(C)do

z=z+G.Value.R
A=A+G.Value.G
B=B+G.Value.B
end
local F=#C
return Color3.new(z/F,A/F,B/F)
end

function r.GenerateUniqueID(x)
return h:GenerateGUID(false)
end

function r.OnThemeChange(x,z)
if typeof(z)~="function"then
return
end

local A=h:GenerateGUID(false)
r.ThemeChangeCallbacks[A]=z

return{
Disconnect=function()
r.ThemeChangeCallbacks[A]=nil
end,
}
end

function r.AddColor(x,z,A,B)
B=math.clamp(B or 1,0,1)
if typeof(A)=="string"then
A=Color3.fromHex(A)
end

return function(C)
local F
if typeof(z)=="string"and string.sub(z,1,1)~="#"then
F=r.GetThemeProperty(z,C)
elseif typeof(z)=="string"then
F=Color3.fromHex(z)
else
F=z
end

if not F or typeof(F)~="Color3"then
return nil
end

return Color3.new(
math.clamp(F.R+A.R*B,0,1),
math.clamp(F.G+A.G*B,0,1),
math.clamp(F.B+A.B*B,0,1)
)
end
end

return r end function a.e()

local b={}







function b.New(d,e,f)
local g={
Enabled=e.Enabled or false,
Translations=e.Translations or{},
Prefix=e.Prefix or"loc:",
DefaultLanguage=e.DefaultLanguage or"en"
}

f.Localization=g

return g
end



return b end function a.f()
local b=a.load'd'
local d=b.New
local e=b.Tween

local f={
Size=UDim2.new(0,300,1,-156),
SizeLower=UDim2.new(0,300,1,-56),
UICorner=18,
UIPadding=14,

Holder=nil,
NotificationIndex=0,
Notifications={},
}

function f.Init(g)
local h={
Lower=false,
}

function h.SetLower(i)
h.Lower=i
h.Frame.Size=i and f.SizeLower or f.Size
end

h.Frame=d("Frame",{
Position=UDim2.new(1,-29,0,56),
AnchorPoint=Vector2.new(1,0),
Size=f.Size,
Parent=g,
BackgroundTransparency=1,




},{
d("UIListLayout",{
HorizontalAlignment="Center",
SortOrder="LayoutOrder",
VerticalAlignment="Bottom",
Padding=UDim.new(0,8),
}),
d("UIPadding",{
PaddingBottom=UDim.new(0,29),
}),
})
return h
end

function f.New(g)
local h={
Title=g.Title or"Notification",
Content=g.Content or nil,
Icon=g.Icon or nil,
IconThemed=g.IconThemed,
Background=g.Background,
BackgroundImageTransparency=g.BackgroundImageTransparency,
Duration=g.Duration or 5,
Buttons=g.Buttons or{},
CanClose=g.CanClose~=false,
UIElements={},
Closed=false,
}



f.NotificationIndex=f.NotificationIndex+1
f.Notifications[f.NotificationIndex]=h









local i

if h.Icon then





















i=b.Image(
h.Icon,
h.Title..":"..h.Icon,
0,
g.Window,
"Notification",
h.IconThemed
)
i.Size=UDim2.new(0,26,0,26)
i.Position=UDim2.new(0,f.UIPadding,0,f.UIPadding)

end

local l
if h.CanClose then
l=d("ImageButton",{
Image=b.Icon"x"[1],
ImageRectSize=b.Icon"x"[2].ImageRectSize,
ImageRectOffset=b.Icon"x"[2].ImageRectPosition,
BackgroundTransparency=1,
Size=UDim2.new(0,16,0,16),
Position=UDim2.new(1,-f.UIPadding,0,f.UIPadding),
AnchorPoint=Vector2.new(1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=0.4,
},{
d("TextButton",{
Size=UDim2.new(1,8,1,8),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Text="",
}),
})
end

local m=b.NewRoundFrame(f.UICorner,"Squircle",{
Size=UDim2.new(0,0,1,0),
ThemeTag={
ImageTransparency="NotificationDurationTransparency",
ImageColor3="NotificationDuration",
},

})

local p=d("Frame",{
Size=UDim2.new(1,h.Icon and-28-f.UIPadding or 0,1,0),
Position=UDim2.new(1,0,0,0),
AnchorPoint=Vector2.new(1,0),
BackgroundTransparency=1,
AutomaticSize="Y",
},{
d("UIPadding",{
PaddingTop=UDim.new(0,f.UIPadding),
PaddingLeft=UDim.new(0,f.UIPadding),
PaddingRight=UDim.new(0,f.UIPadding),
PaddingBottom=UDim.new(0,f.UIPadding),
}),
d("TextLabel",{
AutomaticSize="Y",
Size=UDim2.new(1,-30-f.UIPadding,0,0),
TextWrapped=true,
TextXAlignment="Left",
RichText=true,
BackgroundTransparency=1,
TextSize=18,
ThemeTag={
TextColor3="NotificationTitle",
TextTransparency="NotificationTitleTransparency",
},
Text=h.Title,
FontFace=Font.new(b.Font,Enum.FontWeight.SemiBold),
}),
d("UIListLayout",{
Padding=UDim.new(0,f.UIPadding/3),
}),
})

if h.Content then
d("TextLabel",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
TextWrapped=true,
TextXAlignment="Left",
RichText=true,
BackgroundTransparency=1,

TextSize=15,
ThemeTag={
TextColor3="NotificationContent",
TextTransparency="NotificationContentTransparency",
},
Text=h.Content,
FontFace=Font.new(b.Font,Enum.FontWeight.Medium),
Parent=p,
})
end

local r=b.NewRoundFrame(f.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
Position=UDim2.new(2,0,1,0),
AnchorPoint=Vector2.new(0,1),
AutomaticSize="Y",
ImageTransparency=0.05,
ThemeTag={
ImageColor3="Notification",
},

},{
b.NewRoundFrame(f.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Notification2",
ImageTransparency="Notification2Transparency",
},
}),
d("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Name="DurationFrame",
},{






d("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ClipsDescendants=true,
},{
m,
}),




}),
d("ImageLabel",{
Name="Background",
Image=h.Background,
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
ScaleType="Crop",
ImageTransparency=h.BackgroundImageTransparency,

},{
d("UICorner",{
CornerRadius=UDim.new(0,f.UICorner),
}),
}),

p,
i,
l,
})

local u=d("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Parent=g.Holder,
},{
r,
})

function h.Close(v)
if not h.Closed then
h.Closed=true
e(
u,
0.45,
{Size=UDim2.new(1,0,0,-8)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
e(r,0.55,{Position=UDim2.new(2,0,1,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
task.wait(0.45)
u:Destroy()
end
end

task.spawn(function()
task.wait()
e(
u,
0.45,
{Size=UDim2.new(1,0,0,r.AbsoluteSize.Y)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
e(r,0.45,{Position=UDim2.new(0,0,1,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if h.Duration then
m.Size=UDim2.new(0,r.DurationFrame.AbsoluteSize.X,1,0)
e(
r.DurationFrame.Frame,
h.Duration,
{Size=UDim2.new(0,0,1,0)},
Enum.EasingStyle.Linear,
Enum.EasingDirection.InOut
):Play()
task.wait(h.Duration)
h:Close()
end
end)

if l then
b.AddSignal(l.TextButton.MouseButton1Click,function()
h:Close()
end)
end


return h
end

return f end function a.g()












local b=4294967296;local d=b-1;local function c(e,f)local g,h=0,1;while e~=0 or f~=0 do local i,l=e%2,f%2;local m=(i+l)%2;g=g+m*h;e=math.floor(e/2)f=math.floor(f/2)h=h*2 end;return g%b end;local function k(e,f,g,...)local h;if f then e=e%b;f=f%b;h=c(e,f)if g then h=k(h,g,...)end;return h elseif e then return e%b else return 0 end end;local function n(e,f,g,...)local h;if f then e=e%b;f=f%b;h=(e+f-c(e,f))/2;if g then h=n(h,g,...)end;return h elseif e then return e%b else return d end end;local function o(e)return d-e end;local function q(e,f)if f<0 then return lshift(e,-f)end;return math.floor(e%4294967296/2^f)end;local function s(e,f)if f>31 or f<-31 then return 0 end;return q(e%b,f)end;local function lshift(e,f)if f<0 then return s(e,-f)end;return e*2^f%4294967296 end;local function t(e,f)e=e%b;f=f%32;local g=n(e,2^f-1)return s(e,f)+lshift(g,32-f)end;local e={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(f)return string.gsub(f,".",function(g)return string.format("%02x",string.byte(g))end)end;local function y(f,g)local h=""for i=1,g do local l=f%256;h=string.char(l)..h;f=(f-l)/256 end;return h end;local function D(f,g)local h=0;for i=g,g+3 do h=h*256+string.byte(f,i)end;return h end;local function E(f,g)local h=64-(g+9)%64;g=y(8*g,8)f=f.."\128"..string.rep("\0",h)..g;assert(#f%64==0)return f end;local function I(f)f[1]=0x6a09e667;f[2]=0xbb67ae85;f[3]=0x3c6ef372;f[4]=0xa54ff53a;f[5]=0x510e527f;f[6]=0x9b05688c;f[7]=0x1f83d9ab;f[8]=0x5be0cd19;return f end;local function K(f,g,h)local i={}for l=1,16 do i[l]=D(f,g+(l-1)*4)end;for l=17,64 do local m=i[l-15]local p=k(t(m,7),t(m,18),s(m,3))m=i[l-2]i[l]=(i[l-16]+p+i[l-7]+k(t(m,17),t(m,19),s(m,10)))%b end;local l,m,p,r,u,v,x,z=h[1],h[2],h[3],h[4],h[5],h[6],h[7],h[8]for A=1,64 do local B=k(t(l,2),t(l,13),t(l,22))local C=k(n(l,m),n(l,p),n(m,p))local F=(B+C)%b;local G=k(t(u,6),t(u,11),t(u,25))local H=k(n(u,v),n(o(u),x))local J=(z+G+H+e[A]+i[A])%b;z=x;x=v;v=u;u=(r+J)%b;r=p;p=m;m=l;l=(J+F)%b end;h[1]=(h[1]+l)%b;h[2]=(h[2]+m)%b;h[3]=(h[3]+p)%b;h[4]=(h[4]+r)%b;h[5]=(h[5]+u)%b;h[6]=(h[6]+v)%b;h[7]=(h[7]+x)%b;h[8]=(h[8]+z)%b end;local function Z(f)f=E(f,#f)local g=I{}for h=1,#f,64 do K(f,h,g)end;return w(y(g[1],4)..y(g[2],4)..y(g[3],4)..y(g[4],4)..y(g[5],4)..y(g[6],4)..y(g[7],4)..y(g[8],4))end;local f;local g={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local h={["/"]="/"}for i,l in pairs(g)do h[l]=i end;local i=function(i)return"\\"..(g[i]or string.format("u%04x",i:byte()))end;local l=function(l)return"null"end;local m=function(m,p)local r={}p=p or{}if p[m]then error"circular reference"end;p[m]=true;if rawget(m,1)~=nil or next(m)==nil then local u=0;for v in pairs(m)do if type(v)~="number"then error"invalid table: mixed or invalid key types"end;u=u+1 end;if u~=#m then error"invalid table: sparse array"end;for v,x in ipairs(m)do table.insert(r,f(x,p))end;p[m]=nil;return"["..table.concat(r,",").."]"else for u,v in pairs(m)do if type(u)~="string"then error"invalid table: mixed or invalid key types"end;table.insert(r,f(u,p)..":"..f(v,p))end;p[m]=nil;return"{"..table.concat(r,",").."}"end end;local p=function(p)return'"'..p:gsub('[%z\1-\31\\"]',i)..'"'end;local r=function(r)if r~=r or r<=-math.huge or r>=math.huge then error("unexpected number value '"..tostring(r).."'")end;return string.format("%.14g",r)end;local u={["nil"]=l,table=m,string=p,number=r,boolean=tostring}f=function(v,x)local z=type(v)local A=u[z]if A then return A(v,x)end;error("unexpected type '"..z.."'")end;local v=function(v)return f(v)end;local x;local z=function(...)local z={}for A=1,select("#",...)do z[select(A,...)]=true end;return z end;local A=z(" ","\t","\r","\n")local B=z(" ","\t","\r","\n","]","}",",")local C=z("\\","/",'"',"b","f","n","r","t","u")local F=z("true","false","null")local G={["true"]=true,["false"]=false,null=nil}local H=function(H,J,L,M)for N=J,#H do if L[H:sub(N,N)]~=M then return N end end;return#H+1 end;local J=function(J,L,M)local N=1;local O=1;for P=1,L-1 do O=O+1;if J:sub(P,P)=="\n"then N=N+1;O=1 end end;error(string.format("%s at line %d col %d",M,N,O))end;local L=function(L)local M=math.floor;if L<=0x7f then return string.char(L)elseif L<=0x7ff then return string.char(M(L/64)+192,L%64+128)elseif L<=0xffff then return string.char(M(L/4096)+224,M(L%4096/64)+128,L%64+128)elseif L<=0x10ffff then return string.char(M(L/262144)+240,M(L%262144/4096)+128,M(L%4096/64)+128,L%64+128)end;error(string.format("invalid unicode codepoint '%x'",L))end;local M=function(M)local N=tonumber(M:sub(1,4),16)local O=tonumber(M:sub(7,10),16)if O then return L((N-0xd800)*0x400+O-0xdc00+0x10000)else return L(N)end end;local N=function(N,O)local P=""local Q=O+1;local R=Q;while Q<=#N do local S=N:byte(Q)if S<32 then J(N,Q,"control character in string")elseif S==92 then P=P..N:sub(R,Q-1)Q=Q+1;local T=N:sub(Q,Q)if T=="u"then local U=N:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",Q+1)or N:match("^%x%x%x%x",Q+1)or J(N,Q-1,"invalid unicode escape in string")P=P..M(U)Q=Q+#U else if not C[T]then J(N,Q-1,"invalid escape char '"..T.."' in string")end;P=P..h[T]end;R=Q+1 elseif S==34 then P=P..N:sub(R,Q-1)return P,Q+1 end;Q=Q+1 end;J(N,O,"expected closing quote for string")end;local O=function(O,P)local Q=H(O,P,B)local R=O:sub(P,Q-1)local S=tonumber(R)if not S then J(O,P,"invalid number '"..R.."'")end;return S,Q end;local P=function(P,Q)local R=H(P,Q,B)local S=P:sub(Q,R-1)if not F[S]then J(P,Q,"invalid literal '"..S.."'")end;return G[S],R end;local Q=function(Q,R)local S={}local T=1;R=R+1;while 1 do local U;R=H(Q,R,A,true)if Q:sub(R,R)=="]"then R=R+1;break end;U,R=x(Q,R)S[T]=U;T=T+1;R=H(Q,R,A,true)local V=Q:sub(R,R)R=R+1;if V=="]"then break end;if V~=","then J(Q,R,"expected ']' or ','")end end;return S,R end;local R=function(R,S)local T={}S=S+1;while 1 do local U,V;S=H(R,S,A,true)if R:sub(S,S)=="}"then S=S+1;break end;if R:sub(S,S)~='"'then J(R,S,"expected string for key")end;U,S=x(R,S)S=H(R,S,A,true)if R:sub(S,S)~=":"then J(R,S,"expected ':' after key")end;S=H(R,S+1,A,true)V,S=x(R,S)T[U]=V;S=H(R,S,A,true)local W=R:sub(S,S)S=S+1;if W=="}"then break end;if W~=","then J(R,S,"expected '}' or ','")end end;return T,S end;local S={['"']=N,["0"]=O,["1"]=O,["2"]=O,["3"]=O,["4"]=O,["5"]=O,["6"]=O,["7"]=O,["8"]=O,["9"]=O,["-"]=O,t=P,f=P,n=P,["["]=Q,["{"]=R}x=function(T,U)local V=T:sub(U,U)local W=S[V]if W then return W(T,U)end;J(T,U,"unexpected character '"..V.."'")end;local T=function(T)if type(T)~="string"then error("expected argument of type string, got "..type(T))end;local U,V=x(T,H(T,1,A,true))V=H(T,V,A,true)if V<=#T then J(T,V,"trailing garbage")end;return U end;
local U,V,W=v,T,Z;





local X={}

local Y=(cloneref or clonereference or function(Y)return Y end)


function X.New(_,aa)

local ab=_;
local ac=aa;
local ad=true;


local ae=function(ae)end;


repeat task.wait(1)until game:IsLoaded();


local af=false;
local ag,ah,ai,aj,ak,al,am,an,ao=setclipboard or toclipboard,request or http_request or syn_request,string.char,tostring,string.sub,os.time,math.random,math.floor,gethwid or function()return Y(game:GetService"Players").LocalPlayer.UserId end
local ap,aq="",0;


local ar="https://api.platoboost.app";
local as=ah{
Url=ar.."/public/connectivity",
Method="GET"
};
if as.StatusCode~=200 and as.StatusCode~=429 then
ar="https://api.platoboost.net";
end


function cacheLink()
if aq+(600)<al()then
local at=ah{
Url=ar.."/public/start",
Method="POST",
Body=U{
service=ab,
identifier=W(ao())
},
Headers={
["Content-Type"]="application/json",
["User-Agent"]="Roblox/Exploit"
}
};

if at.StatusCode==200 then
local au=V(at.Body);

if au.success==true then
ap=au.data.url;
aq=al();
return true,ap
else
ae(au.message);
return false,au.message
end
elseif at.StatusCode==429 then
local au="you are being rate limited, please wait 20 seconds and try again.";
ae(au);
return false,au
end

local au="Failed to cache link.";
ae(au);
return false,au
else
return true,ap
end
end

cacheLink();


local at=function()
local at=""
for au=1,16 do
at=at..ai(an(am()*(26))+97)
end
return at
end


for au=1,5 do
local av=at();
task.wait(0.2)
if at()==av then
local aw="platoboost nonce error.";
ae(aw);
error(aw);
end
end


local au=function()
local au,av=cacheLink();

if au then
ag(av);
end
end


local av=function(av)
local aw=at();
local ax=ar.."/public/redeem/"..aj(ab);

local ay={
identifier=W(ao()),
key=av
}

if ad then
ay.nonce=aw;
end

local az=ah{
Url=ax,
Method="POST",
Body=U(ay),
Headers={
["Content-Type"]="application/json"
}
};

if az.StatusCode==200 then
local aA=V(az.Body);

if aA.success==true then
if aA.data.valid==true then
if ad then
if aA.data.hash==W("true".."-"..aw.."-"..ac)then
return true
else
ae"failed to verify integrity.";
return false
end
else
return true
end
else
ae"key is invalid.";
return false
end
else
if ak(aA.message,1,27)=="unique constraint violation"then
ae"you already have an active key, please wait for it to expire before redeeming it.";
return false
else
ae(aA.message);
return false
end
end
elseif az.StatusCode==429 then
ae"you are being rate limited, please wait 20 seconds and try again.";
return false
else
ae"server returned an invalid status code, please try again later.";
return false
end
end


local aw=function(aw)
if af==true then
return false,("A request is already being sent, please slow down.")
else
af=true;
end

local ax=at();
local ay=ar.."/public/whitelist/"..aj(ab).."?identifier="..W(ao()).."&key="..aw;

if ad then
ay=ay.."&nonce="..ax;
end

local az=ah{
Url=ay,
Method="GET",
};

af=false;

if az.StatusCode==200 then
local aA=V(az.Body);

if aA.success==true then
if aA.data.valid==true then
if ad then
if aA.data.hash==W("true".."-"..ax.."-"..ac)then
return true,""
else
return false,("failed to verify integrity.")
end
else
return true
end
else
if ak(aw,1,4)=="KEY_"then
return true,av(aw)
else
return false,("Key is invalid.")
end
end
else
return false,(aA.message)
end
elseif az.StatusCode==429 then
return false,("You are being rate limited, please wait 20 seconds and try again.")
else
return false,("Server returned an invalid status code, please try again later.")
end
end


local ax=function(ax)
local ay=at();
local az=ar.."/public/flag/"..aj(ab).."?name="..ax;

if ad then
az=az.."&nonce="..ay;
end

local aA=ah{
Url=az,
Method="GET",
};

if aA.StatusCode==200 then
local aB=V(aA.Body);

if aB.success==true then
if ad then
if aB.data.hash==W(aj(aB.data.value).."-"..ay.."-"..ac)then
return aB.data.value
else
ae"failed to verify integrity.";
return nil
end
else
return aB.data.value
end
else
ae(aB.message);
return nil
end
else
return nil
end
end


return{
Verify=aw,
GetFlag=ax,
Copy=au,
}
end


return X end function a.h()






local aa=(cloneref or clonereference or function(aa)
return aa
end)

local ab=aa(game:GetService"HttpService")
local ac={}

function ac.New(ad)
local ae=gethwid or function()
return aa(game:GetService"Players").LocalPlayer.UserId
end
local af,ag=request or http_request or syn_request,setclipboard or toclipboard

function ValidateKey(ah)
local ai="https://new.pandadevelopment.net/api/v1/keys/validate"

local aj={
ServiceID=ad,
HWID=tostring(ae()),
Key=tostring(ah),
}

local ak=ab:JSONEncode(aj)
local al,am=pcall(function()
return af{
Url=ai,
Method="POST",
Headers={
["User-Agent"]="Roblox/Exploit",
["Content-Type"]="application/json",
},
Body=ak,
}
end)

if al and am then
if am.Success then
local an,ao=pcall(function()
return ab:JSONDecode(am.Body)
end)

if an and ao then
if ao.Authenticated_Status and ao.Authenticated_Status=="Success"then
return true,"Authenticated"
else
local ap=ao.Note or"Unknown reason"
return false,"Authentication failed: "..ap
end
else
return false,"JSON decode error"
end
else
warn(
" HTTP request was not successful. Code: "
..tostring(am.StatusCode)
.." Message: "
..am.StatusMessage
)
return false,"HTTP request failed: "..am.StatusMessage
end
else
return false,"Request pcall error"
end
end

function GetKeyLink()
return"https://new.pandadevelopment.net/getkey/"..tostring(ad).."?hwid="..tostring(ae())
end

function CopyLink()
return ag(GetKeyLink())
end

return{
Verify=ValidateKey,
Copy=CopyLink,
}
end

return ac end function a.i()









local aa={}


function aa.New(ab,ac)
local ad="https://sdkapi-public.luarmor.net/library.lua"

local ae=loadstring(
game.HttpGetAsync and game:HttpGetAsync(ad)
or HttpService:GetAsync(ad)
)()
local af=setclipboard or toclipboard

ae.script_id=ab

function ValidateKey(ag)
local ah=ae.check_key(ag);


if(ah.code=="KEY_VALID")then
return true,"Whitelisted!"

elseif(ah.code=="KEY_HWID_LOCKED")then
return false,"Key linked to a different HWID. Please reset it using our bot"

elseif(ah.code=="KEY_INCORRECT")then
return false,"Key is wrong or deleted!"
else
return false,"Key check failed:"..ah.message.." Code: "..ah.code
end
end

function CopyLink()
af(tostring(ac))
end

return{
Verify=ValidateKey,
Copy=CopyLink
}
end


return aa end function a.j()








local aa={}

function aa.New(ab,ac,ad)
JunkieProtected.API_KEY=ac
JunkieProtected.PROVIDER=ad
JunkieProtected.SERVICE_ID=ab

local function ValidateKey(ae)
if not ae or ae==""then
print"No key provided!"

return false,"No key provided. Please get a key."
end

local af=JunkieProtected.IsKeylessMode()
if af and af.keyless_mode then
print"Keyless mode enabled. Starting script..."
return true,"Keyless mode enabled. Starting script..."
end

local ag=JunkieProtected.ValidateKey{Key=ae}
if ag=="valid"then
print"Key is valid! Starting script..."
load()
if _G.JD_IsPremium then
print"Premium user detected!"
else
print"Standard user"
end

return true,"Key is valid!"
else
local ah=JunkieProtected.GetKeyLink()
print"Invalid key!"

return false,"Invalid key. Get one from:"..ah
end
end

local function copyLink()
local ae=JunkieProtected.GetKeyLink()

if setclipboard then
setclipboard(ae)
end
end
return{
Verify=ValidateKey,
Copy=copyLink
}
end

return aa end function a.k()



return{
platoboost={
Name="Platoboost",
Icon="rbxassetid://75920162824531",
Args={"ServiceId","Secret"},

New=a.load'g'.New
},
pandadevelopment={
Name="Panda Development",
Icon="panda",
Args={"ServiceId"},

New=a.load'h'.New
},
luarmor={
Name="Luarmor",
Icon="rbxassetid://130918283130165",
Args={"ScriptId","Discord"},

New=a.load'i'.New
},
junkiedevelopment={
Name="Junkie Development",
Icon="rbxassetid://106310347705078",
Args={"ServiceId","ApiKey","Provider"},

New=a.load'j'.New
},


}end function a.l()



return[[
{
    "name": "windui",
    "version": "1.6.65",
    "main": "./dist/main.lua",
    "repository": "https://github.com/Footagesus/WindUI",
    "discord": "https://discord.gg/ftgs-development-hub-1300692552005189632",
    "author": "Footagesus",
    "description": "Roblox UI Library for scripts",
    "license": "MIT",
    "scripts": {
        "dev": "bash build/build.sh dev $INPUT_FILE",
        "build": "bash build/build.sh build $INPUT_FILE",
        "live": "python3 -m http.server 8642",
        "watch": "chokidar . -i 'node_modules' -i 'dist' -i 'build' -c 'npm run dev --'",
        "live-build": "concurrently \"npm run live\" \"npm run watch --\"",
        "example-live-build": "INPUT_FILE=main_example.lua npm run live-build",
        "updater": "python3 updater/main.py"
    },
    "keywords": [
        "ui-library",
        "ui-design",
        "script",
        "script-hub",
        "exploiting"
    ],
    "devDependencies": {
        "chokidar-cli": "^3.0.0",
        "concurrently": "^9.2.0"
    }
}
]]end function a.m()

local aa={}

local ab=a.load'd'
local ac=ab.New
local ad=ab.Tween

function aa.New(ae,af,ag,ah,ai,aj,ak,al)
ah=ah or"Primary"
local am=al or(not ak and 10 or 999)
local an
if af and af~=""then
an=ac("ImageLabel",{
Image=ab.Icon(af)[1],
ImageRectSize=ab.Icon(af)[2].ImageRectSize,
ImageRectOffset=ab.Icon(af)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ImageColor3=ah=="White"and Color3.new(0,0,0)or nil,
ImageTransparency=ah=="White"and 0.4 or 0,
ThemeTag={
ImageColor3=ah~="White"and"Icon"or nil,
},
})
end

local ao=ac("TextButton",{
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
Parent=ai,
BackgroundTransparency=1,
},{
ab.NewRoundFrame(am,"Squircle",{
ThemeTag={
ImageColor3=ah~="White"and"Button"or nil,
},
ImageColor3=ah=="White"and Color3.new(1,1,1)or nil,
Size=UDim2.new(1,0,1,0),
Name="Squircle",
ImageTransparency=ah=="Primary"and 0 or ah=="White"and 0 or 0.9,
}),

ab.NewRoundFrame(am,"Squircle",{



ImageColor3=Color3.new(1,1,1),
Size=UDim2.new(1,0,1,0),
Name="Special",
ImageTransparency=ah=="Secondary"and 0.95 or 1,
}),

ab.NewRoundFrame(am,"Shadow-sm",{



ImageColor3=Color3.new(0,0,0),
Size=UDim2.new(1,3,1,3),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Shadow",

ImageTransparency=1,
Visible=not ak,
}),

ab.NewRoundFrame(am,"SquircleGlass",{
ThemeTag={
ImageColor3="White",
},
Size=UDim2.new(1,1,1,1),

ImageTransparency=0.9,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Outline",
},{













}),

ab.NewRoundFrame(am,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ThemeTag={
ImageColor3=ah~="White"and"Text"or nil,
},
ImageColor3=ah=="White"and Color3.new(0,0,0)or nil,
ImageTransparency=1,
},{
ac("UIPadding",{
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
}),
ac("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
an,
ac("TextLabel",{
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
Text=ae or"Button",
ThemeTag={
TextColor3=(ah~="Primary"and ah~="White")and"Text",
},
TextColor3=ah=="Primary"and Color3.new(1,1,1)
or ah=="White"and Color3.new(0,0,0)
or nil,
AutomaticSize="XY",
TextSize=18,
}),
}),
})

ab.AddSignal(ao.MouseEnter,function()
ad(ao.Frame,0.047,{ImageTransparency=0.95}):Play()
end)
ab.AddSignal(ao.MouseLeave,function()
ad(ao.Frame,0.047,{ImageTransparency=1}):Play()
end)
ab.AddSignal(ao.MouseButton1Up,function()
if aj then
aj:Close()()
end
if ag then
ab.SafeCallback(ag)
end
end)

return ao
end

return aa end function a.n()

local aa={}

local ab=a.load'd'
local ac=ab.New local ad=
ab.Tween

function aa.New(ae,af,ag,ah,ai,aj,ak,al,am)
ah=ah or"Input"
local an=ak or 10
local ao
if af and af~=""then
ao=ac("ImageLabel",{
Image=ab.Icon(af)[1],
ImageRectSize=ab.Icon(af)[2].ImageRectSize,
ImageRectOffset=ab.Icon(af)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
})
end

local ap=ah~="Input"

local aq=ac("TextBox",{
BackgroundTransparency=1,
TextSize=17,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
Size=UDim2.new(1,ao and-29 or 0,1,0),
PlaceholderText=ae,
ClearTextOnFocus=al or false,
ClipsDescendants=true,
TextWrapped=ap,
MultiLine=ap,
TextXAlignment="Left",
TextYAlignment=ah=="Input"and"Center"or"Top",

ThemeTag={
PlaceholderColor3="PlaceholderText",
TextColor3="Text",
},
})

local ar=ac("Frame",{
Size=UDim2.new(1,0,0,42),
Parent=ag,
BackgroundTransparency=1,
},{
ac("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ab.NewRoundFrame(an,"Squircle",{
ThemeTag={
ImageColor3="Placeholder",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.85,
}),
not am and ab.NewRoundFrame(an,"SquircleGlass",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.75,
})or nil,
ab.NewRoundFrame(an,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=0.95,
},{
ac("UIPadding",{
PaddingTop=UDim.new(0,ah=="Input"and 0 or 12),
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
PaddingBottom=UDim.new(0,ah=="Input"and 0 or 12),
}),
ac("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment=ah=="Input"and"Center"or"Top",
HorizontalAlignment="Left",
}),
ao,
aq,
}),
}),
})










if aj then
ab.AddSignal(aq:GetPropertyChangedSignal"Text",function()
if ai then
ab.SafeCallback(ai,aq.Text)
end
end)
else
ab.AddSignal(aq.FocusLost,function()
if ai then
ab.SafeCallback(ai,aq.Text)
end
end)
end

return ar
end

return aa end function a.o()

local aa=a.load'd'
local ab=aa.New
local ac=aa.Tween




local ad={
Holder=nil,

Parent=nil,
}

function ad.Create(ae,af,ag,ah,ai)
local aj={
UICorner=28,
UIPadding=12,

Window=ag,
WindUI=ah,

UIElements={},
}

if ae then
aj.UIPadding=0
end
if ae then
aj.UICorner=26
end

af=af or"Dialog"

if not ae then
aj.UIElements.FullScreen=ab("Frame",{
ZIndex=999,
BackgroundTransparency=1,
BackgroundColor3=Color3.fromHex"#000000",
Size=UDim2.new(1,0,1,0),
Active=false,
Visible=false,
Parent=ad.Parent
or(ag and ag.UIElements and ag.UIElements.Main and ag.UIElements.Main.Main),
},{
ab("UICorner",{
CornerRadius=UDim.new(0,ag.UICorner),
}),
})
end

ab("ImageLabel",{
Image="rbxassetid://8992230677",
ThemeTag={
ImageColor3="WindowShadow",

},
ImageTransparency=1,
Size=UDim2.new(1,100,1,100),
Position=UDim2.new(0,-50,0,-50),
ScaleType="Slice",
SliceCenter=Rect.new(99,99,99,99),
BackgroundTransparency=1,
ZIndex=-999999999999999,
Name="Blur",
})

aj.UIElements.Main=ab("Frame",{
Size=UDim2.new(0,280,0,0),
ThemeTag={
BackgroundColor3=af.."Background",
},
AutomaticSize="Y",
BackgroundTransparency=1,
Visible=false,
ZIndex=99999,
},{
ab("UIPadding",{
PaddingTop=UDim.new(0,aj.UIPadding),
PaddingLeft=UDim.new(0,aj.UIPadding),
PaddingRight=UDim.new(0,aj.UIPadding),
PaddingBottom=UDim.new(0,aj.UIPadding),
}),
})

aj.UIElements.MainContainer=aa.NewRoundFrame(aj.UICorner,"Squircle",{
Visible=false,

ImageTransparency=ae and 0.15 or 0,
Parent=ai or aj.UIElements.FullScreen,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
AutomaticSize="XY",
ThemeTag={
ImageColor3=af.."Background",
ImageTransparency=af.."BackgroundTransparency",
},
ZIndex=9999,
},{






aj.UIElements.Main,




















})

function aj.Open(ak)
if not ae then
aj.UIElements.FullScreen.Visible=true
aj.UIElements.FullScreen.Active=true
end

task.spawn(function()
aj.UIElements.MainContainer.Visible=true

if not ae then
ac(aj.UIElements.FullScreen,0.1,{BackgroundTransparency=0.65}):Play()
end
ac(aj.UIElements.MainContainer,0.1,{ImageTransparency=0}):Play()


task.spawn(function()
task.wait(0.05)
aj.UIElements.Main.Visible=true
end)
end)
end
function aj.Close(ak)
if not ae then
ac(aj.UIElements.FullScreen,0.1,{BackgroundTransparency=1}):Play()
aj.UIElements.FullScreen.Active=false
task.spawn(function()
task.wait(0.1)
aj.UIElements.FullScreen.Visible=false
end)
end
aj.UIElements.Main.Visible=false

ac(aj.UIElements.MainContainer,0.1,{ImageTransparency=1}):Play()



task.spawn(function()
task.wait(0.1)
if not ae then
aj.UIElements.FullScreen:Destroy()
else
aj.UIElements.MainContainer:Destroy()
end
end)

return function()end
end


return aj
end

return ad end function a.p()

local aa={}

local ab=a.load'd'
local ac=ab.New
local ad=ab.Tween

local ae=a.load'm'.New
local af=a.load'n'.New

function aa.new(ag,ah,ai,aj)
local ak=a.load'o'
local al=ak.Create(true,"Popup",ag.Window,ag.WindUI,ag.WindUI.ScreenGui.KeySystem)

local am={}

local an

local ao=(ag.KeySystem.Thumbnail and ag.KeySystem.Thumbnail.Width)or 200

local ap=430
if ag.KeySystem.Thumbnail and ag.KeySystem.Thumbnail.Image then
ap=430+(ao/2)
end

al.UIElements.Main.AutomaticSize="Y"
al.UIElements.Main.Size=UDim2.new(0,ap,0,0)

local aq

if ag.Icon then
aq=
ab.Image(ag.Icon,ag.Title..":"..ag.Icon,0,"Temp","KeySystem",ag.IconThemed)
aq.Size=UDim2.new(0,24,0,24)
aq.LayoutOrder=-1
end

local ar=ac("TextLabel",{
AutomaticSize="XY",
BackgroundTransparency=1,
Text=ag.KeySystem.Title or ag.Title,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
TextSize=20,
})

local as=ac("TextLabel",{
AutomaticSize="XY",
BackgroundTransparency=1,
Text="Key System",
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,0,0.5,0),
TextTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
TextSize=16,
})

local at=ac("Frame",{
BackgroundTransparency=1,
AutomaticSize="XY",
},{
ac("UIListLayout",{
Padding=UDim.new(0,14),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
aq,
ar,
})

local au=ac("Frame",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
},{





at,
as,
})

local av=af("Enter Key","key",nil,"Input",function(av)
an=av
end)

local aw
if ag.KeySystem.Note and ag.KeySystem.Note~=""then
aw=ac("TextLabel",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Text=ag.KeySystem.Note,
TextSize=18,
TextTransparency=0.4,
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
RichText=true,
TextWrapped=true,
})
end

local ax=ac("Frame",{
Size=UDim2.new(1,0,0,42),
BackgroundTransparency=1,
},{
ac("Frame",{
BackgroundTransparency=1,
AutomaticSize="X",
Size=UDim2.new(0,0,1,0),
},{
ac("UIListLayout",{
Padding=UDim.new(0,9),
FillDirection="Horizontal",
}),
}),
})

local ay
if ag.KeySystem.Thumbnail and ag.KeySystem.Thumbnail.Image then
local az
if ag.KeySystem.Thumbnail.Title then
az=ac("TextLabel",{
Text=ag.KeySystem.Thumbnail.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=18,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
AutomaticSize="XY",
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
})
end
ay=ac("ImageLabel",{
Image=ag.KeySystem.Thumbnail.Image,
BackgroundTransparency=1,
Size=UDim2.new(0,ao,1,-12),
Position=UDim2.new(0,6,0,6),
Parent=al.UIElements.Main,
ScaleType="Crop",
},{
az,
ac("UICorner",{
CornerRadius=UDim.new(0,20),
}),
})
end

ac("Frame",{

Size=UDim2.new(1,ay and-ao or 0,1,0),
Position=UDim2.new(0,ay and ao or 0,0,0),
BackgroundTransparency=1,
Parent=al.UIElements.Main,
},{
ac("Frame",{

Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ac("UIListLayout",{
Padding=UDim.new(0,18),
FillDirection="Vertical",
}),
au,
aw,
av,
ax,
ac("UIPadding",{
PaddingTop=UDim.new(0,16),
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
PaddingBottom=UDim.new(0,16),
}),
}),
})





local az=ae("Exit","log-out",function()
al:Close()()
end,"Tertiary",ax.Frame)

if ay then
az.Parent=ay
az.Size=UDim2.new(0,0,0,42)
az.Position=UDim2.new(0,10,1,-10)
az.AnchorPoint=Vector2.new(0,1)
end

if ag.KeySystem.URL then
ae("Get key","key",function()
setclipboard(ag.KeySystem.URL)
end,"Secondary",ax.Frame)
end

if ag.KeySystem.API then








local aA=240
local aB=false
local b=ae("Get key","key",nil,"Secondary",ax.Frame)

local d=ab.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,1,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=0.9,
})

ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
Parent=b.Frame,
},{
d,
ac("UIPadding",{
PaddingLeft=UDim.new(0,5),
PaddingRight=UDim.new(0,5),
}),
})

local f=ab.Image("chevron-down","chevron-down",0,"Temp","KeySystem",true)

f.Size=UDim2.new(1,0,1,0)

ac("Frame",{
Size=UDim2.new(0,21,0,21),
Parent=b.Frame,
BackgroundTransparency=1,
},{
f,
})

local g=ab.NewRoundFrame(15,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ThemeTag={
ImageColor3="Background",
},
},{
ac("UIPadding",{
PaddingTop=UDim.new(0,5),
PaddingLeft=UDim.new(0,5),
PaddingRight=UDim.new(0,5),
PaddingBottom=UDim.new(0,5),
}),
ac("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,5),
}),
})

local h=ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(0,aA,0,0),
ClipsDescendants=true,
AnchorPoint=Vector2.new(1,0),
Parent=b,
Position=UDim2.new(1,0,1,15),
},{
g,
})

ac("TextLabel",{
Text="Select Service",
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag={TextColor3="Text"},
TextTransparency=0.2,
TextSize=16,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
TextWrapped=true,
TextXAlignment="Left",
Parent=g,
},{
ac("UIPadding",{
PaddingTop=UDim.new(0,10),
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingBottom=UDim.new(0,10),
}),
})

for i,l in next,ag.KeySystem.API do
local m=ag.WindUI.Services[l.Type]
if m then
local p={}
for r,u in next,m.Args do
table.insert(p,l[u])
end

local r=m.New(table.unpack(p))
r.Type=l.Type
table.insert(am,r)

local u=ab.Image(
l.Icon or m.Icon or Icons[l.Type]or"user",
l.Icon or m.Icon or Icons[l.Type]or"user",
0,
"Temp",
"KeySystem",
true
)
u.Size=UDim2.new(0,24,0,24)

local v=ab.NewRoundFrame(10,"Squircle",{
Size=UDim2.new(1,0,0,0),
ThemeTag={ImageColor3="Text"},
ImageTransparency=1,
Parent=g,
AutomaticSize="Y",
},{
ac("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,10),
VerticalAlignment="Center",
}),
u,
ac("UIPadding",{
PaddingTop=UDim.new(0,10),
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingBottom=UDim.new(0,10),
}),
ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,-34,0,0),
AutomaticSize="Y",
},{
ac("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,5),
HorizontalAlignment="Center",
}),
ac("TextLabel",{
Text=l.Title or m.Name,
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag={TextColor3="Text"},
TextTransparency=0.05,
TextSize=18,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
TextWrapped=true,
TextXAlignment="Left",
}),
ac("TextLabel",{
Text=l.Desc or"",
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
ThemeTag={TextColor3="Text"},
TextTransparency=0.2,
TextSize=16,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
TextWrapped=true,
Visible=l.Desc and true or false,
TextXAlignment="Left",
}),
}),
},true)

ab.AddSignal(v.MouseEnter,function()
ad(v,0.08,{ImageTransparency=0.95}):Play()
end)
ab.AddSignal(v.InputEnded,function()
ad(v,0.08,{ImageTransparency=1}):Play()
end)
ab.AddSignal(v.MouseButton1Click,function()
r.Copy()
ag.WindUI:Notify{
Title="Key System",
Content="Key link copied to clipboard.",
Image="key",
}
end)
end
end

ab.AddSignal(b.MouseButton1Click,function()
if not aB then
ad(
h,
0.3,
{Size=UDim2.new(0,aA,0,g.AbsoluteSize.Y+1)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
ad(f,0.3,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
else
ad(
h,
0.25,
{Size=UDim2.new(0,aA,0,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
ad(f,0.25,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
aB=not aB
end)
end

local function handleSuccess(aA)
al:Close()()
writefile((ag.Folder or"Temp").."/"..ah..".key",tostring(aA))
task.wait(0.4)
ai(true)
end

local aA=ae("Submit","arrow-right",function()
local aA=tostring(an or"empty")local aB=
ag.Folder or ag.Title

if ag.KeySystem.KeyValidator then
local b=ag.KeySystem.KeyValidator(aA)

if b then
if ag.KeySystem.SaveKey then
handleSuccess(aA)
else
al:Close()()
task.wait(0.4)
ai(true)
end
else
ag.WindUI:Notify{
Title="Key System. Error",
Content="Invalid key.",
Icon="triangle-alert",
}
end
elseif not ag.KeySystem.API then
local b=type(ag.KeySystem.Key)=="table"and table.find(ag.KeySystem.Key,aA)
or ag.KeySystem.Key==aA

if b then
if ag.KeySystem.SaveKey then
handleSuccess(aA)
else
al:Close()()
task.wait(0.4)
ai(true)
end
end
else
local b,d
for f,g in next,am do
local h,i=g.Verify(aA)
if h then
b,d=true,i
break
end
d=i
end

if b then
handleSuccess(aA)
else
ag.WindUI:Notify{
Title="Key System. Error",
Content=d,
Icon="triangle-alert",
}
end
end
end,"Primary",ax)

aA.AnchorPoint=Vector2.new(1,0.5)
aA.Position=UDim2.new(1,0,0.5,0)










al:Open()
end

return aa end function a.q()




local aa=(cloneref or clonereference or function(aa)return aa end)


local function map(ab,ac,ad,ae,af)
return(ab-ac)*(af-ae)/(ad-ac)+ae
end

local function viewportPointToWorld(ab,ac)
local ad=aa(game:GetService"Workspace").CurrentCamera:ScreenPointToRay(ab.X,ab.Y)
return ad.Origin+ad.Direction*ac
end

local function getOffset()
local ab=aa(game:GetService"Workspace").CurrentCamera.ViewportSize.Y
return map(ab,0,2560,8,56)
end

return{viewportPointToWorld,getOffset}end function a.r()



local aa=(cloneref or clonereference or function(aa)return aa end)


local ab=a.load'd'
local ac=ab.New


local ad,ae=unpack(a.load'q')
local af=Instance.new("Folder",aa(game:GetService"Workspace").CurrentCamera)


local function createAcrylic()
local ag=ac("Part",{
Name="Body",
Color=Color3.new(0,0,0),
Material=Enum.Material.Glass,
Size=Vector3.new(1,1,0),
Anchored=true,
CanCollide=false,
Locked=true,
CastShadow=false,
Transparency=0.98,
},{
ac("SpecialMesh",{
MeshType=Enum.MeshType.Brick,
Offset=Vector3.new(0,0,-1E-6),
}),
})

return ag
end


local function createAcrylicBlur(ag)
local ah={}

ag=ag or 0.001
local ai={
topLeft=Vector2.new(),
topRight=Vector2.new(),
bottomRight=Vector2.new(),
}
local aj=createAcrylic()
aj.Parent=af

local function updatePositions(ak,al)
ai.topLeft=al
ai.topRight=al+Vector2.new(ak.X,0)
ai.bottomRight=al+ak
end

local function render()
local ak=aa(game:GetService"Workspace").CurrentCamera
if ak then
ak=ak.CFrame
end
local al=ak
if not al then
al=CFrame.new()
end

local am=al
local an=ai.topLeft
local ao=ai.topRight
local ap=ai.bottomRight

local aq=ad(an,ag)
local ar=ad(ao,ag)
local as=ad(ap,ag)

local at=(ar-aq).Magnitude
local au=(ar-as).Magnitude

aj.CFrame=
CFrame.fromMatrix((aq+as)/2,am.XVector,am.YVector,am.ZVector)
aj.Mesh.Scale=Vector3.new(at,au,0)
end

local function onChange(ak)
local al=ae()
local am=ak.AbsoluteSize-Vector2.new(al,al)
local an=ak.AbsolutePosition+Vector2.new(al/2,al/2)

updatePositions(am,an)
task.spawn(render)
end

local function renderOnChange()
local ak=aa(game:GetService"Workspace").CurrentCamera
if not ak then
return
end

table.insert(ah,ak:GetPropertyChangedSignal"CFrame":Connect(render))
table.insert(ah,ak:GetPropertyChangedSignal"ViewportSize":Connect(render))
table.insert(ah,ak:GetPropertyChangedSignal"FieldOfView":Connect(render))
task.spawn(render)
end

aj.Destroying:Connect(function()
for ak,al in ah do
pcall(function()
al:Disconnect()
end)
end
end)

renderOnChange()

return onChange,aj
end

return function(ag)
local ah={}
local ai,aj=createAcrylicBlur(ag)

local ak=ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
})

ab.AddSignal(ak:GetPropertyChangedSignal"AbsolutePosition",function()
ai(ak)
end)

ab.AddSignal(ak:GetPropertyChangedSignal"AbsoluteSize",function()
ai(ak)
end)

ah.AddParent=function(al)
ab.AddSignal(al:GetPropertyChangedSignal"Visible",function()

end)
end

ah.SetVisibility=function(al)
aj.Transparency=al and 0.98 or 1
end

ah.Frame=ak
ah.Model=aj

return ah
end end function a.s()


local aa=a.load'd'
local ab=a.load'r'

local ac=aa.New

return function(ad)
local ae={}

ae.Frame=ac("Frame",{
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
BackgroundColor3=Color3.fromRGB(255,255,255),
BorderSizePixel=0,
},{












ac("UICorner",{
CornerRadius=UDim.new(0,8),
}),

ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Name="Background",
ThemeTag={
BackgroundColor3="AcrylicMain",
},
},{
ac("UICorner",{
CornerRadius=UDim.new(0,8),
}),
}),

ac("Frame",{
BackgroundColor3=Color3.fromRGB(255,255,255),
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
},{










}),

ac("ImageLabel",{
Image="rbxassetid://9968344105",
ImageTransparency=0.98,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.new(0,128,0,128),
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
},{
ac("UICorner",{
CornerRadius=UDim.new(0,8),
}),
}),

ac("ImageLabel",{
Image="rbxassetid://9968344227",
ImageTransparency=0.9,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.new(0,128,0,128),
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
ThemeTag={
ImageTransparency="AcrylicNoise",
},
},{
ac("UICorner",{
CornerRadius=UDim.new(0,8),
}),
}),

ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
ZIndex=2,
},{










}),
})


local af

task.wait()
if ad.UseAcrylic then
af=ab()

af.Frame.Parent=ae.Frame
ae.Model=af.Model
ae.AddParent=af.AddParent
ae.SetVisibility=af.SetVisibility
end

return ae,af
end end function a.t()



local aa=(cloneref or clonereference or function(aa)return aa end)


local ab={
AcrylicBlur=a.load'r',

AcrylicPaint=a.load's',
}

function ab.init()
local ac=Instance.new"DepthOfFieldEffect"
ac.FarIntensity=0
ac.InFocusRadius=0.1
ac.NearIntensity=1

local ad={}

function ab.Enable()
for ae,af in pairs(ad)do
af.Enabled=false
end
ac.Parent=aa(game:GetService"Lighting")
end

function ab.Disable()
for ae,af in pairs(ad)do
af.Enabled=af.enabled
end
ac.Parent=nil
end

local function registerDefaults()
local function register(ae)
if ae:IsA"DepthOfFieldEffect"then
ad[ae]={enabled=ae.Enabled}
end
end

for ae,af in pairs(aa(game:GetService"Lighting"):GetChildren())do
register(af)
end

if aa(game:GetService"Workspace").CurrentCamera then
for ae,af in pairs(aa(game:GetService"Workspace").CurrentCamera:GetChildren())do
register(af)
end
end
end

registerDefaults()
ab.Enable()
end

return ab end function a.u()

local aa={}

local ab=a.load'd'
local ac=ab.New local ad=
ab.Tween


function aa.new(ae,af)
local ag={
Title=ae.Title or"Dialog",
Content=ae.Content,
Icon=ae.Icon,
IconThemed=ae.IconThemed,
Thumbnail=ae.Thumbnail,
Buttons=ae.Buttons,

IconSize=22,
}

local ah=a.load'o'
local ai=ah.Create(true,"Popup",ae.WindUI.Window,ae.WindUI,af)

local aj=200

local ak=430
if ag.Thumbnail and ag.Thumbnail.Image then
ak=430+(aj/2)
end

ai.UIElements.Main.AutomaticSize="Y"
ai.UIElements.Main.Size=UDim2.new(0,ak,0,0)



local al

if ag.Icon then
al=ab.Image(
ag.Icon,
ag.Title..":"..ag.Icon,
0,
ae.WindUI.Window,
"Popup",
true,
ae.IconThemed,
"PopupIcon"
)
al.Size=UDim2.new(0,ag.IconSize,0,ag.IconSize)
al.LayoutOrder=-1
end


local am=ac("TextLabel",{
AutomaticSize="Y",
BackgroundTransparency=1,
Text=ag.Title,
TextXAlignment="Left",
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="PopupTitle",
},
TextSize=20,
TextWrapped=true,
Size=UDim2.new(1,al and-ag.IconSize-14 or 0,0,0)
})

local an=ac("Frame",{
BackgroundTransparency=1,
AutomaticSize="XY",
},{
ac("UIListLayout",{
Padding=UDim.new(0,14),
FillDirection="Horizontal",
VerticalAlignment="Center"
}),
al,am
})

local ao=ac("Frame",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
},{





an,
})

local ap
if ag.Content and ag.Content~=""then
ap=ac("TextLabel",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Text=ag.Content,
TextSize=18,
TextTransparency=.2,
ThemeTag={
TextColor3="PopupContent",
},
BackgroundTransparency=1,
RichText=true,
TextWrapped=true,
})
end

local aq=ac("Frame",{
Size=UDim2.new(1,0,0,42),
BackgroundTransparency=1,
},{
ac("UIListLayout",{
Padding=UDim.new(0,9),
FillDirection="Horizontal",
HorizontalAlignment="Right"
})
})

local ar
if ag.Thumbnail and ag.Thumbnail.Image then
local as
if ag.Thumbnail.Title then
as=ac("TextLabel",{
Text=ag.Thumbnail.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=18,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
AutomaticSize="XY",
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
})
end
ar=ac("ImageLabel",{
Image=ag.Thumbnail.Image,
BackgroundTransparency=1,
Size=UDim2.new(0,aj,1,0),
Parent=ai.UIElements.Main,
ScaleType="Crop"
},{
as,
ac("UICorner",{
CornerRadius=UDim.new(0,0),
})
})
end

ac("Frame",{

Size=UDim2.new(1,ar and-aj or 0,1,0),
Position=UDim2.new(0,ar and aj or 0,0,0),
BackgroundTransparency=1,
Parent=ai.UIElements.Main
},{
ac("Frame",{

Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ac("UIListLayout",{
Padding=UDim.new(0,18),
FillDirection="Vertical",
}),
ao,
ap,
aq,
ac("UIPadding",{
PaddingTop=UDim.new(0,16),
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
PaddingBottom=UDim.new(0,16),
})
}),
})

local as=a.load'm'.New

for at,au in next,ag.Buttons do
as(au.Title,au.Icon,au.Callback,au.Variant,aq,ai)
end

ai:Open()


return ag
end

return aa end function a.v()
return function(aa,ab)
return{
Dark={
Name="Dark",

Accent=Color3.fromHex"#18181b",
Dialog=Color3.fromHex"#1a1a1a",
Outline=Color3.fromHex"#FFFFFF",
Text=Color3.fromHex"#FFFFFF",
Placeholder=Color3.fromHex"#a1a1a1",
Background=Color3.fromHex"#101010",
Button=Color3.fromHex"#52525b",
Icon=Color3.fromHex"#a1a1aa",
Toggle=Color3.fromHex"#33C759",
Slider=Color3.fromHex"#0091FF",
Checkbox=Color3.fromHex"#0091FF",

PanelBackground=Color3.fromHex"#FFFFFF",
PanelBackgroundTransparency=0.95,

SliderIcon=Color3.fromHex"#908F95",
Primary=Color3.fromHex"#0091FF",


LabelBackground=Color3.fromHex"#000000",
LabelBackgroundTransparency=0.83,

ElementBackground=Color3.fromHex"#2A2A2C",
ElementBackgroundTransparency=0,
},

Light={
Name="Light",

Accent=Color3.fromHex"#efefef",
Dialog=Color3.fromHex"#f4f4f5",
Outline=Color3.fromHex"#ffffff",
Text=Color3.fromHex"#000000",
Placeholder=Color3.fromHex"#555555",
Background=Color3.fromHex"#FFFFFF",
Button=Color3.fromHex"#18181b",
Icon=Color3.fromHex"#52525b",
Toggle=Color3.fromHex"#33C759",
Slider=Color3.fromHex"#0091FF",
Checkbox=Color3.fromHex"#0091FF",

DropdownTabBackground=Color3.fromHex"#bebebe",
DropdownBackground=Color3.fromHex"#ffffff",

TabBackground=Color3.fromHex"#ffffff",
TabBackgroundHover=Color3.fromHex"#f3f3f3",
TabBackgroundHoverTransparency=0,
TabBackgroundActive=Color3.fromHex"#efefef",
TabBackgroundActiveTransparency=0,

PanelBackground=Color3.fromHex"#efefef",
PanelBackgroundTransparency=0,

LabelBackground=Color3.fromHex"#efefef",
LabelBackgroundTransparency=0,

ElementBackground=Color3.fromHex"#ffffff",
ElementBackgroundTransparency=0,
},

Rose={
Name="Rose",

Accent=Color3.fromHex"#be185d",
Dialog=Color3.fromHex"#4c0519",

Text=Color3.fromHex"#fdf2f8",
Placeholder=Color3.fromHex"#d67aa6",
Background=Color3.fromHex"#1f0308",
Button=Color3.fromHex"#e95f74",
Icon=Color3.fromHex"#fb7185",

ElementBackground=Color3.fromHex"#381E23",
ElementBackgroundTransparency=0,
},

Plant={
Name="Plant",

Accent=Color3.fromHex"#166534",
Dialog=Color3.fromHex"#052e16",

Text=Color3.fromHex"#f0fdf4",
Placeholder=Color3.fromHex"#4fbf7a",
Background=Color3.fromHex"#0a1b0f",
Button=Color3.fromHex"#16a34a",
Icon=Color3.fromHex"#4ade80",

ElementBackground=Color3.fromHex"#28342A",
ElementBackgroundTransparency=0,
},

Red={
Name="Red",

Accent=Color3.fromHex"#991b1b",
Dialog=Color3.fromHex"#450a0a",

Text=Color3.fromHex"#fef2f2",
Placeholder=Color3.fromHex"#d95353",
Background=Color3.fromHex"#1c0606",
Button=Color3.fromHex"#dc2626",
Icon=Color3.fromHex"#ef4444",

ElementBackground=Color3.fromHex"#322221",
ElementBackgroundTransparency=0,
},

Indigo={
Name="Indigo",

Accent=Color3.fromHex"#3730a3",
Dialog=Color3.fromHex"#1e1b4b",

Text=Color3.fromHex"#f1f5f9",
Placeholder=Color3.fromHex"#7078d9",
Background=Color3.fromHex"#0f0a2e",
Button=Color3.fromHex"#4f46e5",
Icon=Color3.fromHex"#6366f1",

ElementBackground=Color3.fromHex"#282543",
ElementBackgroundTransparency=0,
},

Sky={
Name="Sky",

Accent=Color3.fromHex"#00d4ff",
Dialog=Color3.fromHex"#0a4d66",

Text=Color3.fromHex"#e6f7ff",
Placeholder=Color3.fromHex"#66b3cc",
Background=Color3.fromHex"#051a26",
Button=Color3.fromHex"#00a8cc",
Icon=Color3.fromHex"#2db8d9",

Toggle=Color3.fromHex"#00d9d9",
Slider=Color3.fromHex"#00d4ff",
Checkbox=Color3.fromHex"#00d4ff",

PanelBackground=Color3.fromHex"#0d3a47",
PanelBackgroundTransparency=0.8,

ElementBackground=Color3.fromHex"#172E3B",
ElementBackgroundTransparency=0,
},

Violet={
Name="Violet",

Accent=Color3.fromHex"#6d28d9",
Dialog=Color3.fromHex"#3c1361",

Text=Color3.fromHex"#faf5ff",
Placeholder=Color3.fromHex"#8f7ee0",
Background=Color3.fromHex"#1e0a3e",
Button=Color3.fromHex"#7c3aed",
Icon=Color3.fromHex"#8b5cf6",

ElementBackground=Color3.fromHex"#342650",
ElementBackgroundTransparency=0,
},

Amber={
Name="Amber",

Accent=aa:Gradient({
["0"]={Color=Color3.fromHex"#b45309",Transparency=0},
["100"]={Color=Color3.fromHex"#d97706",Transparency=0},
},{Rotation=45}),

Dialog=aa:Gradient({
["0"]={Color=Color3.fromHex"#451a03",Transparency=0},
["100"]={Color=Color3.fromHex"#6b2e05",Transparency=0},
},{Rotation=90}),






Text=aa:Gradient({
["0"]={Color=Color3.fromHex"#fffbeb",Transparency=0},
["100"]={Color=Color3.fromHex"#fff7ed",Transparency=0},
},{Rotation=45}),

Placeholder=aa:Gradient({
["0"]={Color=Color3.fromHex"#d1a326",Transparency=0},
["100"]={Color=Color3.fromHex"#fbbf24",Transparency=0},
},{Rotation=45}),

Background=aa:Gradient({
["0"]={Color=Color3.fromHex"#1c1003",Transparency=0},
["100"]={Color=Color3.fromHex"#3f210d",Transparency=0},
},{Rotation=90}),

Button=aa:Gradient({
["0"]={Color=Color3.fromHex"#d97706",Transparency=0},
["100"]={Color=Color3.fromHex"#f59e0b",Transparency=0},
},{Rotation=45}),

Icon=Color3.fromHex"#f59e0b",

Toggle=aa:Gradient({
["0"]={Color=Color3.fromHex"#d97706",Transparency=0},
["100"]={Color=Color3.fromHex"#f59e0b",Transparency=0},
},{Rotation=45}),

Slider=Color3.fromHex"#d97706",

Checkbox=aa:Gradient({
["0"]={Color=Color3.fromHex"#d97706",Transparency=0},
["100"]={Color=Color3.fromHex"#fbbf24",Transparency=0},
},{Rotation=45}),

PanelBackground=Color3.fromHex"#FFFFFF",
PanelBackgroundTransparency=0.95,

ElementBackground=Color3.fromHex"#3A2E22",
ElementBackgroundTransparency=0,
},

Emerald={
Name="Emerald",

Accent=Color3.fromHex"#047857",
Dialog=Color3.fromHex"#022c22",

Text=Color3.fromHex"#ecfdf5",
Placeholder=Color3.fromHex"#3fbf8f",
Background=Color3.fromHex"#011411",
Button=Color3.fromHex"#059669",
Icon=Color3.fromHex"#10b981",

ElementBackground=Color3.fromHex"#202E2A",
ElementBackgroundTransparency=0,
},

Midnight={
Name="Midnight",

Accent=Color3.fromHex"#1e3a8a",
Dialog=Color3.fromHex"#0c1e42",

Text=Color3.fromHex"#dbeafe",
Placeholder=Color3.fromHex"#2f74d1",
Background=Color3.fromHex"#0a0f1e",
Button=Color3.fromHex"#2563eb",
Primary=Color3.fromHex"#2563eb",
Icon=Color3.fromHex"#5591f4",

ElementBackground=Color3.fromHex"#242836",
ElementBackgroundTransparency=0,
},

Crimson={
Name="Crimson",

Accent=Color3.fromHex"#b91c1c",
Dialog=Color3.fromHex"#450a0a",

Text=Color3.fromHex"#fef2f2",
Placeholder=Color3.fromHex"#6f757b",
Background=Color3.fromHex"#0c0404",
Button=Color3.fromHex"#991b1b",
Icon=Color3.fromHex"#dc2626",

ElementBackground=Color3.fromHex"#251F1F",
ElementBackgroundTransparency=0,
},

MonokaiPro={
Name="Monokai Pro",

Accent=Color3.fromHex"#fc9867",
Dialog=Color3.fromHex"#1e1e1e",

Text=Color3.fromHex"#fcfcfa",
Placeholder=Color3.fromHex"#afafaf",
Background=Color3.fromHex"#191622",
Button=Color3.fromHex"#ab9df2",
Icon=Color3.fromHex"#a9dc76",

ElementBackground=Color3.fromHex"#323039",
ElementBackgroundTransparency=0,

Metadata={
PullRequest=23,
},
},

CottonCandy={
Name="Cotton Candy",

Accent=Color3.fromHex"#ec4899",
Dialog=Color3.fromHex"#2d1b3d",

Text=Color3.fromHex"#fdf2f8",
Placeholder=Color3.fromHex"#8a5fd3",
Background=Color3.fromHex"#1a0b2e",
Button=Color3.fromHex"#d946ef",
Slider=Color3.fromHex"#d946ef",
Icon=Color3.fromHex"#06b6d4",

ElementBackground=Color3.fromHex"#312643",
ElementBackgroundTransparency=0,
},

Mellowsi={
Name="Mellowsi",

Accent=Color3.fromHex"#342A1E",
Dialog=Color3.fromHex"#291C13",

Text=Color3.fromHex"#F5EBDD",
Placeholder=Color3.fromHex"#9C8A73",
Background=Color3.fromHex"#1C1002",
Button=Color3.fromHex"#342A1E",
Icon=Color3.fromHex"#C9B79C",

Toggle=Color3.fromHex"#a9873f",
Slider=Color3.fromHex"#C9A24D",
Checkbox=Color3.fromHex"#C9A24D",

ElementBackground=Color3.fromHex"#33291E",
ElementBackgroundTransparency=0,

Metadata={
PullRequest=52,
},
},

Rainbow={
Name="Rainbow",

Accent=aa:Gradient({
["0"]={Color=Color3.fromHex"#00ff41",Transparency=0},
["33"]={Color=Color3.fromHex"#00ffff",Transparency=0},
["66"]={Color=Color3.fromHex"#0080ff",Transparency=0},
["100"]={Color=Color3.fromHex"#8000ff",Transparency=0},
},{Rotation=45}),

Dialog=aa:Gradient({
["0"]={Color=Color3.fromHex"#ff0080",Transparency=0},
["25"]={Color=Color3.fromHex"#8000ff",Transparency=0},
["50"]={Color=Color3.fromHex"#0080ff",Transparency=0},
["75"]={Color=Color3.fromHex"#00ff80",Transparency=0},
["100"]={Color=Color3.fromHex"#ff8000",Transparency=0},
},{Rotation=135}),


Text=Color3.fromHex"#ffffff",
Placeholder=Color3.fromHex"#00ff80",

Background=aa:Gradient({
["0"]={Color=Color3.fromHex"#ff0040",Transparency=0},
["20"]={Color=Color3.fromHex"#ff4000",Transparency=0},
["40"]={Color=Color3.fromHex"#ffff00",Transparency=0},
["60"]={Color=Color3.fromHex"#00ff40",Transparency=0},
["80"]={Color=Color3.fromHex"#0040ff",Transparency=0},
["100"]={Color=Color3.fromHex"#4000ff",Transparency=0},
},{Rotation=90}),

Button=aa:Gradient({
["0"]={Color=Color3.fromHex"#ff0080",Transparency=0},
["25"]={Color=Color3.fromHex"#ff8000",Transparency=0},
["50"]={Color=Color3.fromHex"#ffff00",Transparency=0},
["75"]={Color=Color3.fromHex"#80ff00",Transparency=0},
["100"]={Color=Color3.fromHex"#00ffff",Transparency=0},
},{Rotation=60}),

Icon=Color3.fromHex"#ffffff",
},
}
end end function a.w()

local aa={}

local ab=a.load'd'
local ac=ab.New local ad=
ab.Tween

function aa.New(ae,af,ag,ah,ai,aj)
local ak=ai or 10
local al
if af and af~=""then
al=ac("ImageLabel",{
Image=ab.Icon(af)[1],
ImageRectSize=ab.Icon(af)[2].ImageRectSize,
ImageRectOffset=ab.Icon(af)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
})
end

local am=ac("TextLabel",{
BackgroundTransparency=1,
TextSize=17,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
Size=UDim2.new(1,al and-29 or 0,1,0),
TextXAlignment="Left",
ThemeTag={
TextColor3=ah and"Placeholder"or"Text",
},
Text=ae,
})

local an=ac("TextButton",{
Size=UDim2.new(1,0,0,42),
Parent=ag,
BackgroundTransparency=1,
Text="",
},{
ac("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ab.NewRoundFrame(ak,"Squircle",{
ThemeTag={
ImageColor3="Placeholder",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.85,
}),
not aj and ab.NewRoundFrame(ak,"SquircleGlass",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,1,1,1),
ImageTransparency=0.9,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
})or nil,
ab.NewRoundFrame(ak,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ThemeTag={
ImageColor3="LabelBackground",
ImageTransparency="LabelBackgroundTransparency",
},


},{
ac("UIPadding",{
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
}),
ac("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
al,
am,
}),
}),
})

return an
end

return aa end function a.x()

local aa={}

local ab=(cloneref or clonereference or function(ab)return ab end)


local ac=ab(game:GetService"UserInputService")

local ad=a.load'd'
local ae=ad.New local af=
ad.Tween


function aa.New(ag,ah,ai,aj)
local ak=ae("Frame",{
Size=UDim2.new(0,aj,1,0),
BackgroundTransparency=1,
Position=UDim2.new(1,0,0,0),
AnchorPoint=Vector2.new(1,0),
Parent=ah,
ZIndex=999,
Active=true,
})

local al=ad.NewRoundFrame(aj/2,"Squircle",{
Size=UDim2.new(1,0,0,0),
ImageTransparency=0.85,
ThemeTag={ImageColor3="Text"},
Parent=ak,
})

local am=ae("Frame",{
Size=UDim2.new(1,12,1,12),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Active=true,
ZIndex=999,
Parent=al,
})

local an=false
local ao=0

local function updateSliderSize()
local ap=ag
local aq=ap.AbsoluteCanvasSize.Y
local ar=ap.AbsoluteWindowSize.Y

if aq<=ar then
al.Visible=false
return
end

local as=math.clamp(ar/aq,0.1,1)
al.Size=UDim2.new(1,0,as,0)
al.Visible=true
end

local function updateScrollingFramePosition()
local ap=al.Position.Y.Scale
local aq=ag.AbsoluteCanvasSize.Y
local ar=ag.AbsoluteWindowSize.Y
local as=math.max(aq-ar,0)

if as<=0 then return end

local at=math.max(1-al.Size.Y.Scale,0)
if at<=0 then return end

local au=ap/at

ag.CanvasPosition=Vector2.new(
ag.CanvasPosition.X,
au*as
)
end

local function updateThumbPosition()
if an then return end

local ap=ag.CanvasPosition.Y
local aq=ag.AbsoluteCanvasSize.Y
local ar=ag.AbsoluteWindowSize.Y
local as=math.max(aq-ar,0)

if as<=0 then
al.Position=UDim2.new(0,0,0,0)
return
end

local at=ap/as
local au=math.max(1-al.Size.Y.Scale,0)
local av=math.clamp(at*au,0,au)

al.Position=UDim2.new(0,0,av,0)
end

ad.AddSignal(ak.InputBegan,function(ap)
if(ap.UserInputType==Enum.UserInputType.MouseButton1 or ap.UserInputType==Enum.UserInputType.Touch)then
local aq=al.AbsolutePosition.Y
local ar=aq+al.AbsoluteSize.Y

if not(ap.Position.Y>=aq and ap.Position.Y<=ar)then
local as=ak.AbsolutePosition.Y
local at=ak.AbsoluteSize.Y
local au=al.AbsoluteSize.Y

local av=ap.Position.Y-as-au/2
local aw=at-au

local ax=math.clamp(av/aw,0,1-al.Size.Y.Scale)

al.Position=UDim2.new(0,0,ax,0)
updateScrollingFramePosition()
end
end
end)

ad.AddSignal(am.InputBegan,function(ap)
if ap.UserInputType==Enum.UserInputType.MouseButton1 or ap.UserInputType==Enum.UserInputType.Touch then
an=true
ao=ap.Position.Y-al.AbsolutePosition.Y

local aq
local ar

aq=ac.InputChanged:Connect(function(as)
if as.UserInputType==Enum.UserInputType.MouseMovement or as.UserInputType==Enum.UserInputType.Touch then
local at=ak.AbsolutePosition.Y
local au=ak.AbsoluteSize.Y
local av=al.AbsoluteSize.Y

local aw=as.Position.Y-at-ao
local ax=au-av

local ay=math.clamp(aw/ax,0,1-al.Size.Y.Scale)

al.Position=UDim2.new(0,0,ay,0)
updateScrollingFramePosition()
end
end)

ar=ac.InputEnded:Connect(function(as)
if as.UserInputType==Enum.UserInputType.MouseButton1 or as.UserInputType==Enum.UserInputType.Touch then
an=false
if aq then aq:Disconnect()end
if ar then ar:Disconnect()end
end
end)
end
end)

ad.AddSignal(ag:GetPropertyChangedSignal"AbsoluteWindowSize",function()
updateSliderSize()
updateThumbPosition()
end)

ad.AddSignal(ag:GetPropertyChangedSignal"AbsoluteCanvasSize",function()
updateSliderSize()
updateThumbPosition()
end)

ad.AddSignal(ag:GetPropertyChangedSignal"CanvasPosition",function()
if not an then
updateThumbPosition()
end
end)

updateSliderSize()
updateThumbPosition()

return ak
end


return aa end function a.y()
local aa={}

local ab=a.load'd'
local ac=ab.New
local ad=ab.Tween

function aa.New(ae,af,ag)
local ah={
Title=af.Title or"Tag",
Icon=af.Icon,
Color=af.Color or Color3.fromHex"#315dff",
Radius=af.Radius or 999,
Border=af.Border or false,

TagFrame=nil,
Height=26,
Padding=10,
TextSize=14,
IconSize=16,
}

local ai
if ah.Icon then
ai=ab.Image(ah.Icon,ah.Icon,0,af.Window,"Tag",false)

ai.Size=UDim2.new(0,ah.IconSize,0,ah.IconSize)
ai.ImageLabel.ImageColor3=typeof(ah.Color)=="Color3"
and ab.GetTextColorForHSB(ah.Color)
or typeof(ah.Color)=="string"
and(ab.GetTextColorForHSB(ab.GetThemeProperty(ah.Color,ab.Theme)))
end

local aj=ac("TextLabel",{
BackgroundTransparency=1,
AutomaticSize="XY",
TextSize=ah.TextSize,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
Text=ah.Title,
TextColor3=typeof(ah.Color)=="Color3"and ab.GetTextColorForHSB(ah.Color)or typeof(
ah.Color
)=="string"and(ab.GetTextColorForHSB(ab.GetThemeProperty(ah.Color,ab.Theme))),
})

local ak

if typeof(ah.Color)=="table"then
ak=ac"UIGradient"
for al,am in next,ah.Color do
ak[al]=am
end

aj.TextColor3=ab.GetTextColorForHSB(ab.GetAverageColor(ak))
if ai then
ai.ImageLabel.ImageColor3=ab.GetTextColorForHSB(ab.GetAverageColor(ak))
end
end

local al=ab.NewRoundFrame(ah.Radius,"Squircle",{
AutomaticSize="X",
Size=UDim2.new(0,0,0,ah.Height),
Parent=ag,
ImageColor3=typeof(ah.Color)=="Color3"and ah.Color
or typeof(ah.Color)=="table"and Color3.new(1,1,1)
or nil,
ThemeTag=typeof(ah.Color)=="string"and{
ImageColor3=ah.Color,
},
},{
ak,
ab.NewRoundFrame(ah.Radius+1,"SquircleGlass",{
Size=UDim2.new(1,1,1,1),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ThemeTag={
ImageColor3="White",
},
ImageTransparency=0.75,
}),
ac("Frame",{
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
Name="Content",
BackgroundTransparency=1,
},{
ai,
aj,
ac("UIPadding",{
PaddingLeft=UDim.new(0,ah.Padding),
PaddingRight=UDim.new(0,ah.Padding),
}),
ac("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
Padding=UDim.new(0,ah.Padding/1.5),
}),
}),
})

function ah.SetTitle(am,an)
ah.Title=an
aj.Text=an

return ah
end

function ah.SetColor(am,an)
ah.Color=an
if typeof(an)=="table"then
local ao=ab.GetAverageColor(an)
ad(aj,0.06,{TextColor3=ab.GetTextColorForHSB(ao)}):Play()
local ap=al:FindFirstChildOfClass"UIGradient"or ac("UIGradient",{Parent=al})
for aq,ar in next,an do
ap[aq]=ar
end
ad(al,0.06,{ImageColor3=Color3.new(1,1,1)}):Play()
else
if ak then
ak:Destroy()
end
ad(aj,0.06,{TextColor3=ab.GetTextColorForHSB(an)}):Play()
if ai then
ad(ai.ImageLabel,0.06,{ImageColor3=ab.GetTextColorForHSB(an)}):Play()
end
ad(al,0.06,{ImageColor3=an}):Play()
end

return ah
end

function ah.SetIcon(am,an)
ah.Icon=an

if an then
ai=ab.Image(an,an,0,af.Window,"Tag",false)

ai.Size=UDim2.new(0,ah.IconSize,0,ah.IconSize)
ai.Parent=al

if typeof(ah.Color)=="Color3"then
ai.ImageLabel.ImageColor3=ab.GetTextColorForHSB(ah.Color)
elseif typeof(ah.Color)=="table"then
ai.ImageLabel.ImageColor3=ab.GetTextColorForHSB(ab.GetAverageColor(ak))
end
else
if ai then
ai:Destroy()
ai=nil
end
end
return ah
end

function ah.Destroy(am)
al:Destroy()
return ah
end

ab:OnThemeChange(function(am,an)
aj.TextColor3=ab.GetTextColorForHSB(ab.GetThemeProperty(ah.Color,ab.Theme))
ai.ImageLabel.ImageColor3=
ab.GetTextColorForHSB(ab.GetThemeProperty(ah.Color,ab.Theme))
end)

return ah
end

return aa end function a.z()

local aa=(cloneref or clonereference or function(aa)return aa end)


local ab=aa(game:GetService"RunService")
local ac=aa(game:GetService"HttpService")

local ad

local ae
ae={
Folder=nil,
Path=nil,
Configs={},
Parser={
Colorpicker={
Save=function(af)
return{
__type=af.__type,
value=af.Default:ToHex(),
transparency=af.Transparency or nil,
}
end,
Load=function(af,ag)
if af and af.Update then
af:Update(Color3.fromHex(ag.value),ag.transparency or nil)
end
end
},
Dropdown={
Save=function(af)
return{
__type=af.__type,
value=af.Value,
}
end,
Load=function(af,ag)
if af and af.Select then
af:Select(ag.value)
end
end
},
Input={
Save=function(af)
return{
__type=af.__type,
value=af.Value,
}
end,
Load=function(af,ag)
if af and af.Set then
af:Set(ag.value)
end
end
},
Keybind={
Save=function(af)
return{
__type=af.__type,
value=af.Value,
}
end,
Load=function(af,ag)
if af and af.Set then
af:Set(ag.value)
end
end
},
Slider={
Save=function(af)
return{
__type=af.__type,
value=af.Value.Default,
}
end,
Load=function(af,ag)
if af and af.Set then
af:Set(tonumber(ag.value))
end
end
},
Toggle={
Save=function(af)
return{
__type=af.__type,
value=af.Value,
}
end,
Load=function(af,ag)
if af and af.Set then
af:Set(ag.value)
end
end
},
}
}

function ae.Init(af,ag)
if not ag.Folder then
warn"[ WindUI.ConfigManager ] Window.Folder is not specified."
return false
end
if ab:IsStudio()or not writefile then
warn"[ WindUI.ConfigManager ] The config system doesn't work in the studio."
return false
end

ad=ag
ae.Folder=ad.Folder
ae.Path="WindUI/"..tostring(ae.Folder).."/config/"

if not isfolder(ae.Path)then
makefolder(ae.Path)
end

local ah=ae:AllConfigs()

for ai,aj in next,ah do
if isfile and readfile and isfile(aj..".json")then
ae.Configs[aj]=readfile(aj..".json")
end
end

return ae
end

function ae.SetPath(af,ag)
if not ag then
warn"[ WindUI.ConfigManager ] Custom path is not specified."
return false
end

ae.Path=ag
if not ag:match"/$"then
ae.Path=ag.."/"
end

if not isfolder(ae.Path)then
makefolder(ae.Path)
end

return true
end

function ae.CreateConfig(af,ag,ah)
local ai={
Path=ae.Path..ag..".json",
Elements={},
CustomData={},
AutoLoad=ah or false,
Version=1.2,
}

if not ag then
return false,"No config file is selected"
end

function ai.SetAsCurrent(aj)
ad:SetCurrentConfig(ai)
end

function ai.Register(aj,ak,al)
ai.Elements[ak]=al
end

function ai.Set(aj,ak,al)
ai.CustomData[ak]=al
end

function ai.Get(aj,ak)
return ai.CustomData[ak]
end

function ai.SetAutoLoad(aj,ak)
ai.AutoLoad=ak
end

function ai.Save(aj)
if ad.PendingFlags then
for ak,al in next,ad.PendingFlags do
ai:Register(ak,al)
end
end

local ak={
__version=ai.Version,
__elements={},
__autoload=ai.AutoLoad,
__custom=ai.CustomData
}

for al,am in next,ai.Elements do
if ae.Parser[am.__type]then
ak.__elements[tostring(al)]=ae.Parser[am.__type].Save(am)
end
end

local al=ac:JSONEncode(ak)
if writefile then
writefile(ai.Path,al)
end

return ak
end

function ai.Load(aj)
if isfile and not isfile(ai.Path)then
return false,"Config file does not exist"
end

local ak,al=pcall(function()
local ak=readfile or function()
warn"[ WindUI.ConfigManager ] The config system doesn't work in the studio."
return nil
end
return ac:JSONDecode(ak(ai.Path))
end)

if not ak then
return false,"Failed to parse config file"
end

if not al.__version then
local am={
__version=ai.Version,
__elements=al,
__custom={}
}
al=am
end

if ad.PendingFlags then
for am,an in next,ad.PendingFlags do
ai:Register(am,an)
end
end

for am,an in next,(al.__elements or{})do
if ai.Elements[am]and ae.Parser[an.__type]then
task.spawn(function()
ae.Parser[an.__type].Load(ai.Elements[am],an)
end)
end
end

ai.CustomData=al.__custom or{}

return ai.CustomData
end

function ai.Delete(aj)
if not delfile then
return false,"delfile function is not available"
end

if not isfile(ai.Path)then
return false,"Config file does not exist"
end

local ak,al=pcall(function()
delfile(ai.Path)
end)

if not ak then
return false,"Failed to delete config file: "..tostring(al)
end

ae.Configs[ag]=nil

if ad.CurrentConfig==ai then
ad.CurrentConfig=nil
end

return true,"Config deleted successfully"
end

function ai.GetData(aj)
return{
elements=ai.Elements,
custom=ai.CustomData,
autoload=ai.AutoLoad
}
end


if isfile(ai.Path)then
local aj,ak=pcall(function()
return ac:JSONDecode(readfile(ai.Path))
end)

if aj and ak and ak.__autoload then
ai.AutoLoad=true

task.spawn(function()
task.wait(0.5)
local al,am=pcall(function()
return ai:Load()
end)
if al then
if ad.Debug then print("[ WindUI.ConfigManager ] AutoLoaded config: "..ag)end
else
warn("[ WindUI.ConfigManager ] Failed to AutoLoad config: "..ag.." - "..tostring(am))
end
end)
end
end


ai:SetAsCurrent()
ae.Configs[ag]=ai
return ai
end

function ae.Config(af,ag,ah)
return ae:CreateConfig(ag,ah)
end

function ae.GetAutoLoadConfigs(af)
local ag={}

for ah,ai in pairs(ae.Configs)do
if ai.AutoLoad then
table.insert(ag,ah)
end
end

return ag
end

function ae.DeleteConfig(af,ag)
if not delfile then
return false,"delfile function is not available"
end

local ah=ae.Path..ag..".json"

if not isfile(ah)then
return false,"Config file does not exist"
end

local ai,aj=pcall(function()
delfile(ah)
end)

if not ai then
return false,"Failed to delete config file: "..tostring(aj)
end

ae.Configs[ag]=nil

if ad.CurrentConfig and ad.CurrentConfig.Path==ah then
ad.CurrentConfig=nil
end

return true,"Config deleted successfully"
end

function ae.AllConfigs(af)
if not listfiles then return{}end

local ag={}
if not isfolder(ae.Path)then
makefolder(ae.Path)
return ag
end

for ah,ai in next,listfiles(ae.Path)do
local aj=ai:match"([^\\/]+)%.json$"
if aj then
table.insert(ag,aj)
end
end

return ag
end

function ae.GetConfig(af,ag)
return ae.Configs[ag]
end

return ae end function a.A()
local aa={}

local ab=a.load'd'
local ac=ab.New
local ad=ab.Tween


local ae=(cloneref or clonereference or function(ae)return ae end)


ae(game:GetService"UserInputService")


function aa.New(af)
local ag={
Button=nil
}

local ah













local ai=ac("TextLabel",{
Text=af.Title,
TextSize=17,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
AutomaticSize="XY",
})

local aj=ac("Frame",{
Size=UDim2.new(0,36,0,36),
BackgroundTransparency=1,
Name="Drag",
},{
ac("ImageLabel",{
Image=ab.Icon"move"[1],
ImageRectOffset=ab.Icon"move"[2].ImageRectPosition,
ImageRectSize=ab.Icon"move"[2].ImageRectSize,
Size=UDim2.new(0,18,0,18),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.3,
})
})
local ak=ac("Frame",{
Size=UDim2.new(0,1,1,0),
Position=UDim2.new(0,36,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=.9,
})

local al=ac("Frame",{
Size=UDim2.new(0,0,0,0),
Position=UDim2.new(0.5,0,0,28),
AnchorPoint=Vector2.new(0.5,0.5),
Parent=af.Parent,
BackgroundTransparency=1,
Active=true,
Visible=false,
})


local am=ac("UIScale",{
Scale=1,
})

local an=ac("Frame",{
Size=UDim2.new(0,0,0,44),
AutomaticSize="X",
Parent=al,
Active=false,
BackgroundTransparency=.25,
ZIndex=99,
BackgroundColor3=Color3.new(0,0,0),
},{
am,
ac("UICorner",{
CornerRadius=UDim.new(1,0)
}),
ac("UIStroke",{
Thickness=1,
ApplyStrokeMode="Border",
Color=Color3.new(1,1,1),
Transparency=0,
},{
ac("UIGradient",{
Color=ColorSequence.new(Color3.fromHex"40c9ff",Color3.fromHex"e81cff")
})
}),
aj,
ak,

ac("UIListLayout",{
Padding=UDim.new(0,4),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),

ac("TextButton",{
AutomaticSize="XY",
Active=true,
BackgroundTransparency=1,
Size=UDim2.new(0,0,0,36),

BackgroundColor3=Color3.new(1,1,1),
},{
ac("UICorner",{
CornerRadius=UDim.new(1,-4)
}),
ah,
ac("UIListLayout",{
Padding=UDim.new(0,af.UIPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ai,
ac("UIPadding",{
PaddingLeft=UDim.new(0,11),
PaddingRight=UDim.new(0,11),
}),
}),
ac("UIPadding",{
PaddingLeft=UDim.new(0,4),
PaddingRight=UDim.new(0,4),
})
})

ag.Button=an



function ag.SetIcon(ao,ap)
if ah then
ah:Destroy()
end
if ap then
ah=ab.Image(
ap,
af.Title,
0,
af.Folder,
"OpenButton",
true,
af.IconThemed
)
ah.Size=UDim2.new(0,22,0,22)
ah.LayoutOrder=-1
ah.Parent=ag.Button.TextButton
end
end

if af.Icon then
ag:SetIcon(af.Icon)
end



ab.AddSignal(an:GetPropertyChangedSignal"AbsoluteSize",function()
al.Size=UDim2.new(
0,an.AbsoluteSize.X,
0,an.AbsoluteSize.Y
)
end)

ab.AddSignal(an.TextButton.MouseEnter,function()
ad(an.TextButton,.1,{BackgroundTransparency=.93}):Play()
end)
ab.AddSignal(an.TextButton.MouseLeave,function()
ad(an.TextButton,.1,{BackgroundTransparency=1}):Play()
end)

local ao=ab.Drag(al)


function ag.Visible(ap,aq)
al.Visible=aq
end

function ag.SetScale(ap,aq)
am.Scale=aq
end

function ag.Edit(ap,aq)
local ar={
Title=aq.Title,
Icon=aq.Icon,
Enabled=aq.Enabled,
Position=aq.Position,
OnlyIcon=aq.OnlyIcon or false,
Draggable=aq.Draggable or nil,
OnlyMobile=aq.OnlyMobile,
CornerRadius=aq.CornerRadius or UDim.new(1,0),
StrokeThickness=aq.StrokeThickness or 2,
Scale=aq.Scale or 1,
Color=aq.Color
or ColorSequence.new(Color3.fromHex"40c9ff",Color3.fromHex"e81cff"),
}



if ar.Enabled==false then
af.IsOpenButtonEnabled=false
end

if ar.OnlyMobile~=false then
ar.OnlyMobile=true
else
af.IsPC=false
end


if ar.Draggable==false and aj and ak then
aj.Visible=ar.Draggable
ak.Visible=ar.Draggable

if ao then
ao:Set(ar.Draggable)
end
end

if ar.Position and al then
al.Position=ar.Position
end

if ar.OnlyIcon==true and ai then
ai.Visible=false
an.TextButton.UIPadding.PaddingLeft=UDim.new(0,7)
an.TextButton.UIPadding.PaddingRight=UDim.new(0,7)
elseif ar.OnlyIcon==false then
ai.Visible=true
an.TextButton.UIPadding.PaddingLeft=UDim.new(0,11)
an.TextButton.UIPadding.PaddingRight=UDim.new(0,11)
end





if ai then
if ar.Title then
ai.Text=ar.Title
ab:ChangeTranslationKey(ai,ar.Title)
elseif ar.Title==nil then

end
end

if ar.Icon then
ag:SetIcon(ar.Icon)
end

an.UIStroke.UIGradient.Color=ar.Color
if Glow then
Glow.UIGradient.Color=ar.Color
end

an.UICorner.CornerRadius=ar.CornerRadius
an.TextButton.UICorner.CornerRadius=UDim.new(ar.CornerRadius.Scale,ar.CornerRadius.Offset-4)
an.UIStroke.Thickness=ar.StrokeThickness

ag:SetScale(ar.Scale)
end

return ag
end



return aa end function a.B()
local aa={}

local ab=a.load'd'
local ac=ab.New
local ad=ab.Tween


function aa.New(ae,af,ag,ah,ai,aj)
local ak={
Container=nil,
TooltipSize=16,

TooltipArrowSizeX=ai=="Small"and 16 or 24,
TooltipArrowSizeY=ai=="Small"and 6 or 9,

PaddingX=ai=="Small"and 12 or 14,
PaddingY=ai=="Small"and 7 or 9,

Radius=999,

TitleFrame=nil,
}

ah=ah or""
aj=aj~=false

local al=ac("TextLabel",{
AutomaticSize="XY",
TextWrapped=aj,
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
Text=ae,
TextSize=ai=="Small"and 15 or 17,
TextTransparency=1,
ThemeTag={
TextColor3="Tooltip"..ah.."Text",
}
})

ak.TitleFrame=al

local am=ac("UIScale",{
Scale=.9
})

local an=ac("Frame",{
AnchorPoint=Vector2.new(0.5,0),
AutomaticSize="XY",
BackgroundTransparency=1,
Parent=af,

Visible=false
},{
ac("UISizeConstraint",{
MaxSize=Vector2.new(400,math.huge)
}),
ac("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
LayoutOrder=99,
Visible=ag,
Name="Arrow",
},{
ac("ImageLabel",{
Size=UDim2.new(0,ak.TooltipArrowSizeX,0,ak.TooltipArrowSizeY),
BackgroundTransparency=1,

Image="rbxassetid://105854070513330",
ThemeTag={
ImageColor3="Tooltip"..ah,
},
},{










}),
}),
ab.NewRoundFrame(ak.Radius,"Squircle",{
AutomaticSize="XY",
ThemeTag={
ImageColor3="Tooltip"..ah,
},
ImageTransparency=1,
Name="Background",
},{



ac("Frame",{



AutomaticSize="XY",
BackgroundTransparency=1,
},{
ac("UICorner",{
CornerRadius=UDim.new(0,16),
}),
ac("UIListLayout",{
Padding=UDim.new(0,12),
FillDirection="Horizontal",
VerticalAlignment="Center"
}),

al,
ac("UIPadding",{
PaddingTop=UDim.new(0,ak.PaddingY),
PaddingLeft=UDim.new(0,ak.PaddingX),
PaddingRight=UDim.new(0,ak.PaddingX),
PaddingBottom=UDim.new(0,ak.PaddingY),
}),
})
}),
am,
ac("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
})
ak.Container=an

function ak.Open(ao)
an.Visible=true


ad(an.Background,.2,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(an.Arrow.ImageLabel,.2,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(al,.2,{TextTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(am,.22,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

function ak.Close(ao,ap)

ad(an.Background,.3,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(an.Arrow.ImageLabel,.2,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(al,.3,{TextTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(am,.35,{Scale=.9},Enum.EasingStyle.Quint,Enum.EasingDirection.In):Play()

ap=ap~=false
if ap then
task.wait(.35)

an.Visible=false
an:Destroy()
end
end

return ak
end



return aa end function a.C()
game:GetService"ReplicatedStorage"
local aa=a.load'd'
local ab=aa.New
local ac=aa.NewRoundFrame
local ad=aa.Tween

local ae=(cloneref or clonereference or function(ae)
return ae
end)

ae(game:GetService"UserInputService")

local af=a.load'y'

local function Color3ToHSB(ag)
local ah,ai,aj=ag.R,ag.G,ag.B
local ak=math.max(ah,ai,aj)
local al=math.min(ah,ai,aj)
local am=ak-al

local an=0
if am~=0 then
if ak==ah then
an=(ai-aj)/am%6
elseif ak==ai then
an=(aj-ah)/am+2
else
an=(ah-ai)/am+4
end
an=an*60
else
an=0
end

local ao=(ak==0)and 0 or(am/ak)
local ap=ak

return{
h=math.floor(an+0.5),
s=ao,
b=ap,
}
end

local function GetPerceivedBrightness(ag)
local ah=ag.R
local ai=ag.G
local aj=ag.B
return 0.299*ah+0.587*ai+0.114*aj
end

local function GetTextColorForHSB(ag)
local ah=Color3ToHSB(ag)local
ai, aj, ak=ah.h, ah.s, ah.b
if GetPerceivedBrightness(ag)>0.5 then
return Color3.fromHSV(ai/360,0,0.05)
else
return Color3.fromHSV(ai/360,0,0.98)
end
end

local function getElementPosition(ag,ah,ai)
if type(ah)~="number"or ah~=math.floor(ah)then
return nil,1
end






local aj=#ag


if aj==0 or ah<1 or ah>aj then
return nil,2
end

local function isDelimiter(ak)
if ak==nil then
return true
end
local al=ak.__type
return al=="Divider"or al=="Space"or al=="Section"or al=="Code"
end

if isDelimiter(ag[ah])then
return nil,3
end

local function calculate(ak,al)
if al==1 then
return"Squircle"
end
if ak==1 then
return ai and"SquircleH-TL-TR"or"Squircle-TL-TR"
end
if ak==al then
return ai and"SquircleH-BL-BR"or"Squircle-BL-BR"
end
return"Square"
end

local ak=1
local al=0

for am=1,aj do
local an=ag[am]
if isDelimiter(an)then
if ah>=ak and ah<=am-1 then
local ao=ah-ak+1
return calculate(ao,al)
end
ak=am+1
al=0
else
al=al+1
end
end

if ah>=ak and ah<=aj then
local am=ah-ak+1
return calculate(am,al)
end

return nil,4
end

return function(ag)
local ah={
Title=ag.Title,
Desc=ag.Desc or nil,
Hover=ag.Hover,
Thumbnail=ag.Thumbnail,
ThumbnailSize=ag.ThumbnailSize or 80,
Image=ag.Image,
IconThemed=ag.IconThemed or false,
ImageSize=ag.ImageSize or 30,
Color=ag.Color,
Scalable=ag.Scalable,
Parent=ag.Parent,
Justify=ag.Justify or"Between",
UIPadding=ag.Window.ElementConfig.UIPadding,
UICorner=ag.Window.ElementConfig.UICorner,
Size=ag.Size or"Default",
Tags=ag.Tags or{},
UIElements={},

Index=ag.Index,
}

local ai=ah.Size=="Small"and-4 or ah.Size=="Large"and 4 or 0
local aj=ah.Size=="Small"and-4 or ah.Size=="Large"and 4 or 0

local ak=ah.ImageSize
local al=ah.ThumbnailSize
local am=true


local an=0

local ao
local ap
if ah.Thumbnail then
ao=aa.Image(
ah.Thumbnail,
ah.Title,
ag.Window.NewElements and ah.UICorner-11 or(ah.UICorner-4),
ag.Window.Folder,
"Thumbnail",
false,
ah.IconThemed
)
ao.Size=UDim2.new(1,0,0,al)
end
if ah.Image then
ap=aa.Image(
ah.Image,
ah.Title,
ag.Window.NewElements and ah.UICorner-11 or(ah.UICorner-4),
ag.Window.Folder,
"Image",
ah.IconThemed,
not ah.Color and true or false,
"ElementIcon"
)

if typeof(ah.Color)=="string"and not string.find(ah.Image,"rbxthumb")then
ap.ImageLabel.ImageColor3=GetTextColorForHSB(Color3.fromHex(aa.Colors[ah.Color]))
elseif typeof(ah.Color)=="Color3"and not string.find(ah.Image,"rbxthumb")then
ap.ImageLabel.ImageColor3=GetTextColorForHSB(ah.Color)
end

ap.Size=UDim2.new(0,ak,0,ak)

an=ak
end

local function CreateText(aq,ar)
local as=typeof(ah.Color)=="string"
and GetTextColorForHSB(Color3.fromHex(aa.Colors[ah.Color]))
or typeof(ah.Color)=="Color3"and GetTextColorForHSB(ah.Color)

return ab("TextLabel",{
BackgroundTransparency=1,
Text=aq or"",
TextSize=ar=="Desc"and 15 or 17,
TextXAlignment="Left",
ThemeTag={
TextColor3=not ah.Color and("Element"..ar)or nil,
},
TextColor3=ah.Color and as or nil,
TextTransparency=ar=="Desc"and 0.3 or 0,
TextWrapped=true,
Size=UDim2.new(ah.Justify=="Between"and 1 or 0,0,0,0),
AutomaticSize=ah.Justify=="Between"and"Y"or"XY",
FontFace=Font.new(aa.Font,ar=="Desc"and Enum.FontWeight.Medium or Enum.FontWeight.SemiBold),
})
end

local aq=CreateText(ah.Title,"Title")
local ar=CreateText(ah.Desc,"Desc")
if not ah.Title or ah.Title==""then
ar.Visible=false
end
if not ah.Desc or ah.Desc==""then
ar.Visible=false
end

ah.UIElements.Title=aq
ah.UIElements.Desc=ar

ah.UIElements.Container=ab("Frame",{
Size=UDim2.new(1,0,1,0),
AutomaticSize="Y",
BackgroundTransparency=1,
},{
ab("UIListLayout",{
Padding=UDim.new(0,ah.UIPadding),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment=ah.Justify=="Between"and"Left"or"Center",
}),
ao,
ab("Frame",{
Size=UDim2.new(
ah.Justify=="Between"and 1 or 0,
ah.Justify=="Between"and-ag.TextOffset or 0,
0,
0
),
AutomaticSize=ah.Justify=="Between"and"Y"or"XY",
BackgroundTransparency=1,
Name="TitleFrame",
},{
ab("UIListLayout",{
Padding=UDim.new(0,ah.UIPadding),
FillDirection="Horizontal",
VerticalAlignment=ag.Window.NewElements and(ah.Justify=="Between"and"Top"or"Center")
or"Center",
HorizontalAlignment=ah.Justify~="Between"and ah.Justify or"Center",
}),
ap,
ab("Frame",{
BackgroundTransparency=1,
AutomaticSize=ah.Justify=="Between"and"Y"or"XY",
Size=UDim2.new(
ah.Justify=="Between"and 1 or 0,
ah.Justify=="Between"and(ap and-an-ah.UIPadding or-an)
or 0,
1,
0
),
Name="TitleFrame",
},{
ab("UIPadding",{
PaddingTop=UDim.new(0,(ag.Window.NewElements and ah.UIPadding/2 or 0)+aj),
PaddingLeft=UDim.new(0,(ag.Window.NewElements and ah.UIPadding/2 or 0)+ai),
PaddingRight=UDim.new(
0,
(ag.Window.NewElements and ah.UIPadding/2 or 0)+ai
),
PaddingBottom=UDim.new(
0,
(ag.Window.NewElements and ah.UIPadding/2 or 0)+aj
),
}),
ab("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
ab("ScrollingFrame",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
LayoutOrder=-99,
BackgroundTransparency=1,
ScrollingDirection="X",
CanvasSize=UDim2.new(0,0,0,0),
ScrollBarThickness=0,
Visible=false,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
Padding=UDim.new(0,ag.Window.UIPadding/2),
}),
}),
ab("Frame",{
Name="Space",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
Visible=false,
}),
aq,
ar,
}),
}),
})

for as,at in next,ag.Tags or{}do
if not ah.UIElements.Container.TitleFrame.TitleFrame.ScrollingFrame.Visible then
ah.UIElements.Container.TitleFrame.TitleFrame.ScrollingFrame.Visible=true
ah.UIElements.Container.TitleFrame.TitleFrame.Space.Visible=true
end
af:New(at,ah.UIElements.Container.TitleFrame.TitleFrame.ScrollingFrame)
end

aa.AddSignal(
ah.UIElements.Container.TitleFrame.TitleFrame.ScrollingFrame.UIListLayout:GetPropertyChangedSignal
"AbsoluteContentSize"
,
function()
ah.UIElements.Container.TitleFrame.TitleFrame.ScrollingFrame.Size=UDim2.new(
1,
0,
0,
ah.UIElements.Container.TitleFrame.TitleFrame.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y
/ag.ParentConfig.UIScale
)
end
)





local as=aa.Image("lock","lock",0,ag.Window.Folder,"Lock",false)
as.Size=UDim2.new(0,20,0,20)
as.ImageLabel.ImageColor3=Color3.new(1,1,1)
as.ImageLabel.ImageTransparency=0.4

local at=ab("TextLabel",{
Text="Locked",
TextSize=18,
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
AutomaticSize="XY",
BackgroundTransparency=1,
TextColor3=Color3.new(1,1,1),
TextTransparency=0.05,
})

local au=ab("Frame",{
Size=UDim2.new(1,ah.UIPadding*2,1,ah.UIPadding*2),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ZIndex=9999999,
})

local av,aw=ac(ah.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.25,
ImageColor3=Color3.new(0,0,0),
Visible=false,
Active=false,
Parent=au,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
as,
at,
},nil,true)local

ax=ac(ah.UICorner,"Squircle-Outline",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=au,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
},nil,true)

local ay,az=ac(ah.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=au,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
},nil,true)local

aA=ac(ah.UICorner,"Squircle-Outline",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Visible=false,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=au,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
ab("UIGradient",{
Name="HoverGradient",
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.25,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.75,0.9),
NumberSequenceKeypoint.new(1,1),
},
}),
},nil,true)

local aB,b=ac(ah.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=au,
},{
ab("UIGradient",{
Name="HoverGradient",
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.25,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.75,0.9),
NumberSequenceKeypoint.new(1,1),
},
}),
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
},nil,true)

local d,f=ac(ah.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ImageTransparency=ah.Color and 0.05 or(not ag.Window.NewElements and 0.93 or nil),



Parent=ag.Parent,
ThemeTag={
ImageColor3=not ah.Color and(ag.Window.NewElements and"ElementBackground"or"Text")or nil,
ImageTransparency=not ah.Color
and(ag.Window.NewElements and"ElementBackgroundTransparency"or nil)
or nil,
},
ImageColor3=ah.Color and(typeof(ah.Color)=="string"and Color3.fromHex(
aa.Colors[ah.Color]
)or typeof(ah.Color)=="Color3"and ah.Color)or nil,
},{
ah.UIElements.Container,
au,
ab("UIPadding",{
PaddingTop=UDim.new(0,ah.UIPadding),
PaddingLeft=UDim.new(0,ah.UIPadding),
PaddingRight=UDim.new(0,ah.UIPadding),
PaddingBottom=UDim.new(0,ah.UIPadding),
}),
},true,true)

ah.UIElements.Main=d
ah.UIElements.Locked=av

if ah.Hover then
aa.AddSignal(d.MouseEnter,function()
if am then

ad(aB,0.12,{ImageTransparency=0.9}):Play()
ad(aA,0.12,{ImageTransparency=0.8}):Play()
aa.AddSignal(d.MouseMoved,function(g,h)
aB.HoverGradient.Offset=
Vector2.new(((g-d.AbsolutePosition.X)/d.AbsoluteSize.X)-0.5,0)
aA.HoverGradient.Offset=
Vector2.new(((g-d.AbsolutePosition.X)/d.AbsoluteSize.X)-0.5,0)
end)
end
end)
aa.AddSignal(d.InputEnded,function()
if am then

ad(aB,0.12,{ImageTransparency=1}):Play()
ad(aA,0.12,{ImageTransparency=1}):Play()
end
end)
end

function ah.SetTitle(g,h)
ah.Title=h
aq.Text=h
end

function ah.SetDesc(g,h)
ah.Desc=h
ar.Text=h or""
if not h then
ar.Visible=false
elseif not ar.Visible then
ar.Visible=true
end
end

function ah.Colorize(g,h,i)
if ah.Color then
h[i]=typeof(ah.Color)=="string"
and GetTextColorForHSB(Color3.fromHex(aa.Colors[ah.Color]))
or typeof(ah.Color)=="Color3"and GetTextColorForHSB(ah.Color)
or nil
end
end

if ag.ElementTable then
aa.AddSignal(aq:GetPropertyChangedSignal"Text",function()
if ah.Title~=aq.Text then
ah:SetTitle(aq.Text)
ag.ElementTable.Title=aq.Text
end
end)
aa.AddSignal(ar:GetPropertyChangedSignal"Text",function()
if ah.Desc~=ar.Text then
ah:SetDesc(ar.Text)
ag.ElementTable.Desc=ar.Text
end
end)
end





function ah.SetThumbnail(g,h,i)
ah.Thumbnail=h
if i then
ah.ThumbnailSize=i
al=i
end

if ao then
if h then
ao:Destroy()
ao=aa.Image(
h,
ah.Title,
ah.UICorner-3,
ag.Window.Folder,
"Thumbnail",
false,
ah.IconThemed
)
if ao then
ao.Size=UDim2.new(1,0,0,al)
ao.Parent=ah.UIElements.Container
local l=ah.UIElements.Container:FindFirstChild"UIListLayout"
if l then
ao.LayoutOrder=-1
end
end
else
ao.Visible=false
end
else
if h then
ao=aa.Image(
h,
ah.Title,
ah.UICorner-3,
ag.Window.Folder,
"Thumbnail",
false,
ah.IconThemed
)
if ao then
ao.Size=UDim2.new(1,0,0,al)
ao.Parent=ah.UIElements.Container
local l=ah.UIElements.Container:FindFirstChild"UIListLayout"
if l then
ao.LayoutOrder=-1
end
end
end
end
end

function ah.SetImage(g,h,i)
ah.Image=h
if i then
ah.ImageSize=i
ak=i
end

if h then
local l=ap and ap.Parent or ah.UIElements.Container.TitleFrame
if ap then
ap:Destroy()
end

ap=aa.Image(
h,
h,
ah.UICorner-3,
ag.Window.Folder,
"Image",
not ah.Color and true or false
)
if ap then
if typeof(ah.Color)=="string"and not string.find(ah.Image,"rbxthumb")then
ap.ImageLabel.ImageColor3=
GetTextColorForHSB(Color3.fromHex(aa.Colors[ah.Color]))
elseif typeof(ah.Color)=="Color3"and not string.find(ah.Image,"rbxthumb")then
ap.ImageLabel.ImageColor3=GetTextColorForHSB(ah.Color)
end

ap.Visible=true
ap.Parent=l
ap.LayoutOrder=-99

ap.Size=UDim2.new(0,ak,0,ak)
an=ah.ImageSize+ah.UIPadding
end
else
if ap then
ap.Visible=true
end
an=0
end

ah.UIElements.Container.TitleFrame.TitleFrame.Size=UDim2.new(1,-an,1,0)
end

function ah.Destroy(g)
d:Destroy()
end

function ah.Lock(g,h)
am=false
av.Active=true
av.Visible=true
at.Text=h or"Locked"
end

function ah.Unlock(g)
am=true
av.Active=false
av.Visible=false
end

function ah.Highlight(g)
local h=ab("UIGradient",{
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.1,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.9,0.9),
NumberSequenceKeypoint.new(1,1),
},
Rotation=0,
Offset=Vector2.new(-1,0),
Parent=ax,
})

local i=ab("UIGradient",{
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.15,0.8),
NumberSequenceKeypoint.new(0.5,0.1),
NumberSequenceKeypoint.new(0.85,0.8),
NumberSequenceKeypoint.new(1,1),
},
Rotation=0,
Offset=Vector2.new(-1,0),
Parent=ay,
})

ax.ImageTransparency=0.65
ay.ImageTransparency=0.88

ad(h,0.75,{
Offset=Vector2.new(1,0),
}):Play()

ad(i,0.75,{
Offset=Vector2.new(1,0),
}):Play()

task.spawn(function()
task.wait(0.75)
ax.ImageTransparency=1
ay.ImageTransparency=1
h:Destroy()
i:Destroy()
end)
end

function ah.UpdateShape(g)
if ag.Window.NewElements then
local h=getElementPosition(
g.Elements,
ah.Index,
ag.ParentConfig.ParentTable.__type=="HStack"or ag.ParentConfig.ParentTable.__type=="Group"
)

if h and d then
f:SetType(h)
aw:SetType(h)
az:SetType(h)

b:SetType(h)

end
end
end





return ah
end end function a.D()

local aa=a.load'd'
local ab=aa.New

local ac={}

local ad=a.load'm'.New

function ac.New(ae,af)
af.Hover=false
af.TextOffset=0
af.ParentConfig=af
af.IsButtons=af.Buttons and#af.Buttons>0 and true or false

local ag={
__type="Paragraph",
Title=af.Title or"Paragraph",
Desc=af.Desc or nil,

Locked=af.Locked or false,
}
local ah=a.load'C'(af)

ag.ParagraphFrame=ah
if af.Buttons and#af.Buttons>0 then
local ai=ab("Frame",{
Size=UDim2.new(1,0,0,38),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=ah.UIElements.Container,
},{
ab("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Vertical",
}),
})

for aj,ak in next,af.Buttons do
local al=ad(
ak.Title,
ak.Icon,
ak.Callback,
ak.Variant or"White",
ai,
nil,
nil,
af.Window.NewElements and 999 or 10
)
al.Size=UDim2.new(1,0,0,38)

end
end

return ag.__type,ag
end

return ac end function a.E()

local aa=a.load'd'local ab=
aa.New

local ac={}

function ac.New(ad,ae)
local af={
__type="Button",
Title=ae.Title or"Button",
Desc=ae.Desc or nil,
Icon=ae.Icon or"mouse-pointer-click",
IconThemed=ae.IconThemed or false,
IconColor=ae.IconColor or nil,
Color=ae.Color,
Justify=ae.Justify or"Between",
IconAlign=ae.IconAlign or"Right",
Locked=ae.Locked or false,
LockedTitle=ae.LockedTitle,
Callback=ae.Callback or function()end,
UIElements={},
}

local ag=true

af.ButtonFrame=a.load'C'{
Title=af.Title,
Desc=af.Desc,
Parent=ae.Parent,




Window=ae.Window,
Color=af.Color,
Justify=af.Justify,
TextOffset=20,
Hover=true,
Scalable=true,
Tab=ae.Tab,
Index=ae.Index,
ElementTable=af,
ParentConfig=ae,
Size=ae.Size,
Tags=ae.Tags,
}














af.UIElements.ButtonIcon=aa.Image(
af.Icon,
af.Icon,
0,
ae.Window.Folder,
"Button",
not(af.Color or af.IconColor)and true or nil,
af.IconThemed
)

if af.IconColor then
af.UIElements.ButtonIcon.ImageLabel.ImageColor3=af.IconColor
end

af.UIElements.ButtonIcon.Size=UDim2.new(0,20,0,20)
af.UIElements.ButtonIcon.Parent=af.Justify=="Between"and af.ButtonFrame.UIElements.Main
or af.ButtonFrame.UIElements.Container.TitleFrame
af.UIElements.ButtonIcon.LayoutOrder=af.IconAlign=="Left"and-99999 or 99999
af.UIElements.ButtonIcon.AnchorPoint=Vector2.new(1,0.5)
af.UIElements.ButtonIcon.Position=UDim2.new(1,0,0.5,0)

af.ButtonFrame:Colorize(af.UIElements.ButtonIcon.ImageLabel,"ImageColor3")

function af.Lock(ah)
af.Locked=true
ag=false
return af.ButtonFrame:Lock(af.LockedTitle)
end
function af.Unlock(ah)
af.Locked=false
ag=true
return af.ButtonFrame:Unlock()
end

if af.Locked then
af:Lock()
end

aa.AddSignal(af.ButtonFrame.UIElements.Main.MouseButton1Click,function()
if ag then
task.spawn(function()
aa.SafeCallback(af.Callback)
end)
end
end)
return af.__type,af
end

return ac end function a.F()

local aa={}

local ab=a.load'd'
local ac=ab.New
local ad=ab.Tween

local ae=game:GetService"UserInputService"

function aa.New(af,ag,ah,ai,aj,ak,al)
local am={
GlassSpritesheet={
Id="rbxassetid://77297718671545",
MirroredId="rbxassetid://92258969882244",
Size=Vector2.new(102,128),
Total=80,
Cols=10,
},
}

function am.GetGlassFrame(an,ao:number):(string,Vector2,Vector2)
local ap=am.GlassSpritesheet
local aq:number

if ao<=0.4 then
aq=math.floor((ao/0.4)*(ap.Total-1))
elseif ao<0.6 then
aq=ap.Total-1
else
aq=math.floor(((ao-0.6)/0.4)*(ap.Total-1))
end

aq=math.clamp(aq,0,ap.Total-1)

local ar=ao>=0.6
if ar then
aq=(ap.Total-1)-aq
end

local as=ar and ap.MirroredId or ap.Id

return as,ap.Size,Vector2.new((aq%ap.Cols)*ap.Size.X,math.floor(aq/ap.Cols)*ap.Size.Y)
end

local an=12
local ao
if ag and ag~=""then
ao=ac("ImageLabel",{
Size=UDim2.new(0,13,0,13),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Image=ab.Icon(ag)[1],
ImageRectOffset=ab.Icon(ag)[2].ImageRectPosition,
ImageRectSize=ab.Icon(ag)[2].ImageRectSize,
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
})
end

local ap=ac("Frame",{
Size=UDim2.new(0,2,0,26),
BackgroundTransparency=1,
Parent=ai,
})

local aq=ab.NewRoundFrame(an,"Squircle",{
ImageTransparency=0.85,
ThemeTag={
ImageColor3="Text",
},
Parent=ap,
Size=UDim2.new(0,ak and(52)or(40.8),0,24),
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(0,0,0.5,0),
Name="ToggleFrame",
},{
ab.NewRoundFrame(an,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Layer",
ThemeTag={
ImageColor3="Toggle",
},
ImageTransparency=1,
}),
ab.NewRoundFrame(an,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
Name="Stroke",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=1,
},{
ac("UIGradient",{
Rotation=90,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,1),
},
}),
}),


ab.NewRoundFrame(an,"Squircle",{
Size=UDim2.new(0,ak and 30 or 20,0,20),
Position=UDim2.new(0,2,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
ImageTransparency=1,
Name="Frame",
},{
ab.NewRoundFrame(an,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Bar",
},{
ab.New("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundColor3=Color3.new(1,1,1),
Name="Highlight",
BackgroundTransparency=1,
},{
ab.NewRoundFrame(9999,"SquircleGlass",{
Size=UDim2.new(1,1,1,1),
ImageColor3=Color3.new(1,1,1),
Name="SquircleGlass",
ImageTransparency=0.5,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
}),
ab.NewRoundFrame(an,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="GlassBackground",
ImageTransparency=0,
ThemeTag={
ImageColor3="ElementBackground",
},
ZIndex=-1,
}),
ac("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Name="Glass",
ImageTransparency=0,
},{
ac("UICorner",{
CornerRadius=UDim.new(1,0),
}),
}),






ab.NewRoundFrame(an,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="BarOverlay",
ThemeTag={
ImageColor3="ToggleBar",
},
ZIndex=999,
}),
}),
ao,
ac("UIScale",{
Scale=1,
}),
}),
}),
ac("TextButton",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Name="Hitbox",
Text="",
}),
})

local ar
local as

local at=ak and 30 or 20
local au=aq.Size.X.Offset

function am.Set(av,aw,ax,ay)
if not ay then
if aw then
ad(aq.Frame,0.35,{
Position=UDim2.new(0,au-at-2,0.5,0),
},Enum.EasingStyle.Back,Enum.EasingDirection.Out):Play()
ab.SetThemeTag(aq.Frame.Bar.Highlight.Glass,{ImageColor3="Toggle"},0.15)

ad(
aq.Frame.Bar.Highlight.Glass,
0.15,
{ImageTransparency=0},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
else
ad(aq.Frame,0.35,{
Position=UDim2.new(0,2,0.5,0),
},Enum.EasingStyle.Back,Enum.EasingDirection.Out):Play()
ab.SetThemeTag(aq.Frame.Bar.Highlight.Glass,{ImageColor3="Text"},0.15)
ad(
aq.Frame.Bar.Highlight.Glass,
0.15,
{ImageTransparency=0.85},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
end
else
if aw then
aq.Frame.Position=UDim2.new(0,au-at-2,0.5,0)
else
aq.Frame.Position=UDim2.new(0,2,0.5,0)
end
end

if aw then
ad(aq.Layer,0.1,{
ImageTransparency=0,
}):Play()
ab.SetThemeTag(aq.Frame.Bar.Highlight.Glass,{ImageColor3="Toggle"},0.1)
ad(
aq.Frame.Bar.Highlight.Glass,
0.1,
{ImageTransparency=0},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()

if ao then
ad(ao,0.1,{
ImageTransparency=0,
}):Play()
end

local az,aA,aB=am:GetGlassFrame(1)

aq.Frame.Bar.Highlight.Glass.Image=az
aq.Frame.Bar.Highlight.Glass.ImageRectSize=aA
aq.Frame.Bar.Highlight.Glass.ImageRectOffset=aB
else
ad(aq.Layer,0.1,{
ImageTransparency=1,
}):Play()
ab.SetThemeTag(aq.Frame.Bar.Highlight.Glass,{ImageColor3="Text"},0.1)
ad(
aq.Frame.Bar.Highlight.Glass,
0.1,
{ImageTransparency=0.85},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()

if ao then
ad(ao,0.1,{
ImageTransparency=1,
}):Play()
end

local az,aA,aB=am:GetGlassFrame(0)

aq.Frame.Bar.Highlight.Glass.Image=az
aq.Frame.Bar.Highlight.Glass.ImageRectSize=aA
aq.Frame.Bar.Highlight.Glass.ImageRectOffset=aB
end

ax=ax~=false

task.spawn(function()
if aj and ax then
ab.SafeCallback(aj,aw)
end
end)
end

function am.Animate(av,aw,ax)
if not al.Window.IsToggleDragging then
al.Window.IsToggleDragging=true

local ay=aw.Position.X
local az=aw.Position.Y
local aA=aq.Frame.Position.X.Offset
local aB=false
local b=false

ad(
aq.Frame.Bar.UIScale,
0.28,
{Scale=1.5},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
ad(
aq.Frame.Bar.Highlight.BarOverlay,
0.28,
{ImageTransparency=0.86},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()

if ar then
ar:Disconnect()
end

ar=ae.InputChanged:Connect(function(d)
if not al.Window.IsToggleDragging then
return
end
if
d.UserInputType~=Enum.UserInputType.MouseMovement
and d.UserInputType~=Enum.UserInputType.Touch
then
return
end
if aB then
return
end

local f=math.abs(d.Position.X-ay)
math.abs(d.Position.Y-az)

if not b and f>8 then
b=true
end

local g=d.Position.X-ay
local h=math.max(2,math.min(aA+g,au-at-2))

local i=math.clamp((h-2)/(au-at-4),0,1)

local l,m,p=am:GetGlassFrame(i)
aq.Frame.Bar.Highlight.Glass.Image=l
aq.Frame.Bar.Highlight.Glass.ImageRectSize=m
aq.Frame.Bar.Highlight.Glass.ImageRectOffset=p

ad(aq.Frame,0.12,{
Position=UDim2.new(0,h,0.5,0),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end)

if as then
as:Disconnect()
end

as=ae.InputEnded:Connect(function(d)
if not al.Window.IsToggleDragging then
return
end
if
d.UserInputType~=Enum.UserInputType.MouseButton1
and d.UserInputType~=Enum.UserInputType.Touch
then
return
end

al.Window.IsToggleDragging=false

if ar then
ar:Disconnect()
ar=nil
end
if as then
as:Disconnect()
as=nil
end

al.WindUI.CurrentInput=nil

if aB then
return
end

if not b then
ax:Set(not ax.Value,true,false)
else
local f=aq.Frame.Position.X.Offset
local g=f+at/2
local h=g>au/2
ax:Set(h,true,false)
end

ad(
aq.Frame.Bar.UIScale,
0.23,
{Scale=1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
ad(
aq.Frame.Bar.Highlight.BarOverlay,
0.23,
{ImageTransparency=0},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
end)
end
end

return ap,am
end

return aa end function a.G()

local aa={}

local ab=a.load'd'local ac=
ab.New
local ad=ab.Tween


function aa.New(ae,af,ag,ah,ai,aj)
local ak={}

af=af or"sfsymbols:checkmark"

local al=9

local am=ab.Image(
af,
af,
0,
(aj and aj.Window.Folder or"Temp"),
"Checkbox",
true,
false,
"CheckboxIcon"
)
am.Size=UDim2.new(1,-26+ag,1,-26+ag)
am.AnchorPoint=Vector2.new(0.5,0.5)
am.Position=UDim2.new(0.5,0,0.5,0)


local an=ab.NewRoundFrame(al,"Squircle",{
ImageTransparency=.85,
ThemeTag={
ImageColor3="Text"
},
Parent=ah,
Size=UDim2.new(0,26,0,26),
},{
ab.NewRoundFrame(al,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Layer",
ThemeTag={
ImageColor3="Checkbox",
},
ImageTransparency=1,
}),
ab.NewRoundFrame(al,"Glass-1.4",{
Size=UDim2.new(1,0,1,0),
Name="Stroke",
ThemeTag={
ImageColor3="CheckboxBorder",
ImageTransparency="CheckboxBorderTransparency",
},
},{







}),

am,
},true)

function ak.Set(ao,ap)
if ap then
ad(an.Layer,0.06,{
ImageTransparency=0,
}):Play()



ad(am.ImageLabel,0.06,{
ImageTransparency=0,
}):Play()
else
ad(an.Layer,0.05,{
ImageTransparency=1,
}):Play()



ad(am.ImageLabel,0.06,{
ImageTransparency=1,
}):Play()
end

task.spawn(function()
if ai then
ab.SafeCallback(ai,ap)
end
end)
end

return an,ak
end


return aa end function a.H()
local aa=a.load'd'local ab=
aa.New local ac=
aa.Tween

local ad=a.load'F'.New
local ae=a.load'G'.New

local af={}

function af.New(ag,ah)
local ai={
__type="Toggle",
Title=ah.Title or"Toggle",
Desc=ah.Desc or nil,
Locked=ah.Locked or false,
LockedTitle=ah.LockedTitle,
Value=ah.Value,
Icon=ah.Icon or nil,
IconSize=ah.IconSize or 23,
Type=ah.Type or"Toggle",
Callback=ah.Callback or function()end,
UIElements={},
}
ai.ToggleFrame=a.load'C'{
Title=ai.Title,
Desc=ai.Desc,




Window=ah.Window,
Parent=ah.Parent,
TextOffset=(52),
Hover=false,
Tab=ah.Tab,
Index=ah.Index,
ElementTable=ai,
ParentConfig=ah,
Tags=ah.Tags,
}

local aj=true

if ai.Value==nil then
ai.Value=false
end

function ai.Lock(ak)
ai.Locked=true
aj=false
return ai.ToggleFrame:Lock(ai.LockedTitle)
end
function ai.Unlock(ak)
ai.Locked=false
aj=true
return ai.ToggleFrame:Unlock()
end

if ai.Locked then
ai:Lock()
end

local ak=ai.Value

local al,am
if ai.Type=="Toggle"then
al,am=ad(
ak,
ai.Icon,
ai.IconSize,
ai.ToggleFrame.UIElements.Main,
ai.Callback,
ah.Window.NewElements,
ah
)
elseif ai.Type=="Checkbox"then
al,am=ae(
ak,
ai.Icon,
ai.IconSize,
ai.ToggleFrame.UIElements.Main,
ai.Callback,
ah
)
else
error("Unknown Toggle Type: "..tostring(ai.Type))
end

al.AnchorPoint=Vector2.new(1,ah.Window.NewElements and 0 or 0.5)
al.Position=UDim2.new(1,0,ah.Window.NewElements and 0 or 0.5,0)

function ai.Set(an,ao,ap,aq)
if aj then
am:Set(ao,ap,aq or false)
ak=ao
ai.Value=ao
end
end

ai:Set(ak,false,ah.Window.NewElements)

local an=ah.WindUI.GenerateGUID()

if ah.Window.NewElements and am.Animate then
if ai.Type=="Toggle"then
aa.AddSignal(al.ToggleFrame.Hitbox.InputBegan,function(ao)
if
not ah.Window.IsToggleDragging
and(
ao.UserInputType==Enum.UserInputType.MouseButton1
or ao.UserInputType==Enum.UserInputType.Touch
)
then
if ah.WindUI.CurrentInput and ah.WindUI.CurrentInput~=an then
return
end

ah.WindUI.CurrentInput=an
am:Animate(ao,ai)
end
end)
end





else
if ai.Type=="Toggle"then
aa.AddSignal(al.ToggleFrame.Hitbox.MouseButton1Click,function()
ai:Set(not ai.Value,nil,ah.Window.NewElements)
end)
elseif ai.Type=="Checkbox"then
aa.AddSignal(al.MouseButton1Click,function()
ai:Set(not ai.Value,nil,ah.Window.NewElements)
end)
end
end

return ai.__type,ai
end

return af end function a.I()

local aa=(cloneref or clonereference or function(aa)
return aa
end)

local ac=aa(game:GetService"UserInputService")
local ad=aa(game:GetService"RunService")

local ae=a.load'd'
local af=ae.New
local ag=ae.Tween

local ah={}

local ai=false

function ah.New(aj,ak)
local al={
__type="Slider",
Title=ak.Title or nil,
Desc=ak.Desc or nil,
Locked=ak.Locked or nil,
LockedTitle=ak.LockedTitle,
Value=ak.Value or{},
Icons=ak.Icons or nil,
IsTooltip=ak.IsTooltip or false,
IsTextbox=ak.IsTextbox,
Step=ak.Step or 1,
Callback=ak.Callback or function()end,
UIElements={},
IsFocusing=false,

Width=ak.Width or 130,
TextBoxWidth=ak.Window.NewElements and 40 or 30,
ThumbSize=13,
IconSize=26,
}
if al.Icons=={}then
al.Icons={
From="sfsymbols:sunMinFill",
To="sfsymbols:sunMaxFill",
}
end
if al.IsTextbox==nil and al.Title==nil then
al.IsTextbox=false
else
al.IsTextbox=al.IsTextbox~=false
end

local am
local an
local ao
local ap=al.Value.Default or al.Value.Min or 0

local aq=ap
local ar=(ap-(al.Value.Min or 0))/((al.Value.Max or 100)-(al.Value.Min or 0))

local as=true
local at=al.Step%1~=0

local function FormatValue(au)
if at then
return tonumber(string.format("%.2f",au))
end
return math.floor(au+0.5)
end

local function CalculateValue(au)
if at then
return math.floor(au/al.Step+0.5)*al.Step
else
return math.floor(au/al.Step+0.5)*al.Step
end
end

local au,av
local aw=32
if al.Icons then
if al.Icons.From then
au=ae.Image(
al.Icons.From,
al.Icons.From,
0,
ak.Window.Folder,
"SliderIconFrom",
true,
true,
"SliderIconFrom"
)
au.Size=UDim2.new(0,al.IconSize,0,al.IconSize)
aw=aw+al.IconSize-2
end
if al.Icons.To then
av=ae.Image(
al.Icons.To,
al.Icons.To,
0,
ak.Window.Folder,
"SliderIconTo",
true,
true,
"SliderIconTo"
)
av.Size=UDim2.new(0,al.IconSize,0,al.IconSize)
aw=aw+al.IconSize-2
end
end
al.SliderFrame=a.load'C'{
Title=al.Title,
Desc=al.Desc,
Parent=ak.Parent,
TextOffset=al.Width,
Hover=false,
Tab=ak.Tab,
Index=ak.Index,
Window=ak.Window,
ElementTable=al,
ParentConfig=ak,
Tags=ak.Tags,
}

al.UIElements.SliderIcon=ae.NewRoundFrame(99,"Squircle",{
ImageTransparency=0.95,
Size=UDim2.new(1,not al.IsTextbox and-aw or(-al.TextBoxWidth-8),0,4),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Frame",
ThemeTag={
ImageColor3="Text",
},
},{
ae.NewRoundFrame(99,"Squircle",{
Name="Frame",
Size=UDim2.new(ar,0,1,0),
ImageTransparency=0.1,
ThemeTag={
ImageColor3="Slider",
},
},{
ae.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(
0,
ak.Window.NewElements and(al.ThumbSize*2)or(al.ThumbSize+2),
0,
ak.Window.NewElements and(al.ThumbSize+4)or(al.ThumbSize+2)
),
Position=UDim2.new(1,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="SliderThumb",
},
Name="Thumb",
},{
ae.NewRoundFrame(999,"SquircleGlass",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
Name="Highlight",
ImageTransparency=0.5,
}),
}),
}),
})

al.UIElements.SliderContainer=af("Frame",{
Size=UDim2.new(al.Title==nil and 1 or 0,al.Title==nil and 0 or al.Width,0,0),
AutomaticSize="Y",
Position=UDim2.new(1,al.IsTextbox and(ak.Window.NewElements and-16 or 0)or 0,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Parent=al.SliderFrame.UIElements.Main,
},{
af("UIListLayout",{
Padding=UDim.new(0,al.Title~=nil and 8 or 12),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment=al.Icons
and(al.Icons.From and(al.Icons.To and"Center"or"Left")or al.Icons.To and"Right")
or"Center",
}),
au,
al.UIElements.SliderIcon,
av,
af("TextBox",{
Size=UDim2.new(0,al.TextBoxWidth,0,0),
TextXAlignment="Left",
Text=FormatValue(ap),
ThemeTag={
TextColor3="Text",
},
TextTransparency=0.4,
AutomaticSize="Y",
TextSize=15,
FontFace=Font.new(ae.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
LayoutOrder=-1,
Visible=al.IsTextbox,
}),
})

local ax
if al.IsTooltip then
ax=a.load'B'.New(
ap,
al.UIElements.SliderIcon.Frame.Thumb,
true,
"Secondary",
"Small",
false
)
ax.Container.AnchorPoint=Vector2.new(0.5,1)
ax.Container.Position=UDim2.new(0.5,0,0,-8)
end

function al.Lock(ay)
al.Locked=true
as=false
return al.SliderFrame:Lock(al.LockedTitle)
end
function al.Unlock(ay)
al.Locked=false
as=true
return al.SliderFrame:Unlock()
end

if al.Locked then
al:Lock()
end


local ay=ak.Tab.UIElements.ContainerFrame

function al.Set(az,aA,aB)
if as then
if
not al.IsFocusing
and not ai
and(
not aB
or(
aB.UserInputType==Enum.UserInputType.MouseButton1
or aB.UserInputType==Enum.UserInputType.Touch
)
)
then
if aB then
am=(aB.UserInputType==Enum.UserInputType.Touch)
ay.ScrollingEnabled=false
ai=true

local b=am and aB.Position.X or ac:GetMouseLocation().X
local d=math.clamp(
(b-al.UIElements.SliderIcon.AbsolutePosition.X)
/al.UIElements.SliderIcon.AbsoluteSize.X,
0,
1
)
aA=CalculateValue(al.Value.Min+d*(al.Value.Max-al.Value.Min))
aA=math.clamp(aA,al.Value.Min or 0,al.Value.Max or 100)

if aA~=aq then
ag(al.UIElements.SliderIcon.Frame,0.05,{Size=UDim2.new(d,0,1,0)}):Play()
al.UIElements.SliderContainer.TextBox.Text=FormatValue(aA)
if ax then
ax.TitleFrame.Text=FormatValue(aA)
end
al.Value.Default=FormatValue(aA)
aq=aA
ae.SafeCallback(al.Callback,FormatValue(aA))
end

an=ad.RenderStepped:Connect(function()
local f=am and aB.Position.X or ac:GetMouseLocation().X
local g=math.clamp(
(f-al.UIElements.SliderIcon.AbsolutePosition.X)
/al.UIElements.SliderIcon.AbsoluteSize.X,
0,
1
)
aA=CalculateValue(al.Value.Min+g*(al.Value.Max-al.Value.Min))

if aA~=aq then
ag(al.UIElements.SliderIcon.Frame,0.05,{Size=UDim2.new(g,0,1,0)}):Play()
al.UIElements.SliderContainer.TextBox.Text=FormatValue(aA)
if ax then
ax.TitleFrame.Text=FormatValue(aA)
end
al.Value.Default=FormatValue(aA)
aq=aA
ae.SafeCallback(al.Callback,FormatValue(aA))
end
end)


ao=ac.InputEnded:Connect(function(f)
if
(
f.UserInputType==Enum.UserInputType.MouseButton1
or f.UserInputType==Enum.UserInputType.Touch
)and aB==f
then
an:Disconnect()
ao:Disconnect()
ai=false
ay.ScrollingEnabled=true

ak.WindUI.CurrentInput=nil

if ak.Window.NewElements then
ag(al.UIElements.SliderIcon.Frame.Thumb,0.2,{
ImageTransparency=0,
Size=UDim2.new(
0,
ak.Window.NewElements and(al.ThumbSize*2)or(al.ThumbSize+2),
0,
ak.Window.NewElements and(al.ThumbSize+4)or(al.ThumbSize+2)
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
end
if ax then
ax:Close(false)
end
end
end)
else
aA=math.clamp(aA,al.Value.Min or 0,al.Value.Max or 100)

local b=math.clamp(
(aA-(al.Value.Min or 0))/((al.Value.Max or 100)-(al.Value.Min or 0)),
0,
1
)
aA=CalculateValue(al.Value.Min+b*(al.Value.Max-al.Value.Min))

if aA~=aq then
ag(al.UIElements.SliderIcon.Frame,0.05,{Size=UDim2.new(b,0,1,0)}):Play()
al.UIElements.SliderContainer.TextBox.Text=FormatValue(aA)
if ax then
ax.TitleFrame.Text=FormatValue(aA)
end
al.Value.Default=FormatValue(aA)
aq=aA
ae.SafeCallback(al.Callback,FormatValue(aA))
end
end
end
end
end

function al.SetMax(az,aA)
al.Value.Max=aA

local aB=tonumber(al.Value.Default)or aq
if aB>aA then
al:Set(aA)
else
local b=
math.clamp((aB-(al.Value.Min or 0))/(aA-(al.Value.Min or 0)),0,1)
ag(al.UIElements.SliderIcon.Frame,0.1,{Size=UDim2.new(b,0,1,0)}):Play()
end
end

function al.SetMin(az,aA)
al.Value.Min=aA

local aB=tonumber(al.Value.Default)or aq
if aB<aA then
al:Set(aA)
else
local b=math.clamp((aB-aA)/((al.Value.Max or 100)-aA),0,1)
ag(al.UIElements.SliderIcon.Frame,0.1,{Size=UDim2.new(b,0,1,0)}):Play()
end
end

ae.AddSignal(al.UIElements.SliderContainer.TextBox.FocusLost,function(az)
local aA=tonumber(al.UIElements.SliderContainer.TextBox.Text)
if aA then
al:Set(aA)
else
al.UIElements.SliderContainer.TextBox.Text=FormatValue(aq)
if ax then
ax.TitleFrame.Text=FormatValue(aq)
end
end
end)

local az=ak.WindUI.GenerateGUID()

ae.AddSignal(al.UIElements.SliderContainer.InputBegan,function(aA)
if al.Locked or ai then
return
end
if
aA.UserInputType==Enum.UserInputType.MouseButton1
or aA.UserInputType==Enum.UserInputType.Touch
then
if ak.WindUI.CurrentInput and ak.WindUI.CurrentInput~=az then
return
end
ak.WindUI.CurrentInput=az

al:Set(ap,aA)


if ak.Window.NewElements then
ag(al.UIElements.SliderIcon.Frame.Thumb,0.24,{
ImageTransparency=0.85,
Size=UDim2.new(
0,
(ak.Window.NewElements and(al.ThumbSize*2)or al.ThumbSize)+8,
0,
al.ThumbSize+8
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
if ax then
ax:Open()
end

end
end)

return al.__type,al
end

return ah end function a.J()

local aa=(cloneref or clonereference or function(aa)
return aa
end)

local ac=aa(game:GetService"UserInputService")

local ad=a.load'd'
local ae=ad.New local af=
ad.Tween

local ag={
UICorner=6,
UIPadding=8,
}

local ah=a.load'w'.New

function ag.New(ai,aj)
local function NormalizeKeyCode(ak)
if typeof(ak)=="EnumItem"then
return ak.Name
elseif type(ak)=="string"then
return ak
else
return"F"
end
end

local ak={
__type="Keybind",
Title=aj.Title or"Keybind",
Desc=aj.Desc or nil,
Locked=aj.Locked or false,
LockedTitle=aj.LockedTitle,
Value=NormalizeKeyCode(aj.Value)or"F",
Callback=aj.Callback or function()end,
CanChange=aj.CanChange~=false,
Blacklist=aj.Blacklist or{},
Picking=false,
UIElements={},
}

local al={}

for am,an in next,ak.Blacklist do
table.insert(al,Enum.KeyCode[NormalizeKeyCode(an)])
end
table.insert(al,Enum.KeyCode[NormalizeKeyCode"Escape"])

local am=true

ak.KeybindFrame=a.load'C'{
Title=ak.Title,
Desc=ak.Desc,
Parent=aj.Parent,
TextOffset=85,
Hover=ak.CanChange,
Tab=aj.Tab,
Index=aj.Index,
Window=aj.Window,
ElementTable=ak,
ParentConfig=aj,
Tags=aj.Tags,
}

ak.UIElements.Keybind=ah(
ak.Value,
nil,
ak.KeybindFrame.UIElements.Main,
nil,
aj.Window.NewElements and 12 or 10
)

ak.UIElements.Keybind.Size=
UDim2.new(0,24+ak.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,0,42)
ak.UIElements.Keybind.AnchorPoint=Vector2.new(1,0.5)
ak.UIElements.Keybind.Position=UDim2.new(1,0,0.5,0)
ak.UIElements.Keybind.Interactable=false

ae("UIScale",{
Parent=ak.UIElements.Keybind,
Scale=0.85,
})

ad.AddSignal(
ak.UIElements.Keybind.Frame.Frame.TextLabel:GetPropertyChangedSignal"TextBounds",
function()
ak.UIElements.Keybind.Size=
UDim2.new(0,24+ak.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,0,42)
end
)

function ak.Lock(an)
ak.Locked=true
am=false
return ak.KeybindFrame:Lock(ak.LockedTitle)
end
function ak.Unlock(an)
ak.Locked=false
am=true
return ak.KeybindFrame:Unlock()
end

function ak.Set(an,ao)
local ap=NormalizeKeyCode(ao)
ak.Value=ap
ak.UIElements.Keybind.Frame.Frame.TextLabel.Text=ap
end

if ak.Locked then
ak:Lock()
end

local an

ad.AddSignal(ak.KeybindFrame.UIElements.Main.MouseButton1Click,function()
if am then
if ak.CanChange then
ak.Picking=true
ak.UIElements.Keybind.Frame.Frame.TextLabel.Text="..."



local ao
ao=ac.InputBegan:Connect(function(ap)
local aq

if ap.UserInputType==Enum.UserInputType.Keyboard then
if table.find(al,ap.KeyCode)then
aq=nil
return
else
aq=ap.KeyCode.Name
end
elseif
ap.UserInputType==Enum.UserInputType.MouseButton1
and not table.find(al,"MouseLeftButton")
then
aq="MouseLeftButton"
elseif
ap.UserInputType==Enum.UserInputType.MouseButton2
and not table.find(al,"MouseRightButton")
then
aq="MouseRightButton"
end

if an then
an:Disconnect()
end

an=ac.InputEnded:Connect(function(ar)
if
aq
and(
ar.KeyCode.Name==aq
or aq=="MouseLeft"and ar.UserInputType==Enum.UserInputType.MouseButton1
or aq=="MouseRight"and ar.UserInputType==Enum.UserInputType.MouseButton2
)
then
ak.Picking=false

ak.UIElements.Keybind.Frame.Frame.TextLabel.Text=aq
ak.Value=aq

ao:Disconnect()
an:Disconnect()
end
end)
end)
end
end
end)

ad.AddSignal(ac.InputBegan,function(ao,ap)
if ac:GetFocusedTextBox()then
return
end
if not am then
return
end
if ak.Picking then
return
end

if ao.UserInputType==Enum.UserInputType.Keyboard then
if ao.KeyCode.Name==ak.Value then
ad.SafeCallback(ak.Callback,ao.KeyCode.Name)
end
elseif ao.UserInputType==Enum.UserInputType.MouseButton1 and ak.Value=="MouseLeft"then
ad.SafeCallback(ak.Callback,"MouseLeft")
elseif ao.UserInputType==Enum.UserInputType.MouseButton2 and ak.Value=="MouseRight"then
ad.SafeCallback(ak.Callback,"MouseRight")
end
end)

return ak.__type,ak
end

return ag end function a.K()

local aa=a.load'd'
local ac=aa.New local ad=
aa.Tween

local ae={
UICorner=8,
UIPadding=8,
}local af=a.load'm'

.New
local ag=a.load'n'.New

function ae.New(ah,ai)
local aj={
__type="Input",
Title=ai.Title or"Input",
Desc=ai.Desc or nil,
Type=ai.Type or"Input",
Locked=ai.Locked or false,
LockedTitle=ai.LockedTitle,
InputIcon=ai.InputIcon or false,
Placeholder=ai.Placeholder or"Enter Text...",
Value=ai.Value or"",
Callback=ai.Callback or function()end,
ClearTextOnFocus=ai.ClearTextOnFocus or false,
UIElements={},

Width=150,
}

local ak=true

aj.InputFrame=a.load'C'{
Title=aj.Title,
Desc=aj.Desc,
Parent=ai.Parent,
TextOffset=aj.Width,
Hover=false,
Tab=ai.Tab,
Index=ai.Index,
Window=ai.Window,
ElementTable=aj,
ParentConfig=ai,
Tags=ai.Tags,
}

local al=ag(
aj.Placeholder,
aj.InputIcon,
aj.Type=="Textarea"and aj.InputFrame.UIElements.Container or aj.InputFrame.UIElements.Main,
aj.Type,
function(al)
aj:Set(al,true)
end,
nil,
ai.Window.NewElements and 12 or 10,
aj.ClearTextOnFocus
)

if aj.Type=="Input"then
al.Size=UDim2.new(0,aj.Width,0,36)
al.Position=UDim2.new(1,0,ai.Window.NewElements and 0 or 0.5,0)
al.AnchorPoint=Vector2.new(1,ai.Window.NewElements and 0 or 0.5)
else
al.Size=UDim2.new(1,0,0,148)
end

ac("UIScale",{
Parent=al,
Scale=1,
})

function aj.Lock(am)
aj.Locked=true
ak=false
return aj.InputFrame:Lock(aj.LockedTitle)
end
function aj.Unlock(am)
aj.Locked=false
ak=true
return aj.InputFrame:Unlock()
end

function aj.Set(am,an,ao)
if ak then
aj.Value=an
aa.SafeCallback(aj.Callback,an)

if not ao then
al.Frame.Frame.TextBox.Text=an
end
end
end

function aj.SetPlaceholder(am,an)
al.Frame.Frame.TextBox.PlaceholderText=an
aj.Placeholder=an
end

aj:Set(aj.Value)

if aj.Locked then
aj:Lock()
end

return aj.__type,aj
end

return ae end function a.L()

local aa=a.load'd'
local ac=aa.New

local ae={}

function ae.New(af,ag)
local ah=ac("Frame",{
Size=ag.ParentType~="Group"and UDim2.new(1,0,0,1)or UDim2.new(0,1,1,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=.9,
ThemeTag={
BackgroundColor3="Text"
}
})
local ai=ac("Frame",{
Parent=ag.Parent,
Size=ag.ParentType~="Group"and UDim2.new(1,-7,0,7)or UDim2.new(0,7,1,-7),
BackgroundTransparency=1,
},{
ah
})

return"Divider",{__type="Divider",ElementFrame=ai}
end

return ae end function a.M()
local aa={}

local ac=(cloneref or clonereference or function(ac)
return ac
end)

local ae=ac(game:GetService"UserInputService")
local af=ac(game:GetService"Players").LocalPlayer:GetMouse()
local ag=ac(game:GetService"Workspace").CurrentCamera

local ah=workspace.CurrentCamera

local ai=a.load'n'.New

local aj=a.load'd'
local ak=aj.New
local al=aj.Tween

local am=0.67

function aa.New(an,ao,ap,aq,ar)
local as={}

if not ao.Callback then
ar="Menu"
end

ao.UIElements.UIListLayout=ak("UIListLayout",{
Padding=UDim.new(0,ap.MenuPadding/1.5),
FillDirection="Vertical",
HorizontalAlignment="Center",
})

ao.UIElements.Menu=aj.NewRoundFrame(ap.MenuCorner,"Squircle",{
ThemeTag={
ImageColor3="DropdownBackground",
},
ImageTransparency=1,
Size=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,0,0,0),
},{
ak("UIPadding",{
PaddingTop=UDim.new(0,ap.MenuPadding),
PaddingLeft=UDim.new(0,ap.MenuPadding),
PaddingRight=UDim.new(0,ap.MenuPadding),
PaddingBottom=UDim.new(0,ap.MenuPadding),
}),
ak("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,ap.MenuPadding),
}),
ak("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,ao.SearchBarEnabled and-ap.MenuPadding-ap.SearchBarHeight),

ClipsDescendants=true,
LayoutOrder=999,
Name="Frame",
},{
ak("UICorner",{
CornerRadius=UDim.new(0,ap.MenuCorner-ap.MenuPadding),
}),
ak("ScrollingFrame",{
Size=UDim2.new(1,0,1,0),
ScrollBarThickness=0,
ScrollingDirection="Y",
AutomaticCanvasSize="Y",
CanvasSize=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
ScrollBarImageTransparency=1,
},{
ao.UIElements.UIListLayout,
}),
}),
})

ao.UIElements.MenuCanvas=ak("Frame",{
Size=UDim2.new(0,ao.MenuWidth,0,300),
BackgroundTransparency=1,
Position=UDim2.new(-10,0,-10,0),
Visible=false,
Active=false,

Parent=an.WindUI.DropdownGui,
AnchorPoint=Vector2.new(1,0),
},{
ao.UIElements.Menu,
ak("UISizeConstraint",{
MinSize=Vector2.new(170,0),
MaxSize=Vector2.new(300,400),
}),
})

local function RecalculateCanvasSize()
ao.UIElements.Menu.Frame.ScrollingFrame.CanvasSize=
UDim2.fromOffset(0,ao.UIElements.UIListLayout.AbsoluteContentSize.Y)
end

local function RecalculateListSize()
local at=ah.ViewportSize.Y*0.6

local au=ao.UIElements.UIListLayout.AbsoluteContentSize.Y
local av=ao.SearchBarEnabled and(ap.SearchBarHeight+(ap.MenuPadding*3))
or(ap.MenuPadding*2)
local aw=au+av

if aw>at then
ao.UIElements.MenuCanvas.Size=
UDim2.fromOffset(ao.UIElements.MenuCanvas.AbsoluteSize.X,at)
else
ao.UIElements.MenuCanvas.Size=
UDim2.fromOffset(ao.UIElements.MenuCanvas.AbsoluteSize.X,aw)
end
end

function UpdatePosition()
local at=ao.UIElements.Dropdown or ao.DropdownFrame.UIElements.Main
local au=ao.UIElements.MenuCanvas

local av=ag.ViewportSize.Y
-(at.AbsolutePosition.Y+at.AbsoluteSize.Y)
-ap.MenuPadding
-54
local aw=au.AbsoluteSize.Y+ap.MenuPadding

local ax=-54
if av<aw then
ax=aw-av-54
end

au.Position=UDim2.new(
0,
at.AbsolutePosition.X+at.AbsoluteSize.X,
0,
at.AbsolutePosition.Y+at.AbsoluteSize.Y-ax+(ap.MenuPadding*2)
)
end

local at

function as.Display(au)
local av=ao.Values
local aw=""

if ao.Multi then
local ax={}
if typeof(ao.Value)=="table"then
for ay,az in ipairs(ao.Value)do
local aA=typeof(az)=="table"and az.Title or az
ax[aA]=true
end
end

for ay,az in ipairs(av)do
local aA=typeof(az)=="table"and az.Title or az
if ax[aA]then
aw=aw..aA..", "
end
end

if#aw>0 then
aw=aw:sub(1,#aw-2)
end
else
aw=typeof(ao.Value)=="table"and(ao.Value.Title or ao.Value[1])
or ao.Value
or""
end

if ao.UIElements.Dropdown then
ao.UIElements.Dropdown.Frame.Frame.TextLabel.Text=(aw==""and"--"or aw)
end
end

local function Callback(au)
as:Display()
if ao.Callback then
task.spawn(function()
aj.SafeCallback(ao.Callback,ao.Value)
end)
else
task.spawn(function()
aj.SafeCallback(au)
end)
end
end

function as.LockValues(au,av)
if not av then
return
end

for aw,ax in next,ao.Tabs do
if ax and ax.UIElements and ax.UIElements.TabItem then
local ay=ax.Name
local az=false

for aA,aB in next,av do
if ay==aB then
az=true
break
end
end

if az then
al(ax.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()

al(ax.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0.6}):Play()
if ax.UIElements.TabIcon then
al(ax.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0.6}):Play()
end

ax.UIElements.TabItem.Active=false
ax.Locked=true
else
if ax.Selected then
al(ax.UIElements.TabItem,0.1,{ImageTransparency=am}):Play()

al(ax.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if ax.UIElements.TabIcon then
al(ax.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
else
al(ax.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()

al(
ax.UIElements.TabItem.Frame.Title.TextLabel,
0.1,
{TextTransparency=ar=="Dropdown"and 0.4 or 0.05}
):Play()
if ax.UIElements.TabIcon then
al(
ax.UIElements.TabIcon.ImageLabel,
0.1,
{ImageTransparency=ar=="Dropdown"and 0.2 or 0}
):Play()
end
end

ax.UIElements.TabItem.Active=true
ax.Locked=false
end
end
end
end

function as.Refresh(au,av)
if an.Window.Destroyed then
return
end

for aw,ax in next,ao.UIElements.Menu.Frame.ScrollingFrame:GetChildren()do
if not ax:IsA"UIListLayout"then
ax:Destroy()
end
end

ao.Tabs={}

if ao.SearchBarEnabled then
if not at then
at=ai("Search...","search",ao.UIElements.Menu,nil,function(aw)
for ax,ay in next,ao.Tabs do
if string.find(string.lower(ay.Name),string.lower(aw),1,true)then
ay.UIElements.TabItem.Visible=true
else
ay.UIElements.TabItem.Visible=false
end
RecalculateListSize()
RecalculateCanvasSize()
end
end,true)
at.Size=UDim2.new(1,0,0,ap.SearchBarHeight)
at.Position=UDim2.new(0,0,0,0)
at.Name="SearchBar"
end
end

for aw,ax in next,av do
if ax.Type~="Divider"then
local ay={
Name=typeof(ax)=="table"and ax.Title or ax,
Desc=typeof(ax)=="table"and ax.Desc or nil,
Icon=typeof(ax)=="table"and ax.Icon or nil,
IconSize=typeof(ax)=="table"and ax.IconSize or nil,
Original=ax,
Selected=false,
Locked=typeof(ax)=="table"and ax.Locked or false,
UIElements={},
}
local az
if ay.Icon then
az=aj.Image(ay.Icon,ay.Icon,0,an.Window.Folder,"Dropdown",true)
az.Size=
UDim2.new(0,ay.IconSize or ap.TabIcon,0,ay.IconSize or ap.TabIcon)
az.ImageLabel.ImageTransparency=ar=="Dropdown"and 0.2 or 0
ay.UIElements.TabIcon=az
end
ay.UIElements.TabItem=aj.NewRoundFrame(
ap.MenuCorner-ap.MenuPadding,
"Squircle",
{
Size=UDim2.new(1,0,0,36),
AutomaticSize=ay.Desc and"Y",
ImageTransparency=1,
Parent=ao.UIElements.Menu.Frame.ScrollingFrame,

ThemeTag={
ImageColor3="DropdownTabBackground",
},
Active=not ay.Locked,
},
{
aj.NewRoundFrame(ap.MenuCorner-ap.MenuPadding,"Glass-1.4",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="DropdownTabBorder",
},
ImageTransparency=1,
Name="Highlight",
},{













}),
ak("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ak("UIListLayout",{
Padding=UDim.new(0,ap.TabPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ak("UIPadding",{
PaddingTop=UDim.new(0,ap.TabPadding),
PaddingLeft=UDim.new(0,ap.TabPadding),
PaddingRight=UDim.new(0,ap.TabPadding),
PaddingBottom=UDim.new(0,ap.TabPadding),
}),
ak("UICorner",{
CornerRadius=UDim.new(0,ap.MenuCorner-ap.MenuPadding),
}),
az,
ak("Frame",{
Size=UDim2.new(1,az and-ap.TabPadding-ap.TabIcon or 0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Name="Title",
},{
ak("TextLabel",{
Text=ay.Name,
TextXAlignment="Left",
FontFace=Font.new(aj.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
BackgroundColor3="Text",
},
TextSize=15,
BackgroundTransparency=1,
TextTransparency=ar=="Dropdown"and 0.4 or 0.05,
LayoutOrder=999,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
}),
ak("TextLabel",{
Text=ay.Desc or"",
TextXAlignment="Left",
FontFace=Font.new(aj.Font,Enum.FontWeight.Regular),
ThemeTag={
TextColor3="Text",
BackgroundColor3="Text",
},
TextSize=15,
BackgroundTransparency=1,
TextTransparency=ar=="Dropdown"and 0.6 or 0.35,
LayoutOrder=999,
AutomaticSize="Y",
TextWrapped=true,
Size=UDim2.new(1,0,0,0),
Visible=ay.Desc and true or false,
Name="Desc",
}),
ak("UIListLayout",{
Padding=UDim.new(0,ap.TabPadding/3),
FillDirection="Vertical",
}),
}),
}),
},
true
)

if ay.Locked then
ay.UIElements.TabItem.Frame.Title.TextLabel.TextTransparency=0.6
if ay.UIElements.TabIcon then
ay.UIElements.TabIcon.ImageLabel.ImageTransparency=0.6
end
end

if ao.Multi and typeof(ao.Value)=="string"then
for aA,aB in next,ao.Values do
if typeof(aB)=="table"then
if aB.Title==ao.Value then
ao.Value={aB}
end
else
if aB==ao.Value then
ao.Value={ao.Value}
end
end
end
end

if ao.Multi then
local aA=false
if typeof(ao.Value)=="table"then
for aB,b in ipairs(ao.Value)do
local d=typeof(b)=="table"and b.Title or b
if d==ay.Name then
aA=true
break
end
end
end
ay.Selected=aA
else
local aA=typeof(ao.Value)=="table"and ao.Value.Title or ao.Value
ay.Selected=aA==ay.Name
end

if ay.Selected and not ay.Locked then
ay.UIElements.TabItem.ImageTransparency=am

ay.UIElements.TabItem.Frame.Title.TextLabel.TextTransparency=0
if ay.UIElements.TabIcon then
ay.UIElements.TabIcon.ImageLabel.ImageTransparency=0
end
end

ao.Tabs[aw]=ay

as:Display()

if ar=="Dropdown"then
aj.AddSignal(ay.UIElements.TabItem.MouseButton1Click,function()
if ay.Locked then
return
end

if ao.Multi then
if not ay.Selected then
ay.Selected=true
al(
ay.UIElements.TabItem,
0.1,
{ImageTransparency=am}
):Play()

al(ay.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if ay.UIElements.TabIcon then
al(ay.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
table.insert(ao.Value,ay.Original)
else
if not ao.AllowNone and#ao.Value==1 then
return
end
ay.Selected=false
al(ay.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()

al(ay.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0.4}):Play()
if ay.UIElements.TabIcon then
al(ay.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0.2}):Play()
end

for aA,aB in next,ao.Value do
if typeof(aB)=="table"and(aB.Title==ay.Name)or(aB==ay.Name)then
table.remove(ao.Value,aA)
break
end
end
end
else
for aA,aB in next,ao.Tabs do
al(aB.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()

al(
aB.UIElements.TabItem.Frame.Title.TextLabel,
0.1,
{TextTransparency=0.4}
):Play()
if aB.UIElements.TabIcon then
al(aB.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0.2}):Play()
end
aB.Selected=false
end
ay.Selected=true
al(ay.UIElements.TabItem,0.1,{ImageTransparency=am}):Play()

al(ay.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if ay.UIElements.TabIcon then
al(ay.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
ao.Value=ay.Original
end
Callback()
end)
elseif ar=="Menu"then
if not ay.Locked then
aj.AddSignal(ay.UIElements.TabItem.MouseEnter,function()
al(ay.UIElements.TabItem,0.08,{ImageTransparency=am}):Play()
end)
aj.AddSignal(ay.UIElements.TabItem.InputEnded,function()
al(ay.UIElements.TabItem,0.08,{ImageTransparency=1}):Play()
end)
end
aj.AddSignal(ay.UIElements.TabItem.MouseButton1Click,function()
if ay.Locked then
return
end
Callback(ax.Callback or function()end)
end)
end

RecalculateCanvasSize()
RecalculateListSize()
else a.load'L'
:New{Parent=ao.UIElements.Menu.Frame.ScrollingFrame}
end
end










ao.UIElements.MenuCanvas.Size=UDim2.new(
0,
ao.MenuWidth+6+6+5+5+18+6+6,
ao.UIElements.MenuCanvas.Size.Y.Scale,
ao.UIElements.MenuCanvas.Size.Y.Offset
)
Callback()

ao.Values=av
end

as:Refresh(ao.Values)

function as.Select(au,av)
if av then
ao.Value=av
else
if ao.Multi then
ao.Value={}
else
ao.Value=nil
end
end
as:Refresh(ao.Values)
end

RecalculateListSize()
RecalculateCanvasSize()

function as.Open(au)
if aq then
ao.UIElements.Menu.Visible=true
ao.UIElements.MenuCanvas.Visible=true
ao.UIElements.MenuCanvas.Active=true
ao.UIElements.Menu.Size=UDim2.new(1,0,0,0)
al(ao.UIElements.Menu,0.1,{
Size=UDim2.new(1,0,1,0),
ImageTransparency=0,
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(0.1)
ao.Opened=true
end)

UpdatePosition()
end
end

function as.Close(au)
ao.Opened=false

al(ao.UIElements.Menu,0.25,{
Size=UDim2.new(1,0,0,0),
ImageTransparency=1,
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(0.1)
ao.UIElements.Menu.Visible=false
end)

task.spawn(function()
task.wait(0.25)
ao.UIElements.MenuCanvas.Visible=false
ao.UIElements.MenuCanvas.Active=false
end)
end

aj.AddSignal(
(
ao.UIElements.Dropdown and ao.UIElements.Dropdown.MouseButton1Click
or ao.DropdownFrame.UIElements.Main.MouseButton1Click
),
function()
as:Open()
end
)

aj.AddSignal(ae.InputBegan,function(au)
if
au.UserInputType==Enum.UserInputType.MouseButton1
or au.UserInputType==Enum.UserInputType.Touch
then
local av=ao.UIElements.MenuCanvas
local aw,ax=av.AbsolutePosition,av.AbsoluteSize

local ay=ao.UIElements.Dropdown or ao.DropdownFrame.UIElements.Main
local az=ay.AbsolutePosition
local aA=ay.AbsoluteSize

local aB=af.X>=az.X
and af.X<=az.X+aA.X
and af.Y>=az.Y
and af.Y<=az.Y+aA.Y

local b=af.X>=aw.X
and af.X<=aw.X+ax.X
and af.Y>=aw.Y
and af.Y<=aw.Y+ax.Y

if an.Window.CanDropdown and ao.Opened and not aB and not b then
as:Close()
end
end
end)

aj.AddSignal(
ao.UIElements.Dropdown and ao.UIElements.Dropdown:GetPropertyChangedSignal"AbsolutePosition"
or ao.DropdownFrame.UIElements.Main:GetPropertyChangedSignal"AbsolutePosition",
UpdatePosition
)

return as
end

return aa end function a.N()

local aa=(cloneref or clonereference or function(aa)
return aa
end)

aa(game:GetService"UserInputService")
aa(game:GetService"Players").LocalPlayer:GetMouse()local ac=
aa(game:GetService"Workspace").CurrentCamera

local ae=a.load'd'
local af=ae.New local ag=
ae.Tween

local ah=a.load'w'.New local ai=a.load'n'
.New
local aj=a.load'M'.New local ak=

workspace.CurrentCamera

local al={
UICorner=10,
UIPadding=12,
MenuCorner=15,
MenuPadding=5,
TabPadding=10,
SearchBarHeight=39,
TabIcon=18,
}

function al.New(am,an)
local ao={
__type="Dropdown",
Title=an.Title or"Dropdown",
Desc=an.Desc or nil,
Locked=an.Locked or false,
LockedTitle=an.LockedTitle,
Values=an.Values or{},
MenuWidth=an.MenuWidth or 180,
Value=an.Value,
AllowNone=an.AllowNone,
SearchBarEnabled=an.SearchBarEnabled or false,
Multi=an.Multi,
Callback=an.Callback or nil,

UIElements={},

Opened=false,
Tabs={},

Width=150,
}

if ao.Multi and not ao.Value then
ao.Value={}
end
if ao.Values and typeof(ao.Value)=="number"then
ao.Value=ao.Values[ao.Value]
end

local ap=true

ao.DropdownFrame=a.load'C'{
Title=ao.Title,
Desc=ao.Desc,
Parent=an.Parent,
TextOffset=ao.Callback and ao.Width or 20,
Hover=not ao.Callback and true or false,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=ao,
ParentConfig=an,
Tags=an.Tags,
}

if ao.Callback then
ao.UIElements.Dropdown=
ah("",nil,ao.DropdownFrame.UIElements.Main,nil,an.Window.NewElements and 12 or 10)

ao.UIElements.Dropdown.Frame.Frame.TextLabel.TextTruncate="AtEnd"
ao.UIElements.Dropdown.Frame.Frame.TextLabel.Size=
UDim2.new(1,ao.UIElements.Dropdown.Frame.Frame.TextLabel.Size.X.Offset-18-12-12,0,0)

ao.UIElements.Dropdown.Size=UDim2.new(0,ao.Width,0,36)
ao.UIElements.Dropdown.Position=UDim2.new(1,0,an.Window.NewElements and 0 or 0.5,0)
ao.UIElements.Dropdown.AnchorPoint=Vector2.new(1,an.Window.NewElements and 0 or 0.5)





end

ao.DropdownMenu=aj(an,ao,al,ap,"Dropdown")

ao.Display=ao.DropdownMenu.Display
ao.Refresh=ao.DropdownMenu.Refresh
ao.Select=ao.DropdownMenu.Select
ao.Open=ao.DropdownMenu.Open
ao.Close=ao.DropdownMenu.Close

af("ImageLabel",{
Image=ae.Icon"chevrons-up-down"[1],
ImageRectOffset=ae.Icon"chevrons-up-down"[2].ImageRectPosition,
ImageRectSize=ae.Icon"chevrons-up-down"[2].ImageRectSize,
Size=UDim2.new(0,18,0,18),
Position=UDim2.new(1,ao.UIElements.Dropdown and-12 or 0,0.5,0),
ThemeTag={
ImageColor3="Icon",
},
AnchorPoint=Vector2.new(1,0.5),
Parent=ao.UIElements.Dropdown and ao.UIElements.Dropdown.Frame
or ao.DropdownFrame.UIElements.Main,
})

function ao.Lock(aq)
ao.Locked=true
ap=false
return ao.DropdownFrame:Lock(ao.LockedTitle)
end
function ao.Unlock(aq)
ao.Locked=false
ap=true
return ao.DropdownFrame:Unlock()
end

if ao.Locked then
ao:Lock()
end

return ao.__type,ao
end

return al end function a.O()







local aa={}
local ae={
lua={
"and","break","or","else","elseif","if","then","until","repeat","while","do","for","in","end",
"local","return","function","export",
},
rbx={
"game","workspace","script","math","string","table","task","wait","select","next","Enum",
"tick","assert","shared","loadstring","tonumber","tostring","type",
"typeof","unpack","Instance","CFrame","Vector3","Vector2","Color3","UDim","UDim2","Ray","BrickColor",
"OverlapParams","RaycastParams","Axes","Random","Region3","Rect","TweenInfo",
"collectgarbage","not","utf8","pcall","xpcall","_G","setmetatable","getmetatable","os","pairs","ipairs"
},
operators={
"#","+","-","*","%","/","^","=","~","=","<",">",
}
}

local af={
numbers=Color3.fromHex"#FAB387",
boolean=Color3.fromHex"#FAB387",
operator=Color3.fromHex"#94E2D5",
lua=Color3.fromHex"#CBA6F7",
rbx=Color3.fromHex"#F38BA8",
str=Color3.fromHex"#A6E3A1",
comment=Color3.fromHex"#9399B2",
null=Color3.fromHex"#F38BA8",
call=Color3.fromHex"#89B4FA",
self_call=Color3.fromHex"#89B4FA",
local_property=Color3.fromHex"#CBA6F7",
}

local function createKeywordSet(ah)
local aj={}
for ak,al in ipairs(ah)do
aj[al]=true
end
return aj
end

local ah=createKeywordSet(ae.lua)
local aj=createKeywordSet(ae.rbx)
local ak=createKeywordSet(ae.operators)

local function getHighlight(al,am)
local an=al[am]

if af[an.."_color"]then
return af[an.."_color"]
end

if tonumber(an)then
return af.numbers
elseif an=="nil"then
return af.null
elseif an:sub(1,2)=="--"then
return af.comment
elseif ak[an]then
return af.operator
elseif ah[an]then
return af.lua
elseif aj[an]then
return af.rbx
elseif an:sub(1,1)=="\""or an:sub(1,1)=="\'"then
return af.str
elseif an=="true"or an=="false"then
return af.boolean
end

if al[am+1]=="("then
if al[am-1]==":"then
return af.self_call
end

return af.call
end

if al[am-1]=="."then
if al[am-2]=="Enum"then
return af.rbx
end

return af.local_property
end
end

function aa.run(al)
local am={}
local an=""

local ao=false
local ap=false
local aq=false

for ar=1,#al do
local as=al:sub(ar,ar)

if ap then
if as=="\n"and not aq then
table.insert(am,an)
table.insert(am,as)
an=""

ap=false
elseif al:sub(ar-1,ar)=="]]"and aq then
an=an.."]"

table.insert(am,an)
an=""

ap=false
aq=false
else
an=an..as
end
elseif ao then
if as==ao and al:sub(ar-1,ar-1)~="\\"or as=="\n"then
an=an..as
ao=false
else
an=an..as
end
else
if al:sub(ar,ar+1)=="--"then
table.insert(am,an)
an="-"
ap=true
aq=al:sub(ar+2,ar+3)=="[["
elseif as=="\""or as=="\'"then
table.insert(am,an)
an=as
ao=as
elseif ak[as]then
table.insert(am,an)
table.insert(am,as)
an=""
elseif as:match"[%w_]"then
an=an..as
else
table.insert(am,an)
table.insert(am,as)
an=""
end
end
end

table.insert(am,an)

local ar={}

for as,at in ipairs(am)do
local au=getHighlight(am,as)

if au then
local av=string.format("<font color = \"#%s\">%s</font>",au:ToHex(),at:gsub("<","&lt;"):gsub(">","&gt;"))

table.insert(ar,av)
else
table.insert(ar,at)
end
end

return table.concat(ar)
end

return aa end function a.P()
local aa={}

local ae=a.load'd'
local af=ae.New
local ah=ae.Tween

local aj=a.load'O'

function aa.New(ak,al,am,an,ao)
local ap={
Radius=12,
Padding=10
}

local aq=af("TextLabel",{
Text="",
TextColor3=Color3.fromHex"#CDD6F4",
TextTransparency=0,
TextSize=14,
TextWrapped=false,
LineHeight=1.15,
RichText=true,
TextXAlignment="Left",
Size=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
AutomaticSize="XY",
},{
af("UIPadding",{
PaddingTop=UDim.new(0,ap.Padding+3),
PaddingLeft=UDim.new(0,ap.Padding+3),
PaddingRight=UDim.new(0,ap.Padding+3),
PaddingBottom=UDim.new(0,ap.Padding+3),
})
})
aq.Font="Code"

local ar=af("ScrollingFrame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticCanvasSize="X",
ScrollingDirection="X",
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
ScrollBarThickness=0,
},{
aq
})

local as=af("TextButton",{
BackgroundTransparency=1,
Size=UDim2.new(0,30,0,30),
Position=UDim2.new(1,-ap.Padding/2,0,ap.Padding/2),
AnchorPoint=Vector2.new(1,0),
Visible=an and true or false,
},{
ae.NewRoundFrame(ap.Radius-4,"Squircle",{



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=1,
Size=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Button",
},{
af("UIScale",{
Scale=1,
}),
af("ImageLabel",{
Image=ae.Icon"copy"[1],
ImageRectSize=ae.Icon"copy"[2].ImageRectSize,
ImageRectOffset=ae.Icon"copy"[2].ImageRectPosition,
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Size=UDim2.new(0,12,0,12),



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.1,
})
})
})

ae.AddSignal(as.MouseEnter,function()
ah(as.Button,.05,{ImageTransparency=.95}):Play()
ah(as.Button.UIScale,.05,{Scale=.9}):Play()
end)
ae.AddSignal(as.InputEnded,function()
ah(as.Button,.08,{ImageTransparency=1}):Play()
ah(as.Button.UIScale,.08,{Scale=1}):Play()
end)

local at=ae.NewRoundFrame(ap.Radius,"Squircle",{



ImageColor3=Color3.fromHex"#212121",
ImageTransparency=.035,
Size=UDim2.new(1,0,0,20+(ap.Padding*2)),
AutomaticSize="Y",
Parent=am,
},{
ae.NewRoundFrame(ap.Radius,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.955,
}),
af("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
},{
ae.NewRoundFrame(ap.Radius,"Squircle-TL-TR",{



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.96,
Size=UDim2.new(1,0,0,20+(ap.Padding*2)),
Visible=al and true or false
},{
af("ImageLabel",{
Size=UDim2.new(0,18,0,18),
BackgroundTransparency=1,
Image="rbxassetid://132464694294269",



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.2,
}),
af("TextLabel",{
Text=al,



TextColor3=Color3.fromHex"#ffffff",
TextTransparency=.2,
TextSize=16,
AutomaticSize="Y",
FontFace=Font.new(ae.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
BackgroundTransparency=1,
TextTruncate="AtEnd",
Size=UDim2.new(1,as and-20-(ap.Padding*2),0,0)
}),
af("UIPadding",{

PaddingLeft=UDim.new(0,ap.Padding+3),
PaddingRight=UDim.new(0,ap.Padding+3),

}),
af("UIListLayout",{
Padding=UDim.new(0,ap.Padding),
FillDirection="Horizontal",
VerticalAlignment="Center",
})
}),
ar,
af("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
})
}),
as,
})

ap.CodeFrame=at

ae.AddSignal(aq:GetPropertyChangedSignal"TextBounds",function()
ar.Size=UDim2.new(1,0,0,(aq.TextBounds.Y/(ao or 1))+((ap.Padding+3)*2))
end)

function ap.Set(au)
aq.Text=aj.run(au)
end

function ap.Destroy()
at:Destroy()
ap=nil
end

ap.Set(ak)

ae.AddSignal(as.MouseButton1Click,function()
if an then
an()
local au=ae.Icon"check"
as.Button.ImageLabel.Image=au[1]
as.Button.ImageLabel.ImageRectSize=au[2].ImageRectSize
as.Button.ImageLabel.ImageRectOffset=au[2].ImageRectPosition

task.wait(1)
local av=ae.Icon"copy"
as.Button.ImageLabel.Image=av[1]
as.Button.ImageLabel.ImageRectSize=av[2].ImageRectSize
as.Button.ImageLabel.ImageRectOffset=av[2].ImageRectPosition
end
end)
return ap
end


return aa end function a.Q()
local aa=a.load'd'local ae=
aa.New


local af=a.load'P'

local ah={}

function ah.New(aj,ak)
local al={
__type="Code",
Title=ak.Title,
Code=ak.Code,
OnCopy=ak.OnCopy,
}

local am=not al.Locked











local an=af.New(al.Code,al.Title,ak.Parent,function()
if am then
local an=al.Title or"code"
local ao,ap=pcall(function()
toclipboard(al.Code)

if al.OnCopy then al.OnCopy()end
end)
if not ao then
ak.WindUI:Notify{
Title="Error",
Content="The "..an.." is not copied. Error: "..ap,
Icon="x",
Duration=5,
}
end
end
end,ak.WindUI.UIScale,al)

function al.SetCode(ao,ap)
an.Set(ap)
al.Code=ap
end

function al.Set(ao,ap)
return al.SetCode(ap)
end

function al.Destroy(ao)
an.Destroy()
al=nil
end

al.ElementFrame=an.CodeFrame

return al.__type,al
end

return ah end function a.R()
local aa=a.load'd'
local ae=aa.New local af=
aa.Tween

local ah=(cloneref or clonereference or function(ah)
return ah
end)

local aj=ah(game:GetService"UserInputService")
ah(game:GetService"TouchInputService")
local ak=ah(game:GetService"RunService")
local al=ah(game:GetService"Players")local am=

ak.RenderStepped
local an=al.LocalPlayer
local ao=an:GetMouse()

local ap=a.load'm'.New
local aq=a.load'n'.New

local ar={
UICorner=9,

}

local as

function ar.Colorpicker(at,au,av,aw,ax)
local ay={
__type="Colorpicker",
Title=au.Title,
Desc=au.Desc,
Default=au.Value or au.Default,
Callback=au.Callback,
Transparency=au.Transparency,
UIElements=au.UIElements,

TextPadding=10,
}

function ay.SetHSVFromRGB(az,aA)
local aB,b,d=Color3.toHSV(aA)
ay.Hue=aB
ay.Sat=b
ay.Vib=d
end

ay:SetHSVFromRGB(ay.Default)

local az=a.load'o'
local aA=az.Create(nil,"Dialog",av,aw,av.UIElements.Main.Main)

ay.ColorpickerFrame=aA

aA.UIElements.Main.Size=UDim2.new(1,0,0,0)



local aB,b,d=ay.Hue,ay.Sat,ay.Vib

ay.UIElements.Title=ae("TextLabel",{
Text=ay.Title,
TextSize=20,
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
TextXAlignment="Left",
Size=UDim2.new(0,0,0,0),
AutomaticSize="Y",
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
Parent=aA.UIElements.Main,
},{
ae("UIPadding",{
PaddingTop=UDim.new(0,ay.TextPadding/2),
PaddingLeft=UDim.new(0,ay.TextPadding/2),
PaddingRight=UDim.new(0,ay.TextPadding/2),
PaddingBottom=UDim.new(0,ay.TextPadding/2),
}),
})





local f=ae("Frame",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
})

local g=ae("Frame",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
Parent=f,
BackgroundColor3=ay.Default,
},{
ae("UIStroke",{
Thickness=2,
Transparency=0.1,
ThemeTag={
Color="Text",
},
}),
ae("UICorner",{
CornerRadius=UDim.new(1,0),
}),
})

ay.UIElements.SatVibMap=ae("ImageLabel",{
Size=UDim2.fromOffset(160,158),
Position=UDim2.fromOffset(0,40+ay.TextPadding),
Image="rbxassetid://4155801252",
BackgroundColor3=Color3.fromHSV(aB,1,1),
BackgroundTransparency=0,
Parent=aA.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),
aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.85,
ZIndex=99999,
},{
ae("UIGradient",{
Rotation=45,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
},
}),
}),

g,
})

ay.UIElements.Inputs=ae("Frame",{
AutomaticSize="XY",
Size=UDim2.new(0,0,0,0),
Position=UDim2.fromOffset(
ay.Transparency and 240 or 210,
40+ay.TextPadding
),
BackgroundTransparency=1,
Parent=aA.UIElements.Main,
},{
ae("UIListLayout",{
Padding=UDim.new(0,4),
FillDirection="Vertical",
}),
})





local h=ae("Frame",{
BackgroundColor3=ay.Default,
Size=UDim2.fromScale(1,1),
BackgroundTransparency=ay.Transparency,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),
})

ae("ImageLabel",{
Image="http://www.roblox.com/asset/?id=14204231522",
ImageTransparency=0.45,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.fromOffset(40,40),
BackgroundTransparency=1,
Position=UDim2.fromOffset(85,208+ay.TextPadding),
Size=UDim2.fromOffset(75,24),
Parent=aA.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),
aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.85,
ZIndex=99999,
},{
ae("UIGradient",{
Rotation=60,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
},
}),
}),







h,
})

local i=ae("Frame",{
BackgroundColor3=ay.Default,
Size=UDim2.fromScale(1,1),
BackgroundTransparency=0,
ZIndex=9,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),
})

ae("ImageLabel",{
Image="http://www.roblox.com/asset/?id=14204231522",
ImageTransparency=0.45,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.fromOffset(40,40),
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,208+ay.TextPadding),
Size=UDim2.fromOffset(75,24),
Parent=aA.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),







aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.85,
ZIndex=99999,
},{
ae("UIGradient",{
Rotation=60,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
},
}),
}),
i,
})

local l={}

for m=0,1,0.1 do
table.insert(l,ColorSequenceKeypoint.new(m,Color3.fromHSV(m,1,1)))
end

local m=ae("UIGradient",{
Color=ColorSequence.new(l),
Rotation=90,
})

local p=ae("Frame",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
Parent=f,


BackgroundColor3=ay.Default,
},{
ae("UIStroke",{
Thickness=2,
Transparency=0.1,
ThemeTag={
Color="Text",
},
}),
ae("UICorner",{
CornerRadius=UDim.new(1,0),
}),
})

local r=ae("Frame",{
Size=UDim2.fromOffset(6,192),
Position=UDim2.fromOffset(180,40+ay.TextPadding),
Parent=aA.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(1,0),
}),
m,
f,
})

local function CreateNewInput(u,v)
local x=aq(u,nil,ay.UIElements.Inputs,nil,nil,nil,nil,nil,true)

ae("TextLabel",{
BackgroundTransparency=1,
TextTransparency=0.4,
TextSize=17,
FontFace=Font.new(aa.Font,Enum.FontWeight.Regular),
AutomaticSize="XY",
ThemeTag={
TextColor3="Placeholder",
},
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-12,0.5,0),
Parent=x.Frame,
Text=u,
})

ae("UIScale",{
Parent=x,
Scale=0.85,
})

x.Frame.Frame.TextBox.Text=v
x.Size=UDim2.new(0,150,0,42)

return x
end

local function ToRGB(u)
return{
R=math.floor(u.R*255),
G=math.floor(u.G*255),
B=math.floor(u.B*255),
}
end

local u=CreateNewInput("Hex","#"..ay.Default:ToHex())

local v=CreateNewInput("Red",ToRGB(ay.Default).R)
local x=CreateNewInput("Green",ToRGB(ay.Default).G)
local z=CreateNewInput("Blue",ToRGB(ay.Default).B)
local A
if ay.Transparency then
A=CreateNewInput("Alpha",((1-ay.Transparency)*100).."%")
end

local B=ae("Frame",{
Size=UDim2.new(0,0,0,40),
AutomaticSize="Y",
Position=UDim2.new(0,0,0,254+ay.TextPadding),
BackgroundTransparency=1,
Parent=aA.UIElements.Main,
LayoutOrder=4,
},{
ae("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
HorizontalAlignment="Right",
}),






})

aa.AddSignal(aA.UIElements.Main:GetPropertyChangedSignal"AbsoluteSize",function()
ay.UIElements.Title.Size=UDim2.new(
0,
aA.UIElements.Main.AbsoluteSize.X/au.UIScale-(aA.UIPadding*2),
0,
0
)
B.Size=UDim2.new(
0,
aA.UIElements.Main.AbsoluteSize.X/au.UIScale-aA.UIPadding*2,
0,
40
)
end)

local C={
{
Title="Cancel",
Variant="Secondary",
Callback=function()end,
},
{
Title="Apply",

Variant="Primary",
Callback=function()
ax(Color3.fromHSV(ay.Hue,ay.Sat,ay.Vib),ay.Transparency)
end,
},
}

for F,G in next,C do
local H=ap(
G.Title,
G.Icon,
G.Callback,
G.Variant,
B,
aA,
true
)
H.Size=UDim2.new(0.5,-3,0,40)
H.AutomaticSize="None"
end

local F,G,H
if ay.Transparency then
local J=ae("Frame",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.fromOffset(0,0),
BackgroundTransparency=1,
})

G=ae("ImageLabel",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
ThemeTag={
BackgroundColor3="Text",
},
Parent=J,
},{
ae("UIStroke",{
Thickness=2,
Transparency=0.1,
ThemeTag={
Color="Text",
},
}),
ae("UICorner",{
CornerRadius=UDim.new(1,0),
}),
})

H=ae("Frame",{
Size=UDim2.fromScale(1,1),
},{
ae("UIGradient",{
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,1),
},
Rotation=270,
}),
ae("UICorner",{
CornerRadius=UDim.new(0,6),
}),
})

F=ae("Frame",{
Size=UDim2.fromOffset(6,192),
Position=UDim2.fromOffset(210,40+ay.TextPadding),
Parent=aA.UIElements.Main,
BackgroundTransparency=1,
},{
ae("UICorner",{
CornerRadius=UDim.new(1,0),
}),
ae("ImageLabel",{
Image="rbxassetid://14204231522",
ImageTransparency=0.45,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.fromOffset(40,40),
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
},{
ae("UICorner",{
CornerRadius=UDim.new(1,0),
}),
}),
H,
J,
})
end

function ay.Round(J,L,M)
if M==0 then
return math.floor(L)
end
L=tostring(L)
return L:find"%."and tonumber(L:sub(1,L:find"%."+M))or L
end

function ay.Update(J,L,M)
if L then
aB,b,d=Color3.toHSV(L)
else
aB,b,d=ay.Hue,ay.Sat,ay.Vib
end

ay.UIElements.SatVibMap.BackgroundColor3=Color3.fromHSV(aB,1,1)
g.Position=UDim2.new(b,0,1-d,0)
g.BackgroundColor3=Color3.fromHSV(aB,b,d)
i.BackgroundColor3=Color3.fromHSV(aB,b,d)
p.BackgroundColor3=Color3.fromHSV(aB,1,1)
p.Position=UDim2.new(0.5,0,aB,0)

u.Frame.Frame.TextBox.Text="#"..Color3.fromHSV(aB,b,d):ToHex()
v.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(aB,b,d)).R
x.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(aB,b,d)).G
z.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(aB,b,d)).B

if M or ay.Transparency then
i.BackgroundTransparency=ay.Transparency or M
H.BackgroundColor3=Color3.fromHSV(aB,b,d)
G.BackgroundColor3=Color3.fromHSV(aB,b,d)
G.BackgroundTransparency=ay.Transparency or M
G.Position=UDim2.new(0.5,0,1-ay.Transparency or M,0)
A.Frame.Frame.TextBox.Text=ay:Round(
(1-ay.Transparency or M)*100,
0
).."%"
end
end

ay:Update(ay.Default,ay.Transparency)

local function GetRGB()
local J=Color3.fromHSV(ay.Hue,ay.Sat,ay.Vib)
return{R=math.floor(J.r*255),G=math.floor(J.g*255),B=math.floor(J.b*255)}
end



local function clamp(J,L,M)
return math.clamp(tonumber(J)or 0,L,M)
end

aa.AddSignal(u.Frame.Frame.TextBox.FocusLost,function(J)
if J then
local L=u.Frame.Frame.TextBox.Text:gsub("#","")
local M,N=pcall(Color3.fromHex,L)
if M and typeof(N)=="Color3"then
ay.Hue,ay.Sat,ay.Vib=Color3.toHSV(N)
ay:Update()
ay.Default=N
end
end
end)

local function updateColorFromInput(J,L)
aa.AddSignal(J.Frame.Frame.TextBox.FocusLost,function(M)
if M then
local N=J.Frame.Frame.TextBox
local O=GetRGB()
local P=clamp(N.Text,0,255)
N.Text=tostring(P)

O[L]=P
local Q=Color3.fromRGB(O.R,O.G,O.B)
ay.Hue,ay.Sat,ay.Vib=Color3.toHSV(Q)
ay:Update()
end
end)
end

updateColorFromInput(v,"R")
updateColorFromInput(x,"G")
updateColorFromInput(z,"B")

if ay.Transparency then
aa.AddSignal(A.Frame.Frame.TextBox.FocusLost,function(J)
if J then
local L=A.Frame.Frame.TextBox
local M=clamp(L.Text,0,100)
L.Text=tostring(M)

ay.Transparency=1-M*0.01
ay:Update(nil,ay.Transparency)
end
end)
end



local function UpdateSatVib(J,L)
local M=J.AbsolutePosition.X
local N=M+J.AbsoluteSize.X
local O=J.AbsolutePosition.Y
local P=O+J.AbsoluteSize.Y

local Q=math.clamp(ao.X,M,N)
local R=math.clamp(ao.Y,O,P)

L.Sat=(Q-M)/(N-M)
L.Vib=1-((R-O)/(P-O))

L:Update()
end

local function UpdateHue(J,L)
local M=J.AbsolutePosition.Y
local N=M+J.AbsoluteSize.Y

local O=math.clamp(ao.Y,M,N)

L.Hue=(O-M)/(N-M)

L:Update()
end

local function UpdateTransparency(J,L)
local M=J.AbsolutePosition.Y
local N=M+J.AbsoluteSize.Y

local O=math.clamp(ao.Y,M,N)

L.Transparency=1-((O-M)/(N-M))

L:Update()
end

local J=aw.GenerateGUID()

aj.InputChanged:Connect(function(L)
if
L.UserInputType~=Enum.UserInputType.MouseMovement
and L.UserInputType~=Enum.UserInputType.Touch
then
return
end

if as=="SatVib"then
UpdateSatVib(ay.UIElements.SatVibMap,ay)
elseif as=="Hue"then
UpdateHue(r,ay)
elseif as=="Transparency"then
UpdateTransparency(F,ay)
end
end)

ay.UIElements.SatVibMap.InputBegan:Connect(function(L)
if
L.UserInputType~=Enum.UserInputType.MouseButton1
and L.UserInputType~=Enum.UserInputType.Touch
then
return
end

if aw.CurrentInput and aw.CurrentInput~=J then
return
end
aw.CurrentInput=J

if as and as~="SatVib"then
return
end

as="SatVib"

UpdateSatVib(ay.UIElements.SatVibMap,ay)
end)

r.InputBegan:Connect(function(L)
if
L.UserInputType~=Enum.UserInputType.MouseButton1
and L.UserInputType~=Enum.UserInputType.Touch
then
return
end

if aw.CurrentInput and aw.CurrentInput~=J then
return
end
aw.CurrentInput=J

if as and as~="Hue"then
return
end

as="Hue"

UpdateHue(r,ay)
end)

F.InputBegan:Connect(function(L)
if
L.UserInputType~=Enum.UserInputType.MouseButton1
and L.UserInputType~=Enum.UserInputType.Touch
then
return
end

if aw.CurrentInput and aw.CurrentInput~=J then
return
end
aw.CurrentInput=J

if as and as~="Transparency"then
return
end

as="Transparency"

UpdateTransparency(F,ay)
end)

aj.InputEnded:Connect(function(L)
as=nil

if aw.CurrentInput and aw.CurrentInput~=J then
return
end
aw.CurrentInput=nil
end)

return ay
end

function ar.New(at,au)
local av={
__type="Colorpicker",
Title=au.Title or"Colorpicker",
Desc=au.Desc or nil,
Locked=au.Locked or false,
LockedTitle=au.LockedTitle,
Default=au.Default or Color3.new(1,1,1),
Callback=au.Callback or function()end,

UIScale=au.UIScale,
Transparency=au.Transparency,
UIElements={},
}

local aw=true



av.ColorpickerFrame=a.load'C'{
Title=av.Title,
Desc=av.Desc,
Parent=au.Parent,
TextOffset=40,
Hover=false,
Tab=au.Tab,
Index=au.Index,
Window=au.Window,
ElementTable=av,
ParentConfig=au,
Tags=au.Tags,
}

av.UIElements.Colorpicker=aa.NewRoundFrame(ar.UICorner,"Squircle",{
ImageTransparency=0,
Active=true,
ImageColor3=av.Default,
Parent=av.ColorpickerFrame.UIElements.Main,
Size=UDim2.new(0,26,0,26),
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,0,0,0),
ZIndex=2,
},{
aa.NewRoundFrame(ar.UICorner,"SquircleGlass",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Outline",
},
ImageTransparency=0.55,
}),
},true)

function av.Lock(ax)
av.Locked=true
aw=false
return av.ColorpickerFrame:Lock(av.LockedTitle)
end
function av.Unlock(ax)
av.Locked=false
aw=true
return av.ColorpickerFrame:Unlock()
end

if av.Locked then
av:Lock()
end

function av.Update(ax,ay,az)
av.UIElements.Colorpicker.ImageTransparency=az or 0
av.UIElements.Colorpicker.ImageColor3=ay
av.Default=ay
if az then
av.Transparency=az
end
end

function av.Set(ax,ay,az)
return av:Update(ay,az)
end

aa.AddSignal(av.UIElements.Colorpicker.MouseButton1Click,function()
if aw then
ar:Colorpicker(av,au.Window,au.WindUI,function(ax,ay)
av:Update(ax,ay)
av.Default=ax
av.Transparency=ay
aa.SafeCallback(av.Callback,ax,ay)
end).ColorpickerFrame
:Open()
end
end)

return av.__type,av
end

return ar end function a.S()

local aa=a.load'd'
local ae=aa.New
local ah=aa.Tween

local aj={}

function aj.New(ak,al)
local am={
__type="Section",
Title=al.Title or"Section",
Desc=al.Desc,
Icon=al.Icon,
IconThemed=al.IconThemed,
TextXAlignment=al.TextXAlignment or"Left",
TextSize=al.TextSize or 19,
DescTextSize=al.DescTextSize or 16,
Box=al.Box or false,
BoxBorder=al.BoxBorder or false,
FontWeight=al.FontWeight or Enum.FontWeight.SemiBold,
DescFontWeight=al.DescFontWeight or Enum.FontWeight.Medium,
TextTransparency=al.TextTransparency or 0.05,
DescTextTransparency=al.DescTextTransparency or 0.4,
Opened=al.Opened or false,
UIElements={},

HeaderSize=42,
IconSize=20,
Padding=10,

Elements={},

Expandable=false,
}

local an

function am.SetIcon(ao,ap)
am.Icon=ap or nil
if an then
an:Destroy()
end
if ap then
an=aa.Image(
ap,
ap..":"..am.Title,
0,
al.Window.Folder,
am.__type,
true,
am.IconThemed,
"SectionIcon"
)
an.Size=UDim2.new(0,am.IconSize,0,am.IconSize)
end
end

local ao=ae("Frame",{
Size=UDim2.new(0,am.IconSize,0,am.IconSize),
BackgroundTransparency=1,
Visible=false,
},{
ae("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Image=aa.Icon"chevron-down"[1],
ImageRectSize=aa.Icon"chevron-down"[2].ImageRectSize,
ImageRectOffset=aa.Icon"chevron-down"[2].ImageRectPosition,
ThemeTag={
ImageTransparency="SectionExpandIconTransparency",
ImageColor3="SectionExpandIcon",
},
}),
})

if am.Icon then
am:SetIcon(am.Icon)
end

local ap=ae("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ae("UIListLayout",{
FillDirection="Vertical",
HorizontalAlignment=am.TextXAlignment,
VerticalAlignment="Center",
Padding=UDim.new(0,4),
}),
})

local aq,ar

local function createTitle(as,at)
return ae("TextLabel",{
BackgroundTransparency=1,
TextXAlignment=am.TextXAlignment,
AutomaticSize="Y",
TextSize=at=="Title"and am.TextSize or am.DescTextSize,
TextTransparency=at=="Title"and am.TextTransparency or am.DescTextTransparency,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(aa.Font,at=="Title"and am.FontWeight or am.DescFontWeight),


Text=as,
Size=UDim2.new(1,0,0,0),
TextWrapped=true,
Parent=ap,
})
end

aq=createTitle(am.Title,"Title")
if am.Desc then
ar=createTitle(am.Desc,"Desc")
end

local function UpdateTitleSize()
local as=0
if an then
as=as-(am.IconSize+8)
end
if ao.Visible then
as=as-(am.IconSize+8)
end
ap.Size=UDim2.new(1,as,0,0)
end

local as=aa.NewRoundFrame(al.Window.ElementConfig.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
Parent=al.Parent,
ClipsDescendants=true,
AutomaticSize="Y",
ThemeTag={
ImageTransparency=am.Box and"SectionBoxBackgroundTransparency"or nil,
ImageColor3="SectionBoxBackground",
},
ImageTransparency=not am.Box and 1 or nil,
},{
aa.NewRoundFrame(
al.Window.ElementConfig.UICorner,
al.Window.NewElements and"Glass-1"or"SquircleOutline",
{
Size=UDim2.new(1,0,1,0),

ThemeTag={
ImageTransparency="SectionBoxBorderTransparency",
ImageColor3="SectionBoxBorder",
},
Visible=am.Box and am.BoxBorder,
Name="Outline",
}
),
ae("TextButton",{
Size=UDim2.new(1,0,0,am.Expandable and 0 or(not ar and am.HeaderSize or 0)),
BackgroundTransparency=1,
AutomaticSize=(not am.Expandable or ar)and"Y"or nil,
Text="",
Name="Top",
},{
am.Box and ae("UIPadding",{
PaddingTop=UDim.new(
0,
al.Window.ElementConfig.UIPadding+(al.Window.NewElements and 4 or 0)
),
PaddingLeft=UDim.new(
0,
al.Window.ElementConfig.UIPadding+(al.Window.NewElements and 4 or 0)
),
PaddingRight=UDim.new(
0,
al.Window.ElementConfig.UIPadding+(al.Window.NewElements and 4 or 0)
),
PaddingBottom=UDim.new(
0,
al.Window.ElementConfig.UIPadding+(al.Window.NewElements and 4 or 0)
),
})or nil,
an,
ap,
ae("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
ao,
}),
ae("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
Name="Content",
Visible=false,
Position=UDim2.new(0,0,0,am.HeaderSize),
},{
am.Box and ae("UIPadding",{
PaddingLeft=UDim.new(0,al.Window.ElementConfig.UIPadding),
PaddingRight=UDim.new(0,al.Window.ElementConfig.UIPadding),
PaddingBottom=UDim.new(0,al.Window.ElementConfig.UIPadding),
})or nil,
ae("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,al.Tab.Gap),
VerticalAlignment="Top",
}),
}),
})





am.ElementFrame=as

if ar then
as.Top:GetPropertyChangedSignal"AbsoluteSize":Connect(function()
as.Content.Position=UDim2.new(0,0,0,as.Top.AbsoluteSize.Y/al.UIScale)

if am.Opened then
am:Open(true)
else
am.Close(true)
end
end)
end

local at=al.ElementsModule

at.Load(am,as.Content,at.Elements,al.Window,al.WindUI,function()
if not am.Expandable then
am.Expandable=true
ao.Visible=true
UpdateTitleSize()
end
end,at,al.UIScale,al.Tab)

UpdateTitleSize()

function am.SetTitle(au,av)
am.Title=av
aq.Text=av
end

function am.SetDesc(au,av)
am.Desc=av
if not ar then
ar=createTitle(av,"Desc")
end
ar.Text=av
end

function am.Destroy(au)
for av,aw in next,am.Elements do
aw:Destroy()
end








as:Destroy()
end

function am.Open(au,av)
if am.Expandable then
am.Opened=true
if av then
as.Size=UDim2.new(
as.Size.X.Scale,
as.Size.X.Offset,
0,
as.Top.AbsoluteSize.Y/al.UIScale+(as.Content.AbsoluteSize.Y/al.UIScale)
)
ao.ImageLabel.Rotation=180
else
ah(as,0.33,{
Size=UDim2.new(
as.Size.X.Scale,
as.Size.X.Offset,
0,
as.Top.AbsoluteSize.Y/al.UIScale+(as.Content.AbsoluteSize.Y/al.UIScale)
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

ah(
ao.ImageLabel,
0.2,
{Rotation=180},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
end
end
end
function am.Close(au,av)
if am.Expandable then
am.Opened=false
if av then
as.Size=
UDim2.new(as.Size.X.Scale,as.Size.X.Offset,0,(as.Top.AbsoluteSize.Y/al.UIScale))
ao.ImageLabel.Rotation=0
else
ah(as,0.26,{
Size=UDim2.new(
as.Size.X.Scale,
as.Size.X.Offset,
0,
(as.Top.AbsoluteSize.Y/al.UIScale)
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ah(
ao.ImageLabel,
0.2,
{Rotation=0},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
end
end
end

aa.AddSignal(as.Top.MouseButton1Click,function()
if am.Expandable then
if am.Opened then
am:Close()
else
am:Open()
end
end
end)

aa.AddSignal(as.Content.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()
if am.Opened then
am:Open(true)
else
am:Close(true)
end
end)

task.spawn(function()
task.wait(0.02)
if am.Expandable then








as.Size=UDim2.new(as.Size.X.Scale,as.Size.X.Offset,0,as.Top.AbsoluteSize.Y/al.UIScale)
as.AutomaticSize="None"
as.Top.Size=UDim2.new(1,0,0,(not ar and am.HeaderSize or 0))
as.Top.AutomaticSize=(not am.Expandable or ar)and"Y"or"None"
as.Content.Visible=true
end
if am.Opened then
am:Open()
else
am:Close(true)
end
end)

return am.__type,am
end

return aj end function a.T()

local aa=a.load'd'
local ae=aa.New

local ah={}

function ah.New(aj,ak)
local al=ae("Frame",{
Parent=ak.Parent,
Size=not table.find({"Group","HStack"},ak.ParentType)and UDim2.new(1,-7,0,7*(ak.Columns or 1))or UDim2.new(0,7*(ak.Columns or 1),0,0),
BackgroundTransparency=1,
})

return"Space",{__type="Space",ElementFrame=al}
end

return ah end function a.U()
local aa=a.load'd'
local ae=aa.New

local ah={}

local function ParseAspectRatio(aj)
if type(aj)=="string"then
local ak,al=aj:match"(%d+):(%d+)"
if ak and al then
return tonumber(ak)/tonumber(al)
end
elseif type(aj)=="number"then
return aj
end
return nil
end

function ah.New(aj,ak)
local al={
__type="Image",
Image=ak.Image or"",
AspectRatio=ak.AspectRatio or"16:9",
Radius=ak.Radius or ak.Window.ElementConfig.UICorner,
}
local am=aa.Image(
al.Image,
al.Image,
al.Radius,
ak.Window.Folder,
"Image",
false
)
if am and am.Parent then
am.Parent=ak.Parent
am.Size=UDim2.new(1,0,0,0)
am.BackgroundTransparency=1












local an=ParseAspectRatio(al.AspectRatio)
local ao

if an then
ao=ae("UIAspectRatioConstraint",{
Parent=am,
AspectRatio=an,
AspectType="ScaleWithParentSize",
DominantAxis="Width"
})
end

function al.Destroy(ap)
am:Destroy()
end
end

return al.__type,al
end

return ah end function a.V()
local aa=a.load'd'
local ae=aa.New

local ah={}

function ah.New(aj,ak)
local al={
__type="Group",
Elements={},
ElementFrame=nil,
}

local am=ae("Frame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=ak.Parent,
},{
ae("UIListLayout",{
FillDirection="Horizontal",
HorizontalAlignment="Center",

Padding=UDim.new(0,ak.Tab and ak.Tab.Gap or(ak.Window.NewElements and 1 or 6))
}),
})

al.ElementFrame=am

local an=ak.ElementsModule
an.Load(
al,
am,
an.Elements,
ak.Window,
ak.WindUI,
function(ao,ap)
local aq=ak.Tab and ak.Tab.Gap or(ak.Window.NewElements and 1 or 6)

local ar={}
local as=0

for at,au in next,ap do
if au.__type=="Space"then
as=as+(au.ElementFrame.Size.X.Offset or 6)
elseif au.__type=="Divider"then
as=as+(au.ElementFrame.Size.X.Offset or 1)
else
table.insert(ar,au)
end
end

local at=#ar
if at==0 then return end

local au=1/at

local av=aq*(at-1)

local aw=-(av+as)

local ax=math.floor(aw/at)
local ay=aw-(ax*at)

for az,aA in next,ar do
local aB=ax
if az<=math.abs(ay)then
aB=aB-1
end

if aA.ElementFrame then
aA.ElementFrame.Size=UDim2.new(au,aB,1,0)
end
end
end,
an,
ak.UIScale,
ak.Tab
)



return al.__type,al
end

return ah end function a.W()
local aa=a.load'd'
local ae=aa.New

local ah={}

function ah.New(aj,ak)
local al={
__type="HStack",
AutoSpace=ak.AutoSpace or false,
Elements={},
ElementFrame=nil,
}

local am=ae("Frame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=ak.Parent,
},{
ae("UIListLayout",{
FillDirection="Horizontal",
HorizontalAlignment="Center",

Padding=UDim.new(0,ak.Tab and ak.Tab.Gap or(ak.Window.NewElements and 1 or 6)),
}),
})

al.ElementFrame=am

local an=ak.ElementsModule
an.Load(
al,
am,
an.Elements,
ak.Window,
ak.WindUI,
function(ao,ap)
local aq=ak.Tab and ak.Tab.Gap or(ak.Window.NewElements and 1 or 6)

local ar={}
local as=0

for at,au in next,ap do
if au.__type=="Space"then
as=as+(au.ElementFrame.Size.X.Offset or 6)
elseif au.__type=="Divider"then
as=as+(au.ElementFrame.Size.X.Offset or 1)
else
table.insert(ar,au)
end
end

local at=#ar
if at==0 then
return
end

local au=1/at

local av=aq*(at-1)

local aw=-(av+as)

local ax=math.floor(aw/at)
local ay=aw-(ax*at)

for az,aA in next,ar do
local aB=ax
if az<=math.abs(ay)then
aB=aB-1
end

if aA.ElementFrame then
aA.ElementFrame.Size=UDim2.new(au,aB,1,0)
end
end
end,
an,
ak.UIScale,
ak.Tab
)

if al.AutoSpace then
for ao in next,an.Elements do
if ao~="Space"and ao~="Divider"then
local ap=al[ao]
al[ao]=function(aq,ar)
if#al.Elements>0 then
al:Space()
end
return ap(aq,ar)
end
end
end
end

return al.__type,al
end

return ah end function a.X()

local aa=a.load'd'
local ae=aa.New

local ah={}

function ah.New(aj,ak)
local al={
__type="VStack",
Elements={},
ElementFrame=nil,
}

local am=ae("Frame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=ak.Parent,
},{
ae("UIListLayout",{
FillDirection="Vertical",
HorizontalAlignment="Center",

Padding=UDim.new(0,ak.Tab and ak.Tab.Gap or(ak.Window.NewElements and 1 or 6))
}),
})

al.ElementFrame=am

local an=ak.ElementsModule
an.Load(
al,
am,
an.Elements,
ak.Window,
ak.WindUI,







































nil,
an,
ak.UIScale,
ak.Tab
)



return al.__type,al
end

return ah end function a.Y()
local aa=(cloneref or clonereference or function(aa)
return aa
end)

local ae=aa(game:GetService"UserInputService")

local ah=a.load'd'
local aj=ah.New

local ak={}













function ak.New(al,am:ConfigType__DARKLUA_TYPE_a)
local an={
__type="Viewport",
Object=am.Object,
Camera=am.Camera or Instance.new"Camera",
Interactive=am.Interactive or false,
Height=am.Height or 200,
Focused=am.Focused~=false,
}

local ao=false
local ap=false
local aq,ar=0

local as=ah.NewRoundFrame(am.Window.ElementConfig.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,an.Height),
Parent=am.Parent,
ThemeTag={
ImageColor3="ViewportBackground",
ImageTransparency="ViewportBackgroundTransparency",
},
},{
aj("CanvasGroup",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
aj("UICorner",{
CornerRadius=UDim.new(0,am.Window.ElementConfig.UICorner),
}),
aj("ViewportFrame",{
Name="Viewport",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
CurrentCamera=an.Camera,
Active=an.Interactive,
},{
an.Object,
}),
}),
})

ah.AddSignal(as.CanvasGroup.Viewport.MouseEnter,function()
if an.Interactive then
am.Tab.UIElements.ContainerFrame.ScrollingEnabled=false
end
end)

ah.AddSignal(as.CanvasGroup.Viewport.InputEnded,function(at)
if
at.UserInputType==Enum.UserInputType.MouseMovement
or at.UserInputType==Enum.UserInputType.Touch
then
am.Tab.UIElements.ContainerFrame.ScrollingEnabled=true
end
end)

ah.AddSignal(as.CanvasGroup.Viewport.InputBegan,function(at)
if an.Interactive then
if
(at.UserInputType==Enum.UserInputType.MouseButton1)
or(at.UserInputType==Enum.UserInputType.Touch and not ap)
then
ao=true
ar=at.Position
end
end
end)

ah.AddSignal(ae.InputEnded,function(at)
if an.Interactive then
if
at.UserInputType==Enum.UserInputType.MouseButton1
or at.UserInputType==Enum.UserInputType.Touch
then
ao=false
end
end
end)

ah.AddSignal(ae.InputChanged,function(at)
if an.Interactive and ao and not ap then
if
at.UserInputType==Enum.UserInputType.MouseMovement
or at.UserInputType==Enum.UserInputType.Touch
then
local au=at.Position-ar
ar=at.Position

local av=an.Object:GetPivot().Position
local aw=an.Camera

local ax=CFrame.fromAxisAngle(Vector3.new(0,1,0),-au.X*0.02)
aw.CFrame=CFrame.new(av)*ax*CFrame.new(-av)*aw.CFrame

local ay=CFrame.fromAxisAngle(aw.CFrame.RightVector,-au.Y*0.02)
local az=CFrame.new(av)*ay*CFrame.new(-av)*aw.CFrame

if az.UpVector.Y>0.1 then
aw.CFrame=az
end
end
end
end)

ah.AddSignal(as.CanvasGroup.Viewport.InputChanged,function(at)
if an.Interactive then
if at.UserInputType==Enum.UserInputType.MouseWheel then
local au=at.Position.Z*2
an.Camera.CFrame+=an.Camera.CFrame.LookVector*au
end
end
end)

ah.AddSignal(ae.TouchPinch,function(at,au,av,aw)
if an.Interactive then
if aw==Enum.UserInputState.Begin then
ap=true
ao=false
aq=(at[1]-at[2]).Magnitude
elseif aw==Enum.UserInputState.Change then
local ax=(at[1]-at[2]).Magnitude
local ay=(ax-aq)*0.03
aq=ax
an.Camera.CFrame+=an.Camera.CFrame.LookVector*ay
elseif aw==Enum.UserInputState.End or aw==Enum.UserInputState.Cancel then
ap=false
end
end
end)

local function FocusCamera()
local at=an.Object:IsA"BasePart"and an.Object.Size
or select(2,an.Object:GetBoundingBox(0))
local au=math.max(at.X,at.Y,at.Z)
local av=au*2
local aw=an.Object:GetPivot().Position

an.Camera.CFrame=
CFrame.new(aw+Vector3.new(0,au/2,av),aw)
end

if an.Focused then
FocusCamera()
end

function an.SetObject(at,au,av)
if av then
au=au:Clone()
end
if an.Object then
an.Object:Destroy()
end

an.Object=au
an.Object.Parent=as.CanvasGroup.Viewport
end

function an.SetHeight(at,au)
as.Size=UDim2.new(1,0,0,au)
end

function an.Focus(at)
if an.Object then
FocusCamera()
end
end

function an.SetCamera(at,au)
an.Camera=au
as.CanvasGroup.Viewport.CurrentCamera=au
end

function an.SetInteractive(at,au)
an.Interactive=au
as.CanvasGroup.Viewport.Active=au
end

an.Main=as

return an.__type,an
end

return ak end function a.Z()

return{
Elements={
Paragraph=a.load'D',
Button=a.load'E',
Toggle=a.load'H',
Slider=a.load'I',
Keybind=a.load'J',
Input=a.load'K',
Dropdown=a.load'N',
Code=a.load'Q',
Colorpicker=a.load'R',
Section=a.load'S',
Divider=a.load'L',
Space=a.load'T',
Image=a.load'U',
Group=a.load'V',
HStack=a.load'W',
VStack=a.load'X',
Viewport=a.load'Y',

},
Load=function(aa,ae,ah,aj,ak,al,am,an,ao)
for ap,aq in next,ah do
aa[ap]=function(ar,as)
as=as or{}
as.Tab=ao or aa
as.ParentType=aa.__type
as.ParentTable=aa
as.Index=#aa.Elements+1
as.GlobalIndex=#aj.AllElements+1
as.Parent=ae
as.Window=aj
as.WindUI=ak
as.UIScale=an
as.ElementsModule=am local

at, au=aq:New(as)

if as.Flag and typeof(as.Flag)=="string"then
if aj.CurrentConfig then
aj.CurrentConfig:Register(as.Flag,au)

if aj.PendingConfigData and aj.PendingConfigData[as.Flag]then
local av=aj.PendingConfigData[as.Flag]

local aw=aj.ConfigManager
if aw.Parser[av.__type]then
task.defer(function()
local ax,ay=pcall(function()
aw.Parser[av.__type].Load(au,av)
end)

if ax then
aj.PendingConfigData[as.Flag]=nil
else
warn(
"[ WindUI ] Failed to apply pending config for '"
..as.Flag
.."': "
..tostring(ay)
)
end
end)
end
end
else
aj.PendingFlags=aj.PendingFlags or{}
aj.PendingFlags[as.Flag]=au
end
end

local av
for aw,ax in next,au do
if typeof(ax)=="table"and aw~="ElementFrame"and aw:match"Frame$"then
av=ax
break
end
end

if av then
au.ElementFrame=av.UIElements.Main
function au.SetTitle(aw,ax)
return av.SetTitle and av:SetTitle(ax)
end
function au.SetDesc(aw,ax)
return av.SetDesc and av:SetDesc(ax)
end
function au.SetImage(aw,ax,ay)
return av.SetImage and av:SetImage(ax,ay)
end
function au.SetThumbnail(aw,ax,ay)
return av.SetThumbnail and av:SetThumbnail(ax,ay)
end
function au.Highlight(aw)
av:Highlight()
end
function au.Destroy(aw)
av:Destroy()

table.remove(aj.AllElements,as.GlobalIndex)
table.remove(aa.Elements,as.Index)
table.remove(ao.Elements,as.Index)
aa:UpdateAllElementShapes(aa)
end
end

aj.AllElements[as.Index]=au
aa.Elements[as.Index]=au
if ao then
ao.Elements[as.Index]=au
end

if aj.NewElements then
aa:UpdateAllElementShapes(aa)
end

if al then
al(au,aa.Elements)
end
return au
end
end
function aa.UpdateAllElementShapes(ap,aq)
for ar,as in next,aq.Elements do
local at
for au,av in pairs(as)do
if typeof(av)=="table"and au:match"Frame$"then
at=av
break
end
end

if at then

at.Index=ar
if at.UpdateShape then

at.UpdateShape(aq)
end
end
end
end
end,
}end function a._()

local aa=(cloneref or clonereference or function(aa)
return aa
end)

local ae=game:GetService"Players"

aa(game:GetService"UserInputService")
local ah=ae.LocalPlayer:GetMouse()

local aj=a.load'd'
local ak=aj.New

local al=a.load'B'.New
local am=a.load'x'.New



local an={


Tabs={},
Containers={},
SelectedTab=nil,
TabCount=0,
ToolTipParent=nil,
TabHighlight=nil,

OnChangeFunc=function(an)end,
}

function an.Init(ao,ap,aq,ar)
Window=ao
WindUI=ap
an.ToolTipParent=aq
an.TabHighlight=ar
return an
end

function an.New(ao,ap)
local aq={
__type="Tab",
Title=ao.Title or"Tab",
Desc=ao.Desc,
Icon=ao.Icon,
IconColor=ao.IconColor,
IconShape=ao.IconShape,
IconThemed=ao.IconThemed,
Locked=ao.Locked,
ShowTabTitle=ao.ShowTabTitle,
TabTitleAlign=ao.TabTitleAlign or"Left",
CustomEmptyPage=(ao.CustomEmptyPage and next(ao.CustomEmptyPage)~=nil)and ao.CustomEmptyPage
or{Icon="lucide:frown",IconSize=48,Title="This tab is Empty",Desc=nil},
Border=ao.Border,
Selected=false,
Index=nil,
Parent=ao.Parent,
UIElements={},
Elements={},
ContainerFrame=nil,
UICorner=Window.UICorner-(Window.UIPadding/2),

Gap=Window.NewElements and 1 or 6,

TabPaddingX=4+(Window.UIPadding/2),
TabPaddingY=3+(Window.UIPadding/2),
TitlePaddingY=0,
}









if aq.IconShape then
aq.TabPaddingX=2+(Window.UIPadding/4)
aq.TabPaddingY=2+(Window.UIPadding/4)
aq.TitlePaddingY=2+(Window.UIPadding/4)
end

an.TabCount=an.TabCount+1

local ar=an.TabCount
aq.Index=ar

aq.UIElements.Main=aj.NewRoundFrame(aq.UICorner,"Squircle",{
BackgroundTransparency=1,
Size=UDim2.new(1,-7,0,0),
AutomaticSize="Y",
Parent=ao.Parent,
ThemeTag={
ImageColor3="TabBackground",
},
ImageTransparency=1,
},{
aj.NewRoundFrame(aq.UICorner,"Glass-1.4",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="TabBorder",
},
ImageTransparency=1,
Name="Outline",
},{













}),
aj.NewRoundFrame(aq.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Frame",
},{
ak("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,2+(Window.UIPadding/2)),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ak("TextLabel",{
Text=aq.Title,
ThemeTag={
TextColor3="TabTitle",
},
TextTransparency=not aq.Locked and 0.4 or 0.7,
TextSize=15,
Size=UDim2.new(1,0,0,0),
FontFace=Font.new(aj.Font,Enum.FontWeight.Medium),
TextWrapped=true,
RichText=true,
AutomaticSize="Y",
LayoutOrder=2,
TextXAlignment="Left",
BackgroundTransparency=1,
},{
ak("UIPadding",{
PaddingTop=UDim.new(0,aq.TitlePaddingY),


PaddingBottom=UDim.new(0,aq.TitlePaddingY),
}),
}),
ak("UIPadding",{
PaddingTop=UDim.new(0,aq.TabPaddingY),
PaddingLeft=UDim.new(0,aq.TabPaddingX),
PaddingRight=UDim.new(0,aq.TabPaddingX),
PaddingBottom=UDim.new(0,aq.TabPaddingY),
}),
}),
},true)

local as=0
local at
local au

if aq.Icon then
at=aj.Image(
aq.Icon,
aq.Icon..":"..aq.Title,
0,
Window.Folder,
aq.__type,
aq.IconColor and false or true,
aq.IconThemed,
"TabIcon"
)
at.Size=UDim2.new(0,16,0,16)
if aq.IconColor then
at.ImageLabel.ImageColor3=aq.IconColor
end
if not aq.IconShape then
at.Parent=aq.UIElements.Main.Frame
aq.UIElements.Icon=at
at.ImageLabel.ImageTransparency=not aq.Locked and 0 or 0.7
as=-18-(Window.UIPadding/2)
aq.UIElements.Main.Frame.TextLabel.Size=UDim2.new(1,as,0,0)
elseif aq.IconColor then
aj.NewRoundFrame(
aq.IconShape~="Circle"and(aq.UICorner+5-(2+(Window.UIPadding/4)))or 9999,
"Squircle",
{
Size=UDim2.new(0,26,0,26),
ImageColor3=aq.IconColor,
Parent=aq.UIElements.Main.Frame,
},
{
at,
aj.NewRoundFrame(
aq.IconShape~="Circle"and(aq.UICorner+5-(2+(Window.UIPadding/4)))or 9999,
"Glass-1.4",
{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="White",
},
ImageTransparency=0,
Name="Outline",
},
{













}
),
}
)
at.AnchorPoint=Vector2.new(0.5,0.5)
at.Position=UDim2.new(0.5,0,0.5,0)
at.ImageLabel.ImageTransparency=0
at.ImageLabel.ImageColor3=aj.GetTextColorForHSB(aq.IconColor,0.68)
as=-28-(Window.UIPadding/2)
aq.UIElements.Main.Frame.TextLabel.Size=UDim2.new(1,as,0,0)
end

au=
aj.Image(aq.Icon,aq.Icon..":"..aq.Title,0,Window.Folder,aq.__type,true,aq.IconThemed)
au.Size=UDim2.new(0,16,0,16)
au.ImageLabel.ImageTransparency=not aq.Locked and 0 or 0.7
as=-30




end

aq.UIElements.ContainerFrame=ak("ScrollingFrame",{
Size=UDim2.new(1,0,1,aq.ShowTabTitle and-((Window.UIPadding*2.4)+12)or 0),
BackgroundTransparency=1,
ScrollBarThickness=0,
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
AnchorPoint=Vector2.new(0,1),
Position=UDim2.new(0,0,1,0),
AutomaticCanvasSize="Y",

ScrollingDirection="Y",
},{
ak("UIPadding",{
PaddingTop=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingLeft=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingRight=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingBottom=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
}),
ak("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,aq.Gap),
HorizontalAlignment="Center",
}),
})





aq.UIElements.ContainerFrameCanvas=ak("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Visible=false,
Parent=Window.UIElements.MainBar,
ZIndex=5,
},{
aq.UIElements.ContainerFrame,
ak("Frame",{
Size=UDim2.new(1,0,0,((Window.UIPadding*2.4)+12)),
BackgroundTransparency=1,
Visible=aq.ShowTabTitle or false,
Name="TabTitle",
},{
au,
ak("TextLabel",{
Text=aq.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=20,
TextTransparency=0.1,
Size=UDim2.new(0,0,1,0),
FontFace=Font.new(aj.Font,Enum.FontWeight.SemiBold),

RichText=true,
LayoutOrder=2,
TextXAlignment="Left",
BackgroundTransparency=1,
AutomaticSize="X",
}),
ak("UIPadding",{
PaddingTop=UDim.new(0,20),
PaddingLeft=UDim.new(0,20),
PaddingRight=UDim.new(0,20),
PaddingBottom=UDim.new(0,20),
}),
ak("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment=aq.TabTitleAlign,
}),
}),
ak("Frame",{
Size=UDim2.new(1,0,0,1),
BackgroundTransparency=0.9,
ThemeTag={
BackgroundColor3="Text",
},
Position=UDim2.new(0,0,0,((Window.UIPadding*2.4)+12)),
Visible=aq.ShowTabTitle or false,
}),
})

an.Containers[ar]=aq.UIElements.ContainerFrameCanvas
an.Tabs[ar]=aq

aq.ContainerFrame=aq.UIElements.ContainerFrameCanvas

aj.AddSignal(aq.UIElements.Main.MouseButton1Click,function()
if not aq.Locked then
an:SelectTab(ar)
end
end)

if Window.ScrollBarEnabled then
am(aq.UIElements.ContainerFrame,aq.UIElements.ContainerFrameCanvas,Window,3)
end

local av
local aw
local ax
local ay=false


if aq.Desc then
aj.AddSignal(aq.UIElements.Main.InputBegan,function()
ay=true
aw=task.spawn(function()
task.wait(0.35)
if ay and not av then
av=al(aq.Desc,an.ToolTipParent,true)
av.Container.AnchorPoint=Vector2.new(0.5,0.5)

local function updatePosition()
if av then
av.Container.Position=UDim2.new(0,ah.X,0,ah.Y-4)
end
end

updatePosition()
ax=ah.Move:Connect(updatePosition)
av:Open()
end
end)
end)
end

aj.AddSignal(aq.UIElements.Main.MouseEnter,function()
if not aq.Locked then
aj.SetThemeTag(aq.UIElements.Main.Frame,{
ImageTransparency="TabBackgroundHoverTransparency",
ImageColor3="TabBackgroundHover",
},0.1)
end
end)
aj.AddSignal(aq.UIElements.Main.InputEnded,function()
if aq.Desc then
ay=false
if aw then
task.cancel(aw)
aw=nil
end
if ax then
ax:Disconnect()
ax=nil
end
if av then
av:Close()
av=nil
end
end

if not aq.Locked then
aj.SetThemeTag(aq.UIElements.Main.Frame,{
ImageTransparency="TabBorderTransparency",
},0.1)
end
end)

function aq.ScrollToTheElement(az,aA)
aq.UIElements.ContainerFrame.ScrollingEnabled=false

aj.Tween(aq.UIElements.ContainerFrame,0.45,{
CanvasPosition=Vector2.new(
0,
aq.Elements[aA].ElementFrame.AbsolutePosition.Y
-aq.UIElements.ContainerFrame.AbsolutePosition.Y
-aq.UIElements.ContainerFrame.UIPadding.PaddingTop.Offset
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(0.48)

if aq.Elements[aA].Highlight then
aq.Elements[aA]:Highlight()
end
aq.UIElements.ContainerFrame.ScrollingEnabled=true
end)

return aq
end



local az=a.load'Z'

az.Load(
aq,
aq.UIElements.ContainerFrame,
az.Elements,
Window,
WindUI,
nil,
az,
ap,
aq
)

function aq.LockAll(aA)

for aB,b in next,Window.AllElements do
if b.Tab and b.Tab.Index and b.Tab.Index==aq.Index and b.Lock then
b:Lock()
end
end
end
function aq.UnlockAll(aA)
for aB,b in next,Window.AllElements do
if b.Tab and b.Tab.Index and b.Tab.Index==aq.Index and b.Unlock then
b:Unlock()
end
end
end
function aq.GetLocked(aA)
local aB={}

for b,d in next,Window.AllElements do
if d.Tab and d.Tab.Index and d.Tab.Index==aq.Index and d.Locked==true then
table.insert(aB,d)
end
end

return aB
end
function aq.GetUnlocked(aA)
local aB={}

for b,d in next,Window.AllElements do
if d.Tab and d.Tab.Index and d.Tab.Index==aq.Index and d.Locked==false then
table.insert(aB,d)
end
end

return aB
end

function aq.Select(aA)
return an:SelectTab(aq.Index)
end

task.spawn(function()
local aA
if aq.CustomEmptyPage.Icon then
aA=
aj.Image(aq.CustomEmptyPage.Icon,aq.CustomEmptyPage.Icon,0,"Temp","EmptyPage",true)
aA.Size=
UDim2.fromOffset(aq.CustomEmptyPage.IconSize or 48,aq.CustomEmptyPage.IconSize or 48)
end

local aB=ak("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,-Window.UIElements.Main.Main.Topbar.AbsoluteSize.Y),
Parent=aq.UIElements.ContainerFrame,
},{
ak("UIListLayout",{
Padding=UDim.new(0,8),
SortOrder="LayoutOrder",
VerticalAlignment="Center",
HorizontalAlignment="Center",
FillDirection="Vertical",
}),











aA,
aq.CustomEmptyPage.Title and ak("TextLabel",{
AutomaticSize="XY",
Text=aq.CustomEmptyPage.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=18,
TextTransparency=0.5,
BackgroundTransparency=1,
FontFace=Font.new(aj.Font,Enum.FontWeight.Medium),
})or nil,
aq.CustomEmptyPage.Desc and ak("TextLabel",{
AutomaticSize="XY",
Text=aq.CustomEmptyPage.Desc,
ThemeTag={
TextColor3="Text",
},
TextSize=15,
TextTransparency=0.65,
BackgroundTransparency=1,
FontFace=Font.new(aj.Font,Enum.FontWeight.Regular),
})or nil,
})





local b
b=aj.AddSignal(aq.UIElements.ContainerFrame.ChildAdded,function()
aB.Visible=false
b:Disconnect()
end)
end)

return aq
end

function an.OnChange(ao,ap)
an.OnChangeFunc=ap
end

function an.SelectTab(ao,ap)
if not an.Tabs[ap].Locked then
an.SelectedTab=ap

for aq,ar in next,an.Tabs do
if not ar.Locked then
aj.SetThemeTag(ar.UIElements.Main,{
ImageTransparency="TabBorderTransparency",
},0.15)
if ar.Border then
aj.SetThemeTag(ar.UIElements.Main.Outline,{
ImageTransparency="TabBorderTransparency",
},0.15)
end
aj.SetThemeTag(ar.UIElements.Main.Frame.TextLabel,{
TextTransparency="TabTextTransparency",
},0.15)
if ar.UIElements.Icon and not ar.IconColor then
aj.SetThemeTag(ar.UIElements.Icon.ImageLabel,{
ImageTransparency="TabIconTransparency",
},0.15)
end
ar.Selected=false
end
end
aj.SetThemeTag(an.Tabs[ap].UIElements.Main,{
ImageColor3="TabBackgroundActive",
ImageTransparency="TabBackgroundActiveTransparency",
},0.15)
if an.Tabs[ap].Border then
aj.SetThemeTag(an.Tabs[ap].UIElements.Main.Outline,{
ImageTransparency="TabBorderTransparencyActive",
},0.15)
end
aj.SetThemeTag(an.Tabs[ap].UIElements.Main.Frame.TextLabel,{
TextTransparency="TabTextTransparencyActive",
},0.15)
if an.Tabs[ap].UIElements.Icon and not an.Tabs[ap].IconColor then
aj.SetThemeTag(an.Tabs[ap].UIElements.Icon.ImageLabel,{
ImageTransparency="TabIconTransparencyActive",
},0.15)
end
an.Tabs[ap].Selected=true

task.spawn(function()
for aq,ar in next,an.Containers do
ar.AnchorPoint=Vector2.new(0,0.05)
ar.Visible=false
end
an.Containers[ap].Visible=true
local aq=game:GetService"TweenService"

local ar=TweenInfo.new(0.15,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
local as=aq:Create(an.Containers[ap],ar,{
AnchorPoint=Vector2.new(0,0),
})
as:Play()
end)

an.OnChangeFunc(ap)
end
end

return an end function a.aa()

local aa={}


local ae=a.load'd'
local ah=ae.New
local aj=ae.Tween

local ak=a.load'_'

function aa.New(al,am,an,ao,ap)
local aq={
Title=al.Title or"Section",
Icon=al.Icon,
IconThemed=al.IconThemed,
Opened=al.Opened or false,

HeaderSize=42,
IconSize=18,

Expandable=false,
}

local ar
if aq.Icon then
ar=ae.Image(
aq.Icon,
aq.Icon,
0,
an,
"Section",
true,
aq.IconThemed,
"TabSectionIcon"
)

ar.Size=UDim2.new(0,aq.IconSize,0,aq.IconSize)
ar.ImageLabel.ImageTransparency=.25
end

local as=ah("Frame",{
Size=UDim2.new(0,aq.IconSize,0,aq.IconSize),
BackgroundTransparency=1,
Visible=false
},{
ah("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Image=ae.Icon"chevron-down"[1],
ImageRectSize=ae.Icon"chevron-down"[2].ImageRectSize,
ImageRectOffset=ae.Icon"chevron-down"[2].ImageRectPosition,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.7,
})
})

local at=ah("Frame",{
Size=UDim2.new(1,0,0,aq.HeaderSize),
BackgroundTransparency=1,
Parent=am,
ClipsDescendants=true,
},{
ah("TextButton",{
Size=UDim2.new(1,0,0,aq.HeaderSize),
BackgroundTransparency=1,
Text="",
},{
ar,
ah("TextLabel",{
Text=aq.Title,
TextXAlignment="Left",
Size=UDim2.new(
1,
ar and(-aq.IconSize-10)*2
or(-aq.IconSize-10),

1,
0
),
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(ae.Font,Enum.FontWeight.SemiBold),
TextSize=14,
BackgroundTransparency=1,
TextTransparency=.7,

TextWrapped=true
}),
ah("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
Padding=UDim.new(0,10)
}),
as,
ah("UIPadding",{
PaddingLeft=UDim.new(0,11),
PaddingRight=UDim.new(0,11),
})
}),
ah("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
Name="Content",
Visible=true,
Position=UDim2.new(0,0,0,aq.HeaderSize)
},{
ah("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,ap.Gap),
VerticalAlignment="Bottom",
}),
})
})


function aq.Tab(au,av)
if not aq.Expandable then
aq.Expandable=true
as.Visible=true
end
av.Parent=at.Content
return ak.New(av,ao)
end

function aq.Open(au)
if aq.Expandable then
aq.Opened=true
aj(at,0.33,{
Size=UDim2.new(1,0,0,aq.HeaderSize+(at.Content.AbsoluteSize.Y/ao))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

aj(as.ImageLabel,0.1,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
function aq.Close(au)
if aq.Expandable then
aq.Opened=false
aj(at,0.26,{
Size=UDim2.new(1,0,0,aq.HeaderSize)
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
aj(as.ImageLabel,0.1,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

ae.AddSignal(at.TextButton.MouseButton1Click,function()
if aq.Expandable then
if aq.Opened then
aq:Close()
else
aq:Open()
end
end
end)

ae.AddSignal(at.Content.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()
if aq.Opened then
aq:Open()
end
end)

if aq.Opened then
task.spawn(function()
task.wait()
aq:Open()
end)
end



return aq
end


return aa end function a.ab()
return{
Tab="table-of-contents",
Paragraph="type",
Button="square-mouse-pointer",
Toggle="toggle-right",
Slider="sliders-horizontal",
Keybind="command",
Input="text-cursor-input",
Dropdown="chevrons-up-down",
Code="terminal",
Colorpicker="palette",
}end function a.ac()
local aa=(cloneref or clonereference or function(aa)
return aa
end)

aa(game:GetService"UserInputService")

local ae={
Margin=8,
Padding=9,
}

local ah=a.load'd'
local aj=ah.New
local ak=ah.Tween

function ae.new(al,am,an)
local ao={
IconSize=18,
Padding=14,
Radius=22,
Width=400,
MaxHeight=380,

Icons=a.load'ab',
}

local ap=aj("TextBox",{
Text="",
PlaceholderText="Search...",
ThemeTag={
PlaceholderColor3="Placeholder",
TextColor3="Text",
},
Size=UDim2.new(1,-((ao.IconSize*2)+(ao.Padding*2)),0,0),
AutomaticSize="Y",
ClipsDescendants=true,
ClearTextOnFocus=false,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(ah.Font,Enum.FontWeight.Regular),
TextSize=18,
})

local aq=aj("ImageLabel",{
Image=ah.Icon"x"[1],
ImageRectSize=ah.Icon"x"[2].ImageRectSize,
ImageRectOffset=ah.Icon"x"[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=0.1,
Size=UDim2.new(0,ao.IconSize,0,ao.IconSize),
},{
aj("TextButton",{
Size=UDim2.new(1,8,1,8),
BackgroundTransparency=1,
Active=true,
ZIndex=999999999,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Text="",
}),
})

local ar=aj("ScrollingFrame",{
Size=UDim2.new(1,0,0,0),
AutomaticCanvasSize="Y",
ScrollingDirection="Y",
ElasticBehavior="Never",
ScrollBarThickness=0,
CanvasSize=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
Visible=false,
},{
aj("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
aj("UIPadding",{
PaddingTop=UDim.new(0,ao.Padding),
PaddingLeft=UDim.new(0,ao.Padding),
PaddingRight=UDim.new(0,ao.Padding),
PaddingBottom=UDim.new(0,ao.Padding),
}),
})

local as=ah.NewRoundFrame(ao.Radius,"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="WindowSearchBarBackground",
},
ImageTransparency=0,
},{
ah.NewRoundFrame(ao.Radius,"Squircle",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,

Visible=false,
ThemeTag={
ImageColor3="White",
},
ImageTransparency=1,
Name="Frame",
},{
aj("Frame",{
Size=UDim2.new(1,0,0,46),
BackgroundTransparency=1,
},{








aj("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
aj("ImageLabel",{
Image=ah.Icon"search"[1],
ImageRectSize=ah.Icon"search"[2].ImageRectSize,
ImageRectOffset=ah.Icon"search"[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=0.1,
Size=UDim2.new(0,ao.IconSize,0,ao.IconSize),
}),
ap,
aq,
aj("UIListLayout",{
Padding=UDim.new(0,ao.Padding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
aj("UIPadding",{
PaddingLeft=UDim.new(0,ao.Padding),
PaddingRight=UDim.new(0,ao.Padding),
}),
}),
}),
aj("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Name="Results",
},{
aj("Frame",{
Size=UDim2.new(1,0,0,1),
ThemeTag={
BackgroundColor3="Outline",
},
BackgroundTransparency=0.9,
Visible=false,
}),
ar,
aj("UISizeConstraint",{
MaxSize=Vector2.new(ao.Width,ao.MaxHeight),
}),
}),
aj("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
}),
})

local at=aj("Frame",{
Size=UDim2.new(0,ao.Width,0,0),
AutomaticSize="Y",
Parent=am,
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Visible=false,

ZIndex=99999999,
},{
aj("UIScale",{
Scale=0.9,
}),
as,















})

local function CreateSearchTab(au,av,aw,ax,ay,az)
local aA=aj("TextButton",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ax or nil,
},{
ah.NewRoundFrame(ao.Radius-11,"Squircle",{
Size=UDim2.new(1,0,0,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),

ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Main",
},{
ah.NewRoundFrame(ao.Radius-11,"Glass-1",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="White",
},
ImageTransparency=1,
Name="Outline",
},{








aj("UIPadding",{
PaddingTop=UDim.new(0,ao.Padding-2),
PaddingLeft=UDim.new(0,ao.Padding),
PaddingRight=UDim.new(0,ao.Padding),
PaddingBottom=UDim.new(0,ao.Padding-2),
}),
aj("ImageLabel",{
Image=ah.Icon(aw)[1],
ImageRectSize=ah.Icon(aw)[2].ImageRectSize,
ImageRectOffset=ah.Icon(aw)[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=0.1,
Size=UDim2.new(0,ao.IconSize,0,ao.IconSize),
}),
aj("Frame",{
Size=UDim2.new(1,-ao.IconSize-ao.Padding,0,0),
BackgroundTransparency=1,
},{
aj("TextLabel",{
Text=au,
ThemeTag={
TextColor3="Text",
},
TextSize=17,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(ah.Font,Enum.FontWeight.Medium),
Size=UDim2.new(1,0,0,0),
TextTruncate="AtEnd",
AutomaticSize="Y",
Name="Title",
}),
aj("TextLabel",{
Text=av or"",
Visible=av and true or false,
ThemeTag={
TextColor3="Text",
},
TextSize=15,
TextTransparency=0.3,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(ah.Font,Enum.FontWeight.Medium),
Size=UDim2.new(1,0,0,0),
TextTruncate="AtEnd",
AutomaticSize="Y",
Name="Desc",
})or nil,
aj("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
}),
}),
aj("UIListLayout",{
Padding=UDim.new(0,ao.Padding),
FillDirection="Horizontal",
}),
}),
},true),
aj("Frame",{
Name="ParentContainer",
Size=UDim2.new(1,-ao.Padding,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Visible=ay,

},{
ah.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,2,1,0),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=0.9,
}),
aj("Frame",{
Size=UDim2.new(1,-ao.Padding-2,0,0),
Position=UDim2.new(0,ao.Padding+2,0,0),
BackgroundTransparency=1,
},{
aj("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
}),
}),
aj("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
HorizontalAlignment="Right",
}),
})



aA.Main.Size=UDim2.new(
1,
0,
0,
aA.Main.Outline.Frame.Desc.Visible
and(((ao.Padding-2)*2)+aA.Main.Outline.Frame.Title.TextBounds.Y+6+aA.Main.Outline.Frame.Desc.TextBounds.Y)
or(((ao.Padding-2)*2)+aA.Main.Outline.Frame.Title.TextBounds.Y)
)

ah.AddSignal(aA.Main.MouseEnter,function()
ak(aA.Main,0.04,{ImageTransparency=0.95}):Play()

end)
ah.AddSignal(aA.Main.InputEnded,function()
ak(aA.Main,0.08,{ImageTransparency=1}):Play()

end)
ah.AddSignal(aA.Main.MouseButton1Click,function()
if az then
az()
end
end)

return aA
end

local function ContainsText(au,av)
if not av or av==""then
return false
end

if not au or au==""then
return false
end

local aw=string.lower(au)
local ax=string.lower(av)

return string.find(aw,ax,1,true)~=nil
end

local function Search(au)
if not au or au==""then
return{}
end

local av={}
for aw,ax in next,al.Tabs do
local ay=ContainsText(ax.Title or"",au)
local az={}

for aA,aB in next,ax.Elements do
if aB.__type~="Section"then
local b=ContainsText(aB.Title or"",au)
local d=ContainsText(aB.Desc or"",au)

if b or d then
az[aA]={
Title=aB.Title,
Desc=aB.Desc,
Original=aB,
__type=aB.__type,
Index=aA,
}
end
end
end

if ay or next(az)~=nil then
av[aw]={
Tab=ax,
Title=ax.Title,
Icon=ax.Icon,
Elements=az,
}
end
end
return av
end

ah.AddSignal(ar.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()

ak(ar,0.06,{
Size=UDim2.new(
1,
0,
0,
math.clamp(
ar.UIListLayout.AbsoluteContentSize.Y+(ao.Padding*2),
0,
ao.MaxHeight
)
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()






end)

function ao.Open(au)
task.spawn(function()
as.Frame.Visible=true
at.Visible=true
ak(at.UIScale,0.12,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end)
end

function ao.Close(au,av)
task.spawn(function()
an()
as.Frame.Visible=false
ak(at.UIScale,0.12,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

task.wait(0.12)
at.Visible=false
if av then
at:Destroy()
end
end)
end

ah.AddSignal(aq.TextButton.MouseButton1Click,function()
ao:Close(true)
end)

ao:Open()

function ao.Search(au,av)
av=av or""

local aw=Search(av)

ar.Visible=true
as.Frame.Results.Frame.Visible=true
for ax,ay in next,ar:GetChildren()do
if ay.ClassName~="UIListLayout"and ay.ClassName~="UIPadding"then
ay:Destroy()
end
end

if aw and next(aw)~=nil then
for ax,ay in next,aw do
local az=ao.Icons.Tab
local aA=CreateSearchTab(ay.Title,nil,az,ar,true,function()
ao:Close()
al:SelectTab(ax)
end)
if ay.Elements and next(ay.Elements)~=nil then
for aB,b in next,ay.Elements do
local d=ao.Icons[b.__type]
CreateSearchTab(
b.Title,
b.Desc,
d,
aA:FindFirstChild"ParentContainer"and aA.ParentContainer.Frame
or nil,
false,
function()
ao:Close()
al:SelectTab(ax)
if ay.Tab.ScrollToTheElement then

ay.Tab:ScrollToTheElement(b.Index)
end

end
)

end
end
end
elseif av~=""then
aj("TextLabel",{
Size=UDim2.new(1,0,0,70),
Text="No results found",
TextSize=16,
ThemeTag={
TextColor3="Text",
},
TextTransparency=0.2,
BackgroundTransparency=1,
FontFace=Font.new(ah.Font,Enum.FontWeight.Medium),
Parent=ar,
Name="NotFound",
})
else
ar.Visible=false
as.Frame.Results.Frame.Visible=false
end
end

ah.AddSignal(ap:GetPropertyChangedSignal"Text",function()
ao:Search(ap.Text)
end)

return ao
end

return ae end function a.ad()



local aa=(cloneref or clonereference or function(aa)
return aa
end)

local ae=aa(game:GetService"UserInputService")
local ah=aa(game:GetService"RunService")
local aj=aa(game:GetService"Players")

local ak=workspace.CurrentCamera

local al=a.load't'

local am=a.load'd'
local an=am.New
local ao=am.Tween


local ap=a.load'w'.New
local aq=a.load'm'.New
local ar=a.load'x'.New
local as=a.load'y'

local at=a.load'z'



return function(au)
local av={
Title=au.Title or"UI Library",
Author=au.Author,
Icon=au.Icon,
IconSize=au.IconSize or 22,
IconThemed=au.IconThemed,
IconRadius=au.IconRadius or 0,
Folder=au.Folder,
Resizable=au.Resizable~=false,
Background=au.Background,
BackgroundImageTransparency=au.BackgroundImageTransparency or 0,
ShadowTransparency=au.ShadowTransparency or 0.6,
User=au.User or{},
Footer=au.Footer or{},
Topbar=au.Topbar or{Height=52,ButtonsType="Default"},

Size=au.Size,

MinSize=au.MinSize or Vector2.new(560,350),
MaxSize=au.MaxSize or Vector2.new(850,560),

TopBarButtonIconSize=au.TopBarButtonIconSize,

ToggleKey=au.ToggleKey,
ElementsRadius=au.ElementsRadius,
Radius=au.Radius or 16,
Transparent=au.Transparent or false,
HideSearchBar=au.HideSearchBar~=false,
ScrollBarEnabled=au.ScrollBarEnabled or false,
SideBarWidth=au.SideBarWidth or 200,
Acrylic=au.Acrylic or false,
NewElements=au.NewElements or false,
IgnoreAlerts=au.IgnoreAlerts or false,
HidePanelBackground=au.HidePanelBackground or false,
AutoScale=au.AutoScale~=false,
OpenButton=au.OpenButton,
DragFrameSize=160,

Position=UDim2.new(0.5,0,0.5,0),
UICorner=16,
UIPadding=14,
UIElements={},
CanDropdown=true,
Closed=false,
Parent=au.Parent,
Destroyed=false,
IsFullscreen=false,
CanResize=au.Resizable~=false,
IsOpenButtonEnabled=true,

CurrentConfig=nil,
ConfigManager=nil,
AcrylicPaint=nil,
CurrentTab=nil,
TabModule=nil,

OnOpenCallback=nil,
OnCloseCallback=nil,
OnDestroyCallback=nil,

IsPC=false,

Gap=5,

TopBarButtons={},
AllElements={},

ElementConfig={},

PendingFlags={},

IsToggleDragging=false,
}

av.UICorner=av.Radius

av.TopBarButtonIconSize=av.TopBarButtonIconSize or(av.Topbar.ButtonsType=="Mac"and 11 or 16)

av.ElementConfig={
UIPadding=(av.NewElements and 10 or 13),
UICorner=av.ElementsRadius or(av.NewElements and 23 or 16),
}

local aw=av.Size or UDim2.new(0,580,0,460)
av.Size=UDim2.new(
aw.X.Scale,
math.clamp(aw.X.Offset,av.MinSize.X,av.MaxSize.X),
aw.Y.Scale,
math.clamp(aw.Y.Offset,av.MinSize.Y,av.MaxSize.Y)
)

if av.Topbar=={}then
av.Topbar={Height=52,ButtonsType="Default"}
end

if not ah:IsStudio()and av.Folder and writefile then
if not isfolder("WindUI/"..av.Folder)then
makefolder("WindUI/"..av.Folder)
end
if not isfolder("WindUI/"..av.Folder.."/assets")then
makefolder("WindUI/"..av.Folder.."/assets")
end
if not isfolder(av.Folder)then
makefolder(av.Folder)
end
if not isfolder(av.Folder.."/assets")then
makefolder(av.Folder.."/assets")
end
end

local ax=an("UICorner",{
CornerRadius=UDim.new(0,av.UICorner),
})

if av.Folder then
av.ConfigManager=at:Init(av)
end

if av.Acrylic then local
ay=al.AcrylicPaint{UseAcrylic=av.Acrylic}

av.AcrylicPaint=ay
end

local ay=an("Frame",{
Size=UDim2.new(0,32,0,32),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
ZIndex=99,
Active=true,
},{
an("ImageLabel",{
Size=UDim2.new(0,96,0,96),
BackgroundTransparency=1,
Image="rbxassetid://120997033468887",
Position=UDim2.new(0.5,-16,0.5,-16),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=1,
}),
})
local az=am.NewRoundFrame(av.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
ZIndex=98,
Active=false,
},{
an("ImageLabel",{
Size=UDim2.new(0,70,0,70),
Image=am.Icon"expand"[1],
ImageRectOffset=am.Icon"expand"[2].ImageRectPosition,
ImageRectSize=am.Icon"expand"[2].ImageRectSize,
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=1,
}),
})

local aA=am.NewRoundFrame(av.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
ZIndex=999,
Active=false,
})









av.UIElements.SideBar=an("ScrollingFrame",{
Size=UDim2.new(
1,
av.ScrollBarEnabled and-3-(av.UIPadding/2)or 0,
1,
not av.HideSearchBar and-45 or 0
),
Position=UDim2.new(0,0,1,0),
AnchorPoint=Vector2.new(0,1),
BackgroundTransparency=1,
ScrollBarThickness=0,
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
AutomaticCanvasSize="Y",
ScrollingDirection="Y",
ClipsDescendants=true,
VerticalScrollBarPosition="Left",
},{
an("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Name="Frame",
},{
an("UIPadding",{



PaddingBottom=UDim.new(0,av.UIPadding/2),
}),
an("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,av.Gap),
}),
}),
an("UIPadding",{

PaddingLeft=UDim.new(0,av.UIPadding/2),
PaddingRight=UDim.new(0,av.UIPadding/2),

}),

})

av.UIElements.SideBarContainer=an("Frame",{
Size=UDim2.new(
0,
av.SideBarWidth,
1,
av.User.Enabled and-av.Topbar.Height-42-(av.UIPadding*2)or-av.Topbar.Height
),
Position=UDim2.new(0,0,0,av.Topbar.Height),
BackgroundTransparency=1,
Visible=true,
},{
an("Frame",{
Name="Content",
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,not av.HideSearchBar and-45-av.UIPadding/2 or 0),
Position=UDim2.new(0,0,1,0),
AnchorPoint=Vector2.new(0,1),
}),
av.UIElements.SideBar,
})

if av.ScrollBarEnabled then
ar(av.UIElements.SideBar,av.UIElements.SideBarContainer.Content,av,3)
end

av.UIElements.MainBar=an("Frame",{
Size=UDim2.new(1,-av.UIElements.SideBarContainer.AbsoluteSize.X,1,-av.Topbar.Height),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,1),
BackgroundTransparency=1,
},{
am.NewRoundFrame(av.UICorner-(av.UIPadding/2),"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="PanelBackground",
ImageTransparency="PanelBackgroundTransparency",
},


ZIndex=3,
Name="Background",
Visible=not av.HidePanelBackground,
}),
an("UIPadding",{

PaddingLeft=UDim.new(0,av.UIPadding/2),
PaddingRight=UDim.new(0,av.UIPadding/2),
PaddingBottom=UDim.new(0,av.UIPadding/2),
}),
})

local aB=an("ImageLabel",{
Image="rbxassetid://8992230677",
ThemeTag={
ImageColor3="WindowShadow",

},
ImageTransparency=1,
Size=UDim2.new(1,100,1,100),
Position=UDim2.new(0,-50,0,-50),
ScaleType="Slice",
SliceCenter=Rect.new(99,99,99,99),
BackgroundTransparency=1,
ZIndex=-999999999999999,
Name="Blur",
})

if ae.TouchEnabled and not ae.KeyboardEnabled then
av.IsPC=false
elseif ae.KeyboardEnabled then
av.IsPC=true
else
av.IsPC=nil
end







local b
if av.User then
local function GetUserThumb()local
d=aj:GetUserThumbnailAsync(
av.User.Anonymous and 1 or aj.LocalPlayer.UserId,
Enum.ThumbnailType.HeadShot,
Enum.ThumbnailSize.Size420x420
)
return d
end

b=an("TextButton",{
Size=UDim2.new(
0,
av.UIElements.SideBarContainer.AbsoluteSize.X-(av.UIPadding/2),
0,
42+av.UIPadding
),
Position=UDim2.new(0,av.UIPadding/2,1,-(av.UIPadding/2)),
AnchorPoint=Vector2.new(0,1),
BackgroundTransparency=1,
Visible=av.User.Enabled or false,
},{
am.NewRoundFrame(av.UICorner-(av.UIPadding/2),"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Outline",
},{
an("UIGradient",{
Rotation=78,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
},
}),
}),
am.NewRoundFrame(av.UICorner-(av.UIPadding/2),"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="UserIcon",
},{
an("ImageLabel",{
Image=GetUserThumb(),
BackgroundTransparency=1,
Size=UDim2.new(0,42,0,42),
ThemeTag={
BackgroundColor3="Text",
},
BackgroundTransparency=0.93,
},{
an("UICorner",{
CornerRadius=UDim.new(1,0),
}),
}),
an("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
},{
an("TextLabel",{
Text=av.User.Anonymous and"Anonymous"or aj.LocalPlayer.DisplayName,
TextSize=17,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(am.Font,Enum.FontWeight.SemiBold),
AutomaticSize="Y",
BackgroundTransparency=1,
Size=UDim2.new(1,-27,0,0),
TextTruncate="AtEnd",
TextXAlignment="Left",
Name="DisplayName",
}),
an("TextLabel",{
Text=av.User.Anonymous and"anonymous"or aj.LocalPlayer.Name,
TextSize=15,
TextTransparency=0.6,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(am.Font,Enum.FontWeight.Medium),
AutomaticSize="Y",
BackgroundTransparency=1,
Size=UDim2.new(1,-27,0,0),
TextTruncate="AtEnd",
TextXAlignment="Left",
Name="UserName",
}),
an("UIListLayout",{
Padding=UDim.new(0,4),
HorizontalAlignment="Left",
}),
}),
an("UIListLayout",{
Padding=UDim.new(0,av.UIPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
an("UIPadding",{
PaddingLeft=UDim.new(0,av.UIPadding/2),
PaddingRight=UDim.new(0,av.UIPadding/2),
}),
}),
})

function av.User.Enable(d)
av.User.Enabled=true
ao(
av.UIElements.SideBarContainer,
0.25,
{Size=UDim2.new(0,av.SideBarWidth,1,-av.Topbar.Height-42-(av.UIPadding*2))},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
b.Visible=true
end
function av.User.Disable(d)
av.User.Enabled=false
ao(
av.UIElements.SideBarContainer,
0.25,
{Size=UDim2.new(0,av.SideBarWidth,1,-av.Topbar.Height)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
b.Visible=false
end
function av.User.SetAnonymous(d,f)
if f~=false then
f=true
end
av.User.Anonymous=f
b.UserIcon.ImageLabel.Image=GetUserThumb()
b.UserIcon.Frame.DisplayName.Text=f and"Anonymous"or aj.LocalPlayer.DisplayName
b.UserIcon.Frame.UserName.Text=f and"anonymous"or aj.LocalPlayer.Name
end

if av.User.Enabled then
av.User:Enable()
else
av.User:Disable()
end

if av.User.Callback then
am.AddSignal(b.MouseButton1Click,function()
av.User.Callback()
end)
am.AddSignal(b.MouseEnter,function()
ao(b.UserIcon,0.04,{ImageTransparency=0.95}):Play()
ao(b.Outline,0.04,{ImageTransparency=0.85}):Play()
end)
am.AddSignal(b.InputEnded,function()
ao(b.UserIcon,0.04,{ImageTransparency=1}):Play()
ao(b.Outline,0.04,{ImageTransparency=1}):Play()
end)
end
end

local d
local f

local g=false
local h

local i=typeof(av.Background)=="string"and string.match(av.Background,"^video:(.+)")or nil

local l=typeof(av.Background)=="string"
and not i
and string.match(av.Background,"^https?://.+")
or nil

local m=typeof(av.Background)=="string"
and not i
and string.match(av.Background,"^rbxassetid://%d+")
or nil

local function GetImageExtension(p)
if not p or typeof(p)~="string"then
return".png"
end
local r=p:match"^([^?#]+)"or p
local u=r:match"%.(%w+)$"
if u then
u=u:lower()
if u=="jpg"or u=="jpeg"or u=="png"or u=="webp"then
return"."..u
end
end
return".png"
end



if typeof(av.Background)=="string"and i then
g=true

if string.find(i,"http")then
local p=(av.Folder or"Temp").."/assets/."..am.SanitizeFilename(i)..".webm"
if not isfile(p)then
local r,u=pcall(function()





local r=game.HttpGet and game:HttpGet(i)
or am.Request{
Url=i,
Method="GET",
Headers={["User-Agent"]="Roblox/Exploit"},
}.Body

writefile(p,r)
end)
if not r then
warn("[ WindUI.Window.Background ] Failed to download video: "..tostring(u))
end
end

local r,u=pcall(function()
return getcustomasset(p)
end)
if not r then
warn("[ WindUI.Window.Background ] Failed to load custom asset: "..tostring(u))
end
warn"[ WindUI.Window.Background ] VideoFrame may not work with custom video"
i=u
end

h=an("VideoFrame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Video=i,
Looped=true,
Volume=0,
},{
an("UICorner",{
CornerRadius=UDim.new(0,av.UICorner),
}),
})
h:Play()
elseif l then
local p=(av.Folder or"Temp")
.."/assets/."
..am.SanitizeFilename(l)
..GetImageExtension(l)

if isfile and not isfile(p)then
local r,u=pcall(function()
local r=game.HttpGet and game:HttpGet(l)
or am.Request{
Url=l,
Method="GET",
Headers={["User-Agent"]="Roblox/Exploit"},
}.Body

writefile(p,r)
end)

if not r then
warn("[ Window.Background ] Failed to download image: "..tostring(u))
end
end

local r,u=pcall(function()
return getcustomasset(p)
end)

if not r then
warn("[ Window.Background ] Failed to load custom asset: "..tostring(u))
end

h=an("ImageLabel",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Image=u,
ImageTransparency=0,
ScaleType="Crop",
},{
an("UICorner",{
CornerRadius=UDim.new(0,av.UICorner),
}),
})
elseif m then
h=an("ImageLabel",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Image=m,
ImageTransparency=0,
ScaleType="Crop",
},{
an("UICorner",{
CornerRadius=UDim.new(0,av.UICorner),
}),
})
elseif av.Background then
h=an("ImageLabel",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Image=typeof(av.Background)=="string"and av.Background or"",
ImageTransparency=1,
ScaleType="Crop",
},{
an("UICorner",{
CornerRadius=UDim.new(0,av.UICorner),
}),
})
end

local p=am.NewRoundFrame(99,"Squircle",{
ImageTransparency=0.8,
ImageColor3=Color3.new(1,1,1),
Size=UDim2.new(0,0,0,4),
Position=UDim2.new(0.5,0,1,4),
AnchorPoint=Vector2.new(0.5,0),
},{
an("TextButton",{
Size=UDim2.new(1,12,1,12),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,
ZIndex=99,
Name="Frame",
}),
})

function createAuthor(r)
return an("TextLabel",{
Text=r,
FontFace=Font.new(am.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
TextTransparency=0.35,
AutomaticSize="XY",
Parent=av.UIElements.Main and av.UIElements.Main.Main.Topbar.Left.Title,
TextXAlignment="Left",
TextSize=13,
LayoutOrder=2,
ThemeTag={
TextColor3="WindowTopbarAuthor",
},
Name="Author",
})
end

local r
local u

if av.Author then
r=createAuthor(av.Author)
end

local v=an("TextLabel",{
Text=av.Title,
FontFace=Font.new(am.Font,Enum.FontWeight.SemiBold),
BackgroundTransparency=1,
AutomaticSize="XY",
Name="Title",
TextXAlignment="Left",
TextSize=16,
ThemeTag={
TextColor3="WindowTopbarTitle",
},
})

av.UIElements.Main=an("Frame",{
Size=UDim2.new(av.Size.X.Scale,av.Size.X.Offset,0,0),
Position=av.Position,
BackgroundTransparency=1,
Parent=au.Parent,
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,

},{
au.WindUI.UIScaleObj,
av.AcrylicPaint and av.AcrylicPaint.Frame or nil,
aB,
am.NewRoundFrame(av.UICorner,"Squircle",{
ImageTransparency=1,
Size=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Background",
ThemeTag={
ImageColor3="WindowBackground",
},

},{
h,
p,
ay,
}),




ax,
az,
aA,
an("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Name="Main",

Visible=false,
ZIndex=97,
},{
an("UICorner",{
CornerRadius=UDim.new(0,av.UICorner),
}),
av.UIElements.SideBarContainer,
av.UIElements.MainBar,

b,

f,
an("Frame",{
Size=UDim2.new(1,0,0,av.Topbar.Height),
BackgroundTransparency=1,
BackgroundColor3=Color3.fromRGB(50,50,50),
Name="Topbar",
},{
d,






an("Frame",{
AutomaticSize="X",
Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,
Name="Left",
},{
an("UIListLayout",{
Padding=UDim.new(0,av.UIPadding+4),
SortOrder="LayoutOrder",
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
an("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
Name="Title",
Size=UDim2.new(0,0,1,0),
LayoutOrder=2,
},{
an("UIListLayout",{
Padding=UDim.new(0,0),
SortOrder="LayoutOrder",
FillDirection="Vertical",
VerticalAlignment="Center",
}),
v,
r,
}),
an("UIPadding",{
PaddingLeft=UDim.new(0,4),
}),
}),
an("CanvasGroup",{
Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,
Name="Center",
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,0,0.5,0),
AutomaticSize="Y",
Visible=false,
},{



an("ScrollingFrame",{
Name="Holder",
BackgroundTransparency=1,
AutomaticSize="Y",
ScrollBarThickness=0,
ScrollingDirection="X",
AutomaticCanvasSize="X",
CanvasSize=UDim2.new(0,0,0,0),
Size=UDim2.new(1,0,1,0),


},{

an("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
Padding=UDim.new(0,av.UIPadding/2),
}),
}),
}),
an("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
Position=UDim2.new(av.Topbar.ButtonsType=="Default"and 1 or 0,0,0.5,0),
AnchorPoint=Vector2.new(av.Topbar.ButtonsType=="Default"and 1 or 0,0.5),
Name="Right",
},{
an("UIListLayout",{
Padding=UDim.new(0,av.Topbar.ButtonsType=="Default"and 9 or 0),
FillDirection="Horizontal",
SortOrder="LayoutOrder",
}),
}),
an("UIPadding",{
PaddingTop=UDim.new(0,av.UIPadding),
PaddingLeft=UDim.new(
0,
av.Topbar.ButtonsType=="Default"and av.UIPadding or av.UIPadding-2
),
PaddingRight=UDim.new(0,8),
PaddingBottom=UDim.new(0,av.UIPadding),
}),
}),
}),
})

am.AddSignal(av.UIElements.Main.Main.Topbar.Left:GetPropertyChangedSignal"AbsoluteSize",function()
local x=0
local z=av.UIElements.Main.Main.Topbar.Right.UIListLayout.AbsoluteContentSize.X
/au.WindUI.UIScale

x=av.UIElements.Main.Main.Topbar.Left.AbsoluteSize.X/au.WindUI.UIScale
if av.Topbar.ButtonsType~="Default"then
x=x+z+av.UIPadding-4
end

av.UIElements.Main.Main.Topbar.Center.Position=
UDim2.new(0,x+(av.UIPadding/au.WindUI.UIScale),0.5,0)
av.UIElements.Main.Main.Topbar.Center.Size=UDim2.new(
1,
-x
-(av.UIPadding/au.WindUI.UIScale)
-(av.Topbar.ButtonsType=="Default"and z+av.UIPadding or 0),
1,
0
)
end)

if av.Topbar.ButtonsType~="Default"then
am.AddSignal(av.UIElements.Main.Main.Topbar.Right:GetPropertyChangedSignal"AbsoluteSize",function()
av.UIElements.Main.Main.Topbar.Left.Position=UDim2.new(
0,
(av.UIElements.Main.Main.Topbar.Right.AbsoluteSize.X/au.WindUI.UIScale)+av.UIPadding-4,
0,
0
)
end)
end

function av.CreateTopbarButton(x,z,A,B,C,F,G,H)
local J=am.Image(
A,
A,
0,
av.Folder,
"WindowTopbarIcon",
av.Topbar.ButtonsType=="Default"and true or false,
F,
"WindowTopbarButtonIcon"
)
J.Size=av.Topbar.ButtonsType=="Default"
and UDim2.new(0,H or av.TopBarButtonIconSize,0,H or av.TopBarButtonIconSize)
or UDim2.new(0,0,0,0)
J.AnchorPoint=Vector2.new(0.5,0.5)
J.Position=UDim2.new(0.5,0,0.5,0)
J.ImageLabel.ImageTransparency=av.Topbar.ButtonsType=="Default"and 0 or 1

if av.Topbar.ButtonsType~="Default"then
J.ImageLabel.ImageColor3=am.GetTextColorForHSB(G)
end

local L=am.NewRoundFrame(
av.Topbar.ButtonsType=="Default"and av.UICorner-(av.UIPadding/2)or 999,
"Squircle",
{
Size=av.Topbar.ButtonsType=="Default"
and UDim2.new(0,av.Topbar.Height-16,0,av.Topbar.Height-16)
or UDim2.new(0,14,0,14),
LayoutOrder=C or 999,


ZIndex=9999,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ImageColor3=av.Topbar.ButtonsType~="Default"and(G or Color3.fromHex"#ff3030")or nil,
ThemeTag=av.Topbar.ButtonsType=="Default"and{
ImageColor3="Text",
}or nil,
ImageTransparency=av.Topbar.ButtonsType=="Default"and 1 or 0,
},
{












J,
an("UIScale",{
Scale=1,
}),
},
true
)

local M=an("Frame",{
Size=av.Topbar.ButtonsType~="Default"and UDim2.new(0,24,0,24)
or UDim2.new(0,av.Topbar.Height-16,0,av.Topbar.Height-16),
BackgroundTransparency=1,
Parent=av.UIElements.Main.Main.Topbar.Right,
LayoutOrder=C or 999,
},{
L,
})



av.TopBarButtons[100-C]={
Name=z,
Object=M,
}

am.AddSignal(L.MouseButton1Click,function()
if B then
B()
end
end)
am.AddSignal(L.MouseEnter,function()
if av.Topbar.ButtonsType=="Default"then
ao(L,0.15,{ImageTransparency=0.93}):Play()


else

ao(
J.ImageLabel,
0.1,
{ImageTransparency=0},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
ao(J,0.1,{
Size=UDim2.new(
0,
H or av.TopBarButtonIconSize,
0,
H or av.TopBarButtonIconSize
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end)

am.AddSignal(L.MouseButton1Down,function()
ao(L.UIScale,0.2,{Scale=0.9},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end)

am.AddSignal(L.MouseLeave,function()
if av.Topbar.ButtonsType=="Default"then
ao(L,0.1,{ImageTransparency=1}):Play()


else

ao(
J.ImageLabel,
0.1,
{ImageTransparency=1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
ao(
J,
0.1,
{Size=UDim2.new(0,0,0,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
end
end)

am.AddSignal(L.InputEnded,function()
ao(L.UIScale,0.2,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
end)

return L
end

function av.Topbar.Button(x,z:{
Name:string,
Icon:string,
Callback:any,
LayoutOrder:number,
IconThemed:boolean,
Color:Color3,
IconSize:number,
})
return av:CreateTopbarButton(
z.Name,
z.Icon,
z.Callback,
z.LayoutOrder or 0,
z.IconThemed,
z.Color,
z.IconSize
)
end



local x=am.Drag(
av.UIElements.Main,
{av.UIElements.Main.Main.Topbar,p.Frame},
function(x,z)
if not av.Closed then
if x and z==p.Frame then
ao(p,0.1,{ImageTransparency=0.35}):Play()
else
ao(p,0.2,{ImageTransparency=0.8}):Play()
end
av.Position=av.UIElements.Main.Position
av.Dragging=x
end
end
)

if not g and av.Background and typeof(av.Background)=="table"then
local z=an"UIGradient"
for A,B in next,av.Background do
z[A]=B
end

av.UIElements.BackgroundGradient=am.NewRoundFrame(av.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
Parent=av.UIElements.Main.Background,
ImageTransparency=av.Transparent and au.WindUI.TransparencyValue or 0,
},{
z,
})
end














av.OpenButtonMain=a.load'A'.New(av)

task.spawn(function()
if av.Icon then
local z=an("Frame",{
Size=UDim2.new(0,22,0,22),
BackgroundTransparency=1,
Parent=av.UIElements.Main.Main.Topbar.Left,
})

u=am.Image(
av.Icon,
av.Title,
av.IconRadius,
av.Folder,
"Window",
true,
av.IconThemed,
"WindowTopbarIcon"
)
u.Parent=z
u.Size=UDim2.new(0,av.IconSize,0,av.IconSize)
u.Position=UDim2.new(0.5,0,0.5,0)
u.AnchorPoint=Vector2.new(0.5,0.5)

av.OpenButtonMain:SetIcon(av.Icon)











else
av.OpenButtonMain:SetIcon(av.Icon)

end
end)

function av.SetToggleKey(z,A)
av.ToggleKey=A
end

function av.SetTitle(z,A)
av.Title=A
v.Text=A
end

function av.SetAuthor(z,A)
av.Author=A
if not r then
r=createAuthor(av.Author)
end

r.Text=A
end

function av.SetSize(z,A)
if typeof(A)=="UDim2"then
av.Size=A

ao(av.UIElements.Main,0.08,{Size=A},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

function av.SetBackgroundImage(z,A)
av.UIElements.Main.Background.ImageLabel.Image=A
end
function av.SetBackgroundImageTransparency(z,A)
if h and h:IsA"ImageLabel"then
h.ImageTransparency=math.floor(A*10+0.5)/10
end
av.BackgroundImageTransparency=math.floor(A*10+0.5)/10
end

function av.SetBackgroundTransparency(z,A)
local B=math.floor(tonumber(A)*10+0.5)/10
au.WindUI.TransparencyValue=B
av:ToggleTransparency(B>0)
end

local z
local A
am.Icon"minimize"
am.Icon"maximize"

av:CreateTopbarButton(
"Fullscreen",
av.Topbar.ButtonsType=="Mac"and"rbxassetid://127426072704909"or"maximize",
function()
av:ToggleFullscreen()
end,
(av.Topbar.ButtonsType=="Default"and 998 or 999),
true,
Color3.fromHex"#60C762",
av.Topbar.ButtonsType=="Mac"and 9 or nil
)

local function SetSize(B)
ao(av.UIElements.Main,0.45,{
Size=not av.IsFullscreen and A or UDim2.new(
0,
(au.WindUI.ScreenGui.AbsoluteSize.X-20)/au.WindUI.UIScale,
0,
(au.WindUI.ScreenGui.AbsoluteSize.Y-20-52)/au.WindUI.UIScale
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

ao(
av.UIElements.Main,
0.45,
{Position=not av.IsFullscreen and z or UDim2.new(0.5,0,0.5,26)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
end

function av.ToggleFullscreen(B)
local C=av.IsFullscreen

x:Set(C)

if not C then
z=av.UIElements.Main.Position
A=av.UIElements.Main.Size

av.CanResize=false
else
if av.Resizable then
av.CanResize=true
end
end

av.IsFullscreen=not C

SetSize(true)
end

am.AddSignal(au.WindUI.ScreenGui:GetPropertyChangedSignal"AbsoluteSize",function()
if av.IsFullscreen then
SetSize()
end
end)

av:CreateTopbarButton("Minimize","minus",function()
if av.Close then
av:Close()
end






















end,(av.Topbar.ButtonsType=="Default"and 997 or 998),nil,Color3.fromHex"#F4C948")

function av.OnOpen(B,C)
av.OnOpenCallback=C
end
function av.OnClose(B,C)
av.OnCloseCallback=C
end
function av.OnDestroy(B,C)
av.OnDestroyCallback=C
end

if au.WindUI.UseAcrylic then
av.AcrylicPaint.AddParent(av.UIElements.Main)
end

function av.SetIconSize(B,C)
local F
if typeof(C)=="number"then
F=UDim2.new(0,C,0,C)
av.IconSize=C
elseif typeof(C)=="UDim2"then
F=C
av.IconSize=C.X.Offset
end

if u then
u.Size=F
end
end

function av.Open(B)
if av.Destroyed then
return
end
task.spawn(function()
if av.OnOpenCallback then
task.spawn(function()
am.SafeCallback(av.OnOpenCallback)
end)
end

task.wait(0.06)
av.Closed=false

av.UIElements.Main.Size=UDim2.new(av.Size.X.Scale,av.Size.X.Offset,0,100)

ao(av.UIElements.Main,0.8,{

Size=av.Size,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

if av.UIElements.BackgroundGradient then
ao(av.UIElements.BackgroundGradient,0.2,{
ImageTransparency=0,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

av.UIElements.Main.Background.ImageTransparency=1
ao(av.UIElements.Main.Background,0.4,{

ImageTransparency=av.Transparent and au.WindUI.TransparencyValue or 0,
},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()

if h then
if h:IsA"VideoFrame"then
h.Visible=true
else
ao(h,0.2,{
ImageTransparency=av.BackgroundImageTransparency,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

if av.OpenButtonMain and av.IsOpenButtonEnabled then
av.OpenButtonMain:Visible(false)
end

au.WindUI.UIScaleObj.Scale-=0.15000000000000002
ao(
au.WindUI.UIScaleObj,
0.33,
{Scale=au.WindUI.UIScale},
Enum.EasingStyle.Back,
Enum.EasingDirection.Out
):Play()
ao(
aB,
0.25,
{ImageTransparency=av.ShadowTransparency},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()




ao(
p,
0.45,
{Size=UDim2.new(0,av.DragFrameSize,0,4),ImageTransparency=0.8},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out
):Play()
x:Set(true)

if av.Resizable then
ao(
ay.ImageLabel,
0.45,
{ImageTransparency=0.8},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out
):Play()
av.CanResize=true
end

av.CanDropdown=true
av.UIElements.Main.Visible=true



av.UIElements.Main:WaitForChild"Main".Visible=true

au.WindUI:ToggleAcrylic(true)

end)
end
function av.Close(B)
if av.Destroyed then
return
end

local C={}

if av.OnCloseCallback then
task.spawn(function()
am.SafeCallback(av.OnCloseCallback)
end)
end

au.WindUI:ToggleAcrylic(false)

if av.UIElements.Main and av.UIElements.Main:WaitForChild"Main"then
av.UIElements.Main.Main.Visible=false
end

av.CanDropdown=false
av.Closed=true

ao(av.UIElements.Main,0.9,{

Size=UDim2.new(av.Size.X.Scale,av.Size.X.Offset,0,0),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if av.UIElements.BackgroundGradient then
ao(av.UIElements.BackgroundGradient,0.2,{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
end

ao(av.UIElements.Main.Background,0.3,{

ImageTransparency=1,
},Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut):Play()

ao(
au.WindUI.UIScaleObj,
0.28,
{Scale=au.WindUI.UIScale-(0.15000000000000002)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
if h then
if h:IsA"VideoFrame"then
h.Visible=false
else
ao(h,0.3,{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
ao(aB,0.25,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()




ao(
p,
0.3,
{Size=UDim2.new(0,0,0,4),ImageTransparency=1},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.InOut
):Play()
ao(
ay.ImageLabel,
0.3,
{ImageTransparency=1},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out
):Play()
x:Set(false)
av.CanResize=false

task.spawn(function()
task.wait(0.4)

if not av.Closed then
return
end

av.UIElements.Main.Visible=false

if av.OpenButtonMain and not av.Destroyed and not av.IsPC and av.IsOpenButtonEnabled then
av.OpenButtonMain:Visible(true)
end
end)

function C.Destroy(F)
task.spawn(function()
if av.OnDestroyCallback then
task.spawn(function()
am.SafeCallback(av.OnDestroyCallback)
end)
end

if av.AcrylicPaint and av.AcrylicPaint.Model then
av.AcrylicPaint.Model:Destroy()
end

av.Destroyed=true

task.wait(0.4)

au.WindUI.ScreenGui:Destroy()
au.WindUI.NotificationGui:Destroy()
au.WindUI.DropdownGui:Destroy()
au.WindUI.TooltipGui:Destroy()

am.DisconnectAll()

return
end)
end

return C
end
function av.Destroy(B)
return av:Close():Destroy()
end
function av.Toggle(B)
if av.Closed then
av:Open()
else
av:Close()
end
end

function av.ToggleTransparency(B,C)

av.Transparent=C
au.WindUI.Transparent=C

av.UIElements.Main.Background.ImageTransparency=C and au.WindUI.TransparencyValue or 0


end

function av.LockAll(B)
for C,F in next,av.AllElements do
if F.Lock then
F:Lock()
end
end
end
function av.UnlockAll(B)
for C,F in next,av.AllElements do
if F.Unlock then
F:Unlock()
end
end
end
function av.GetLocked(B)
local C={}

for F,G in next,av.AllElements do
if G.Locked then
table.insert(C,G)
end
end

return C
end
function av.GetUnlocked(B)
local C={}

for F,G in next,av.AllElements do
if G.Locked==false then
table.insert(C,G)
end
end

return C
end

function av.GetUIScale(B,C)
return au.WindUI.UIScale
end

function av.SetUIScale(B,C)
au.WindUI.UIScale=C
ao(au.WindUI.UIScaleObj,0.2,{Scale=C},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
return av
end

function av.SetToTheCenter(B)
ao(
av.UIElements.Main,
0.45,
{Position=UDim2.new(0.5,0,0.5,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
return av
end

function av.SetCurrentConfig(B,C)
av.CurrentConfig=C
end

do
local B=40
local C=ak.ViewportSize
local F=Vector2.new(av.Size.X.Offset,av.Size.Y.Offset)

if not av.IsFullscreen and av.AutoScale then
local G=C.X-(B*2)
local H=C.Y-(B*2)

local J=G/F.X
local L=H/F.Y

local M=math.min(J,L)

local N=0.3
local O=1.0

local P=math.clamp(M,N,O)

local Q=av:GetUIScale()or 1
local R=0.05

if math.abs(P-Q)>R then
av:SetUIScale(P)
end
end
end

if av.OpenButtonMain and av.OpenButtonMain.Button then
am.AddSignal(av.OpenButtonMain.Button.TextButton.MouseButton1Click,function()


av:Open()
end)
end

am.AddSignal(ae.InputBegan,function(B,C)
if C then
return
end

if av.ToggleKey then
if B.KeyCode==av.ToggleKey then
av:Toggle()
end
end
end)

task.spawn(function()

av:Open()
end)

function av.EditOpenButton(B,C)
return av.OpenButtonMain:Edit(C)
end

if av.OpenButton and typeof(av.OpenButton)=="table"then
av:EditOpenButton(av.OpenButton)
end

local B=a.load'_'
local C=a.load'aa'
local F=B.Init(av,au.WindUI,au.WindUI.TooltipGui)
F:OnChange(function(G)
av.CurrentTab=G
end)

av.TabModule=F

function av.Tab(G,H)
H.Parent=av.UIElements.SideBar.Frame
return F.New(H,au.WindUI.UIScale)
end

function av.SelectTab(G,H)
F:SelectTab(H)
end

function av.Section(G,H)
return C.New(
H,
av.UIElements.SideBar.Frame,
av.Folder,
au.WindUI.UIScale,
av
)
end

function av.IsResizable(G,H)
av.Resizable=H
av.CanResize=H
end

function av.SetPanelBackground(G,H)
if typeof(H)=="boolean"then
av.HidePanelBackground=H

av.UIElements.MainBar.Background.Visible=H

if F then
for J,L in next,F.Containers do
L.ScrollingFrame.UIPadding.PaddingTop=UDim.new(0,av.HidePanelBackground and 20 or 10)
L.ScrollingFrame.UIPadding.PaddingLeft=
UDim.new(0,av.HidePanelBackground and 20 or 10)
L.ScrollingFrame.UIPadding.PaddingRight=
UDim.new(0,av.HidePanelBackground and 20 or 10)
L.ScrollingFrame.UIPadding.PaddingBottom=
UDim.new(0,av.HidePanelBackground and 20 or 10)
end
end
end
end

function av.Divider(G)
local H=an("Frame",{
Size=UDim2.new(1,0,0,1),
Position=UDim2.new(0.5,0,0,0),
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=0.9,
ThemeTag={
BackgroundColor3="Text",
},
})
local J=an("Frame",{
Parent=av.UIElements.SideBar.Frame,

Size=UDim2.new(1,-7,0,5),
BackgroundTransparency=1,
},{
H,
})

return J
end

local G=a.load'o'
function av.Dialog(H,J)
local L={
Title=J.Title or"Dialog",
Width=J.Width or 320,
Content=J.Content,
Buttons=J.Buttons or{},

TextPadding=14,
}
local M=G.Create(false,"Dialog",av,au.WindUI,av.UIElements.Main.Main)

M.UIElements.Main.Size=UDim2.new(0,L.Width,0,0)

local N=an("Frame",{
Size=UDim2.new(1,0,1,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=M.UIElements.Main,
},{
an("UIListLayout",{
FillDirection="Vertical",

Padding=UDim.new(0,M.UIPadding),
}),
})

local O=an("Frame",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=N,
},{
an("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,M.UIPadding),
VerticalAlignment="Center",
}),
an("UIPadding",{
PaddingTop=UDim.new(0,L.TextPadding/2),
PaddingLeft=UDim.new(0,L.TextPadding/2),
PaddingRight=UDim.new(0,L.TextPadding/2),
}),
})

local P
if J.Icon then
P=am.Image(
J.Icon,
L.Title..":"..J.Icon,
0,
av,
"Dialog",
true,
J.IconThemed
)
P.Size=UDim2.new(0,22,0,22)
P.Parent=O
end

M.UIElements.UIListLayout=an("UIListLayout",{
Padding=UDim.new(0,12),
FillDirection="Vertical",
HorizontalAlignment="Left",
VerticalFlex="SpaceBetween",
Parent=M.UIElements.Main,
})

an("UISizeConstraint",{
MinSize=Vector2.new(180,20),
MaxSize=Vector2.new(400,math.huge),
Parent=M.UIElements.Main,
})

M.UIElements.Title=an("TextLabel",{
Text=L.Title,
TextSize=20,
FontFace=Font.new(am.Font,Enum.FontWeight.SemiBold),
TextXAlignment="Left",
TextWrapped=true,
RichText=true,
Size=UDim2.new(1,P and-26-M.UIPadding or 0,0,0),
AutomaticSize="Y",
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
Parent=O,
})
if L.Content then
an("TextLabel",{
Text=L.Content,
TextSize=18,
TextTransparency=0.4,
TextWrapped=true,
RichText=true,
FontFace=Font.new(am.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
LayoutOrder=2,
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
Parent=N,
},{
an("UIPadding",{
PaddingLeft=UDim.new(0,L.TextPadding/2),
PaddingRight=UDim.new(0,L.TextPadding/2),
PaddingBottom=UDim.new(0,L.TextPadding/2),
}),
})
end

local Q=an("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
HorizontalAlignment="Center",
HorizontalFlex="Fill",
})

local R=an("Frame",{
Size=UDim2.new(1,0,0,36),
AutomaticSize="None",
BackgroundTransparency=1,
Parent=M.UIElements.Main,
LayoutOrder=4,
},{
Q,






})

local S={}

for T,U in next,L.Buttons do
local V=
aq(U.Title,U.Icon,U.Callback,U.Variant,R,M,true)
table.insert(S,V)
V.Size=UDim2.new(1,0,1,0)
end





















































M:Open()

return M
end

local H=false

av:CreateTopbarButton("Close","x",function()
if not H then
if not av.IgnoreAlerts then
H=true

av:Dialog{

Title="Close Window",
Content="Do you want to close this window? You will not be able to open it again.",
Buttons={
{
Title="Cancel",

Callback=function()
H=false
end,
Variant="Secondary",
},
{
Title="Close Window",

Callback=function()
H=false
av:Destroy()
end,
Variant="Primary",
},
},
}
else
av:Destroy()
end
end
end,(av.Topbar.ButtonsType=="Default"and 999 or 997),nil,Color3.fromHex"#F4695F")

function av.Tag(J,L)
if av.UIElements.Main.Main.Topbar.Center.Visible==false then
av.UIElements.Main.Main.Topbar.Center.Visible=true
end
L.Window=av
return as:New(L,av.UIElements.Main.Main.Topbar.Center.Holder)
end

local J=au.WindUI.GenerateGUID()

local function startResizing(L)
if av.CanResize then
isResizing=true
az.Active=true
initialSize=av.UIElements.Main.Size
initialInputPosition=L.Position


ao(ay.ImageLabel,0.1,{ImageTransparency=0.35}):Play()

am.AddSignal(L.Changed,function()
if L.UserInputState==Enum.UserInputState.End then
if au.WindUI.CurrentInput and au.WindUI.CurrentInput~=J then
return
end

au.WindUI.CurrentInput=nil

isResizing=false
az.Active=false


ao(ay.ImageLabel,0.17,{ImageTransparency=0.8}):Play()
end
end)
end
end

am.AddSignal(ay.InputBegan,function(L)
if
L.UserInputType==Enum.UserInputType.MouseButton1
or L.UserInputType==Enum.UserInputType.Touch
then
if au.WindUI.CurrentInput and au.WindUI.CurrentInput~=J then
return
end
au.WindUI.CurrentInput=J

if av.CanResize then
startResizing(L)
end
end
end)

am.AddSignal(ae.InputChanged,function(L)
if
L.UserInputType==Enum.UserInputType.MouseMovement
or L.UserInputType==Enum.UserInputType.Touch
then
if isResizing and av.CanResize then
local M=L.Position-initialInputPosition
local N=UDim2.new(0,initialSize.X.Offset+M.X*2,0,initialSize.Y.Offset+M.Y*2)

N=UDim2.new(
N.X.Scale,
math.clamp(N.X.Offset,av.MinSize.X,av.MaxSize.X),
N.Y.Scale,
math.clamp(N.Y.Offset,av.MinSize.Y,av.MaxSize.Y)
)

ao(av.UIElements.Main,0.08,{
Size=N,
},Enum.EasingStyle.Quad,Enum.EasingDirection.Out):Play()

av.Size=N
end
end
end)

am.AddSignal(ay.MouseEnter,function()
if au.WindUI.CurrentInput and au.WindUI.CurrentInput~=J then
return
end
if not isResizing then
ao(ay.ImageLabel,0.1,{ImageTransparency=0.35}):Play()
end
end)
am.AddSignal(ay.MouseLeave,function()
if au.WindUI.CurrentInput and au.WindUI.CurrentInput~=J then
return
end
if not isResizing then
ao(ay.ImageLabel,0.17,{ImageTransparency=0.8}):Play()
end
end)



local L=0
local M=0.4
local N
local O=0

function onDoubleClick()
av:SetToTheCenter()
end

am.AddSignal(p.Frame.MouseButton1Up,function()
local P=tick()
local Q=av.Position

O=O+1

if O==1 then
L=P
N=Q

task.spawn(function()
task.wait(M)
if O==1 then
O=0
N=nil
end
end)
elseif O==2 then
if P-L<=M and Q==N then
onDoubleClick()
end

O=0
N=nil
L=0
else
O=1
L=P
N=Q
end
end)



if not av.HideSearchBar then
local P=a.load'ac'
local Q=false





















local R=ap("Search","search",av.UIElements.SideBarContainer,true)
R.Size=UDim2.new(1,-av.UIPadding/2,0,39)
R.Position=UDim2.new(0,av.UIPadding/2,0,0)

am.AddSignal(R.MouseButton1Click,function()
if Q then
return
end

P.new(av.TabModule,av.UIElements.Main,function()

Q=false
if av.Resizable then
av.CanResize=true
end

ao(aA,0.1,{ImageTransparency=1}):Play()
aA.Active=false
end)
ao(aA,0.1,{ImageTransparency=0.65}):Play()
aA.Active=true

Q=true
av.CanResize=false
end)
end



function av.DisableTopbarButtons(P,Q)
for R,S in next,Q do
for T,U in next,av.TopBarButtons do
if U.Name==S then
U.Object.Visible=false
end
end
end
end



























return av
end end end

local aa={
Window=nil,
Theme=nil,
Creator=a.load'd',
LocalizationModule=a.load'e',
NotificationModule=a.load'f',
Themes=nil,
Transparent=false,

TransparencyValue=0.15,

UIScale=1,

ConfigManager=nil,
Version="0.0.0",

Services=a.load'k',

OnThemeChangeFunction=nil,

cloneref=nil,
UIScaleObj=nil,

CreateWindow=nil,

CurrentInput=nil,
}

local ae=(cloneref or clonereference or function(ae)
return ae
end)

aa.cloneref=ae

local ah=ae(game:GetService"HttpService")
local aj=ae(game:GetService"Players")
local ak=ae(game:GetService"CoreGui")
local al=ae(game:GetService"RunService")
local am=ae(game:GetService"UserInputService")

function aa.GenerateGUID()
return ah:GenerateGUID(false)
end

local an=aa.GenerateGUID()

am.InputBegan:Connect(function(ao,ap)




task.defer(function()
if
ao.UserInputType==Enum.UserInputType.MouseButton1
or ao.UserInputType==Enum.UserInputType.Touch
then
if aa.CurrentInput and aa.CurrentInput~=an then
return
end

aa.CurrentInput=an
print(an)

end
end)
end)
am.InputEnded:Connect(function(ao,ap)
if ao.UserInputType==Enum.UserInputType.MouseButton1 or ao.UserInputType==Enum.UserInputType.Touch then
if aa.CurrentInput and aa.CurrentInput~=an then
return
end

aa.CurrentInput=nil
end
end)

local ao=aj.LocalPlayer or nil

local ap=ah:JSONDecode(a.load'l')
if ap then
aa.Version=ap.version
end

local aq=a.load'p'

local ar=aa.Creator

local as=ar.New




local at=a.load't'

local au=protectgui or(syn and syn.protect_gui)or function()end

local av=gethui and gethui()or(ak or ao:WaitForChild"PlayerGui")

local aw=as("UIScale",{
Scale=aa.UIScale,
})

aa.UIScaleObj=aw

aa.ScreenGui=as("ScreenGui",{
Name="WindUI",
Parent=av,
IgnoreGuiInset=true,
ScreenInsets="None",
DisplayOrder=-99999,
},{

as("Folder",{
Name="Window",
}),






as("Folder",{
Name="KeySystem",
}),
as("Folder",{
Name="Popups",
}),
as("Folder",{
Name="ToolTips",
}),
})

aa.NotificationGui=as("ScreenGui",{
Name="WindUI/Notifications",
Parent=av,
IgnoreGuiInset=true,
})
aa.DropdownGui=as("ScreenGui",{
Name="WindUI/Dropdowns",
Parent=av,
IgnoreGuiInset=true,
})
aa.TooltipGui=as("ScreenGui",{
Name="WindUI/Tooltips",
Parent=av,
IgnoreGuiInset=true,
})
au(aa.ScreenGui)
au(aa.NotificationGui)
au(aa.DropdownGui)
au(aa.TooltipGui)

ar.Init(aa)

function aa.SetParent(ax,ay)
if aa.ScreenGui then
aa.ScreenGui.Parent=ay
end
if aa.NotificationGui then
aa.NotificationGui.Parent=ay
end
if aa.DropdownGui then
aa.DropdownGui.Parent=ay
end
if aa.TooltipGui then
aa.TooltipGui.Parent=ay
end
end
math.clamp(aa.TransparencyValue,0,1)

local ax=aa.NotificationModule.Init(aa.NotificationGui)

function aa.Notify(ay,az)
az.Holder=ax.Frame
az.Window=aa.Window

return aa.NotificationModule.New(az)
end

function aa.SetNotificationLower(ay,az)
ax.SetLower(az)
end

function aa.SetFont(ay,az)
ar.UpdateFont(az)
end

function aa.OnThemeChange(ay,az)
aa.OnThemeChangeFunction=az
end

function aa.AddTheme(ay,az)
aa.Themes[az.Name]=az
return az
end

function aa.SetTheme(ay,az)
if aa.Themes[az]then
aa.Theme=aa.Themes[az]
ar.SetTheme(aa.Themes[az])

if aa.OnThemeChangeFunction then
aa.OnThemeChangeFunction(az)
end

return aa.Themes[az]
end
return nil
end

function aa.GetThemes(ay)
return aa.Themes
end
function aa.GetCurrentTheme(ay)
return aa.Theme.Name
end
function aa.GetTransparency(ay)
return aa.Transparent or false
end
function aa.GetWindowSize(ay)
return aa.Window.UIElements.Main.Size
end
function aa.Localization(ay,az)
return aa.LocalizationModule:New(az,ar)
end

function aa.SetLanguage(ay,az)
if ar.Localization then
return ar.SetLanguage(az)
end
return false
end

function aa.ToggleAcrylic(ay,az)
if aa.Window and aa.Window.AcrylicPaint and aa.Window.AcrylicPaint.Model then
aa.Window.Acrylic=az
aa.Window.AcrylicPaint.Model.Transparency=az and 0.98 or 1
if az then
at.Enable()
else
at.Disable()
end
end
end

function aa.Gradient(ay,az,aA)
local aB={}
local b={}

for d,f in next,az do
local g=tonumber(d)
if g then
g=math.clamp(g/100,0,1)

local h=f.Color
if typeof(h)=="string"and string.sub(h,1,1)=="#"then
h=Color3.fromHex(h)
end

local i=f.Transparency or 0

table.insert(aB,ColorSequenceKeypoint.new(g,h))
table.insert(b,NumberSequenceKeypoint.new(g,i))
end
end

table.sort(aB,function(d,f)
return d.Time<f.Time
end)
table.sort(b,function(d,f)
return d.Time<f.Time
end)

if#aB<2 then
table.insert(aB,ColorSequenceKeypoint.new(1,aB[1].Value))
table.insert(b,NumberSequenceKeypoint.new(1,b[1].Value))
end

local d={
Color=ColorSequence.new(aB),
Transparency=NumberSequence.new(b),
}

if aA then
for f,g in pairs(aA)do
d[f]=g
end
end

return d
end

function aa.Popup(ay,az)
az.WindUI=aa
return a.load'u'.new(az,aa.ScreenGui.Popups)
end

aa.Themes=a.load'v'(aa,ar)

ar.Themes=aa.Themes

aa:SetTheme"Dark"
aa:SetLanguage(ar.Language)

function aa.CreateWindow(ay,az)
local aA=a.load'ad'

if not al:IsStudio()and writefile then
if not isfolder"WindUI"then
makefolder"WindUI"
end
if az.Folder then
makefolder(az.Folder)
else
makefolder(az.Title)
end
end

az.WindUI=aa
az.Window=aa.Window
az.Parent=aa.ScreenGui.Window

if aa.Window then
warn"You cannot create more than one window"
return
end

local aB=true

local b=aa.Themes[az.Theme or"Dark"]


ar.SetTheme(b)

local d=gethwid or function()
return aj.LocalPlayer.UserId
end

local f=d()

if az.KeySystem then
aB=false

local function loadKeysystem()
aq.new(az,f,function(g)
aB=g
end)
end

local g=(az.Folder or"Temp").."/"..f..".key"

if az.KeySystem.KeyValidator then
if az.KeySystem.SaveKey and isfile(g)then
local h=readfile(g)
local i=az.KeySystem.KeyValidator(h)

if i then
aB=true
else
loadKeysystem()
end
else
loadKeysystem()
end
elseif not az.KeySystem.API then
if az.KeySystem.SaveKey and isfile(g)then
local h=readfile(g)
local i=(type(az.KeySystem.Key)=="table")and table.find(az.KeySystem.Key,h)
or tostring(az.KeySystem.Key)==tostring(h)

if i then
aB=true
else
loadKeysystem()
end
else
loadKeysystem()
end
else
if isfile(g)then
local h=readfile(g)
local i=false

for l,m in next,az.KeySystem.API do
local p=aa.Services[m.Type]
if p then
local r={}
for u,v in next,p.Args do
table.insert(r,m[v])
end

local u=p.New(table.unpack(r))
local v=u.Verify(h)
if v then
i=true
break
end
end
end

aB=i
if not i then
loadKeysystem()
end
else
loadKeysystem()
end
end

repeat
task.wait()
until aB
end

local g=aA(az)

aa.Transparent=az.Transparent
aa.Window=g

if az.Acrylic then
at.init()
end













return g
end

return aa