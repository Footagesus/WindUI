--[[
     _      ___         ____  ______
    | | /| / (_)__  ___/ / / / /  _/
    | |/ |/ / / _ \/ _  / /_/ // /  
    |__/|__/_/_//_/\_,_/\____/___/
    
    v1.6.62  |  2025-12-09  |  Roblox UI Library for scripts
    
    To view the source code, see the `src/` folder on the official GitHub repository.
    
    Author: Footagesus (Footages, .ftgs, oftgs)
    Github: https://github.com/Footagesus/WindUI
    Discord: https://discord.gg/ftgs-development-hub-1300692552005189632
    License: MIT
]]

local a a={cache={}, load=function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}end return a.cache[b].c end}do function a.a()return{


Primary=Color3.fromHex"#0091FF",

White=Color3.new(1,1,1),
Black=Color3.new(0,0,0),

Dialog="Accent",

Background="Accent",
BackgroundTransparency=0,
Hover="Text",

WindowBackground="Background",

WindowShadow="Black",


WindowTopbarTitle="Text",
WindowTopbarAuthor="Text",
WindowTopbarIcon="Icon",
WindowTopbarButtonIcon="Icon",

TabBackground="Hover",
TabTitle="Text",
TabIcon="Icon",

ElementBackground="Text",
ElementTitle="Text",
ElementDesc="Text",
ElementIcon="Icon",

PopupBackground="Background",
PopupBackgroundTransparency="BackgroundTransparency",
PopupTitle="Text",
PopupContent="Text",
PopupIcon="Icon",

DialogBackground="Background",
DialogBackgroundTransparency="BackgroundTransparency",
DialogTitle="Text",
DialogContent="Text",
DialogIcon="Icon",

Toggle="Button",
ToggleBar="White",

Checkbox="Primary",
CheckboxIcon="White",

Slider="Primary",
SliderThumb="White",
SliderIconFrom=Color3.fromHex"#908F95",
SliderIconTo=Color3.fromHex"#908F95",

Tooltip=Color3.fromHex"4C4C4C",
TooltipText="White",
TooltipSecondary="Primary",
TooltipSecondaryText="White",
}end function a.b()

local b=(cloneref or clonereference or function(b)return b end)

local d=b(game:GetService"RunService")
local e=b(game:GetService"UserInputService")
local f=b(game:GetService"TweenService")
local g=b(game:GetService"LocalizationService")
local h=b(game:GetService"HttpService")local i=

d.Heartbeat

local j="https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"

local l=loadstring(
game.HttpGetAsync and game:HttpGetAsync(j)
or h:GetAsync(j)
)()
l.SetIconsType"lucide"

local m

local p={
Font="rbxassetid://12187365364",
Localization=nil,
CanDraggable=true,
Theme=nil,
Themes=nil,
Icons=l,
Signals={},
Objects={},
LocalizationObjects={},
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
},TextButton={
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
}
},
Colors={
Red="#e53935",
Orange="#f57c00",
Green="#43a047",
Blue="#039be5",
White="#ffffff",
Grey="#484848",
},
ThemeFallbacks=a.load'a',
Shapes={
Square="rbxassetid://82909646051652",
["Square-Outline"]="rbxassetid://72946211851948",

Squircle="rbxassetid://80999662900595",
SquircleOutline="rbxassetid://117788349049947",
["Squircle-Outline"]="rbxassetid://117817408534198",

SquircleOutline2="rbxassetid://117817408534198",

["Shadow-sm"]="rbxassetid://84825982946844",

["Squircle-TL-TR"]="rbxassetid://73569156276236",
["Squircle-BL-BR"]="rbxassetid://93853842912264",
["Squircle-TL-TR-Outline"]="rbxassetid://136702870075563",
["Squircle-BL-BR-Outline"]="rbxassetid://75035847706564",
}
}

function p.Init(r)
m=r
end

function p.AddSignal(r,u)
local v=r:Connect(u)
table.insert(p.Signals,v)
return v
end

function p.DisconnectAll()
for r,u in next,p.Signals do
local v=table.remove(p.Signals,r)
v:Disconnect()
end
end

function p.SafeCallback(r,...)
if not r then
return
end

local u,v=pcall(r,...)
if not u then
if m and m.Window and m.Window.Debug then local
x, z=v:find":%d+: "

warn("[ WindUI: DEBUG Mode ] "..v)

return m:Notify{
Title="DEBUG Mode: Error",
Content=not z and v or v:sub(z+1),
Duration=8,
}
end
end
end

function p.Gradient(r,u)
if m and m.Gradient then
return m:Gradient(r,u)
end

local v={}
local x={}

for z,A in next,r do
local B=tonumber(z)
if B then
B=math.clamp(B/100,0,1)
table.insert(v,ColorSequenceKeypoint.new(B,A.Color))
table.insert(x,NumberSequenceKeypoint.new(B,A.Transparency or 0))
end
end

table.sort(v,function(B,C)return B.Time<C.Time end)
table.sort(x,function(B,C)return B.Time<C.Time end)

if#v<2 then
error"ColorSequence requires at least 2 keypoints"
end

local B={
Color=ColorSequence.new(v),
Transparency=NumberSequence.new(x),
}

if u then
for C,F in pairs(u)do
B[C]=F
end
end

return B
end

function p.SetTheme(r)
p.Theme=r
p.UpdateTheme(nil,false)
end

function p.AddFontObject(r)
table.insert(p.FontObjects,r)
p.UpdateFont(p.Font)
end

function p.UpdateFont(r)
p.Font=r
for u,v in next,p.FontObjects do
v.FontFace=Font.new(r,v.FontFace.Weight,v.FontFace.Style)
end
end

function p.GetThemeProperty(r,u)
local function getValue(v,x)
local z=x[v]

if z==nil then return nil end

if typeof(z)=="string"and string.sub(z,1,1)=="#"then
return Color3.fromHex(z)
end

if typeof(z)=="Color3"then
return z
end

if typeof(z)=="number"then
return z
end

if typeof(z)=="table"and z.Color and z.Transparency then
return z
end

if typeof(z)=="function"then
return z()
end

return z
end

local v=getValue(r,u)
if v~=nil then
if typeof(v)=="string"and string.sub(v,1,1)~="#"then
local x=p.GetThemeProperty(v,u)
if x~=nil then
return x
end
else
return v
end
end

local x=p.ThemeFallbacks[r]
if x~=nil then
if typeof(x)=="string"and string.sub(x,1,1)~="#"then
return p.GetThemeProperty(x,u)
else
return getValue(r,{[r]=x})
end
end

v=getValue(r,p.Themes.Dark)
if v~=nil then
if typeof(v)=="string"and string.sub(v,1,1)~="#"then
local z=p.GetThemeProperty(v,p.Themes.Dark)
if z~=nil then
return z
end
else
return v
end
end

if x~=nil then
if typeof(x)=="string"and string.sub(x,1,1)~="#"then
return p.GetThemeProperty(x,p.Themes.Dark)
else
return getValue(r,{[r]=x})
end
end

return nil
end

function p.AddThemeObject(r,u)
p.Objects[r]={Object=r,Properties=u}
p.UpdateTheme(r,false)
return r
end

function p.AddLangObject(r)
local u=p.LocalizationObjects[r]
local v=u.Object
local x=currentObjTranslationId
p.UpdateLang(v,x)
return v
end

function p.UpdateTheme(r,u)
local function ApplyTheme(v)
for x,z in pairs(v.Properties or{})do
local A=p.GetThemeProperty(z,p.Theme)
if A~=nil then
if typeof(A)=="Color3"then
local B=v.Object:FindFirstChild"WindUIGradient"
if B then
B:Destroy()
end

if not u then
v.Object[x]=A
else
p.Tween(v.Object,0.08,{[x]=A}):Play()
end
elseif typeof(A)=="table"and A.Color and A.Transparency then
v.Object[x]=Color3.new(1,1,1)

local B=v.Object:FindFirstChild"WindUIGradient"
if not B then
B=Instance.new"UIGradient"
B.Name="WindUIGradient"
B.Parent=v.Object
end

B.Color=A.Color
B.Transparency=A.Transparency

for C,F in pairs(A)do
if C~="Color"and C~="Transparency"and B[C]~=nil then
B[C]=F
end
end
elseif typeof(A)=="number"then
if not u then
v.Object[x]=A
else
p.Tween(v.Object,0.08,{[x]=A}):Play()
end
end
else

local B=v.Object:FindFirstChild"WindUIGradient"
if B then
B:Destroy()
end
end
end
end

if r then
local v=p.Objects[r]
if v then
ApplyTheme(v)
end
else
for v,x in pairs(p.Objects)do
ApplyTheme(x)
end
end
end

function p.SetLangForObject(r)
if p.Localization and p.Localization.Enabled then
local u=p.LocalizationObjects[r]
if not u then return end

local v=u.Object
local x=u.TranslationId

local z=p.Localization.Translations[p.Language]
if z and z[x]then
v.Text=z[x]
else
local A=p.Localization and p.Localization.Translations and p.Localization.Translations.en or nil
if A and A[x]then
v.Text=A[x]
else
v.Text="["..x.."]"
end
end
end
end

function p.ChangeTranslationKey(r,u,v)
if p.Localization and p.Localization.Enabled then
local x=string.match(v,"^"..p.Localization.Prefix.."(.+)")
if x then
for z,A in ipairs(p.LocalizationObjects)do
if A.Object==u then
A.TranslationId=x
p.SetLangForObject(z)
return
end
end

table.insert(p.LocalizationObjects,{
TranslationId=x,
Object=u
})
p.SetLangForObject(#p.LocalizationObjects)
end
end
end

function p.UpdateLang(r)
if r then
p.Language=r
end

for u=1,#p.LocalizationObjects do
local v=p.LocalizationObjects[u]
if v.Object and v.Object.Parent~=nil then
p.SetLangForObject(u)
else
p.LocalizationObjects[u]=nil
end
end
end

function p.SetLanguage(r)
p.Language=r
p.UpdateLang()
end

function p.Icon(r,u)
return l.Icon2(r,nil,u~=false)
end

function p.AddIcons(r,u)
return l.AddIcons(r,u)
end

function p.New(r,u,v)
local x=Instance.new(r)

for z,A in next,p.DefaultProperties[r]or{}do
x[z]=A
end

for B,C in next,u or{}do
if B~="ThemeTag"then
x[B]=C
end
if p.Localization and p.Localization.Enabled and B=="Text"then
local F=string.match(C,"^"..p.Localization.Prefix.."(.+)")
if F then
local G=#p.LocalizationObjects+1
p.LocalizationObjects[G]={TranslationId=F,Object=x}

p.SetLangForObject(G)
end
end
end

for F,G in next,v or{}do
G.Parent=x
end

if u and u.ThemeTag then
p.AddThemeObject(x,u.ThemeTag)
end
if u and u.FontFace then
p.AddFontObject(x)
end
return x
end

function p.Tween(r,u,v,...)
return f:Create(r,TweenInfo.new(u,...),v)
end

function p.NewRoundFrame(r,u,v,x,B,C)
local function getImageForType(F)
return p.Shapes[F]
end

local function getSliceCenterForType(F)
return F~="Shadow-sm"and Rect.new(256
,256
,256
,256

)or Rect.new(512,512,512,512)
end

local F=p.New(B and"ImageButton"or"ImageLabel",{
Image=getImageForType(u),
ScaleType="Slice",
SliceCenter=getSliceCenterForType(u),
SliceScale=1,
BackgroundTransparency=1,
ThemeTag=v.ThemeTag and v.ThemeTag
},x)

for G,H in pairs(v or{})do
if G~="ThemeTag"then
F[G]=H
end
end

local function UpdateSliceScale(J)
local L=u~="Shadow-sm"and(J/(256))or(J/512)
F.SliceScale=math.max(L,0.0001)
end

local J={}

function J.SetRadius(L,M)
UpdateSliceScale(M)
end

function J.SetType(L,M)
u=M
F.Image=getImageForType(M)
F.SliceCenter=getSliceCenterForType(M)
UpdateSliceScale(r)
end

function J.UpdateShape(L,M,N)
if N then
u=N
F.Image=getImageForType(N)
F.SliceCenter=getSliceCenterForType(N)
end
if M then
r=M
end
UpdateSliceScale(r)
end

function J.GetRadius(L)
return r
end

function J.GetType(L)
return u
end

UpdateSliceScale(r)

return F,C and J or nil
end

local r=p.New local u=
p.Tween

function p.SetDraggable(v)
p.CanDraggable=v
end



function p.Drag(v,x,B)
local C
local F,G,H
local J={
CanDraggable=true
}

if not x or typeof(x)~="table"then
x={v}
end

local function update(L)
if not F or not J.CanDraggable then return end

local M=L.Position-G
p.Tween(v,0.02,{Position=UDim2.new(
H.X.Scale,H.X.Offset+M.X,
H.Y.Scale,H.Y.Offset+M.Y
)}):Play()
end

for L,M in pairs(x)do
M.InputBegan:Connect(function(N)
if(N.UserInputType==Enum.UserInputType.MouseButton1 or N.UserInputType==Enum.UserInputType.Touch)and J.CanDraggable then
if C==nil then
C=M
F=true
G=N.Position
H=v.Position

if B and typeof(B)=="function"then
B(true,C)
end

N.Changed:Connect(function()
if N.UserInputState==Enum.UserInputState.End then
F=false
C=nil

if B and typeof(B)=="function"then
B(false,nil)
end
end
end)
end
end
end)

M.InputChanged:Connect(function(N)
if F and C==M then
if N.UserInputType==Enum.UserInputType.MouseMovement or N.UserInputType==Enum.UserInputType.Touch then
update(N)
end
end
end)
end

e.InputChanged:Connect(function(N)
if F and C~=nil then
if N.UserInputType==Enum.UserInputType.MouseMovement or N.UserInputType==Enum.UserInputType.Touch then
update(N)
end
end
end)

function J.Set(N,O)
J.CanDraggable=O
end

return J
end


l.Init(r,"Icon")


function p.SanitizeFilename(v)
local x=v:match"([^/]+)$"or v

x=x:gsub("%.[^%.]+$","")

x=x:gsub("[^%w%-_]","_")

if#x>50 then
x=x:sub(1,50)
end

return x
end

function p.Image(v,x,B,C,F,G,H,J)
C=C or"Temp"
x=p.SanitizeFilename(x)

local L=r("Frame",{
Size=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
},{
r("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ScaleType="Crop",
ThemeTag=(p.Icon(v)or H)and{
ImageColor3=G and(J or"Icon")or nil
}or nil,
},{
r("UICorner",{
CornerRadius=UDim.new(0,B)
})
})
})
if p.Icon(v)then
L.ImageLabel:Destroy()

local M=l.Image{
Icon=v,
Size=UDim2.new(1,0,1,0),
Colors={
(G and(J or"Icon")or false),
"Button"
}
}.IconFrame
M.Parent=L
elseif string.find(v,"http")then
local M="WindUI/"..C.."/assets/."..F.."-"..x..".png"
local N,O=pcall(function()
task.spawn(function()
local N=p.Request{
Url=v,
Method="GET",
}.Body

writefile(M,N)


local O,P=pcall(getcustomasset,M)
if O then
L.ImageLabel.Image=P
else
warn(string.format("[ WindUI.Creator ] Failed to load custom asset '%s': %s",M,tostring(P)))
L:Destroy()

return
end
end)
end)
if not N then
warn("[ WindUI.Creator ]  '"..identifyexecutor().."' doesnt support the URL Images. Error: "..O)

L:Destroy()
end
elseif v==""then
L.Visible=false
else
L.ImageLabel.Image=v
end

return L
end



function p.Color3ToHSB(v)
local x,B,C=v.R,v.G,v.B
local F=math.max(x,B,C)
local G=math.min(x,B,C)
local H=F-G

local J=0
if H~=0 then
if F==x then
J=(B-C)/H%6
elseif F==B then
J=(C-x)/H+2
else
J=(x-B)/H+4
end
J=J*60
else
J=0
end

local L=(F==0)and 0 or(H/F)
local M=F

return{
h=math.floor(J+0.5),
s=L,
b=M
}
end

function p.GetPerceivedBrightness(v)
local x=v.R
local B=v.G
local C=v.B
return 0.299*x+0.587*B+0.114*C
end

function p.GetTextColorForHSB(v)
local x=p.Color3ToHSB(v)local
B, C, F=x.h, x.s, x.b
if p.GetPerceivedBrightness(v)>0.68 then
return Color3.fromHSV(B/360,0,0.05)
else
return Color3.fromHSV(B/360,0,0.98)
end
end

function p.GetAverageColor(v)
local x,B,C=0,0,0
local F=v.Color.Keypoints
for G,H in ipairs(F)do

x=x+H.Value.R
B=B+H.Value.G
C=C+H.Value.B
end
local J=#F
return Color3.new(x/J,B/J,C/J)
end


return p end function a.c()

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



return b end function a.d()
local b=a.load'b'
local d=b.New
local e=b.Tween

local f={
Size=UDim2.new(0,300,1,-156),
SizeLower=UDim2.new(0,300,1,-56),
UICorner=13,
UIPadding=14,

Holder=nil,
NotificationIndex=0,
Notifications={}
}

function f.Init(g)
local h={
Lower=false
}

function h.SetLower(j)
h.Lower=j
h.Frame.Size=j and f.SizeLower or f.Size
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
PaddingBottom=UDim.new(0,29)
})
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
CanClose=true,
UIElements={},
Closed=false,
}
if h.CanClose==nil then
h.CanClose=true
end
f.NotificationIndex=f.NotificationIndex+1
f.Notifications[f.NotificationIndex]=h









local j

if h.Icon then





















j=b.Image(
h.Icon,
h.Title..":"..h.Icon,
0,
g.Window,
"Notification",
h.IconThemed
)
j.Size=UDim2.new(0,26,0,26)
j.Position=UDim2.new(0,f.UIPadding,0,f.UIPadding)

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
ImageColor3="Text"
},
ImageTransparency=.4,
},{
d("TextButton",{
Size=UDim2.new(1,8,1,8),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Text="",
})
})
end

local m=d("Frame",{
Size=UDim2.new(0,0,1,0),
BackgroundTransparency=.95,
ThemeTag={
BackgroundColor3="Text",
},

})

local p=d("Frame",{
Size=UDim2.new(1,
h.Icon and-28-f.UIPadding or 0,
1,0),
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
TextSize=16,
ThemeTag={
TextColor3="Text"
},
Text=h.Title,
FontFace=Font.new(b.Font,Enum.FontWeight.Medium)
}),
d("UIListLayout",{
Padding=UDim.new(0,f.UIPadding/3)
})
})

if h.Content then
d("TextLabel",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
TextWrapped=true,
TextXAlignment="Left",
RichText=true,
BackgroundTransparency=1,
TextTransparency=.4,
TextSize=15,
ThemeTag={
TextColor3="Text"
},
Text=h.Content,
FontFace=Font.new(b.Font,Enum.FontWeight.Medium),
Parent=p
})
end


local r=b.NewRoundFrame(f.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
Position=UDim2.new(2,0,1,0),
AnchorPoint=Vector2.new(0,1),
AutomaticSize="Y",
ImageTransparency=.05,
ThemeTag={
ImageColor3="Background"
},

},{
d("CanvasGroup",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
m,
d("UICorner",{
CornerRadius=UDim.new(0,f.UICorner),
})

}),
d("ImageLabel",{
Name="Background",
Image=h.Background,
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
ScaleType="Crop",
ImageTransparency=h.BackgroundImageTransparency

},{
d("UICorner",{
CornerRadius=UDim.new(0,f.UICorner),
})
}),

p,
j,l,
})

local u=d("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Parent=g.Holder
},{
r
})

function h.Close(v)
if not h.Closed then
h.Closed=true
e(u,0.45,{Size=UDim2.new(1,0,0,-8)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
e(r,0.55,{Position=UDim2.new(2,0,1,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
task.wait(.45)
u:Destroy()
end
end

task.spawn(function()
task.wait()
e(u,0.45,{Size=UDim2.new(
1,
0,
0,
r.AbsoluteSize.Y
)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
e(r,0.45,{Position=UDim2.new(0,0,1,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if h.Duration then
e(m,h.Duration,{Size=UDim2.new(1,0,1,0)},Enum.EasingStyle.Linear,Enum.EasingDirection.InOut):Play()
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

return f end function a.e()











local b=4294967296;local d=b-1;local function c(e,f)local g,h=0,1;while e~=0 or f~=0 do local j,l=e%2,f%2;local m=(j+l)%2;g=g+m*h;e=math.floor(e/2)f=math.floor(f/2)h=h*2 end;return g%b end;local function k(e,f,g,...)local h;if f then e=e%b;f=f%b;h=c(e,f)if g then h=k(h,g,...)end;return h elseif e then return e%b else return 0 end end;local function n(e,f,g,...)local h;if f then e=e%b;f=f%b;h=(e+f-c(e,f))/2;if g then h=n(h,g,...)end;return h elseif e then return e%b else return d end end;local function o(e)return d-e end;local function q(e,f)if f<0 then return lshift(e,-f)end;return math.floor(e%4294967296/2^f)end;local function s(e,f)if f>31 or f<-31 then return 0 end;return q(e%b,f)end;local function lshift(e,f)if f<0 then return s(e,-f)end;return e*2^f%4294967296 end;local function t(e,f)e=e%b;f=f%32;local g=n(e,2^f-1)return s(e,f)+lshift(g,32-f)end;local e={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(f)return string.gsub(f,".",function(g)return string.format("%02x",string.byte(g))end)end;local function y(f,g)local h=""for j=1,g do local l=f%256;h=string.char(l)..h;f=(f-l)/256 end;return h end;local function D(f,g)local h=0;for j=g,g+3 do h=h*256+string.byte(f,j)end;return h end;local function E(f,g)local h=64-(g+9)%64;g=y(8*g,8)f=f.."\128"..string.rep("\0",h)..g;assert(#f%64==0)return f end;local function I(f)f[1]=0x6a09e667;f[2]=0xbb67ae85;f[3]=0x3c6ef372;f[4]=0xa54ff53a;f[5]=0x510e527f;f[6]=0x9b05688c;f[7]=0x1f83d9ab;f[8]=0x5be0cd19;return f end;local function K(f,g,h)local j={}for l=1,16 do j[l]=D(f,g+(l-1)*4)end;for l=17,64 do local m=j[l-15]local p=k(t(m,7),t(m,18),s(m,3))m=j[l-2]j[l]=(j[l-16]+p+j[l-7]+k(t(m,17),t(m,19),s(m,10)))%b end;local l,m,p,r,u,v,x,B=h[1],h[2],h[3],h[4],h[5],h[6],h[7],h[8]for C=1,64 do local F=k(t(l,2),t(l,13),t(l,22))local G=k(n(l,m),n(l,p),n(m,p))local H=(F+G)%b;local J=k(t(u,6),t(u,11),t(u,25))local L=k(n(u,v),n(o(u),x))local M=(B+J+L+e[C]+j[C])%b;B=x;x=v;v=u;u=(r+M)%b;r=p;p=m;m=l;l=(M+H)%b end;h[1]=(h[1]+l)%b;h[2]=(h[2]+m)%b;h[3]=(h[3]+p)%b;h[4]=(h[4]+r)%b;h[5]=(h[5]+u)%b;h[6]=(h[6]+v)%b;h[7]=(h[7]+x)%b;h[8]=(h[8]+B)%b end;local function Z(f)f=E(f,#f)local g=I{}for h=1,#f,64 do K(f,h,g)end;return w(y(g[1],4)..y(g[2],4)..y(g[3],4)..y(g[4],4)..y(g[5],4)..y(g[6],4)..y(g[7],4)..y(g[8],4))end;local f;local g={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local h={["/"]="/"}for j,l in pairs(g)do h[l]=j end;local m=function(m)return"\\"..(g[m]or string.format("u%04x",m:byte()))end;local p=function(p)return"null"end;local r=function(r,u)local v={}u=u or{}if u[r]then error"circular reference"end;u[r]=true;if rawget(r,1)~=nil or next(r)==nil then local x=0;for B in pairs(r)do if type(B)~="number"then error"invalid table: mixed or invalid key types"end;x=x+1 end;if x~=#r then error"invalid table: sparse array"end;for C,F in ipairs(r)do table.insert(v,f(F,u))end;u[r]=nil;return"["..table.concat(v,",").."]"else for x,B in pairs(r)do if type(x)~="string"then error"invalid table: mixed or invalid key types"end;table.insert(v,f(x,u)..":"..f(B,u))end;u[r]=nil;return"{"..table.concat(v,",").."}"end end;local u=function(u)return'"'..u:gsub('[%z\1-\31\\"]',m)..'"'end;local v=function(v)if v~=v or v<=-math.huge or v>=math.huge then error("unexpected number value '"..tostring(v).."'")end;return string.format("%.14g",v)end;local x={["nil"]=p,table=r,string=u,number=v,boolean=tostring}f=function(B,C)local F=type(B)local G=x[F]if G then return G(B,C)end;error("unexpected type '"..F.."'")end;local B=function(B)return f(B)end;local C;local F=function(...)local F={}for G=1,select("#",...)do F[select(G,...)]=true end;return F end;local G=F(" ","\t","\r","\n")local H=F(" ","\t","\r","\n","]","}",",")local J=F("\\","/",'"',"b","f","n","r","t","u")local L=F("true","false","null")local M={["true"]=true,["false"]=false,null=nil}local N=function(N,O,P,Q)for R=O,#N do if P[N:sub(R,R)]~=Q then return R end end;return#N+1 end;local O=function(O,P,Q)local R=1;local S=1;for T=1,P-1 do S=S+1;if O:sub(T,T)=="\n"then R=R+1;S=1 end end;error(string.format("%s at line %d col %d",Q,R,S))end;local P=function(P)local Q=math.floor;if P<=0x7f then return string.char(P)elseif P<=0x7ff then return string.char(Q(P/64)+192,P%64+128)elseif P<=0xffff then return string.char(Q(P/4096)+224,Q(P%4096/64)+128,P%64+128)elseif P<=0x10ffff then return string.char(Q(P/262144)+240,Q(P%262144/4096)+128,Q(P%4096/64)+128,P%64+128)end;error(string.format("invalid unicode codepoint '%x'",P))end;local Q=function(Q)local R=tonumber(Q:sub(1,4),16)local S=tonumber(Q:sub(7,10),16)if S then return P((R-0xd800)*0x400+S-0xdc00+0x10000)else return P(R)end end;local R=function(R,S)local T=""local U=S+1;local V=U;while U<=#R do local W=R:byte(U)if W<32 then O(R,U,"control character in string")elseif W==92 then T=T..R:sub(V,U-1)U=U+1;local X=R:sub(U,U)if X=="u"then local Y=R:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",U+1)or R:match("^%x%x%x%x",U+1)or O(R,U-1,"invalid unicode escape in string")T=T..Q(Y)U=U+#Y else if not J[X]then O(R,U-1,"invalid escape char '"..X.."' in string")end;T=T..h[X]end;V=U+1 elseif W==34 then T=T..R:sub(V,U-1)return T,U+1 end;U=U+1 end;O(R,S,"expected closing quote for string")end;local S=function(S,T)local U=N(S,T,H)local V=S:sub(T,U-1)local W=tonumber(V)if not W then O(S,T,"invalid number '"..V.."'")end;return W,U end;local T=function(T,U)local V=N(T,U,H)local W=T:sub(U,V-1)if not L[W]then O(T,U,"invalid literal '"..W.."'")end;return M[W],V end;local U=function(U,V)local W={}local X=1;V=V+1;while 1 do local Y;V=N(U,V,G,true)if U:sub(V,V)=="]"then V=V+1;break end;Y,V=C(U,V)W[X]=Y;X=X+1;V=N(U,V,G,true)local _=U:sub(V,V)V=V+1;if _=="]"then break end;if _~=","then O(U,V,"expected ']' or ','")end end;return W,V end;local aa=function(V,W)local X={}W=W+1;while 1 do local Y,_;W=N(V,W,G,true)if V:sub(W,W)=="}"then W=W+1;break end;if V:sub(W,W)~='"'then O(V,W,"expected string for key")end;Y,W=C(V,W)W=N(V,W,G,true)if V:sub(W,W)~=":"then O(V,W,"expected ':' after key")end;W=N(V,W+1,G,true)_,W=C(V,W)X[Y]=_;W=N(V,W,G,true)local aa=V:sub(W,W)W=W+1;if aa=="}"then break end;if aa~=","then O(V,W,"expected '}' or ','")end end;return X,W end;local V={['"']=R,["0"]=S,["1"]=S,["2"]=S,["3"]=S,["4"]=S,["5"]=S,["6"]=S,["7"]=S,["8"]=S,["9"]=S,["-"]=S,t=T,f=T,n=T,["["]=U,["{"]=aa}C=function(W,X)local Y=W:sub(X,X)local _=V[Y]if _ then return _(W,X)end;O(W,X,"unexpected character '"..Y.."'")end;local W=function(W)if type(W)~="string"then error("expected argument of type string, got "..type(W))end;local X,Y=C(W,N(W,1,G,true))Y=N(W,Y,G,true)if Y<=#W then O(W,Y,"trailing garbage")end;return X end;
local X,Y,_=B,W,Z;





local ab={}

local ac=(cloneref or clonereference or function(ac)return ac end)


function ab.New(ad,ae)

local af=ad;
local ag=ae;
local ah=true;


local ai=function(ai)end;


repeat task.wait(1)until game:IsLoaded();


local aj=false;
local ak,al,am,an,ao,ap,aq,ar,as=setclipboard or toclipboard,request or http_request or syn_request,string.char,tostring,string.sub,os.time,math.random,math.floor,gethwid or function()return ac(game:GetService"Players").LocalPlayer.UserId end
local at,au="",0;


local av="https://api.platoboost.app";
local aw=al{
Url=av.."/public/connectivity",
Method="GET"
};
if aw.StatusCode~=200 and aw.StatusCode~=429 then
av="https://api.platoboost.net";
end


function cacheLink()
if au+(600)<ap()then
local ax=al{
Url=av.."/public/start",
Method="POST",
Body=X{
service=af,
identifier=_(as())
},
Headers={
["Content-Type"]="application/json",
["User-Agent"]="Roblox/Exploit"
}
};

if ax.StatusCode==200 then
local ay=Y(ax.Body);

if ay.success==true then
at=ay.data.url;
au=ap();
return true,at
else
ai(ay.message);
return false,ay.message
end
elseif ax.StatusCode==429 then
local ay="you are being rate limited, please wait 20 seconds and try again.";
ai(ay);
return false,ay
end

local ay="Failed to cache link.";
ai(ay);
return false,ay
else
return true,at
end
end

cacheLink();


local ax=function()
local ax=""
for ay=1,16 do
ax=ax..am(ar(aq()*(26))+97)
end
return ax
end


for ay=1,5 do
local az=ax();
task.wait(0.2)
if ax()==az then
local aA="platoboost nonce error.";
ai(aA);
error(aA);
end
end


local ay=function()
local ay,az=cacheLink();

if ay then
ak(az);
end
end


local az=function(az)
local aA=ax();
local aB=av.."/public/redeem/"..an(af);

local aC={
identifier=_(as()),
key=az
}

if ah then
aC.nonce=aA;
end

local aD=al{
Url=aB,
Method="POST",
Body=X(aC),
Headers={
["Content-Type"]="application/json"
}
};

if aD.StatusCode==200 then
local aE=Y(aD.Body);

if aE.success==true then
if aE.data.valid==true then
if ah then
if aE.data.hash==_("true".."-"..aA.."-"..ag)then
return true
else
ai"failed to verify integrity.";
return false
end
else
return true
end
else
ai"key is invalid.";
return false
end
else
if ao(aE.message,1,27)=="unique constraint violation"then
ai"you already have an active key, please wait for it to expire before redeeming it.";
return false
else
ai(aE.message);
return false
end
end
elseif aD.StatusCode==429 then
ai"you are being rate limited, please wait 20 seconds and try again.";
return false
else
ai"server returned an invalid status code, please try again later.";
return false
end
end


local aA=function(aA)
if aj==true then
return false,("A request is already being sent, please slow down.")
else
aj=true;
end

local aB=ax();
local aC=av.."/public/whitelist/"..an(af).."?identifier=".._(as()).."&key="..aA;

if ah then
aC=aC.."&nonce="..aB;
end

local aD=al{
Url=aC,
Method="GET",
};

aj=false;

if aD.StatusCode==200 then
local aE=Y(aD.Body);

if aE.success==true then
if aE.data.valid==true then
if ah then
if aE.data.hash==_("true".."-"..aB.."-"..ag)then
return true,""
else
return false,("failed to verify integrity.")
end
else
return true
end
else
if ao(aA,1,4)=="KEY_"then
return true,az(aA)
else
return false,("Key is invalid.")
end
end
else
return false,(aE.message)
end
elseif aD.StatusCode==429 then
return false,("You are being rate limited, please wait 20 seconds and try again.")
else
return false,("Server returned an invalid status code, please try again later.")
end
end


local aB=function(aB)
local aC=ax();
local aD=av.."/public/flag/"..an(af).."?name="..aB;

if ah then
aD=aD.."&nonce="..aC;
end

local aE=al{
Url=aD,
Method="GET",
};

if aE.StatusCode==200 then
local aF=Y(aE.Body);

if aF.success==true then
if ah then
if aF.data.hash==_(an(aF.data.value).."-"..aC.."-"..ag)then
return aF.data.value
else
ai"failed to verify integrity.";
return nil
end
else
return aF.data.value
end
else
ai(aF.message);
return nil
end
else
return nil
end
end


return{
Verify=aA,
GetFlag=aB,
Copy=ay,
}
end


return ab end function a.f()









local aa=(cloneref or clonereference or function(aa)return aa end)

local ab=aa(game:GetService"HttpService")
local ac={}



function ac.New(ad)
local ae=gethwid or function()return aa(game:GetService"Players").LocalPlayer.UserId end
local af,ag=request or http_request or syn_request,setclipboard or toclipboard

function ValidateKey(ah)
local ai="https://pandadevelopment.net/v2_validation?key="..tostring(ah).."&service="..tostring(ad).."&hwid="..tostring(ae())


local aj,ak=pcall(function()
return af{
Url=ai,
Method="GET",
Headers={["User-Agent"]="Roblox/Exploit"}
}
end)

if aj and ak then
if ak.Success then
local al,am=pcall(function()
return ab:JSONDecode(ak.Body)
end)

if al and am then
if am.V2_Authentication and am.V2_Authentication=="success"then

return true,"Authenticated"
else
local an=am.Key_Information.Notes or"Unknown reason"

return false,"Authentication failed: "..an
end
else

return false,"JSON decode error"
end
else
warn("[Pelinda Ov2.5] HTTP request was not successful. Code: "..tostring(ak.StatusCode).." Message: "..ak.StatusMessage)
return false,"HTTP request failed: "..ak.StatusMessage
end
else

return false,"Request pcall error"
end
end

function GetKeyLink()
return"https://pandadevelopment.net/getkey?service="..tostring(ad).."&hwid="..tostring(ae())
end

function CopyLink()
return ag(GetKeyLink())
end

return{
Verify=ValidateKey,
Copy=CopyLink
}
end

return ac end function a.g()








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


return aa end function a.h()
return{
platoboost={
Name="Platoboost",
Icon="rbxassetid://75920162824531",
Args={"ServiceId","Secret"},


New=a.load'e'.New
},
pandadevelopment={
Name="Panda Development",
Icon="panda",
Args={"ServiceId"},


New=a.load'f'.New
},
luarmor={
Name="Luarmor",
Icon="rbxassetid://130918283130165",
Args={"ScriptId","Discord"},


New=a.load'g'.New
},

}end function a.i()


return[[
{
    "name": "windui",
    "version": "1.6.62",
    "main": "./dist/main.lua",
    "repository": "https://github.com/Footagesus/WindUI",
    "discord": "https://discord.gg/ftgs-development-hub-1300692552005189632",
    "author": "Footagesus",
    "description": "Roblox UI Library for scripts",
    "license": "MIT",
    "scripts": {
        "dev": "bash build/build.sh dev $INPUT_FILE",
        "build": "bash build/build.sh build $INPUT_FILE",
        "live": "python -m http.server 8642",
        "watch": "chokidar . -i 'node_modules' -i 'dist' -i 'build' -c 'npm run dev --'",
        "live-build": "concurrently \"npm run live\" \"npm run watch --\"",
        "example-live-build": "INPUT_FILE=main_example.lua npm run live-build",
        "updater": "python updater/main.py"
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
}]]end function a.j()

local aa={}

local ab=a.load'b'
local ac=ab.New
local ad=ab.Tween


function aa.New(ae,af,ag,ah,ai,aj,ak,al)
ah=ah or"Primary"
local am=al or(not ak and 10 or 99)
local an
if af and af~=""then
an=ac("ImageLabel",{
Image=ab.Icon(af)[1],
ImageRectSize=ab.Icon(af)[2].ImageRectSize,
ImageRectOffset=ab.Icon(af)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ImageColor3=ah=="White"and Color3.new(0,0,0)or nil,
ImageTransparency=ah=="White"and.4 or 0,
ThemeTag={
ImageColor3=ah~="White"and"Icon"or nil,
}
})
end

local ao=ac("TextButton",{
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
Parent=ai,
BackgroundTransparency=1
},{
ab.NewRoundFrame(am,"Squircle",{
ThemeTag={
ImageColor3=ah~="White"and"Button"or nil,
},
ImageColor3=ah=="White"and Color3.new(1,1,1)or nil,
Size=UDim2.new(1,0,1,0),
Name="Squircle",
ImageTransparency=ah=="Primary"and 0 or ah=="White"and 0 or 1
}),

ab.NewRoundFrame(am,"Squircle",{



ImageColor3=Color3.new(1,1,1),
Size=UDim2.new(1,0,1,0),
Name="Special",
ImageTransparency=ah=="Secondary"and 0.95 or 1
}),

ab.NewRoundFrame(am,"Shadow-sm",{



ImageColor3=Color3.new(0,0,0),
Size=UDim2.new(1,3,1,3),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Shadow",

ImageTransparency=1,
Visible=not ak
}),

ab.NewRoundFrame(am,not ak and"SquircleOutline"or"SquircleOutline2",{
ThemeTag={
ImageColor3=ah~="White"and"Outline"or nil,
},
Size=UDim2.new(1,0,1,0),
ImageColor3=ah=="White"and Color3.new(0,0,0)or nil,
ImageTransparency=ah=="Primary"and.95 or.85,
Name="SquircleOutline",
},{
ac("UIGradient",{
Rotation=70,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
})
}),

ab.NewRoundFrame(am,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ThemeTag={
ImageColor3=ah~="White"and"Text"or nil
},
ImageColor3=ah=="White"and Color3.new(0,0,0)or nil,
ImageTransparency=1
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
TextColor3=ah=="Primary"and Color3.new(1,1,1)or ah=="White"and Color3.new(0,0,0)or nil,
AutomaticSize="XY",
TextSize=18,
})
})
})

ab.AddSignal(ao.MouseEnter,function()
ad(ao.Frame,.047,{ImageTransparency=.95}):Play()
end)
ab.AddSignal(ao.MouseLeave,function()
ad(ao.Frame,.047,{ImageTransparency=1}):Play()
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


return aa end function a.k()
local aa={}

local ab=a.load'b'
local ac=ab.New local ad=
ab.Tween


function aa.New(ae,af,ag,ah,ai,aj,ak,al)
ah=ah or"Input"
local am=ak or 10
local an
if af and af~=""then
an=ac("ImageLabel",{
Image=ab.Icon(af)[1],
ImageRectSize=ab.Icon(af)[2].ImageRectSize,
ImageRectOffset=ab.Icon(af)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
}
})
end

local ao=ah~="Input"

local ap=ac("TextBox",{
BackgroundTransparency=1,
TextSize=17,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
Size=UDim2.new(1,an and-29 or 0,1,0),
PlaceholderText=ae,
ClearTextOnFocus=al or false,
ClipsDescendants=true,
TextWrapped=ao,
MultiLine=ao,
TextXAlignment="Left",
TextYAlignment=ah=="Input"and"Center"or"Top",

ThemeTag={
PlaceholderColor3="PlaceholderText",
TextColor3="Text",
},
})

local aq=ac("Frame",{
Size=UDim2.new(1,0,0,42),
Parent=ag,
BackgroundTransparency=1
},{
ac("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ab.NewRoundFrame(am,"Squircle",{
ThemeTag={
ImageColor3="Accent",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.97,
}),
ab.NewRoundFrame(am,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.95,
},{













}),
ab.NewRoundFrame(am,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=.95
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
an,
ap,
})
})
})










if aj then
ab.AddSignal(ap:GetPropertyChangedSignal"Text",function()
if ai then
ab.SafeCallback(ai,ap.Text)
end
end)
else
ab.AddSignal(ap.FocusLost,function()
if ai then
ab.SafeCallback(ai,ap.Text)
end
end)
end

return aq
end


return aa end function a.l()
local aa=a.load'b'
local ab=aa.New
local ac=aa.Tween



local ad={
Holder=nil,

Parent=nil,
}

function ad.Init(ae,af)
Window=ae
ad.Parent=af
return ad
end

function ad.Create(ae,af)
local ag={
UICorner=24,
UIPadding=15,
UIElements={}
}

if ae then ag.UIPadding=0 end
if ae then ag.UICorner=26 end

af=af or"Dialog"

if not ae then
ag.UIElements.FullScreen=ab("Frame",{
ZIndex=999,
BackgroundTransparency=1,
BackgroundColor3=Color3.fromHex"#000000",
Size=UDim2.new(1,0,1,0),
Active=false,
Visible=false,
Parent=ad.Parent or(Window and Window.UIElements and Window.UIElements.Main and Window.UIElements.Main.Main)
},{
ab("UICorner",{
CornerRadius=UDim.new(0,Window.UICorner)
})
})
end

ag.UIElements.Main=ab("Frame",{
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
PaddingTop=UDim.new(0,ag.UIPadding),
PaddingLeft=UDim.new(0,ag.UIPadding),
PaddingRight=UDim.new(0,ag.UIPadding),
PaddingBottom=UDim.new(0,ag.UIPadding),
})
})

ag.UIElements.MainContainer=aa.NewRoundFrame(ag.UICorner,"Squircle",{
Visible=false,

ImageTransparency=ae and 0.15 or 0,
Parent=ae and ad.Parent or ag.UIElements.FullScreen,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
AutomaticSize="XY",
ThemeTag={
ImageColor3=af.."Background",
ImageTransparency=af.."BackgroundTransparency",
},
ZIndex=9999,
},{





ag.UIElements.Main,



















})

function ag.Open(ah)
if not ae then
ag.UIElements.FullScreen.Visible=true
ag.UIElements.FullScreen.Active=true
end

task.spawn(function()
ag.UIElements.MainContainer.Visible=true

if not ae then
ac(ag.UIElements.FullScreen,0.1,{BackgroundTransparency=.3}):Play()
end
ac(ag.UIElements.MainContainer,0.1,{ImageTransparency=0}):Play()


task.spawn(function()
task.wait(0.05)
ag.UIElements.Main.Visible=true
end)
end)
end
function ag.Close(ah)
if not ae then
ac(ag.UIElements.FullScreen,0.1,{BackgroundTransparency=1}):Play()
ag.UIElements.FullScreen.Active=false
task.spawn(function()
task.wait(.1)
ag.UIElements.FullScreen.Visible=false
end)
end
ag.UIElements.Main.Visible=false

ac(ag.UIElements.MainContainer,0.1,{ImageTransparency=1}):Play()



task.spawn(function()
task.wait(.1)
if not ae then
ag.UIElements.FullScreen:Destroy()
else
ag.UIElements.MainContainer:Destroy()
end
end)

return function()end
end


return ag
end

return ad end function a.m()
local aa={}


local ab=a.load'b'
local ac=ab.New
local ad=ab.Tween

local ae=a.load'j'.New
local af=a.load'k'.New

function aa.new(ag,ah,ai,aj)
local ak=a.load'l'.Init(nil,ag.WindUI.ScreenGui.KeySystem)
local al=ak.Create(true)

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

aq=ab.Image(
ag.Icon,
ag.Title..":"..ag.Icon,
0,
"Temp",
"KeySystem",
ag.IconThemed
)
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
TextSize=20
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
TextSize=16
})

local at=ac("Frame",{
BackgroundTransparency=1,
AutomaticSize="XY",
},{
ac("UIListLayout",{
Padding=UDim.new(0,14),
FillDirection="Horizontal",
VerticalAlignment="Center"
}),
aq,ar
})

local au=ac("Frame",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
},{





at,as,
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
TextTransparency=.4,
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
})
})
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
ScaleType="Crop"
},{
az,
ac("UICorner",{
CornerRadius=UDim.new(0,20),
})
})
end

ac("Frame",{

Size=UDim2.new(1,ay and-ao or 0,1,0),
Position=UDim2.new(0,ay and ao or 0,0,0),
BackgroundTransparency=1,
Parent=al.UIElements.Main
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
})
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
local aC=ae("Get key","key",nil,"Secondary",ax.Frame)

local aD=ab.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,1,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=.9,
})

ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
Parent=aC.Frame,
},{
aD,
ac("UIPadding",{
PaddingLeft=UDim.new(0,5),
PaddingRight=UDim.new(0,5),
})
})

local aE=ab.Image(
"chevron-down",
"chevron-down",
0,
"Temp",
"KeySystem",
true
)

aE.Size=UDim2.new(1,0,1,0)

ac("Frame",{
Size=UDim2.new(0,21,0,21),
Parent=aC.Frame,
BackgroundTransparency=1,
},{
aE
})

local aF=ab.NewRoundFrame(15,"Squircle",{
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
})
})

local b=ac("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(0,aA,0,0),
ClipsDescendants=true,
AnchorPoint=Vector2.new(1,0),
Parent=aC,
Position=UDim2.new(1,0,1,15)
},{
aF
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
Parent=aF,
},{
ac("UIPadding",{
PaddingTop=UDim.new(0,10),
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingBottom=UDim.new(0,10),
})
})

for d,f in next,ag.KeySystem.API do
local g=ag.WindUI.Services[f.Type]
if g then
local h={}
for j,l in next,g.Args do
table.insert(h,f[l])
end

local m=g.New(table.unpack(h))
m.Type=f.Type
table.insert(am,m)

local p=ab.Image(
f.Icon or g.Icon or Icons[f.Type]or"user",
f.Icon or g.Icon or Icons[f.Type]or"user",
0,
"Temp",
"KeySystem",
true
)
p.Size=UDim2.new(0,24,0,24)

local r=ab.NewRoundFrame(10,"Squircle",{
Size=UDim2.new(1,0,0,0),
ThemeTag={ImageColor3="Text"},
ImageTransparency=1,
Parent=aF,
AutomaticSize="Y",
},{
ac("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,10),
VerticalAlignment="Center",
}),
p,
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
Text=f.Title or g.Name,
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
Text=f.Desc or"",
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
ThemeTag={TextColor3="Text"},
TextTransparency=0.2,
TextSize=16,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
TextWrapped=true,
Visible=f.Desc and true or false,
TextXAlignment="Left",
})
})
},true)

ab.AddSignal(r.MouseEnter,function()
ad(r,0.08,{ImageTransparency=.95}):Play()
end)
ab.AddSignal(r.InputEnded,function()
ad(r,0.08,{ImageTransparency=1}):Play()
end)
ab.AddSignal(r.MouseButton1Click,function()
m.Copy()
ag.WindUI:Notify{
Title="Key System",
Content="Key link copied to clipboard.",
Image="key",
}
end)
end
end

ab.AddSignal(aC.MouseButton1Click,function()
if not aB then
ad(b,.3,{Size=UDim2.new(0,aA,0,aF.AbsoluteSize.Y+1)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(aE,.3,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
else
ad(b,.25,{Size=UDim2.new(0,aA,0,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(aE,.25,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
aB=not aB
end)

end

local function handleSuccess(aA)
al:Close()()
writefile((ag.Folder or"Temp").."/"..ah..".key",tostring(aA))
task.wait(.4)
ai(true)
end

local aA=ae("Submit","arrow-right",function()
local aA=tostring(an or"empty")local aB=
ag.Folder or ag.Title

if ag.KeySystem.KeyValidator then
local aC=ag.KeySystem.KeyValidator(aA)

if aC then
if ag.KeySystem.SaveKey then
handleSuccess(aA)
else
al:Close()()
task.wait(.4)
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
local aC=type(ag.KeySystem.Key)=="table"
and table.find(ag.KeySystem.Key,aA)
or ag.KeySystem.Key==aA

if aC then
if ag.KeySystem.SaveKey then
handleSuccess(aA)
else
al:Close()()
task.wait(.4)
ai(true)
end
end
else
local aC,aD
for aE,aF in next,am do
local b,d=aF.Verify(aA)
if b then
aC,aD=true,d
break
end
aD=d
end

if aC then
handleSuccess(aA)
else
ag.WindUI:Notify{
Title="Key System. Error",
Content=aD,
Icon="triangle-alert",
}
end
end
end,"Primary",ax)

aA.AnchorPoint=Vector2.new(1,0.5)
aA.Position=UDim2.new(1,0,0.5,0)










al:Open()
end

return aa end function a.n()



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

return{viewportPointToWorld,getOffset}end function a.o()



local aa=(cloneref or clonereference or function(aa)return aa end)


local ab=a.load'b'
local ac=ab.New


local ad,ae=unpack(a.load'n')
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
ah.SetVisibility(al.Visible)
end)
end

ah.SetVisibility=function(al)
aj.Transparency=al and 0.98 or 1
end

ah.Frame=ak
ah.Model=aj

return ah
end end function a.p()



local aa=a.load'b'
local ab=a.load'o'

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
end end function a.q()



local aa=(cloneref or clonereference or function(aa)return aa end)


local ab={
AcrylicBlur=a.load'o',

AcrylicPaint=a.load'p',
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
for ag,ah in pairs(aa(game:GetService"Workspace").CurrentCamera:GetChildren())do
register(ah)
end
end
end

registerDefaults()
ab.Enable()
end

return ab end function a.r()

local aa={}

local ab=a.load'b'
local ac=ab.New local ad=
ab.Tween


function aa.new(ae)
local af={
Title=ae.Title or"Dialog",
Content=ae.Content,
Icon=ae.Icon,
IconThemed=ae.IconThemed,
Thumbnail=ae.Thumbnail,
Buttons=ae.Buttons,

IconSize=22,
}

local ag=a.load'l'.Init(nil,ae.WindUI.ScreenGui.Popups)
local ah=ag.Create(true,"Popup")

local ai=200

local aj=430
if af.Thumbnail and af.Thumbnail.Image then
aj=430+(ai/2)
end

ah.UIElements.Main.AutomaticSize="Y"
ah.UIElements.Main.Size=UDim2.new(0,aj,0,0)



local ak

if af.Icon then
ak=ab.Image(
af.Icon,
af.Title..":"..af.Icon,
0,
ae.WindUI.Window,
"Popup",
true,
ae.IconThemed,
"PopupIcon"
)
ak.Size=UDim2.new(0,af.IconSize,0,af.IconSize)
ak.LayoutOrder=-1
end


local al=ac("TextLabel",{
AutomaticSize="Y",
BackgroundTransparency=1,
Text=af.Title,
TextXAlignment="Left",
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="PopupTitle",
},
TextSize=20,
TextWrapped=true,
Size=UDim2.new(1,ak and-af.IconSize-14 or 0,0,0)
})

local am=ac("Frame",{
BackgroundTransparency=1,
AutomaticSize="XY",
},{
ac("UIListLayout",{
Padding=UDim.new(0,14),
FillDirection="Horizontal",
VerticalAlignment="Center"
}),
ak,al
})

local an=ac("Frame",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
},{





am,
})

local ao
if af.Content and af.Content~=""then
ao=ac("TextLabel",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Text=af.Content,
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

local ap=ac("Frame",{
Size=UDim2.new(1,0,0,42),
BackgroundTransparency=1,
},{
ac("UIListLayout",{
Padding=UDim.new(0,9),
FillDirection="Horizontal",
HorizontalAlignment="Right"
})
})

local aq
if af.Thumbnail and af.Thumbnail.Image then
local ar
if af.Thumbnail.Title then
ar=ac("TextLabel",{
Text=af.Thumbnail.Title,
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
aq=ac("ImageLabel",{
Image=af.Thumbnail.Image,
BackgroundTransparency=1,
Size=UDim2.new(0,ai,1,0),
Parent=ah.UIElements.Main,
ScaleType="Crop"
},{
ar,
ac("UICorner",{
CornerRadius=UDim.new(0,0),
})
})
end

ac("Frame",{

Size=UDim2.new(1,aq and-ai or 0,1,0),
Position=UDim2.new(0,aq and ai or 0,0,0),
BackgroundTransparency=1,
Parent=ah.UIElements.Main
},{
ac("Frame",{

Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ac("UIListLayout",{
Padding=UDim.new(0,18),
FillDirection="Vertical",
}),
an,
ao,
ap,
ac("UIPadding",{
PaddingTop=UDim.new(0,16),
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
PaddingBottom=UDim.new(0,16),
})
}),
})

local ar=a.load'j'.New

for as,at in next,af.Buttons do
ar(at.Title,at.Icon,at.Callback,at.Variant,ap,ah)
end

ah:Open()


return af
end

return aa end function a.s()
return function(aa)
return{
Dark={
Name="Dark",

Accent=Color3.fromHex"#18181b",
Dialog=Color3.fromHex"#161616",
Outline=Color3.fromHex"#FFFFFF",
Text=Color3.fromHex"#FFFFFF",
Placeholder=Color3.fromHex"#7a7a7a",
Background=Color3.fromHex"#101010",
Button=Color3.fromHex"#52525b",
Icon=Color3.fromHex"#a1a1aa",
Toggle=Color3.fromHex"#33C759",
Slider=Color3.fromHex"#0091FF",
Checkbox=Color3.fromHex"#0091FF",
},
Light={
Name="Light",

Accent=Color3.fromHex"#FFFFFF",
Dialog=Color3.fromHex"#f4f4f5",
Outline=Color3.fromHex"#09090b",
Text=Color3.fromHex"#000000",
Placeholder=Color3.fromHex"#555555",
Background=Color3.fromHex"#e4e4e7",
Button=Color3.fromHex"#18181b",
Icon=Color3.fromHex"#52525b",
},
Rose={
Name="Rose",

Accent=Color3.fromHex"#be185d",
Dialog=Color3.fromHex"#4c0519",
Outline=Color3.fromHex"#fecdd3",
Text=Color3.fromHex"#fdf2f8",
Placeholder=Color3.fromHex"#d67aa6",
Background=Color3.fromHex"#1f0308",
Button=Color3.fromHex"#e11d48",
Icon=Color3.fromHex"#fb7185",
},
Plant={
Name="Plant",

Accent=Color3.fromHex"#166534",
Dialog=Color3.fromHex"#052e16",
Outline=Color3.fromHex"#bbf7d0",
Text=Color3.fromHex"#f0fdf4",
Placeholder=Color3.fromHex"#4fbf7a",
Background=Color3.fromHex"#0a1b0f",
Button=Color3.fromHex"#16a34a",
Icon=Color3.fromHex"#4ade80",
},
Red={
Name="Red",

Accent=Color3.fromHex"#991b1b",
Dialog=Color3.fromHex"#450a0a",
Outline=Color3.fromHex"#fecaca",
Text=Color3.fromHex"#fef2f2",
Placeholder=Color3.fromHex"#d95353",
Background=Color3.fromHex"#1c0606",
Button=Color3.fromHex"#dc2626",
Icon=Color3.fromHex"#ef4444",
},
Indigo={
Name="Indigo",

Accent=Color3.fromHex"#3730a3",
Dialog=Color3.fromHex"#1e1b4b",
Outline=Color3.fromHex"#c7d2fe",
Text=Color3.fromHex"#f1f5f9",
Placeholder=Color3.fromHex"#7078d9",
Background=Color3.fromHex"#0f0a2e",
Button=Color3.fromHex"#4f46e5",
Icon=Color3.fromHex"#6366f1",
},
Sky={
Name="Sky",

Accent=Color3.fromHex"#0369a1",
Dialog=Color3.fromHex"#0c4a6e",
Outline=Color3.fromHex"#bae6fd",
Text=Color3.fromHex"#f0f9ff",
Placeholder=Color3.fromHex"#4fb6d9",
Background=Color3.fromHex"#041f2e",
Button=Color3.fromHex"#0284c7",
Icon=Color3.fromHex"#0ea5e9",
},
Violet={
Name="Violet",

Accent=Color3.fromHex"#6d28d9",
Dialog=Color3.fromHex"#3c1361",
Outline=Color3.fromHex"#ddd6fe",
Text=Color3.fromHex"#faf5ff",
Placeholder=Color3.fromHex"#8f7ee0",
Background=Color3.fromHex"#1e0a3e",
Button=Color3.fromHex"#7c3aed",
Icon=Color3.fromHex"#8b5cf6",
},
Amber={
Name="Amber",

Accent=Color3.fromHex"#b45309",
Dialog=Color3.fromHex"#451a03",
Outline=Color3.fromHex"#fde68a",
Text=Color3.fromHex"#fffbeb",
Placeholder=Color3.fromHex"#d1a326",
Background=Color3.fromHex"#1c1003",
Button=Color3.fromHex"#d97706",
Icon=Color3.fromHex"#f59e0b",
},
Emerald={
Name="Emerald",

Accent=Color3.fromHex"#047857",
Dialog=Color3.fromHex"#022c22",
Outline=Color3.fromHex"#a7f3d0",
Text=Color3.fromHex"#ecfdf5",
Placeholder=Color3.fromHex"#3fbf8f",
Background=Color3.fromHex"#011411",
Button=Color3.fromHex"#059669",
Icon=Color3.fromHex"#10b981",
},
Midnight={
Name="Midnight",

Accent=Color3.fromHex"#1e3a8a",
Dialog=Color3.fromHex"#0c1e42",
Outline=Color3.fromHex"#bfdbfe",
Text=Color3.fromHex"#dbeafe",
Placeholder=Color3.fromHex"#2f74d1",
Background=Color3.fromHex"#0a0f1e",
Button=Color3.fromHex"#2563eb",
Icon=Color3.fromHex"#3b82f6",
},
Crimson={
Name="Crimson",

Accent=Color3.fromHex"#b91c1c",
Dialog=Color3.fromHex"#450a0a",
Outline=Color3.fromHex"#fca5a5",
Text=Color3.fromHex"#fef2f2",
Placeholder=Color3.fromHex"#6f757b",
Background=Color3.fromHex"#0c0404",
Button=Color3.fromHex"#991b1b",
Icon=Color3.fromHex"#dc2626",
},
MonokaiPro={
Name="Monokai Pro",

Accent=Color3.fromHex"#fc9867",
Dialog=Color3.fromHex"#1e1e1e",
Outline=Color3.fromHex"#78dce8",
Text=Color3.fromHex"#fcfcfa",
Placeholder=Color3.fromHex"#6f6f6f",
Background=Color3.fromHex"#191622",
Button=Color3.fromHex"#ab9df2",
Icon=Color3.fromHex"#a9dc76",
},
CottonCandy={
Name="Cotton Candy",

Accent=Color3.fromHex"#ec4899",
Dialog=Color3.fromHex"#2d1b3d",
Outline=Color3.fromHex"#f9a8d4",
Text=Color3.fromHex"#fdf2f8",
Placeholder=Color3.fromHex"#8a5fd3",
Background=Color3.fromHex"#1a0b2e",
Button=Color3.fromHex"#d946ef",
Icon=Color3.fromHex"#06b6d4",
},
Rainbow={
Name="Rainbow",

Accent=aa:Gradient({
["0"]={Color=Color3.fromHex"#00ff41",Transparency=0},
["33"]={Color=Color3.fromHex"#00ffff",Transparency=0},
["66"]={Color=Color3.fromHex"#0080ff",Transparency=0},
["100"]={Color=Color3.fromHex"#8000ff",Transparency=0},
},{
Rotation=45,
}),

Dialog=aa:Gradient({
["0"]={Color=Color3.fromHex"#ff0080",Transparency=0},
["25"]={Color=Color3.fromHex"#8000ff",Transparency=0},
["50"]={Color=Color3.fromHex"#0080ff",Transparency=0},
["75"]={Color=Color3.fromHex"#00ff80",Transparency=0},
["100"]={Color=Color3.fromHex"#ff8000",Transparency=0},
},{
Rotation=135,
}),

Outline=Color3.fromHex"#ffffff",
Text=Color3.fromHex"#ffffff",

Placeholder=Color3.fromHex"#00ff80",

Background=aa:Gradient({
["0"]={Color=Color3.fromHex"#ff0040",Transparency=0},
["20"]={Color=Color3.fromHex"#ff4000",Transparency=0},
["40"]={Color=Color3.fromHex"#ffff00",Transparency=0},
["60"]={Color=Color3.fromHex"#00ff40",Transparency=0},
["80"]={Color=Color3.fromHex"#0040ff",Transparency=0},
["100"]={Color=Color3.fromHex"#4000ff",Transparency=0},
},{
Rotation=90,
}),

Button=aa:Gradient({
["0"]={Color=Color3.fromHex"#ff0080",Transparency=0},
["25"]={Color=Color3.fromHex"#ff8000",Transparency=0},
["50"]={Color=Color3.fromHex"#ffff00",Transparency=0},
["75"]={Color=Color3.fromHex"#80ff00",Transparency=0},
["100"]={Color=Color3.fromHex"#00ffff",Transparency=0},
},{
Rotation=60,
}),

Icon=Color3.fromHex"#ffffff",
},
}
end end function a.t()
local aa={}

local ab=a.load'b'
local ac=ab.New local ad=
ab.Tween


function aa.New(ae,af,ag,ah,ai)
local aj=ai or 10
local ak
if af and af~=""then
ak=ac("ImageLabel",{
Image=ab.Icon(af)[1],
ImageRectSize=ab.Icon(af)[2].ImageRectSize,
ImageRectOffset=ab.Icon(af)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
}
})
end

local al=ac("TextLabel",{
BackgroundTransparency=1,
TextSize=17,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
Size=UDim2.new(1,ak and-29 or 0,1,0),
TextXAlignment="Left",
ThemeTag={
TextColor3=ah and"Placeholder"or"Text",
},
Text=ae,
})

local am=ac("TextButton",{
Size=UDim2.new(1,0,0,42),
Parent=ag,
BackgroundTransparency=1,
Text="",
},{
ac("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ab.NewRoundFrame(aj,"Squircle",{
ThemeTag={
ImageColor3="Accent",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.97,
}),
ab.NewRoundFrame(aj,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.95,
},{
ac("UIGradient",{
Rotation=70,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
})
}),
ab.NewRoundFrame(aj,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=.95
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
ak,
al,
})
})
})

return am
end


return aa end function a.u()
local aa={}

local ab=(cloneref or clonereference or function(ab)return ab end)


local ac=ab(game:GetService"UserInputService")

local ad=a.load'b'
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


return aa end function a.v()
local aa={}


local ab=a.load'b'
local ac=ab.New
local ad=ab.Tween


function aa.New(ae,af,ag)
local ah={
Title=af.Title or"Tag",
Icon=af.Icon,
Color=af.Color or Color3.fromHex"#315dff",
Radius=af.Radius or 999,

TagFrame=nil,
Height=26,
Padding=10,
TextSize=14,
IconSize=16,
}

local ai
if ah.Icon then
ai=ab.Image(
ah.Icon,
ah.Icon,
0,
af.Window,
"Tag",
false
)

ai.Size=UDim2.new(0,ah.IconSize,0,ah.IconSize)
ai.ImageLabel.ImageColor3=typeof(ah.Color)=="Color3"and ab.GetTextColorForHSB(ah.Color)or nil
end

local aj=ac("TextLabel",{
BackgroundTransparency=1,
AutomaticSize="XY",
TextSize=ah.TextSize,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
Text=ah.Title,
TextColor3=typeof(ah.Color)=="Color3"and ab.GetTextColorForHSB(ah.Color)or nil,
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
ImageColor3=typeof(ah.Color)=="Color3"and ah.Color or Color3.new(1,1,1),
},{
ak,
ac("UIPadding",{
PaddingLeft=UDim.new(0,ah.Padding),
PaddingRight=UDim.new(0,ah.Padding),
}),
ai,
aj,
ac("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
Padding=UDim.new(0,ah.Padding/1.5)
})
})


function ah.SetTitle(am,an)
ah.Title=an
aj.Text=an
end

function ah.SetColor(am,an)
ah.Color=an
if typeof(an)=="table"then
local ao=ab.GetAverageColor(an)
ad(aj,.06,{TextColor3=ab.GetTextColorForHSB(ao)}):Play()
local ap=al:FindFirstChildOfClass"UIGradient"or ac("UIGradient",{Parent=al})
for aq,ar in next,an do ap[aq]=ar end
ad(al,.06,{ImageColor3=Color3.new(1,1,1)}):Play()
else
if ak then
ak:Destroy()
end
ad(aj,.06,{TextColor3=ab.GetTextColorForHSB(an)}):Play()
if ai then
ad(ai.ImageLabel,.06,{ImageColor3=ab.GetTextColorForHSB(an)}):Play()
end
ad(al,.06,{ImageColor3=an}):Play()
end
end


return ah
end


return aa end function a.w()
local aa=(cloneref or clonereference or function(aa)return aa end)


local ab=aa(game:GetService"HttpService")

local ac

local ad
ad={
Folder=nil,
Path=nil,
Configs={},
Parser={
Colorpicker={
Save=function(ae)
return{
__type=ae.__type,
value=ae.Default:ToHex(),
transparency=ae.Transparency or nil,
}
end,
Load=function(ae,af)
if ae and ae.Update then
ae:Update(Color3.fromHex(af.value),af.transparency or nil)
end
end
},
Dropdown={
Save=function(ae)
return{
__type=ae.__type,
value=ae.Value,
}
end,
Load=function(ae,af)
if ae and ae.Select then
ae:Select(af.value)
end
end
},
Input={
Save=function(ae)
return{
__type=ae.__type,
value=ae.Value,
}
end,
Load=function(ae,af)
if ae and ae.Set then
ae:Set(af.value)
end
end
},
Keybind={
Save=function(ae)
return{
__type=ae.__type,
value=ae.Value,
}
end,
Load=function(ae,af)
if ae and ae.Set then
ae:Set(af.value)
end
end
},
Slider={
Save=function(ae)
return{
__type=ae.__type,
value=ae.Value.Default,
}
end,
Load=function(ae,af)
if ae and ae.Set then
ae:Set(tonumber(af.value))
end
end
},
Toggle={
Save=function(ae)
return{
__type=ae.__type,
value=ae.Value,
}
end,
Load=function(ae,af)
if ae and ae.Set then
ae:Set(af.value)
end
end
},
}
}

function ad.Init(ae,af)
if not af.Folder then
warn"[ WindUI.ConfigManager ] Window.Folder is not specified."
return false
end

ac=af
ad.Folder=ac.Folder
ad.Path="WindUI/"..tostring(ad.Folder).."/config/"

if not isfolder("WindUI/"..ad.Folder)then
makefolder("WindUI/"..ad.Folder)
if not isfolder("WindUI/"..ad.Folder.."/config/")then
makefolder("WindUI/"..ad.Folder.."/config/")
end
end

local ag=ad:AllConfigs()

for ah,ai in next,ag do
if isfile and readfile and isfile(ai..".json")then
ad.Configs[ai]=readfile(ai..".json")
end
end

return ad
end

function ad.CreateConfig(ae,af,ag)
local ah={
Path=ad.Path..af..".json",
Elements={},
CustomData={},
AutoLoad=ag or false,
Version=1.2,
}

if not af then
return false,"No config file is selected"
end

function ah.SetAsCurrent(ai)
ac:SetCurrentConfig(ah)
end

function ah.Register(ai,aj,ak)
ah.Elements[aj]=ak
end

function ah.Set(ai,aj,ak)
ah.CustomData[aj]=ak
end

function ah.Get(ai,aj)
return ah.CustomData[aj]
end

function ah.SetAutoLoad(ai,aj)
ah.AutoLoad=aj
end

function ah.Save(ai)
if ac.PendingFlags then
for aj,ak in next,ac.PendingFlags do
ah:Register(aj,ak)
end
end

local aj={
__version=ah.Version,
__elements={},
__autoload=ah.AutoLoad,
__custom=ah.CustomData
}

for ak,al in next,ah.Elements do
if ad.Parser[al.__type]then
aj.__elements[tostring(ak)]=ad.Parser[al.__type].Save(al)
end
end

local am=ab:JSONEncode(aj)
if writefile then
writefile(ah.Path,am)
end

return aj
end

function ah.Load(ai)
if isfile and not isfile(ah.Path)then
return false,"Config file does not exist"
end

local aj,ak=pcall(function()
local aj=readfile or function()
warn"[ WindUI.ConfigManager ] The config system doesn't work in the studio."
return nil
end
return ab:JSONDecode(aj(ah.Path))
end)

if not aj then
return false,"Failed to parse config file"
end

if not ak.__version then
local al={
__version=ah.Version,
__elements=ak,
__custom={}
}
ak=al
end

if ac.PendingFlags then
for al,am in next,ac.PendingFlags do
ah:Register(al,am)
end
end

for al,am in next,(ak.__elements or{})do
if ah.Elements[al]and ad.Parser[am.__type]then
task.spawn(function()
ad.Parser[am.__type].Load(ah.Elements[al],am)
end)
end
end

ah.CustomData=ak.__custom or{}

return ah.CustomData
end

function ah.Delete(ai)
if not delfile then
return false,"delfile function is not available"
end

if not isfile(ah.Path)then
return false,"Config file does not exist"
end

local aj,ak=pcall(function()
delfile(ah.Path)
end)

if not aj then
return false,"Failed to delete config file: "..tostring(ak)
end

ad.Configs[af]=nil

if ac.CurrentConfig==ah then
ac.CurrentConfig=nil
end

return true,"Config deleted successfully"
end

function ah.GetData(ai)
return{
elements=ah.Elements,
custom=ah.CustomData,
autoload=ah.AutoLoad
}
end


if isfile(ah.Path)then
local ai,aj=pcall(function()
return ab:JSONDecode(readfile(ah.Path))
end)

if ai and aj and aj.__autoload then
ah.AutoLoad=true

task.spawn(function()
task.wait(0.5)
local ak,al=pcall(function()
return ah:Load()
end)
if ak then
if ac.Debug then print("[ WindUI.ConfigManager ] AutoLoaded config: "..af)end
else
warn("[ WindUI.ConfigManager ] Failed to AutoLoad config: "..af.." - "..tostring(al))
end
end)
end
end


ah:SetAsCurrent()
ad.Configs[af]=ah
return ah
end

function ad.Config(ae,af,ag)
return ad:CreateConfig(af,ag)
end

function ad.GetAutoLoadConfigs(ae)
local af={}

for ag,ah in pairs(ad.Configs)do
if ah.AutoLoad then
table.insert(af,ag)
end
end

return af
end

function ad.DeleteConfig(ae,af)
if not delfile then
return false,"delfile function is not available"
end

local ag=ad.Path..af..".json"

if not isfile(ag)then
return false,"Config file does not exist"
end

local ah,ai=pcall(function()
delfile(ag)
end)

if not ah then
return false,"Failed to delete config file: "..tostring(ai)
end

ad.Configs[af]=nil

if ac.CurrentConfig and ac.CurrentConfig.Path==ag then
ac.CurrentConfig=nil
end

return true,"Config deleted successfully"
end

function ad.AllConfigs(ae)
if not listfiles then return{}end

local af={}
if not isfolder(ad.Path)then
makefolder(ad.Path)
return af
end

for ag,ah in next,listfiles(ad.Path)do
local ai=ah:match"([^\\/]+)%.json$"
if ai then
table.insert(af,ai)
end
end

return af
end

function ad.GetConfig(ae,af)
return ad.Configs[af]
end

return ad end function a.x()
local aa={}

local ab=a.load'b'
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
local am=ac("TextButton",{
Size=UDim2.new(0,0,0,44),
AutomaticSize="X",
Parent=al,
Active=false,
BackgroundTransparency=.25,
ZIndex=99,
BackgroundColor3=Color3.new(0,0,0),
},{
ac("UIScale",{
Scale=1,
}),
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

ag.Button=am



function ag.SetIcon(an,ao)
if ah then
ah:Destroy()
end
if ao then
ah=ab.Image(
ao,
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



ab.AddSignal(am:GetPropertyChangedSignal"AbsoluteSize",function()
al.Size=UDim2.new(
0,am.AbsoluteSize.X,
0,am.AbsoluteSize.Y
)
end)

ab.AddSignal(am.TextButton.MouseEnter,function()
ad(am.TextButton,.1,{BackgroundTransparency=.93}):Play()
end)
ab.AddSignal(am.TextButton.MouseLeave,function()
ad(am.TextButton,.1,{BackgroundTransparency=1}):Play()
end)

local an=ab.Drag(al)


function ag.Visible(ao,ap)
al.Visible=ap
end

function ag.Edit(ao,ap)
local aq={
Title=ap.Title,
Icon=ap.Icon,
Enabled=ap.Enabled,
Position=ap.Position,
OnlyIcon=ap.OnlyIcon or false,
Draggable=ap.Draggable or nil,
OnlyMobile=ap.OnlyMobile,
CornerRadius=ap.CornerRadius or UDim.new(1,0),
StrokeThickness=ap.StrokeThickness or 2,
Color=ap.Color
or ColorSequence.new(Color3.fromHex"40c9ff",Color3.fromHex"e81cff"),
}



if aq.Enabled==false then
af.IsOpenButtonEnabled=false
end

if aq.OnlyMobile~=false then
aq.OnlyMobile=true
else
af.IsPC=false
end


if aq.Draggable==false and aj and ak then
aj.Visible=aq.Draggable
ak.Visible=aq.Draggable

if an then
an:Set(aq.Draggable)
end
end

if aq.Position and al then
al.Position=aq.Position
end

if aq.OnlyIcon==true and ai then
ai.Visible=false
am.TextButton.UIPadding.PaddingLeft=UDim.new(0,7)
am.TextButton.UIPadding.PaddingRight=UDim.new(0,7)
elseif aq.OnlyIcon==false then
ai.Visible=true
am.TextButton.UIPadding.PaddingLeft=UDim.new(0,11)
am.TextButton.UIPadding.PaddingRight=UDim.new(0,11)
end





if ai then
if aq.Title then
ai.Text=aq.Title
ab:ChangeTranslationKey(ai,aq.Title)
elseif aq.Title==nil then

end
end

if aq.Icon then
ag:SetIcon(aq.Icon)
end

am.UIStroke.UIGradient.Color=aq.Color
if Glow then
Glow.UIGradient.Color=aq.Color
end

am.UICorner.CornerRadius=aq.CornerRadius
am.TextButton.UICorner.CornerRadius=UDim.new(aq.CornerRadius.Scale,aq.CornerRadius.Offset-4)
am.UIStroke.Thickness=aq.StrokeThickness
end

return ag
end



return aa end function a.y()
local aa={}

local ab=a.load'b'
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



return aa end function a.z()
local aa=a.load'b'
local ab=aa.New
local ac=aa.NewRoundFrame
local ad=aa.Tween

local ae=(cloneref or clonereference or function(ae)return ae end)


ae(game:GetService"UserInputService")


local function Color3ToHSB(af)
local ag,ah,ai=af.R,af.G,af.B
local aj=math.max(ag,ah,ai)
local ak=math.min(ag,ah,ai)
local al=aj-ak

local am=0
if al~=0 then
if aj==ag then
am=(ah-ai)/al%6
elseif aj==ah then
am=(ai-ag)/al+2
else
am=(ag-ah)/al+4
end
am=am*60
else
am=0
end

local an=(aj==0)and 0 or(al/aj)
local ao=aj

return{
h=math.floor(am+0.5),
s=an,
b=ao
}
end

local function GetPerceivedBrightness(af)
local ag=af.R
local ah=af.G
local ai=af.B
return 0.299*ag+0.587*ah+0.114*ai
end

local function GetTextColorForHSB(af)
local ag=Color3ToHSB(af)local
ah, ai, aj=ag.h, ag.s, ag.b
if GetPerceivedBrightness(af)>0.5 then
return Color3.fromHSV(ah/360,0,0.05)
else
return Color3.fromHSV(ah/360,0,0.98)
end
end


local function getElementPosition(af,ag)
if type(ag)~="number"or ag~=math.floor(ag)then
return nil,1
end






local ah=#af


if ah==0 or ag<1 or ag>ah then
return nil,2
end

local function isDelimiter(ai)
if ai==nil then return true end
local aj=ai.__type
return aj=="Divider"or aj=="Space"or aj=="Section"or aj=="Code"
end

if isDelimiter(af[ag])then
return nil,3
end

local function calculate(ai,aj)
if aj==1 then return"Squircle"end
if ai==1 then return"Squircle-TL-TR"end
if ai==aj then return"Squircle-BL-BR"end
return"Square"
end

local ai=1
local aj=0

for ak=1,ah do
local al=af[ak]
if isDelimiter(al)then
if ag>=ai and ag<=ak-1 then
local am=ag-ai+1
return calculate(am,aj)
end
ai=ak+1
aj=0
else
aj=aj+1
end
end


if ag>=ai and ag<=ah then
local ak=ag-ai+1
return calculate(ak,aj)
end

return nil,4
end


return function(af)
local ag={
Title=af.Title,
Desc=af.Desc or nil,
Hover=af.Hover,
Thumbnail=af.Thumbnail,
ThumbnailSize=af.ThumbnailSize or 80,
Image=af.Image,
IconThemed=af.IconThemed or false,
ImageSize=af.ImageSize or 30,
Color=af.Color,
Scalable=af.Scalable,
Parent=af.Parent,
Justify=af.Justify or"Between",
UIPadding=af.Window.ElementConfig.UIPadding,
UICorner=af.Window.ElementConfig.UICorner,
UIElements={},

Index=af.Index
}

local ah=ag.ImageSize
local ai=ag.ThumbnailSize
local aj=true


local ak=0

local al
local am
if ag.Thumbnail then
al=aa.Image(
ag.Thumbnail,
ag.Title,
af.Window.NewElements and ag.UICorner-11 or(ag.UICorner-4),
af.Window.Folder,
"Thumbnail",
false,
ag.IconThemed
)
al.Size=UDim2.new(1,0,0,ai)
end
if ag.Image then
am=aa.Image(
ag.Image,
ag.Title,
af.Window.NewElements and ag.UICorner-11 or(ag.UICorner-4),
af.Window.Folder,
"Image",
ag.IconThemed,
not ag.Color and true or false,
"ElementIcon"
)
if typeof(ag.Color)=="string"then
am.ImageLabel.ImageColor3=GetTextColorForHSB(Color3.fromHex(aa.Colors[ag.Color]))
elseif typeof(ag.Color)=="Color3"then
am.ImageLabel.ImageColor3=GetTextColorForHSB(ag.Color)
end

am.Size=UDim2.new(0,ah,0,ah)

ak=ah
end

local function CreateText(an,ao)
local ap=typeof(ag.Color)=="string"
and GetTextColorForHSB(Color3.fromHex(aa.Colors[ag.Color]))
or typeof(ag.Color)=="Color3"
and GetTextColorForHSB(ag.Color)

return ab("TextLabel",{
BackgroundTransparency=1,
Text=an or"",
TextSize=ao=="Desc"and 15 or 17,
TextXAlignment="Left",
ThemeTag={
TextColor3=not ag.Color and("Element"..ao)or nil,
},
TextColor3=ag.Color and ap or nil,
TextTransparency=ao=="Desc"and.3 or 0,
TextWrapped=true,
Size=UDim2.new(ag.Justify=="Between"and 1 or 0,0,0,0),
AutomaticSize=ag.Justify=="Between"and"Y"or"XY",
FontFace=Font.new(aa.Font,ao=="Desc"and Enum.FontWeight.Medium or Enum.FontWeight.SemiBold)
})
end

local an=CreateText(ag.Title,"Title")
local ao=CreateText(ag.Desc,"Desc")
if not ag.Title or ag.Title==""then
ao.Visible=false
end
if not ag.Desc or ag.Desc==""then
ao.Visible=false
end

ag.UIElements.Title=an
ag.UIElements.Desc=ao

ag.UIElements.Container=ab("Frame",{
Size=UDim2.new(1,0,1,0),
AutomaticSize="Y",
BackgroundTransparency=1,
},{
ab("UIListLayout",{
Padding=UDim.new(0,ag.UIPadding),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment=ag.Justify=="Between"and"Left"or"Center",
}),
al,
ab("Frame",{
Size=UDim2.new(
ag.Justify=="Between"and 1 or 0,
ag.Justify=="Between"and-af.TextOffset or 0,
0,
0
),
AutomaticSize=ag.Justify=="Between"and"Y"or"XY",
BackgroundTransparency=1,
Name="TitleFrame",
},{
ab("UIListLayout",{
Padding=UDim.new(0,ag.UIPadding),
FillDirection="Horizontal",
VerticalAlignment=af.Window.NewElements and(ag.Justify=="Between"and"Top"or"Center")or"Center",
HorizontalAlignment=ag.Justify~="Between"and ag.Justify or"Center",
}),
am,
ab("Frame",{
BackgroundTransparency=1,
AutomaticSize=ag.Justify=="Between"and"Y"or"XY",
Size=UDim2.new(
ag.Justify=="Between"and 1 or 0,
ag.Justify=="Between"and(am and-ak-ag.UIPadding or-ak)or 0,
1,
0
),
Name="TitleFrame",
},{
ab("UIPadding",{
PaddingTop=UDim.new(0,af.Window.NewElements and ag.UIPadding/2 or 0),
PaddingLeft=UDim.new(0,af.Window.NewElements and ag.UIPadding/2 or 0),
PaddingRight=UDim.new(0,af.Window.NewElements and ag.UIPadding/2 or 0),
PaddingBottom=UDim.new(0,af.Window.NewElements and ag.UIPadding/2 or 0),
}),
ab("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
an,
ao
}),
})
})






local ap=aa.Image(
"lock",
"lock",
0,
af.Window.Folder,
"Lock",
false
)
ap.Size=UDim2.new(0,20,0,20)
ap.ImageLabel.ImageColor3=Color3.new(1,1,1)
ap.ImageLabel.ImageTransparency=.4

local aq=ab("TextLabel",{
Text="Locked",
TextSize=18,
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
AutomaticSize="XY",
BackgroundTransparency=1,
TextColor3=Color3.new(1,1,1),
TextTransparency=.05,
})

local ar=ab("Frame",{
Size=UDim2.new(1,ag.UIPadding*2,1,ag.UIPadding*2),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ZIndex=9999999,
})

local as,at=ac(ag.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=.25,
ImageColor3=Color3.new(0,0,0),
Visible=false,
Active=false,
Parent=ar,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8)
}),
ap,aq
},nil,true)

local au,av=ac(ag.UICorner,"Squircle-Outline",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=ar,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8)
}),
},nil,true)

local aw,ax=ac(ag.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=ar,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8)
}),
},nil,true)


local ay,az=ac(ag.UICorner,"Squircle-Outline",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=ar,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8)
}),
ab("UIGradient",{
Name="HoverGradient",
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1))
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.25,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.75,0.9),
NumberSequenceKeypoint.new(1,1)
},
}),
},nil,true)

local aA,aB=ac(ag.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=ar,
},{
ab("UIGradient",{
Name="HoverGradient",
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1))
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.25,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.75,0.9),
NumberSequenceKeypoint.new(1,1)
},
}),
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8)
}),
},nil,true)

local aC,aD=ac(ag.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ImageTransparency=ag.Color and.05 or.93,



Parent=af.Parent,
ThemeTag={
ImageColor3=not ag.Color and"ElementBackground"or nil
},
ImageColor3=ag.Color and
(
typeof(ag.Color)=="string"
and Color3.fromHex(aa.Colors[ag.Color])
or typeof(ag.Color)=="Color3"
and ag.Color
)or nil
},{
ag.UIElements.Container,
ar,
ab("UIPadding",{
PaddingTop=UDim.new(0,ag.UIPadding),
PaddingLeft=UDim.new(0,ag.UIPadding),
PaddingRight=UDim.new(0,ag.UIPadding),
PaddingBottom=UDim.new(0,ag.UIPadding),
}),
},true,true)

ag.UIElements.Main=aC
ag.UIElements.Locked=as

if ag.Hover then
aa.AddSignal(aC.MouseEnter,function()
if aj then
ad(aC,.12,{ImageTransparency=ag.Color and.15 or.9}):Play()
ad(aA,.12,{ImageTransparency=.9}):Play()
ad(ay,.12,{ImageTransparency=.8}):Play()
aa.AddSignal(aC.MouseMoved,function(aE,aF)
aA.HoverGradient.Offset=Vector2.new(((aE-aC.AbsolutePosition.X)/aC.AbsoluteSize.X)-0.5,0)
ay.HoverGradient.Offset=Vector2.new(((aE-aC.AbsolutePosition.X)/aC.AbsoluteSize.X)-0.5,0)
end)
end
end)
aa.AddSignal(aC.InputEnded,function()
if aj then
ad(aC,.12,{ImageTransparency=ag.Color and.05 or.93}):Play()
ad(aA,.12,{ImageTransparency=1}):Play()
ad(ay,.12,{ImageTransparency=1}):Play()
end
end)
end

function ag.SetTitle(aE,aF)
ag.Title=aF
an.Text=aF
end

function ag.SetDesc(aE,aF)
ag.Desc=aF
ao.Text=aF or""
if not aF then
ao.Visible=false
elseif not ao.Visible then
ao.Visible=true
end
end


function ag.Colorize(aE,aF,b)
if ag.Color then
aF[b]=typeof(ag.Color)=="string"
and GetTextColorForHSB(Color3.fromHex(aa.Colors[ag.Color]))
or typeof(ag.Color)=="Color3"
and GetTextColorForHSB(ag.Color)
or nil
end
end

if af.ElementTable then
aa.AddSignal(an:GetPropertyChangedSignal"Text",function()
if ag.Title~=an.Text then
ag:SetTitle(an.Text)
af.ElementTable.Title=an.Text
end
end)
aa.AddSignal(ao:GetPropertyChangedSignal"Text",function()
if ag.Desc~=ao.Text then
ag:SetDesc(ao.Text)
af.ElementTable.Desc=ao.Text
end
end)
end





function ag.SetThumbnail(aE,aF,b)
ag.Thumbnail=aF
if b then
ag.ThumbnailSize=b
ai=b
end

if al then
if aF then
al:Destroy()
al=aa.Image(
aF,
ag.Title,
ag.UICorner-3,
af.Window.Folder,
"Thumbnail",
false,
ag.IconThemed
)
al.Size=UDim2.new(1,0,0,ai)
al.Parent=ag.UIElements.Container
local d=ag.UIElements.Container:FindFirstChild"UIListLayout"
if d then
al.LayoutOrder=-1
end
else
al.Visible=false
end
else
if aF then
al=aa.Image(
aF,
ag.Title,
ag.UICorner-3,
af.Window.Folder,
"Thumbnail",
false,
ag.IconThemed
)
al.Size=UDim2.new(1,0,0,ai)
al.Parent=ag.UIElements.Container
local d=ag.UIElements.Container:FindFirstChild"UIListLayout"
if d then
al.LayoutOrder=-1
end
end
end
end

function ag.SetImage(aE,aF,b)
ag.Image=aF
if b then
ag.ImageSize=b
ah=b
end

if aF then
am=aa.Image(
aF,
ag.Title,
ag.UICorner-3,
af.Window.Folder,
"Image",
not ag.Color and true or false
)

if typeof(ag.Color)=="string"then
am.ImageLabel.ImageColor3=GetTextColorForHSB(Color3.fromHex(aa.Colors[ag.Color]))
elseif typeof(ag.Color)=="Color3"then
am.ImageLabel.ImageColor3=GetTextColorForHSB(ag.Color)
end

am.Visible=true

am.Size=UDim2.new(0,ah,0,ah)
ak=ah

else
if am then
am.Visible=true
end
ak=0
end

ag.UIElements.Container.TitleFrame.TitleFrame.Size=UDim2.new(1,-ak,1,0)
end

function ag.Destroy(aE)
aC:Destroy()
end


function ag.Lock(aE)
aj=false
as.Active=true
as.Visible=true
end

function ag.Unlock(aE)
aj=true
as.Active=false
as.Visible=false
end

function ag.Highlight(aE)
local aF=ab("UIGradient",{
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1))
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.1,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.9,0.9),
NumberSequenceKeypoint.new(1,1)
},
Rotation=0,
Offset=Vector2.new(-1,0),
Parent=au
})

local b=ab("UIGradient",{
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1))
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.15,0.8),
NumberSequenceKeypoint.new(0.5,0.1),
NumberSequenceKeypoint.new(0.85,0.8),
NumberSequenceKeypoint.new(1,1)
},
Rotation=0,
Offset=Vector2.new(-1,0),
Parent=aw
})

au.ImageTransparency=0.65
aw.ImageTransparency=0.88

ad(aF,0.75,{
Offset=Vector2.new(1,0)
}):Play()

ad(b,0.75,{
Offset=Vector2.new(1,0)
}):Play()


task.spawn(function()
task.wait(.75)
au.ImageTransparency=1
aw.ImageTransparency=1
aF:Destroy()
b:Destroy()
end)
end


function ag.UpdateShape(aE)
if af.Window.NewElements then
local aF
if af.ParentConfig.ParentType=="Group"then
aF="Squircle"
else
aF=getElementPosition(aE.Elements,ag.Index)
end

if aF and aC then
aD:SetType(aF)
at:SetType(aF)
ax:SetType(aF)
av:SetType(aF.."-Outline")
aB:SetType(aF)
az:SetType(aF.."-Outline")
end
end
end





return ag
end end function a.A()
local aa=a.load'b'
local ab=aa.New

local ac={}

local ad=a.load'j'.New

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
local ah=a.load'z'(af)

ag.ParagraphFrame=ah
if af.Buttons and#af.Buttons>0 then
local ai=ab("Frame",{
Size=UDim2.new(1,0,0,38),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=ah.UIElements.Container
},{
ab("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Vertical",
})
})


for aj,ak in next,af.Buttons do
local al=ad(ak.Title,ak.Icon,ak.Callback,"White",ai,nil,nil,af.Window.NewElements and 12 or 10)
al.Size=UDim2.new(1,0,0,38)

end
end

return ag.__type,ag

end

return ac end function a.B()
local aa=a.load'b'local ab=
aa.New

local ac={}

function ac.New(ad,ae)
local af={
__type="Button",
Title=ae.Title or"Button",
Desc=ae.Desc or nil,
Icon=ae.Icon or"mouse-pointer-click",
IconThemed=ae.IconThemed or false,
Color=ae.Color,
Justify=ae.Justify or"Between",
IconAlign=ae.IconAlign or"Right",
Locked=ae.Locked or false,
Callback=ae.Callback or function()end,
UIElements={}
}

local ag=true

af.ButtonFrame=a.load'z'{
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
}














af.UIElements.ButtonIcon=aa.Image(
af.Icon,
af.Icon,
0,
ae.Window.Folder,
"Button",
not af.Color and true or nil,
af.IconThemed
)

af.UIElements.ButtonIcon.Size=UDim2.new(0,20,0,20)
af.UIElements.ButtonIcon.Parent=af.Justify=="Between"and af.ButtonFrame.UIElements.Main or af.ButtonFrame.UIElements.Container.TitleFrame
af.UIElements.ButtonIcon.LayoutOrder=af.IconAlign=="Left"and-99999 or 99999
af.UIElements.ButtonIcon.AnchorPoint=Vector2.new(1,0.5)
af.UIElements.ButtonIcon.Position=UDim2.new(1,0,0.5,0)

af.ButtonFrame:Colorize(af.UIElements.ButtonIcon.ImageLabel,"ImageColor3")

function af.Lock(ah)
af.Locked=true
ag=false
return af.ButtonFrame:Lock()
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

return ac end function a.C()
local aa={}

local ab=a.load'b'
local ac=ab.New
local ad=ab.Tween

local ae=game:GetService"UserInputService"

function aa.New(af,ag,ah,ai,aj,ak,al)
local am={}

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
ImageTransparency=.85,
ThemeTag={
ImageColor3="Text"
},
Parent=ap,
Size=UDim2.new(0,ak and(52)or(40.8),0,24),
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(0,0,0.5,0),
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
}
})
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
ThemeTag={
ImageColor3="ToggleBar",
},
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Bar"
},{
ab.NewRoundFrame(an,"SquircleOutline2",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
Name="Highlight",
ImageTransparency=.45,
},{
ac("UIGradient",{
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
}
}),
}),
ao,
ac("UIScale",{
Scale=1,
})
}),
})
})

local ar
local as

local at=ak and 30 or 20
local au=aq.Size.X.Offset

function am.Set(av,aw,ax,ay)
if not ay then
if aw then
ad(aq.Frame,0.15,{
Position=UDim2.new(0,au-at-2,0.5,0),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
else
ad(aq.Frame,0.15,{
Position=UDim2.new(0,2,0.5,0),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

if aw then
ad(aq.Layer,0.1,{
ImageTransparency=0,
}):Play()

if ao then
ad(ao,0.1,{
ImageTransparency=0,
}):Play()
end
else
ad(aq.Layer,0.1,{
ImageTransparency=1,
}):Play()

if ao then
ad(ao,0.1,{
ImageTransparency=1,
}):Play()
end
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

ad(aq.Frame.Bar.UIScale,0.28,{Scale=1.5},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(aq.Frame.Bar,0.28,{ImageTransparency=.85},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

if ar then
ar:Disconnect()
end

ar=ae.InputChanged:Connect(function(aC)
if al.Window.IsToggleDragging and(aC.UserInputType==Enum.UserInputType.MouseMovement or aC.UserInputType==Enum.UserInputType.Touch)then
if aB then
return
end

local aD=math.abs(aC.Position.X-ay)
local aE=math.abs(aC.Position.Y-az)

if aE>aD and aE>10 then
aB=true
al.Window.IsToggleDragging=false

if ar then
ar:Disconnect()
ar=nil
end
if as then
as:Disconnect()
as=nil
end

ad(aq.Frame,0.15,{
Position=UDim2.new(0,aA,0.5,0)
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

ad(aq.Frame.Bar.UIScale,0.23,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(aq.Frame.Bar,0.23,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
return
end

local aF=aC.Position.X-ay
local b=math.max(2,math.min(aA+aF,au-at-2))local d=

(aq.Frame.Position.X.Offset-2)/(au-at-4)

ad(aq.Frame,0.05,{
Position=UDim2.new(0,b,0.5,0)
},Enum.EasingStyle.Linear,Enum.EasingDirection.Out):Play()





end
end)

if as then
as:Disconnect()
end

as=ae.InputEnded:Connect(function(aC)
if al.Window.IsToggleDragging and(aC.UserInputType==Enum.UserInputType.MouseButton1 or aC.UserInputType==Enum.UserInputType.Touch)then
al.Window.IsToggleDragging=false

if ar then
ar:Disconnect()
ar=nil
end

if as then
as:Disconnect()
as=nil
end

if aB then
return
end

local aD=aq.Frame.Position.X.Offset
local aE=math.abs(aC.Position.X-ay)

if aE<10 then
local aF=not ax.Value
ax:Set(aF,true,false)
else
local aF=aD+at/2
local b=au/2
local d=aF>b
ax:Set(d,true,false)
end

ad(aq.Frame.Bar.UIScale,0.23,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(aq.Frame.Bar,0.23,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end)
end
end

return ap,am
end

return aa end function a.D()
local aa={}

local ab=a.load'b'
local ac=ab.New
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
ab.NewRoundFrame(al,"SquircleOutline",{
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
}
})
}),

am,
})

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


return aa end function a.E()
local aa=a.load'b'local ab=
aa.New local ac=
aa.Tween

local ad=a.load'C'.New
local ae=a.load'D'.New

local af={}

function af.New(ag,ah)
local ai={
__type="Toggle",
Title=ah.Title or"Toggle",
Desc=ah.Desc or nil,
Locked=ah.Locked or false,
Value=ah.Value,
Icon=ah.Icon or nil,
IconSize=ah.IconSize or 23,
Type=ah.Type or"Toggle",
Callback=ah.Callback or function()end,
UIElements={}
}
ai.ToggleFrame=a.load'z'{
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
}

local aj=true

if ai.Value==nil then
ai.Value=false
end



function ai.Lock(ak)
ai.Locked=true
aj=false
return ai.ToggleFrame:Lock()
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
al,am=ad(ak,ai.Icon,ai.IconSize,ai.ToggleFrame.UIElements.Main,ai.Callback,ah.Window.NewElements,ah)
elseif ai.Type=="Checkbox"then
al,am=ae(ak,ai.Icon,ai.IconSize,ai.ToggleFrame.UIElements.Main,ai.Callback,ah)
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


if ah.Window.NewElements and am.Animate then
aa.AddSignal(ai.ToggleFrame.UIElements.Main.InputBegan,function(an)
if not ah.Window.IsToggleDragging and an.UserInputType==Enum.UserInputType.MouseButton1 or an.UserInputType==Enum.UserInputType.Touch then
am:Animate(an,ai)
end
end)






else
aa.AddSignal(ai.ToggleFrame.UIElements.Main.MouseButton1Click,function()
ai:Set(not ai.Value,nil,ah.Window.NewElements)
end)
end

return ai.__type,ai
end

return af end function a.F()
local aa=cloneref(game:GetService"UserInputService")
local ac=cloneref(game:GetService"RunService")

local ad=a.load'b'
local ae=ad.New
local af=ad.Tween



local ag={}

local ah=false

function ag.New(ai,aj)
local ak={
__type="Slider",
Title=aj.Title or nil,
Desc=aj.Desc or nil,
Locked=aj.Locked or nil,
Value=aj.Value or{},
Icons=aj.Icons or nil,
IsTooltip=aj.IsTooltip or false,
IsTextbox=aj.IsTextbox,
Step=aj.Step or 1,
Callback=aj.Callback or function()end,
UIElements={},
IsFocusing=false,

Width=aj.Width or 130,
TextBoxWidth=aj.Window.NewElements and 40 or 30,
ThumbSize=13,
IconSize=26,
}
if ak.Icons=={}then
ak.Icons={
From="sfsymbols:sunMinFill",
To="sfsymbols:sunMaxFill",
}
end
if ak.IsTextbox==nil and ak.Title==nil then ak.IsTextbox=false else ak.IsTextbox=ak.IsTextbox~=false end

local al
local am
local an
local ao=ak.Value.Default or ak.Value.Min or 0

local ap=ao
local aq=(ao-(ak.Value.Min or 0))/((ak.Value.Max or 100)-(ak.Value.Min or 0))

local ar=true
local as=ak.Step%1~=0

local function FormatValue(at)
if as then
return string.format("%.2f",at)
else
return tonumber(math.floor(at+0.5))
end
end

local function CalculateValue(at)
if as then
return math.floor(at/ak.Step+0.5)*ak.Step
else
return math.floor(at/ak.Step+0.5)*ak.Step
end
end

local at,au
local av=32
if ak.Icons then
if ak.Icons.From then
at=ad.Image(
ak.Icons.From,
ak.Icons.From,
0,
aj.Window.Folder,
"SliderIconFrom",
true,
true,
"SliderIconFrom"
)
at.Size=UDim2.new(0,ak.IconSize,0,ak.IconSize)
av=av+ak.IconSize-2
end
if ak.Icons.To then
au=ad.Image(
ak.Icons.To,
ak.Icons.To,
0,
aj.Window.Folder,
"SliderIconTo",
true,
true,
"SliderIconTo"
)
au.Size=UDim2.new(0,ak.IconSize,0,ak.IconSize)
av=av+ak.IconSize-2
end
end
ak.SliderFrame=a.load'z'{
Title=ak.Title,
Desc=ak.Desc,
Parent=aj.Parent,
TextOffset=ak.Width,
Hover=false,
Tab=aj.Tab,
Index=aj.Index,
Window=aj.Window,
ElementTable=ak,
ParentConfig=aj,
}


ak.UIElements.SliderIcon=ad.NewRoundFrame(99,"Squircle",{
ImageTransparency=.95,
Size=UDim2.new(1,not ak.IsTextbox and-av or(-ak.TextBoxWidth-8),0,4),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Frame",
ThemeTag={
ImageColor3="Text",
},
},{
ad.NewRoundFrame(99,"Squircle",{
Name="Frame",
Size=UDim2.new(aq,0,1,0),
ImageTransparency=.1,
ThemeTag={
ImageColor3="Slider",
},
},{
ad.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,aj.Window.NewElements and(ak.ThumbSize*2)or(ak.ThumbSize+2),0,aj.Window.NewElements and(ak.ThumbSize+4)or(ak.ThumbSize+2)),
Position=UDim2.new(1,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="SliderThumb",
},
Name="Thumb",
},{
ad.NewRoundFrame(99,"SquircleOutline2",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
Name="Highlight",
ImageTransparency=.45,
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
}
}),
}),
})
})
})

ak.UIElements.SliderContainer=ae("Frame",{
Size=UDim2.new(ak.Title==nil and 1 or 0,ak.Title==nil and 0 or ak.Width,0,0),
AutomaticSize="Y",
Position=UDim2.new(1,ak.IsTextbox and(aj.Window.NewElements and-16 or 0)or 0,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Parent=ak.SliderFrame.UIElements.Main,
},{
ae("UIListLayout",{
Padding=UDim.new(0,ak.Title~=nil and 8 or 12),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment=ak.Icons and(ak.Icons.From and(ak.Icons.To and"Center"or"Left")or ak.Icons.To and"Right")or"Center",
}),
at,
ak.UIElements.SliderIcon,
au,
ae("TextBox",{
Size=UDim2.new(0,ak.TextBoxWidth,0,0),
TextXAlignment="Left",
Text=FormatValue(ao),
ThemeTag={
TextColor3="Text"
},
TextTransparency=.4,
AutomaticSize="Y",
TextSize=15,
FontFace=Font.new(ad.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
LayoutOrder=-1,
Visible=ak.IsTextbox,
})
})

local aw
if ak.IsTooltip then
aw=a.load'y'.New(ao,ak.UIElements.SliderIcon.Frame.Thumb,true,"Secondary","Small",false)
aw.Container.AnchorPoint=Vector2.new(0.5,1)
aw.Container.Position=UDim2.new(0.5,0,0,-8)
end

function ak.Lock(ax)
ak.Locked=true
ar=false
return ak.SliderFrame:Lock()
end
function ak.Unlock(ax)
ak.Locked=false
ar=true
return ak.SliderFrame:Unlock()
end

if ak.Locked then
ak:Lock()
end


local ax=aj.Tab.UIElements.ContainerFrame

function ak.Set(ay,az,aA)
if ar then
if not ak.IsFocusing and not ah and(not aA or(aA.UserInputType==Enum.UserInputType.MouseButton1 or aA.UserInputType==Enum.UserInputType.Touch))then
if aA then
al=(aA.UserInputType==Enum.UserInputType.Touch)
ax.ScrollingEnabled=false
ah=true

local aB=al and aA.Position.X or aa:GetMouseLocation().X
local aC=math.clamp((aB-ak.UIElements.SliderIcon.AbsolutePosition.X)/ak.UIElements.SliderIcon.AbsoluteSize.X,0,1)
az=CalculateValue(ak.Value.Min+aC*(ak.Value.Max-ak.Value.Min))
az=math.clamp(az,ak.Value.Min or 0,ak.Value.Max or 100)

if az~=ap then
af(ak.UIElements.SliderIcon.Frame,0.05,{Size=UDim2.new(aC,0,1,0)}):Play()
ak.UIElements.SliderContainer.TextBox.Text=FormatValue(az)
if aw then aw.TitleFrame.Text=FormatValue(az)end
ak.Value.Default=FormatValue(az)
ap=az
ad.SafeCallback(ak.Callback,FormatValue(az))
end

am=ac.RenderStepped:Connect(function()
local aD=al and aA.Position.X or aa:GetMouseLocation().X
local aE=math.clamp((aD-ak.UIElements.SliderIcon.AbsolutePosition.X)/ak.UIElements.SliderIcon.AbsoluteSize.X,0,1)
az=CalculateValue(ak.Value.Min+aE*(ak.Value.Max-ak.Value.Min))

if az~=ap then
af(ak.UIElements.SliderIcon.Frame,0.05,{Size=UDim2.new(aE,0,1,0)}):Play()
ak.UIElements.SliderContainer.TextBox.Text=FormatValue(az)
if aw then aw.TitleFrame.Text=FormatValue(az)end
ak.Value.Default=FormatValue(az)
ap=az
ad.SafeCallback(ak.Callback,FormatValue(az))
end
end)


an=aa.InputEnded:Connect(function(aD)
if(aD.UserInputType==Enum.UserInputType.MouseButton1 or aD.UserInputType==Enum.UserInputType.Touch)and aA==aD then
am:Disconnect()
an:Disconnect()
ah=false
ax.ScrollingEnabled=true

if aj.Window.NewElements then
af(ak.UIElements.SliderIcon.Frame.Thumb,.2,{ImageTransparency=0,Size=UDim2.new(0,aj.Window.NewElements and(ak.ThumbSize*2)or(ak.ThumbSize+2),0,aj.Window.NewElements and(ak.ThumbSize+4)or(ak.ThumbSize+2))},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
end
if aw then aw:Close(false)end
end
end)
else
az=math.clamp(az,ak.Value.Min or 0,ak.Value.Max or 100)

local aB=math.clamp((az-(ak.Value.Min or 0))/((ak.Value.Max or 100)-(ak.Value.Min or 0)),0,1)
az=CalculateValue(ak.Value.Min+aB*(ak.Value.Max-ak.Value.Min))

if az~=ap then
af(ak.UIElements.SliderIcon.Frame,0.05,{Size=UDim2.new(aB,0,1,0)}):Play()
ak.UIElements.SliderContainer.TextBox.Text=FormatValue(az)
if aw then aw.TitleFrame.Text=FormatValue(az)end
ak.Value.Default=FormatValue(az)
ap=az
ad.SafeCallback(ak.Callback,FormatValue(az))
end
end
end
end
end

function ak.SetMax(ay,az)
ak.Value.Max=az

local aA=tonumber(ak.Value.Default)or ap
if aA>az then
ak:Set(az)
else
local aB=math.clamp((aA-(ak.Value.Min or 0))/(az-(ak.Value.Min or 0)),0,1)
af(ak.UIElements.SliderIcon.Frame,0.1,{Size=UDim2.new(aB,0,1,0)}):Play()
end
end

function ak.SetMin(ay,az)
ak.Value.Min=az

local aA=tonumber(ak.Value.Default)or ap
if aA<az then
ak:Set(az)
else
local aB=math.clamp((aA-az)/((ak.Value.Max or 100)-az),0,1)
af(ak.UIElements.SliderIcon.Frame,0.1,{Size=UDim2.new(aB,0,1,0)}):Play()
end
end

ad.AddSignal(ak.UIElements.SliderContainer.TextBox.FocusLost,function(ay)
if ay then
local az=tonumber(ak.UIElements.SliderContainer.TextBox.Text)
if az then
ak:Set(az)
else
ak.UIElements.SliderContainer.TextBox.Text=FormatValue(ap)
if aw then aw.TitleFrame.Text=FormatValue(ap)end
end
end
end)

ad.AddSignal(ak.UIElements.SliderContainer.InputBegan,function(ay)
if ak.Locked or ah then
return
end

ak:Set(ao,ay)

if ay.UserInputType==Enum.UserInputType.MouseButton1 or ay.UserInputType==Enum.UserInputType.Touch then

if aj.Window.NewElements then
af(ak.UIElements.SliderIcon.Frame.Thumb,.24,{ImageTransparency=.85,Size=UDim2.new(0,(aj.Window.NewElements and(ak.ThumbSize*2)or(ak.ThumbSize))+8,0,ak.ThumbSize+8)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
if aw then aw:Open()end
print"piskaa"
end
end)

return ak.__type,ak
end

return ag end function a.G()
local aa=(cloneref or clonereference or function(aa)return aa end)

local ac=aa(game:GetService"UserInputService")

local ad=a.load'b'
local ae=ad.New local af=
ad.Tween

local ag={
UICorner=6,
UIPadding=8,
}

local ah=a.load't'.New

function ag.New(ai,aj)
local ak={
__type="Keybind",
Title=aj.Title or"Keybind",
Desc=aj.Desc or nil,
Locked=aj.Locked or false,
Value=aj.Value or"F",
Callback=aj.Callback or function()end,
CanChange=aj.CanChange or true,
Picking=false,
UIElements={},
}

local al=true

ak.KeybindFrame=a.load'z'{
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
}

ak.UIElements.Keybind=ah(ak.Value,nil,ak.KeybindFrame.UIElements.Main)

ak.UIElements.Keybind.Size=UDim2.new(
0,24
+ak.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,
0,
42
)
ak.UIElements.Keybind.AnchorPoint=Vector2.new(1,0.5)
ak.UIElements.Keybind.Position=UDim2.new(1,0,0.5,0)

ae("UIScale",{
Parent=ak.UIElements.Keybind,
Scale=.85,
})

ad.AddSignal(ak.UIElements.Keybind.Frame.Frame.TextLabel:GetPropertyChangedSignal"TextBounds",function()
ak.UIElements.Keybind.Size=UDim2.new(
0,24
+ak.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,
0,
42
)
end)

function ak.Lock(am)
ak.Locked=true
al=false
return ak.KeybindFrame:Lock()
end
function ak.Unlock(am)
ak.Locked=false
al=true
return ak.KeybindFrame:Unlock()
end

function ak.Set(am,an)
ak.Value=an
ak.UIElements.Keybind.Frame.Frame.TextLabel.Text=an
end

if ak.Locked then
ak:Lock()
end

ad.AddSignal(ak.KeybindFrame.UIElements.Main.MouseButton1Click,function()
if al then
if ak.CanChange then
ak.Picking=true
ak.UIElements.Keybind.Frame.Frame.TextLabel.Text="..."

task.wait(0.2)

local am
am=ac.InputBegan:Connect(function(an)
local ao

if an.UserInputType==Enum.UserInputType.Keyboard then
ao=an.KeyCode.Name
elseif an.UserInputType==Enum.UserInputType.MouseButton1 then
ao="MouseLeft"
elseif an.UserInputType==Enum.UserInputType.MouseButton2 then
ao="MouseRight"
end

local ap
ap=ac.InputEnded:Connect(function(aq)
if aq.KeyCode.Name==ao or ao=="MouseLeft"and aq.UserInputType==Enum.UserInputType.MouseButton1 or ao=="MouseRight"and aq.UserInputType==Enum.UserInputType.MouseButton2 then
ak.Picking=false

ak.UIElements.Keybind.Frame.Frame.TextLabel.Text=ao
ak.Value=ao

am:Disconnect()
ap:Disconnect()
end
end)
end)
end
end
end)

ad.AddSignal(ac.InputBegan,function(am,an)
if ac:GetFocusedTextBox()then
return
end

if not al then
return
end

if am.UserInputType==Enum.UserInputType.Keyboard then
if am.KeyCode.Name==ak.Value then
ad.SafeCallback(ak.Callback,am.KeyCode.Name)
end
elseif am.UserInputType==Enum.UserInputType.MouseButton1 and ak.Value=="MouseLeft"then
ad.SafeCallback(ak.Callback,"MouseLeft")
elseif am.UserInputType==Enum.UserInputType.MouseButton2 and ak.Value=="MouseRight"then
ad.SafeCallback(ak.Callback,"MouseRight")
end
end)

return ak.__type,ak
end

return ag end function a.H()
local aa=a.load'b'
local ac=aa.New local ad=
aa.Tween

local ae={
UICorner=8,
UIPadding=8,
}local af=a.load'j'


.New
local ag=a.load'k'.New

function ae.New(ah,ai)
local aj={
__type="Input",
Title=ai.Title or"Input",
Desc=ai.Desc or nil,
Type=ai.Type or"Input",
Locked=ai.Locked or false,
InputIcon=ai.InputIcon or false,
Placeholder=ai.Placeholder or"Enter Text...",
Value=ai.Value or"",
Callback=ai.Callback or function()end,
ClearTextOnFocus=ai.ClearTextOnFocus or false,
UIElements={},

Width=150,
}

local ak=true

aj.InputFrame=a.load'z'{
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
return aj.InputFrame:Lock()
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

return ae end function a.I()
local aa=a.load'b'
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

return ae end function a.J()
local aa={}

local ac=(cloneref or clonereference or function(ac)return ac end)

local ae=ac(game:GetService"UserInputService")
local af=ac(game:GetService"Players").LocalPlayer:GetMouse()
local ag=ac(game:GetService"Workspace").CurrentCamera

local ah=workspace.CurrentCamera

local ai=a.load'k'.New

local aj=a.load'b'
local ak=aj.New
local al=aj.Tween

function aa.New(am,an,ao,ap,aq)
local ar={}

if not an.Callback then
aq="Menu"
end

an.UIElements.UIListLayout=ak("UIListLayout",{
Padding=UDim.new(0,ao.MenuPadding/1.5),
FillDirection="Vertical",
HorizontalAlignment="Center",
})

an.UIElements.Menu=aj.NewRoundFrame(ao.MenuCorner,"Squircle",{
ThemeTag={
ImageColor3="Background",
},
ImageTransparency=1,
Size=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,0,0,0),
},{
ak("UIPadding",{
PaddingTop=UDim.new(0,ao.MenuPadding),
PaddingLeft=UDim.new(0,ao.MenuPadding),
PaddingRight=UDim.new(0,ao.MenuPadding),
PaddingBottom=UDim.new(0,ao.MenuPadding),
}),
ak("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,ao.MenuPadding)
}),
ak("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,an.SearchBarEnabled and-ao.MenuPadding-ao.SearchBarHeight),

ClipsDescendants=true,
LayoutOrder=999,
},{
ak("UICorner",{
CornerRadius=UDim.new(0,ao.MenuCorner-ao.MenuPadding),
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
an.UIElements.UIListLayout,
})
})
})

an.UIElements.MenuCanvas=ak("Frame",{
Size=UDim2.new(0,an.MenuWidth,0,300),
BackgroundTransparency=1,
Position=UDim2.new(-10,0,-10,0),
Visible=false,
Active=false,

Parent=am.WindUI.DropdownGui,
AnchorPoint=Vector2.new(1,0),
},{
an.UIElements.Menu,
ak("UISizeConstraint",{
MinSize=Vector2.new(170,0),
MaxSize=Vector2.new(300,400),
})
})

local function RecalculateCanvasSize()
an.UIElements.Menu.Frame.ScrollingFrame.CanvasSize=UDim2.fromOffset(0,an.UIElements.UIListLayout.AbsoluteContentSize.Y)
end

local function RecalculateListSize()
local as=ah.ViewportSize.Y*0.6

local at=an.UIElements.UIListLayout.AbsoluteContentSize.Y
local au=an.SearchBarEnabled and(ao.SearchBarHeight+(ao.MenuPadding*3))or(ao.MenuPadding*2)
local av=(at)+au

if av>as then
an.UIElements.MenuCanvas.Size=UDim2.fromOffset(
an.UIElements.MenuCanvas.AbsoluteSize.X,
as
)
else
an.UIElements.MenuCanvas.Size=UDim2.fromOffset(
an.UIElements.MenuCanvas.AbsoluteSize.X,
av
)
end
end

function UpdatePosition()
local as=an.UIElements.Dropdown or an.DropdownFrame.UIElements.Main
local at=an.UIElements.MenuCanvas

local au=ag.ViewportSize.Y-(as.AbsolutePosition.Y+as.AbsoluteSize.Y)-ao.MenuPadding-54
local av=at.AbsoluteSize.Y+ao.MenuPadding

local aw=-54
if au<av then
aw=av-au-54
end

at.Position=UDim2.new(
0,
as.AbsolutePosition.X+as.AbsoluteSize.X,
0,
as.AbsolutePosition.Y+as.AbsoluteSize.Y-aw+(ao.MenuPadding*2)
)
end

local as

function ar.Display(at)
local au=an.Values
local av=""

if an.Multi then
local aw={}
if typeof(an.Value)=="table"then
for ax,ay in ipairs(an.Value)do
local az=typeof(ay)=="table"and ay.Title or ay
aw[az]=true
end
end

for ax,ay in ipairs(au)do
local az=typeof(ay)=="table"and ay.Title or ay
if aw[az]then
av=av..az..", "
end
end

if#av>0 then
av=av:sub(1,#av-2)
end
else
av=typeof(an.Value)=="table"and an.Value.Title or an.Value or""
end

if an.UIElements.Dropdown then
an.UIElements.Dropdown.Frame.Frame.TextLabel.Text=(av==""and"--"or av)
end
end

local function Callback(at)
ar:Display()
if an.Callback then
task.spawn(function()
aj.SafeCallback(an.Callback,an.Value)
end)
else
task.spawn(function()
aj.SafeCallback(at)
end)
end
end

function ar.LockValues(at,au)
if not au then return end

for av,aw in next,an.Tabs do
if aw and aw.UIElements and aw.UIElements.TabItem then
local ax=aw.Name
local ay=false

for az,aA in next,au do
if ax==aA then
ay=true
break
end
end

if ay then
al(aw.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()
al(aw.UIElements.TabItem.Highlight,0.1,{ImageTransparency=1}):Play()
al(aw.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0.6}):Play()
if aw.UIElements.TabIcon then
al(aw.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0.6}):Play()
end

aw.UIElements.TabItem.Active=false
aw.Locked=true
else
if aw.Selected then
al(aw.UIElements.TabItem,0.1,{ImageTransparency=0.95}):Play()
al(aw.UIElements.TabItem.Highlight,0.1,{ImageTransparency=0.75}):Play()
al(aw.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if aw.UIElements.TabIcon then
al(aw.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
else
al(aw.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()
al(aw.UIElements.TabItem.Highlight,0.1,{ImageTransparency=1}):Play()
al(aw.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=aq=="Dropdown"and 0.4 or 0.05}):Play()
if aw.UIElements.TabIcon then
al(aw.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=aq=="Dropdown"and 0.2 or 0}):Play()
end
end

aw.UIElements.TabItem.Active=true
aw.Locked=false
end
end
end
end

function ar.Refresh(at,au)
for av,aw in next,an.UIElements.Menu.Frame.ScrollingFrame:GetChildren()do
if not aw:IsA"UIListLayout"then
aw:Destroy()
end
end

an.Tabs={}

if an.SearchBarEnabled then
if not as then
as=ai("Search...","search",an.UIElements.Menu,nil,function(ax)
for ay,az in next,an.Tabs do
if string.find(string.lower(az.Name),string.lower(ax),1,true)then
az.UIElements.TabItem.Visible=true
else
az.UIElements.TabItem.Visible=false
end
RecalculateListSize()
RecalculateCanvasSize()
end
end,true)
as.Size=UDim2.new(1,0,0,ao.SearchBarHeight)
as.Position=UDim2.new(0,0,0,0)
as.Name="SearchBar"
end
end

for ax,ay in next,au do
if(ay.Type~="Divider")then
local az={
Name=typeof(ay)=="table"and ay.Title or ay,
Desc=typeof(ay)=="table"and ay.Desc or nil,
Icon=typeof(ay)=="table"and ay.Icon or nil,
Original=ay,
Selected=false,
Locked=typeof(ay)=="table"and ay.Locked or false,
UIElements={},
}
local aA
if az.Icon then
aA=aj.Image(
az.Icon,
az.Icon,
0,
am.Window.Folder,
"Dropdown",
true
)
aA.Size=UDim2.new(0,ao.TabIcon,0,ao.TabIcon)
aA.ImageLabel.ImageTransparency=aq=="Dropdown"and.2 or 0
az.UIElements.TabIcon=aA
end
az.UIElements.TabItem=aj.NewRoundFrame(ao.MenuCorner-ao.MenuPadding,"Squircle",{
Size=UDim2.new(1,0,0,36),
AutomaticSize=az.Desc and"Y",
ImageTransparency=1,
Parent=an.UIElements.Menu.Frame.ScrollingFrame,
ImageColor3=Color3.new(1,1,1),
Active=not az.Locked,
},{
aj.NewRoundFrame(ao.MenuCorner-ao.MenuPadding,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
ImageTransparency=1,
Name="Highlight",
},{
ak("UIGradient",{
Rotation=80,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
}),
}),
ak("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ak("UIListLayout",{
Padding=UDim.new(0,ao.TabPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ak("UIPadding",{
PaddingTop=UDim.new(0,ao.TabPadding),
PaddingLeft=UDim.new(0,ao.TabPadding),
PaddingRight=UDim.new(0,ao.TabPadding),
PaddingBottom=UDim.new(0,ao.TabPadding),
}),
ak("UICorner",{
CornerRadius=UDim.new(0,ao.MenuCorner-ao.MenuPadding)
}),
aA,
ak("Frame",{
Size=UDim2.new(1,aA and-ao.TabPadding-ao.TabIcon or 0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Name="Title",
},{
ak("TextLabel",{
Text=az.Name,
TextXAlignment="Left",
FontFace=Font.new(aj.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
BackgroundColor3="Text"
},
TextSize=15,
BackgroundTransparency=1,
TextTransparency=aq=="Dropdown"and.4 or.05,
LayoutOrder=999,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
}),
ak("TextLabel",{
Text=az.Desc or"",
TextXAlignment="Left",
FontFace=Font.new(aj.Font,Enum.FontWeight.Regular),
ThemeTag={
TextColor3="Text",
BackgroundColor3="Text"
},
TextSize=15,
BackgroundTransparency=1,
TextTransparency=aq=="Dropdown"and.6 or.35,
LayoutOrder=999,
AutomaticSize="Y",
TextWrapped=true,
Size=UDim2.new(1,0,0,0),
Visible=az.Desc and true or false,
Name="Desc",
}),
ak("UIListLayout",{
Padding=UDim.new(0,ao.TabPadding/3),
FillDirection="Vertical",
}),
})
})
},true)

if az.Locked then
az.UIElements.TabItem.Frame.Title.TextLabel.TextTransparency=0.6
if az.UIElements.TabIcon then
az.UIElements.TabIcon.ImageLabel.ImageTransparency=0.6
end
end

if an.Multi and typeof(an.Value)=="string"then
for aB,aC in next,an.Values do
if typeof(aC)=="table"then
if aC.Title==an.Value then an.Value={aC}end
else
if aC==an.Value then an.Value={an.Value}end
end
end
end

if an.Multi then
local aB=false
if typeof(an.Value)=="table"then
for aC,aD in ipairs(an.Value)do
local aE=typeof(aD)=="table"and aD.Title or aD
if aE==az.Name then
aB=true
break
end
end
end
az.Selected=aB
else
local aB=typeof(an.Value)=="table"and an.Value.Title or an.Value
az.Selected=aB==az.Name
end

if az.Selected and not az.Locked then
az.UIElements.TabItem.ImageTransparency=.95
az.UIElements.TabItem.Highlight.ImageTransparency=.75
az.UIElements.TabItem.Frame.Title.TextLabel.TextTransparency=0
if az.UIElements.TabIcon then
az.UIElements.TabIcon.ImageLabel.ImageTransparency=0
end
end

an.Tabs[ax]=az

ar:Display()

if aq=="Dropdown"then
aj.AddSignal(az.UIElements.TabItem.MouseButton1Click,function()
if az.Locked then return end

if an.Multi then
if not az.Selected then
az.Selected=true
al(az.UIElements.TabItem,0.1,{ImageTransparency=.95}):Play()
al(az.UIElements.TabItem.Highlight,0.1,{ImageTransparency=.75}):Play()
al(az.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if az.UIElements.TabIcon then
al(az.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
table.insert(an.Value,az.Original)
else
if not an.AllowNone and#an.Value==1 then
return
end
az.Selected=false
al(az.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()
al(az.UIElements.TabItem.Highlight,0.1,{ImageTransparency=1}):Play()
al(az.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=.4}):Play()
if az.UIElements.TabIcon then
al(az.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=.2}):Play()
end

for aB,aC in next,an.Value do
if typeof(aC)=="table"and(aC.Title==az.Name)or(aC==az.Name)then
table.remove(an.Value,aB)
break
end
end
end
else
for aB,aC in next,an.Tabs do
al(aC.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()
al(aC.UIElements.TabItem.Highlight,0.1,{ImageTransparency=1}):Play()
al(aC.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=.4}):Play()
if aC.UIElements.TabIcon then
al(aC.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=.2}):Play()
end
aC.Selected=false
end
az.Selected=true
al(az.UIElements.TabItem,0.1,{ImageTransparency=.95}):Play()
al(az.UIElements.TabItem.Highlight,0.1,{ImageTransparency=.75}):Play()
al(az.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if az.UIElements.TabIcon then
al(az.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
an.Value=az.Original
end
Callback()
end)
elseif aq=="Menu"then
if not az.Locked then
aj.AddSignal(az.UIElements.TabItem.MouseEnter,function()
al(az.UIElements.TabItem,0.08,{ImageTransparency=.95}):Play()
end)
aj.AddSignal(az.UIElements.TabItem.InputEnded,function()
al(az.UIElements.TabItem,0.08,{ImageTransparency=1}):Play()
end)
end
aj.AddSignal(az.UIElements.TabItem.MouseButton1Click,function()
if az.Locked then return end
Callback(ay.Callback or function()end)
end)
end

RecalculateCanvasSize()
RecalculateListSize()
else a.load'I'
:New{Parent=an.UIElements.Menu.Frame.ScrollingFrame}
end
end

local az=an.MenuWidth or 0
if az==0 then
for aA,aB in next,an.Tabs do
if aB.UIElements.TabItem.Frame.UIListLayout then
az=math.max(az,aB.UIElements.TabItem.Frame.UIListLayout.AbsoluteContentSize.X)
end
end
end

an.UIElements.MenuCanvas.Size=UDim2.new(0,az+6+6+5+5+18+6+6,an.UIElements.MenuCanvas.Size.Y.Scale,an.UIElements.MenuCanvas.Size.Y.Offset)
Callback()

an.Values=au
end

ar:Refresh(an.Values)

function ar.Select(at,au)
if au then
an.Value=au
else
if an.Multi then
an.Value={}
else
an.Value=nil
end
end
ar:Refresh(an.Values)
end

RecalculateListSize()
RecalculateCanvasSize()

function ar.Open(at)
if ap then
an.UIElements.Menu.Visible=true
an.UIElements.MenuCanvas.Visible=true
an.UIElements.MenuCanvas.Active=true
an.UIElements.Menu.Size=UDim2.new(
1,0,
0,0
)
al(an.UIElements.Menu,0.1,{
Size=UDim2.new(
1,0,
1,0
),
ImageTransparency=0.05
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(.1)
an.Opened=true
end)

UpdatePosition()
end
end

function ar.Close(at)
an.Opened=false

al(an.UIElements.Menu,0.25,{
Size=UDim2.new(
1,0,
0,0
),
ImageTransparency=1,
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(.1)
an.UIElements.Menu.Visible=false
end)

task.spawn(function()
task.wait(.25)
an.UIElements.MenuCanvas.Visible=false
an.UIElements.MenuCanvas.Active=false
end)
end

aj.AddSignal((an.UIElements.Dropdown and an.UIElements.Dropdown.MouseButton1Click or an.DropdownFrame.UIElements.Main.MouseButton1Click),function()
ar:Open()
end)

aj.AddSignal(ae.InputBegan,function(at)
if at.UserInputType==Enum.UserInputType.MouseButton1 or at.UserInputType==Enum.UserInputType.Touch then
local au=an.UIElements.MenuCanvas
local av,aw=au.AbsolutePosition,au.AbsoluteSize

local ax=an.UIElements.Dropdown or an.DropdownFrame.UIElements.Main
local ay=ax.AbsolutePosition
local az=ax.AbsoluteSize

local aA=
af.X>=ay.X and
af.X<=ay.X+az.X and
af.Y>=ay.Y and
af.Y<=ay.Y+az.Y

local aB=
af.X>=av.X and
af.X<=av.X+aw.X and
af.Y>=av.Y and
af.Y<=av.Y+aw.Y

if am.Window.CanDropdown and an.Opened and not aA and not aB then
ar:Close()
end
end
end)

aj.AddSignal(
an.UIElements.Dropdown and an.UIElements.Dropdown:GetPropertyChangedSignal"AbsolutePosition"or
an.DropdownFrame.UIElements.Main:GetPropertyChangedSignal"AbsolutePosition",
UpdatePosition
)

return ar
end

return aa end function a.K()

local aa=(cloneref or clonereference or function(aa)return aa end)

aa(game:GetService"UserInputService")
aa(game:GetService"Players").LocalPlayer:GetMouse()local ac=
aa(game:GetService"Workspace").CurrentCamera

local ae=a.load'b'
local af=ae.New local ag=
ae.Tween

local ah=a.load't'.New local ai=a.load'k'
.New
local aj=a.load'J'.New local ak=

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
Values=an.Values or{},
MenuWidth=an.MenuWidth,
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

local ap=true

ao.DropdownFrame=a.load'z'{
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
}


if ao.Callback then
ao.UIElements.Dropdown=ah("",nil,ao.DropdownFrame.UIElements.Main,nil,an.Window.NewElements and 12 or 10)

ao.UIElements.Dropdown.Frame.Frame.TextLabel.TextTruncate="AtEnd"
ao.UIElements.Dropdown.Frame.Frame.TextLabel.Size=UDim2.new(1,ao.UIElements.Dropdown.Frame.Frame.TextLabel.Size.X.Offset-18-12-12,0,0)

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
Position=UDim2.new(
1,
ao.UIElements.Dropdown and-12 or 0,
0.5,
0
),
ThemeTag={
ImageColor3="Icon"
},
AnchorPoint=Vector2.new(1,0.5),
Parent=ao.UIElements.Dropdown and ao.UIElements.Dropdown.Frame or ao.DropdownFrame.UIElements.Main
})



function ao.Lock(aq)
ao.Locked=true
ap=false
return ao.DropdownFrame:Lock()
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

return al end function a.L()






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

return aa end function a.M()
local aa={}

local ae=a.load'b'
local af=ae.New
local ah=ae.Tween

local aj=a.load'L'

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


return aa end function a.N()
local aa=a.load'b'local ae=
aa.New


local af=a.load'M'

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

function al.Destroy(ao)
an.Destroy()
al=nil
end

al.ElementFrame=an.CodeFrame

return al.__type,al
end

return ah end function a.O()
local aa=a.load'b'
local ae=aa.New local af=
aa.Tween

local ah=(cloneref or clonereference or function(ah)return ah end)

local aj=ah(game:GetService"UserInputService")
ah(game:GetService"TouchInputService")
local ak=ah(game:GetService"RunService")
local al=ah(game:GetService"Players")

local am=ak.RenderStepped
local an=al.LocalPlayer
local ao=an:GetMouse()

local ap=a.load'j'.New
local aq=a.load'k'.New

local ar={
UICorner=9,

}

function ar.Colorpicker(as,at,au,av)
local aw={
__type="Colorpicker",
Title=at.Title,
Desc=at.Desc,
Default=at.Default,
Callback=at.Callback,
Transparency=at.Transparency,
UIElements=at.UIElements,

TextPadding=10,
}

function aw.SetHSVFromRGB(ax,ay)
local az,aA,aB=Color3.toHSV(ay)
aw.Hue=az
aw.Sat=aA
aw.Vib=aB
end

aw:SetHSVFromRGB(aw.Default)

local ax=a.load'l'.Init(au)
local ay=ax.Create()

aw.ColorpickerFrame=ay

ay.UIElements.Main.Size=UDim2.new(1,0,0,0)



local az,aA,aB=aw.Hue,aw.Sat,aw.Vib

aw.UIElements.Title=ae("TextLabel",{
Text=aw.Title,
TextSize=20,
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
TextXAlignment="Left",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ThemeTag={
TextColor3="Text"
},
BackgroundTransparency=1,
Parent=ay.UIElements.Main
},{
ae("UIPadding",{
PaddingTop=UDim.new(0,aw.TextPadding/2),
PaddingLeft=UDim.new(0,aw.TextPadding/2),
PaddingRight=UDim.new(0,aw.TextPadding/2),
PaddingBottom=UDim.new(0,aw.TextPadding/2),
})
})





local aC=ae("Frame",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
Parent=HueDragHolder,
BackgroundColor3=aw.Default
},{
ae("UIStroke",{
Thickness=2,
Transparency=.1,
ThemeTag={
Color="Text",
},
}),
ae("UICorner",{
CornerRadius=UDim.new(1,0),
})
})

aw.UIElements.SatVibMap=ae("ImageLabel",{
Size=UDim2.fromOffset(160,158),
Position=UDim2.fromOffset(0,40+aw.TextPadding),
Image="rbxassetid://4155801252",
BackgroundColor3=Color3.fromHSV(az,1,1),
BackgroundTransparency=0,
Parent=ay.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),
aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.85,
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
}
})
}),

aC,
})

aw.UIElements.Inputs=ae("Frame",{
AutomaticSize="XY",
Size=UDim2.new(0,0,0,0),
Position=UDim2.fromOffset(aw.Transparency and 240 or 210,40+aw.TextPadding),
BackgroundTransparency=1,
Parent=ay.UIElements.Main
},{
ae("UIListLayout",{
Padding=UDim.new(0,4),
FillDirection="Vertical",
})
})





local aD=ae("Frame",{
BackgroundColor3=aw.Default,
Size=UDim2.fromScale(1,1),
BackgroundTransparency=aw.Transparency,
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
Position=UDim2.fromOffset(85,208+aw.TextPadding),
Size=UDim2.fromOffset(75,24),
Parent=ay.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),
aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.85,
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
}
})
}),







aD,
})

local aE=ae("Frame",{
BackgroundColor3=aw.Default,
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
Position=UDim2.fromOffset(0,208+aw.TextPadding),
Size=UDim2.fromOffset(75,24),
Parent=ay.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),







aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=.85,
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
}
})
}),
aE,
})

local aF={}

for b=0,1,0.1 do
table.insert(aF,ColorSequenceKeypoint.new(b,Color3.fromHSV(b,1,1)))
end

local b=ae("UIGradient",{
Color=ColorSequence.new(aF),
Rotation=90,
})

local d=ae("Frame",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
})

local f=ae("Frame",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
Parent=d,


BackgroundColor3=aw.Default
},{
ae("UIStroke",{
Thickness=2,
Transparency=.1,
ThemeTag={
Color="Text",
},
}),
ae("UICorner",{
CornerRadius=UDim.new(1,0),
})
})

local g=ae("Frame",{
Size=UDim2.fromOffset(6,192),
Position=UDim2.fromOffset(180,40+aw.TextPadding),
Parent=ay.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(1,0),
}),
b,
d,
})


function CreateNewInput(h,j)
local l=aq(h,nil,aw.UIElements.Inputs)

ae("TextLabel",{
BackgroundTransparency=1,
TextTransparency=.4,
TextSize=17,
FontFace=Font.new(aa.Font,Enum.FontWeight.Regular),
AutomaticSize="XY",
ThemeTag={
TextColor3="Placeholder",
},
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-12,0.5,0),
Parent=l.Frame,
Text=h,
})

ae("UIScale",{
Parent=l,
Scale=.85,
})

l.Frame.Frame.TextBox.Text=j
l.Size=UDim2.new(0,150,0,42)

return l
end

local function ToRGB(h)
return{
R=math.floor(h.R*255),
G=math.floor(h.G*255),
B=math.floor(h.B*255)
}
end

local h=CreateNewInput("Hex","#"..aw.Default:ToHex())

local j=CreateNewInput("Red",ToRGB(aw.Default).R)
local l=CreateNewInput("Green",ToRGB(aw.Default).G)
local m=CreateNewInput("Blue",ToRGB(aw.Default).B)
local p
if aw.Transparency then
p=CreateNewInput("Alpha",((1-aw.Transparency)*100).."%")
end

local r=ae("Frame",{
Size=UDim2.new(1,0,0,40),
AutomaticSize="Y",
Position=UDim2.new(0,0,0,254+aw.TextPadding),
BackgroundTransparency=1,
Parent=ay.UIElements.Main,
LayoutOrder=4,
},{
ae("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
HorizontalAlignment="Right",
}),






})

local u={
{
Title="Cancel",
Variant="Secondary",
Callback=function()end
},
{
Title="Apply",
Icon="chevron-right",
Variant="Primary",
Callback=function()av(Color3.fromHSV(aw.Hue,aw.Sat,aw.Vib),aw.Transparency)end
}
}

for v,x in next,u do
local B=ap(x.Title,x.Icon,x.Callback,x.Variant,r,ay,false)
B.Size=UDim2.new(0.5,-3,0,40)
B.AutomaticSize="None"
end



local B,C,F
if aw.Transparency then
local G=ae("Frame",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.fromOffset(0,0),
BackgroundTransparency=1,
})

C=ae("ImageLabel",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
ThemeTag={
BackgroundColor3="Text",
},
Parent=G,

},{
ae("UIStroke",{
Thickness=2,
Transparency=.1,
ThemeTag={
Color="Text",
},
}),
ae("UICorner",{
CornerRadius=UDim.new(1,0),
})

})

F=ae("Frame",{
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

B=ae("Frame",{
Size=UDim2.fromOffset(6,192),
Position=UDim2.fromOffset(210,40+aw.TextPadding),
Parent=ay.UIElements.Main,
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
F,
G,
})
end

function aw.Round(G,H,J)
if J==0 then
return math.floor(H)
end
H=tostring(H)
return H:find"%."and tonumber(H:sub(1,H:find"%."+J))or H
end


function aw.Update(G,H,J)
if H then az,aA,aB=Color3.toHSV(H)else az,aA,aB=aw.Hue,aw.Sat,aw.Vib end

aw.UIElements.SatVibMap.BackgroundColor3=Color3.fromHSV(az,1,1)
aC.Position=UDim2.new(aA,0,1-aB,0)
aC.BackgroundColor3=Color3.fromHSV(az,aA,aB)
aE.BackgroundColor3=Color3.fromHSV(az,aA,aB)
f.BackgroundColor3=Color3.fromHSV(az,1,1)
f.Position=UDim2.new(0.5,0,az,0)

h.Frame.Frame.TextBox.Text="#"..Color3.fromHSV(az,aA,aB):ToHex()
j.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(az,aA,aB)).R
l.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(az,aA,aB)).G
m.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(az,aA,aB)).B

if J or aw.Transparency then
aE.BackgroundTransparency=aw.Transparency or J
F.BackgroundColor3=Color3.fromHSV(az,aA,aB)
C.BackgroundColor3=Color3.fromHSV(az,aA,aB)
C.BackgroundTransparency=aw.Transparency or J
C.Position=UDim2.new(0.5,0,1-aw.Transparency or J,0)
p.Frame.Frame.TextBox.Text=aw:Round((1-aw.Transparency or J)*100,0).."%"
end
end

aw:Update(aw.Default,aw.Transparency)




local function GetRGB()
local G=Color3.fromHSV(aw.Hue,aw.Sat,aw.Vib)
return{R=math.floor(G.r*255),G=math.floor(G.g*255),B=math.floor(G.b*255)}
end



local function clamp(G,H,J)
return math.clamp(tonumber(G)or 0,H,J)
end

aa.AddSignal(h.Frame.Frame.TextBox.FocusLost,function(G)
if G then
local H=h.Frame.Frame.TextBox.Text:gsub("#","")
local J,L=pcall(Color3.fromHex,H)
if J and typeof(L)=="Color3"then
aw.Hue,aw.Sat,aw.Vib=Color3.toHSV(L)
aw:Update()
aw.Default=L
end
end
end)

local function updateColorFromInput(G,H)
aa.AddSignal(G.Frame.Frame.TextBox.FocusLost,function(J)
if J then
local L=G.Frame.Frame.TextBox
local M=GetRGB()
local N=clamp(L.Text,0,255)
L.Text=tostring(N)

M[H]=N
local O=Color3.fromRGB(M.R,M.G,M.B)
aw.Hue,aw.Sat,aw.Vib=Color3.toHSV(O)
aw:Update()
end
end)
end

updateColorFromInput(j,"R")
updateColorFromInput(l,"G")
updateColorFromInput(m,"B")

if aw.Transparency then
aa.AddSignal(p.Frame.Frame.TextBox.FocusLost,function(G)
if G then
local H=p.Frame.Frame.TextBox
local J=clamp(H.Text,0,100)
H.Text=tostring(J)

aw.Transparency=1-J*0.01
aw:Update(nil,aw.Transparency)
end
end)
end



local G=aw.UIElements.SatVibMap
aa.AddSignal(G.InputBegan,function(H)
if H.UserInputType==Enum.UserInputType.MouseButton1 or H.UserInputType==Enum.UserInputType.Touch then
while aj:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local J=G.AbsolutePosition.X
local L=J+G.AbsoluteSize.X
local M=math.clamp(ao.X,J,L)

local N=G.AbsolutePosition.Y
local O=N+G.AbsoluteSize.Y
local P=math.clamp(ao.Y,N,O)

aw.Sat=(M-J)/(L-J)
aw.Vib=1-((P-N)/(O-N))
aw:Update()

am:Wait()
end
end
end)

aa.AddSignal(g.InputBegan,function(H)
if H.UserInputType==Enum.UserInputType.MouseButton1 or H.UserInputType==Enum.UserInputType.Touch then
while aj:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local J=g.AbsolutePosition.Y
local L=J+g.AbsoluteSize.Y
local M=math.clamp(ao.Y,J,L)

aw.Hue=((M-J)/(L-J))
aw:Update()

am:Wait()
end
end
end)

if aw.Transparency then
aa.AddSignal(B.InputBegan,function(H)
if H.UserInputType==Enum.UserInputType.MouseButton1 or H.UserInputType==Enum.UserInputType.Touch then
while aj:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local J=B.AbsolutePosition.Y
local L=J+B.AbsoluteSize.Y
local M=math.clamp(ao.Y,J,L)

aw.Transparency=1-((M-J)/(L-J))
aw:Update()

am:Wait()
end
end
end)
end

return aw
end

function ar.New(as,at)
local au={
__type="Colorpicker",
Title=at.Title or"Colorpicker",
Desc=at.Desc or nil,
Locked=at.Locked or false,
Default=at.Default or Color3.new(1,1,1),
Callback=at.Callback or function()end,

UIScale=at.UIScale,
Transparency=at.Transparency,
UIElements={}
}

local av=true



au.ColorpickerFrame=a.load'z'{
Title=au.Title,
Desc=au.Desc,
Parent=at.Parent,
TextOffset=40,
Hover=false,
Tab=at.Tab,
Index=at.Index,
Window=at.Window,
ElementTable=au,
ParentConfig=at,
}

au.UIElements.Colorpicker=aa.NewRoundFrame(ar.UICorner,"Squircle",{
ImageTransparency=0,
Active=true,
ImageColor3=au.Default,
Parent=au.ColorpickerFrame.UIElements.Main,
Size=UDim2.new(0,26,0,26),
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,0,0,0),
ZIndex=2
},nil,true)


function au.Lock(aw)
au.Locked=true
av=false
return au.ColorpickerFrame:Lock()
end
function au.Unlock(aw)
au.Locked=false
av=true
return au.ColorpickerFrame:Unlock()
end

if au.Locked then
au:Lock()
end


function au.Update(aw,ax,ay)
au.UIElements.Colorpicker.ImageTransparency=ay or 0
au.UIElements.Colorpicker.ImageColor3=ax
au.Default=ax
if ay then
au.Transparency=ay
end
end

function au.Set(aw,ax,ay)
return au:Update(ax,ay)
end

aa.AddSignal(au.UIElements.Colorpicker.MouseButton1Click,function()
if av then
ar:Colorpicker(au,at.Window,function(aw,ax)
au:Update(aw,ax)
au.Default=aw
au.Transparency=ax
aa.SafeCallback(au.Callback,aw,ax)
end).ColorpickerFrame:Open()
end
end)

return au.__type,au
end

return ar end function a.P()
local aa=a.load'b'
local ae=aa.New
local af=aa.Tween

local ah={}

function ah.New(aj,ak)
local al={
__type="Section",
Title=ak.Title or"Section",
Icon=ak.Icon,
TextXAlignment=ak.TextXAlignment or"Left",
TextSize=ak.TextSize or 19,
Box=ak.Box or false,
FontWeight=ak.FontWeight or Enum.FontWeight.SemiBold,
TextTransparency=ak.TextTransparency or 0.05,
Opened=ak.Opened or false,
UIElements={},

HeaderSize=42,
IconSize=20,
Padding=10,

Elements={},

Expandable=false,
}

local am


function al.SetIcon(an,ao)
al.Icon=ao or nil
if am then am:Destroy()end
if ao then
am=aa.Image(
ao,
ao..":"..al.Title,
0,
ak.Window.Folder,
al.__type,
true
)
am.Size=UDim2.new(0,al.IconSize,0,al.IconSize)
end
end

local an=ae("Frame",{
Size=UDim2.new(0,al.IconSize,0,al.IconSize),
BackgroundTransparency=1,
Visible=false
},{
ae("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Image=aa.Icon"chevron-down"[1],
ImageRectSize=aa.Icon"chevron-down"[2].ImageRectSize,
ImageRectOffset=aa.Icon"chevron-down"[2].ImageRectPosition,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.7,
})
})


if al.Icon then
al:SetIcon(al.Icon)
end

local ao=ae("TextLabel",{
BackgroundTransparency=1,
TextXAlignment=al.TextXAlignment,
AutomaticSize="Y",
TextSize=al.TextSize,
TextTransparency=al.TextTransparency,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(aa.Font,al.FontWeight),


Text=al.Title,
Size=UDim2.new(
1,
0,
0,
0
),
TextWrapped=true,
})


local function UpdateTitleSize()
local ap=0
if am then
ap=ap-(al.IconSize+8)
end
if an.Visible then
ap=ap-(al.IconSize+8)
end
ao.Size=UDim2.new(1,ap,0,0)
end


local ap=aa.NewRoundFrame(ak.Window.ElementConfig.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
Parent=ak.Parent,
ClipsDescendants=true,
AutomaticSize="Y",
ImageTransparency=al.Box and.93 or 1,
ThemeTag={
ImageColor3="Text",
},
},{
ae("TextButton",{
Size=UDim2.new(1,0,0,Expandable and 0 or al.HeaderSize),
BackgroundTransparency=1,
AutomaticSize=Expandable and nil or"Y",
Text="",
Name="Top",
},{
al.Box and ae("UIPadding",{
PaddingLeft=UDim.new(0,ak.Window.ElementConfig.UIPadding+(ak.Window.NewElements and 4 or 0)),
PaddingRight=UDim.new(0,ak.Window.ElementConfig.UIPadding+(ak.Window.NewElements and 4 or 0)),
})or nil,
am,
ao,
ae("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
an,
}),
ae("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
Name="Content",
Visible=false,
Position=UDim2.new(0,0,0,al.HeaderSize)
},{
al.Box and ae("UIPadding",{
PaddingLeft=UDim.new(0,ak.Window.ElementConfig.UIPadding),
PaddingRight=UDim.new(0,ak.Window.ElementConfig.UIPadding),
PaddingBottom=UDim.new(0,ak.Window.ElementConfig.UIPadding),
})or nil,
ae("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,ak.Tab.Gap),
VerticalAlignment="Top",
}),
})
})





al.ElementFrame=ap


local aq=ak.ElementsModule

aq.Load(al,ap.Content,aq.Elements,ak.Window,ak.WindUI,function()
if not al.Expandable then
al.Expandable=true
an.Visible=true
UpdateTitleSize()
end
end,aq,ak.UIScale,ak.Tab)


UpdateTitleSize()

function al.SetTitle(ar,as)
ao.Text=as
end

function al.Destroy(ar)
for as,at in next,al.Elements do
at:Destroy()
end








ap:Destroy()
end

function al.Open(ar)
if al.Expandable then
al.Opened=true
af(ap,0.33,{
Size=UDim2.new(ap.Size.X.Scale,ap.Size.X.Offset,0,al.HeaderSize+(ap.Content.AbsoluteSize.Y/ak.UIScale))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

af(an.ImageLabel,0.1,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
function al.Close(ar)
if al.Expandable then
al.Opened=false
af(ap,0.26,{
Size=UDim2.new(ap.Size.X.Scale,ap.Size.X.Offset,0,al.HeaderSize)
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
af(an.ImageLabel,0.1,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

aa.AddSignal(ap.Top.MouseButton1Click,function()
if al.Expandable then
if al.Opened then
al:Close()
else
al:Open()
end
end
end)

aa.AddSignal(ap.Content.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()
if al.Opened then
al:Open()
end
end)

task.spawn(function()
task.wait(0.02)
if al.Expandable then








ap.Size=UDim2.new(ap.Size.X.Scale,ap.Size.X.Offset,0,al.HeaderSize)
ap.AutomaticSize="None"
ap.Top.Size=UDim2.new(1,0,0,al.HeaderSize)
ap.Top.AutomaticSize="None"
ap.Content.Visible=true
end
if al.Opened then
al:Open()
end

end)

return al.__type,al
end

return ah end function a.Q()
local aa=a.load'b'
local ae=aa.New

local af={}

function af.New(ah,aj)
local ak=ae("Frame",{
Parent=aj.Parent,
Size=aj.ParentType~="Group"and UDim2.new(1,-7,0,7*(aj.Columns or 1))or UDim2.new(0,7*(aj.Columns or 1),0,0),
BackgroundTransparency=1,
})

return"Space",{__type="Space",ElementFrame=ak}
end

return af end function a.R()
local aa=a.load'b'
local ae=aa.New

local af={}

local function ParseAspectRatio(ah)
if type(ah)=="string"then
local aj,ak=ah:match"(%d+):(%d+)"
if aj and ak then
return tonumber(aj)/tonumber(ak)
end
elseif type(ah)=="number"then
return ah
end
return nil
end

function af.New(ah,aj)
local ak={
__type="Image",
Image=aj.Image or"",
AspectRatio=aj.AspectRatio or"16:9",
Radius=aj.Radius or aj.Window.ElementConfig.UICorner,
}
local al=aa.Image(
ak.Image,
ak.Image,
ak.Radius,
aj.Window.Folder,
"Image",
false
)
al.Parent=aj.Parent
al.Size=UDim2.new(1,0,0,0)
al.BackgroundTransparency=1












local am=ParseAspectRatio(ak.AspectRatio)
local an

if am then
an=ae("UIAspectRatioConstraint",{
Parent=al,
AspectRatio=am,
AspectType="ScaleWithParentSize",
DominantAxis="Width"
})
end

function ak.Destroy(ao)
al:Destroy()
end

return ak.__type,ak
end

return af end function a.S()
local aa=a.load'b'
local ae=aa.New

local af={}

function af.New(ah,aj)
local ak={
__type="Group",
Elements={}
}

local al=ae("Frame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=aj.Parent,
},{
ae("UIListLayout",{
FillDirection="Horizontal",
HorizontalAlignment="Center",

Padding=UDim.new(0,aj.Tab and aj.Tab.Gap or(Window.NewElements and 1 or 6))
}),
})

local am=aj.ElementsModule
am.Load(
ak,
al,
am.Elements,
aj.Window,
aj.WindUI,
function(an,ao)
local ap=aj.Tab and aj.Tab.Gap or(aj.Window.NewElements and 1 or 6)

local aq={}
local ar=0

for as,at in next,ao do
if at.__type=="Space"then
ar=ar+(at.ElementFrame.Size.X.Offset or 6)
elseif at.__type=="Divider"then
ar=ar+(at.ElementFrame.Size.X.Offset or 1)
else
table.insert(aq,at)
end
end

local au=#aq
if au==0 then return end

local av=1/au

local aw=ap*(au-1)

local ax=-(aw+ar)

local ay=math.floor(ax/au)
local az=ax-(ay*au)

for aA,aB in next,aq do
local aC=ay
if aA<=math.abs(az)then
aC=aC-1
end

if aB.ElementFrame then
aB.ElementFrame.Size=UDim2.new(av,aC,1,0)
end
end
end,
am,
aj.UIScale,
aj.Tab
)



return ak.__type,ak
end

return af end function a.T()
return{
Elements={
Paragraph=a.load'A',
Button=a.load'B',
Toggle=a.load'E',
Slider=a.load'F',
Keybind=a.load'G',
Input=a.load'H',
Dropdown=a.load'K',
Code=a.load'N',
Colorpicker=a.load'O',
Section=a.load'P',
Divider=a.load'I',
Space=a.load'Q',
Image=a.load'R',
Group=a.load'S',

},
Load=function(aa,ae,af,ah,aj,ak,al,am,an)
for ao,ap in next,af do
aa[ao]=function(aq,ar)
ar=ar or{}
ar.Tab=an or aa
ar.ParentType=aa.__type
ar.ParentTable=aa
ar.Index=#aa.Elements+1
ar.GlobalIndex=#ah.AllElements+1
ar.Parent=ae
ar.Window=ah
ar.WindUI=aj
ar.UIScale=am
ar.ElementsModule=al local

as, au=ap:New(ar)

if ar.Flag and typeof(ar.Flag)=="string"then
if ah.CurrentConfig then
ah.CurrentConfig:Register(ar.Flag,au)

if ah.PendingConfigData and ah.PendingConfigData[ar.Flag]then
local av=ah.PendingConfigData[ar.Flag]

local aw=ah.ConfigManager
if aw.Parser[av.__type]then
task.defer(function()
local ax,ay=pcall(function()
aw.Parser[av.__type].Load(au,av)
end)

if ax then
ah.PendingConfigData[ar.Flag]=nil
else
warn("[ WindUI ] Failed to apply pending config for '"..ar.Flag.."': "..tostring(ay))
end
end)
end
end
else
ah.PendingFlags=ah.PendingFlags or{}
ah.PendingFlags[ar.Flag]=au
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
function au.SetTitle(ay,az)
av:SetTitle(az)
end
function au.SetDesc(ay,az)
av:SetDesc(az)
end
function au.Highlight(ay)
av:Highlight()
end
function au.Destroy(ay)
av:Destroy()

table.remove(ah.AllElements,ar.GlobalIndex)
table.remove(aa.Elements,ar.Index)
table.remove(an.Elements,ar.Index)
aa:UpdateAllElementShapes(aa)
end
end



ah.AllElements[ar.Index]=au
aa.Elements[ar.Index]=au
if an then an.Elements[ar.Index]=au end

if ah.NewElements then
aa:UpdateAllElementShapes(aa)
end

if ak then
ak(au,aa.Elements)
end
return au
end
end
function aa.UpdateAllElementShapes(aq,ar)
for as,au in next,ar.Elements do
local av
for aw,ax in pairs(au)do
if typeof(ax)=="table"and aw:match"Frame$"then
av=ax
break
end
end

if av then

av.Index=as
if av.UpdateShape then

av.UpdateShape(ar)
end
end
end
end
end,

}end function a.U()
local aa=(cloneref or clonereference or function(aa)return aa end)

aa(game:GetService"UserInputService")
local ae=game.Players.LocalPlayer:GetMouse()

local af=a.load'b'
local ah=af.New
local aj=af.Tween

local ak=a.load'y'.New
local al=a.load'u'.New





local am={


Tabs={},
Containers={},
SelectedTab=nil,
TabCount=0,
ToolTipParent=nil,
TabHighlight=nil,

OnChangeFunc=function(am)end
}

function am.Init(an,ao,ap,aq)
Window=an
WindUI=ao
am.ToolTipParent=ap
am.TabHighlight=aq
return am
end

function am.New(an,ao)
local ap={
__type="Tab",
Title=an.Title or"Tab",
Desc=an.Desc,
Icon=an.Icon,
IconColor=an.IconColor,
IconShape=an.IconShape,
IconThemed=an.IconThemed,
Locked=an.Locked,
ShowTabTitle=an.ShowTabTitle,
Selected=false,
Index=nil,
Parent=an.Parent,
UIElements={},
Elements={},
ContainerFrame=nil,
UICorner=Window.UICorner-(Window.UIPadding/2),

Gap=Window.NewElements and 1 or 6,

TabPaddingX=4+(Window.UIPadding/2),
TabPaddingY=3+(Window.UIPadding/2),
TitlePaddingY=0,
}

if ap.IconShape then
ap.TabPaddingX=2+(Window.UIPadding/4)
ap.TabPaddingY=2+(Window.UIPadding/4)
ap.TitlePaddingY=2+(Window.UIPadding/4)
end

am.TabCount=am.TabCount+1

local aq=am.TabCount
ap.Index=aq

ap.UIElements.Main=af.NewRoundFrame(ap.UICorner,"Squircle",{
BackgroundTransparency=1,
Size=UDim2.new(1,-7,0,0),
AutomaticSize="Y",
Parent=an.Parent,
ThemeTag={
ImageColor3="TabBackground",
},
ImageTransparency=1,
},{
af.NewRoundFrame(ap.UICorner,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Outline"
},{
ah("UIGradient",{
Rotation=80,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
}),
}),
af.NewRoundFrame(ap.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Frame",
},{
ah("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,2+(Window.UIPadding/2)),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ah("TextLabel",{
Text=ap.Title,
ThemeTag={
TextColor3="TabTitle"
},
TextTransparency=not ap.Locked and 0.4 or.7,
TextSize=15,
Size=UDim2.new(1,0,0,0),
FontFace=Font.new(af.Font,Enum.FontWeight.Medium),
TextWrapped=true,
RichText=true,
AutomaticSize="Y",
LayoutOrder=2,
TextXAlignment="Left",
BackgroundTransparency=1,
},{
ah("UIPadding",{
PaddingTop=UDim.new(0,ap.TitlePaddingY),


PaddingBottom=UDim.new(0,ap.TitlePaddingY)
})
}),
ah("UIPadding",{
PaddingTop=UDim.new(0,ap.TabPaddingY),
PaddingLeft=UDim.new(0,ap.TabPaddingX),
PaddingRight=UDim.new(0,ap.TabPaddingX),
PaddingBottom=UDim.new(0,ap.TabPaddingY),
})
}),
},true)

local ar=0
local as
local au

if ap.Icon then
as=af.Image(
ap.Icon,
ap.Icon..":"..ap.Title,
0,
Window.Folder,
ap.__type,
ap.IconColor and false or true,
ap.IconThemed,
"TabIcon"
)
as.Size=UDim2.new(0,16,0,16)
if ap.IconColor then
as.ImageLabel.ImageColor3=ap.IconColor
end
if not ap.IconShape then
as.Parent=ap.UIElements.Main.Frame
ap.UIElements.Icon=as
as.ImageLabel.ImageTransparency=not ap.Locked and 0 or.7
ar=-18-(Window.UIPadding/2)
ap.UIElements.Main.Frame.TextLabel.Size=UDim2.new(1,ar,0,0)
elseif ap.IconColor then
af.NewRoundFrame(ap.IconShape~="Circle"and(ap.UICorner+5-(2+(Window.UIPadding/4)))or 9999,"Squircle",{
Size=UDim2.new(0,26,0,26),
ImageColor3=ap.IconColor,
Parent=ap.UIElements.Main.Frame
},{
as,
af.NewRoundFrame(ap.IconShape~="Circle"and(ap.UICorner+5-(2+(Window.UIPadding/4)))or 9999,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="White",
},
ImageTransparency=.35,
Name="Outline"
},{
ah("UIGradient",{
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
}
}),
}),
})
as.AnchorPoint=Vector2.new(0.5,0.5)
as.Position=UDim2.new(0.5,0,0.5,0)
as.ImageLabel.ImageTransparency=0
as.ImageLabel.ImageColor3=af.GetTextColorForHSB(ap.IconColor)
ar=-28-(Window.UIPadding/2)
ap.UIElements.Main.Frame.TextLabel.Size=UDim2.new(1,ar,0,0)
end





au=af.Image(
ap.Icon,
ap.Icon..":"..ap.Title,
0,
Window.Folder,
ap.__type,
true,
ap.IconThemed
)
au.Size=UDim2.new(0,16,0,16)
au.ImageLabel.ImageTransparency=not ap.Locked and 0 or.7
ar=-30




end

ap.UIElements.ContainerFrame=ah("ScrollingFrame",{
Size=UDim2.new(1,0,1,ap.ShowTabTitle and-((Window.UIPadding*2.4)+12)or 0),
BackgroundTransparency=1,
ScrollBarThickness=0,
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
AnchorPoint=Vector2.new(0,1),
Position=UDim2.new(0,0,1,0),
AutomaticCanvasSize="Y",

ScrollingDirection="Y",
},{
ah("UIPadding",{
PaddingTop=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingLeft=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingRight=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingBottom=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
}),
ah("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,ap.Gap),
HorizontalAlignment="Center",
})
})





ap.UIElements.ContainerFrameCanvas=ah("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Visible=false,
Parent=Window.UIElements.MainBar,
ZIndex=5,
},{
ap.UIElements.ContainerFrame,
ah("Frame",{
Size=UDim2.new(1,0,0,((Window.UIPadding*2.4)+12)),
BackgroundTransparency=1,
Visible=ap.ShowTabTitle or false,
Name="TabTitle"
},{
au,
ah("TextLabel",{
Text=ap.Title,
ThemeTag={
TextColor3="Text"
},
TextSize=20,
TextTransparency=.1,
Size=UDim2.new(1,-ar,1,0),
FontFace=Font.new(af.Font,Enum.FontWeight.SemiBold),
TextTruncate="AtEnd",
RichText=true,
LayoutOrder=2,
TextXAlignment="Left",
BackgroundTransparency=1,
}),
ah("UIPadding",{
PaddingTop=UDim.new(0,20),
PaddingLeft=UDim.new(0,20),
PaddingRight=UDim.new(0,20),
PaddingBottom=UDim.new(0,20),
}),
ah("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
})
}),
ah("Frame",{
Size=UDim2.new(1,0,0,1),
BackgroundTransparency=.9,
ThemeTag={
BackgroundColor3="Text"
},
Position=UDim2.new(0,0,0,((Window.UIPadding*2.4)+12)),
Visible=ap.ShowTabTitle or false,
})
})

am.Containers[aq]=ap.UIElements.ContainerFrameCanvas
am.Tabs[aq]=ap

ap.ContainerFrame=ContainerFrameCanvas

af.AddSignal(ap.UIElements.Main.MouseButton1Click,function()
if not ap.Locked then
am:SelectTab(aq)
end
end)

if Window.ScrollBarEnabled then
al(ap.UIElements.ContainerFrame,ap.UIElements.ContainerFrameCanvas,Window,3)
end

local av
local aw
local ax
local ay=false



if ap.Desc then


af.AddSignal(ap.UIElements.Main.InputBegan,function()
ay=true
aw=task.spawn(function()
task.wait(0.35)
if ay and not av then
av=ak(ap.Desc,am.ToolTipParent,true)
av.Container.AnchorPoint=Vector2.new(0.5,0.5)

local function updatePosition()
if av then
av.Container.Position=UDim2.new(0,ae.X,0,ae.Y-4)
end
end

updatePosition()
ax=ae.Move:Connect(updatePosition)
av:Open()
end
end)
end)

end

af.AddSignal(ap.UIElements.Main.MouseEnter,function()
if not ap.Locked then
aj(ap.UIElements.Main.Frame,0.08,{ImageTransparency=.97}):Play()
end
end)
af.AddSignal(ap.UIElements.Main.InputEnded,function()
if ap.Desc then
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

if not ap.Locked then
aj(ap.UIElements.Main.Frame,0.08,{ImageTransparency=1}):Play()
end
end)



function ap.ScrollToTheElement(az,aA)
ap.UIElements.ContainerFrame.ScrollingEnabled=false
aj(ap.UIElements.ContainerFrame,.45,
{
CanvasPosition=Vector2.new(
0,

ap.Elements[aA].ElementFrame.AbsolutePosition.Y
-ap.UIElements.ContainerFrame.AbsolutePosition.Y
-ap.UIElements.ContainerFrame.UIPadding.PaddingTop.Offset
)
},
Enum.EasingStyle.Quint,Enum.EasingDirection.Out
):Play()

task.spawn(function()
task.wait(.48)

if ap.Elements[aA].Highlight then
ap.Elements[aA]:Highlight()
ap.UIElements.ContainerFrame.ScrollingEnabled=true
end
end)

return ap
end





local az=a.load'T'

az.Load(ap,ap.UIElements.ContainerFrame,az.Elements,Window,WindUI,nil,az,ao)



function ap.LockAll(aA)

for aB,aC in next,Window.AllElements do
if aC.Tab and aC.Tab.Index and aC.Tab.Index==ap.Index and aC.Lock then
aC:Lock()
end
end
end
function ap.UnlockAll(aA)
for aB,aC in next,Window.AllElements do
if aC.Tab and aC.Tab.Index and aC.Tab.Index==ap.Index and aC.Unlock then
aC:Unlock()
end
end
end
function ap.GetLocked(aA)
local aB={}

for aC,aD in next,Window.AllElements do
if aD.Tab and aD.Tab.Index and aD.Tab.Index==ap.Index and aD.Locked==true then
table.insert(aB,aD)
end
end

return aB
end
function ap.GetUnlocked(aA)
local aB={}

for aC,aD in next,Window.AllElements do
if aD.Tab and aD.Tab.Index and aD.Tab.Index==ap.Index and aD.Locked==false then
table.insert(aB,aD)
end
end

return aB
end

function ap.Select(aA)
return am:SelectTab(ap.Index)
end

task.spawn(function()
local aA=ah("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,-Window.UIElements.Main.Main.Topbar.AbsoluteSize.Y),
Parent=ap.UIElements.ContainerFrame
},{
ah("UIListLayout",{
Padding=UDim.new(0,8),
SortOrder="LayoutOrder",
VerticalAlignment="Center",
HorizontalAlignment="Center",
FillDirection="Vertical",
}),
ah("ImageLabel",{
Size=UDim2.new(0,48,0,48),
Image=af.Icon"frown"[1],
ImageRectOffset=af.Icon"frown"[2].ImageRectPosition,
ImageRectSize=af.Icon"frown"[2].ImageRectSize,
ThemeTag={
ImageColor3="Icon"
},
BackgroundTransparency=1,
ImageTransparency=.6,
}),
ah("TextLabel",{
AutomaticSize="XY",
Text="This tab is empty",
ThemeTag={
TextColor3="Text"
},
TextSize=18,
TextTransparency=.5,
BackgroundTransparency=1,
FontFace=Font.new(af.Font,Enum.FontWeight.Medium),
})
})





local aB
aB=af.AddSignal(ap.UIElements.ContainerFrame.ChildAdded,function()
aA.Visible=false
aB:Disconnect()
end)
end)

return ap
end

function am.OnChange(an,ao)
am.OnChangeFunc=ao
end

function am.SelectTab(an,ao)
if not am.Tabs[ao].Locked then
am.SelectedTab=ao

for ap,aq in next,am.Tabs do
if not aq.Locked then
aj(aq.UIElements.Main,0.15,{ImageTransparency=1}):Play()

aj(aq.UIElements.Main.Frame.TextLabel,0.15,{TextTransparency=0.3}):Play()
if aq.UIElements.Icon and not aq.IconColor then
aj(aq.UIElements.Icon.ImageLabel,0.15,{ImageTransparency=0.4}):Play()
end
aq.Selected=false
end
end
aj(am.Tabs[ao].UIElements.Main,0.15,{ImageTransparency=0.93}):Play()

aj(am.Tabs[ao].UIElements.Main.Frame.TextLabel,0.15,{TextTransparency=0}):Play()
if am.Tabs[ao].UIElements.Icon and not am.Tabs[ao].IconColor then
aj(am.Tabs[ao].UIElements.Icon.ImageLabel,0.15,{ImageTransparency=0.1}):Play()
end
am.Tabs[ao].Selected=true


task.spawn(function()
for ar,as in next,am.Containers do
as.AnchorPoint=Vector2.new(0,0.05)
as.Visible=false
end
am.Containers[ao].Visible=true
aj(am.Containers[ao],0.15,{AnchorPoint=Vector2.new(0,0)},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()
end)

am.OnChangeFunc(ao)
end
end

return am end function a.V()
local aa={}


local ae=a.load'b'
local af=ae.New
local ah=ae.Tween

local aj=a.load'U'

function aa.New(ak,al,am,an,ao)
local ap={
Title=ak.Title or"Section",
Icon=ak.Icon,
IconThemed=ak.IconThemed,
Opened=ak.Opened or false,

HeaderSize=42,
IconSize=18,

Expandable=false,
}

local aq
if ap.Icon then
aq=ae.Image(
ap.Icon,
ap.Icon,
0,
am,
"Section",
true,
ap.IconThemed
)

aq.Size=UDim2.new(0,ap.IconSize,0,ap.IconSize)
aq.ImageLabel.ImageTransparency=.25
end

local ar=af("Frame",{
Size=UDim2.new(0,ap.IconSize,0,ap.IconSize),
BackgroundTransparency=1,
Visible=false
},{
af("ImageLabel",{
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

local as=af("Frame",{
Size=UDim2.new(1,0,0,ap.HeaderSize),
BackgroundTransparency=1,
Parent=al,
ClipsDescendants=true,
},{
af("TextButton",{
Size=UDim2.new(1,0,0,ap.HeaderSize),
BackgroundTransparency=1,
Text="",
},{
aq,
af("TextLabel",{
Text=ap.Title,
TextXAlignment="Left",
Size=UDim2.new(
1,
aq and(-ap.IconSize-10)*2
or(-ap.IconSize-10),

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
af("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
Padding=UDim.new(0,10)
}),
ar,
af("UIPadding",{
PaddingLeft=UDim.new(0,11),
PaddingRight=UDim.new(0,11),
})
}),
af("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
Name="Content",
Visible=true,
Position=UDim2.new(0,0,0,ap.HeaderSize)
},{
af("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,ao.Gap),
VerticalAlignment="Bottom",
}),
})
})


function ap.Tab(au,av)
if not ap.Expandable then
ap.Expandable=true
ar.Visible=true
end
av.Parent=as.Content
return aj.New(av,an)
end

function ap.Open(au)
if ap.Expandable then
ap.Opened=true
ah(as,0.33,{
Size=UDim2.new(1,0,0,ap.HeaderSize+(as.Content.AbsoluteSize.Y/an))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

ah(ar.ImageLabel,0.1,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
function ap.Close(au)
if ap.Expandable then
ap.Opened=false
ah(as,0.26,{
Size=UDim2.new(1,0,0,ap.HeaderSize)
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ah(ar.ImageLabel,0.1,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

ae.AddSignal(as.TextButton.MouseButton1Click,function()
if ap.Expandable then
if ap.Opened then
ap:Close()
else
ap:Open()
end
end
end)

ae.AddSignal(as.Content.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()
if ap.Opened then
ap:Open()
end
end)

if ap.Opened then
task.spawn(function()
task.wait()
ap:Open()
end)
end



return ap
end


return aa end function a.W()
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
}end function a.X()
local aa=(cloneref or clonereference or function(aa)return aa end)

aa(game:GetService"UserInputService")

local ae={
Margin=8,
Padding=9,
}


local af=a.load'b'
local ah=af.New
local aj=af.Tween


function ae.new(ak,al,am)
local an={
IconSize=18,
Padding=14,
Radius=22,
Width=400,
MaxHeight=380,

Icons=a.load'W'
}


local ao=ah("TextBox",{
Text="",
PlaceholderText="Search...",
ThemeTag={
PlaceholderColor3="Placeholder",
TextColor3="Text",
},
Size=UDim2.new(
1,
-((an.IconSize*2)+(an.Padding*2)),
0,
0
),
AutomaticSize="Y",
ClipsDescendants=true,
ClearTextOnFocus=false,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(af.Font,Enum.FontWeight.Regular),
TextSize=18,
})

local ap=ah("ImageLabel",{
Image=af.Icon"x"[1],
ImageRectSize=af.Icon"x"[2].ImageRectSize,
ImageRectOffset=af.Icon"x"[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.1,
Size=UDim2.new(0,an.IconSize,0,an.IconSize)
},{
ah("TextButton",{
Size=UDim2.new(1,8,1,8),
BackgroundTransparency=1,
Active=true,
ZIndex=999999999,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Text="",
})
})

local aq=ah("ScrollingFrame",{
Size=UDim2.new(1,0,0,0),
AutomaticCanvasSize="Y",
ScrollingDirection="Y",
ElasticBehavior="Never",
ScrollBarThickness=0,
CanvasSize=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
Visible=false
},{
ah("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
ah("UIPadding",{
PaddingTop=UDim.new(0,an.Padding),
PaddingLeft=UDim.new(0,an.Padding),
PaddingRight=UDim.new(0,an.Padding),
PaddingBottom=UDim.new(0,an.Padding),
})
})

local ar=af.NewRoundFrame(an.Radius,"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Background",
},
ImageTransparency=0,
},{
af.NewRoundFrame(an.Radius,"Squircle",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,

Visible=false,
ImageColor3=Color3.new(1,1,1),
ImageTransparency=.98,
Name="Frame",
},{
ah("Frame",{
Size=UDim2.new(1,0,0,46),
BackgroundTransparency=1,
},{








ah("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ah("ImageLabel",{
Image=af.Icon"search"[1],
ImageRectSize=af.Icon"search"[2].ImageRectSize,
ImageRectOffset=af.Icon"search"[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.1,
Size=UDim2.new(0,an.IconSize,0,an.IconSize)
}),
ao,
ap,
ah("UIListLayout",{
Padding=UDim.new(0,an.Padding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ah("UIPadding",{
PaddingLeft=UDim.new(0,an.Padding),
PaddingRight=UDim.new(0,an.Padding),
})
})
}),
ah("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Name="Results",
},{
ah("Frame",{
Size=UDim2.new(1,0,0,1),
ThemeTag={
BackgroundColor3="Outline",
},
BackgroundTransparency=.9,
Visible=false,
}),
aq,
ah("UISizeConstraint",{
MaxSize=Vector2.new(an.Width,an.MaxHeight),
}),
}),
ah("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
})
})

local as=ah("Frame",{
Size=UDim2.new(0,an.Width,0,0),
AutomaticSize="Y",
Parent=al,
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Visible=false,

ZIndex=99999999,
},{
ah("UIScale",{
Scale=.9,
}),
ar,
af.NewRoundFrame(an.Radius,"SquircleOutline2",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Outline",
},
ImageTransparency=1,
},{
ah("UIGradient",{
Rotation=45,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.55),
NumberSequenceKeypoint.new(0.5,0.8),
NumberSequenceKeypoint.new(1,0.6)
}
})
})
})

local function CreateSearchTab(au,av,aw,ax,ay,az)
local aA=ah("TextButton",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ax or nil
},{
af.NewRoundFrame(an.Radius-11,"Squircle",{
Size=UDim2.new(1,0,0,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),

ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Main"
},{
af.NewRoundFrame(an.Radius-11,"SquircleOutline2",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="Outline",
},
ImageTransparency=1,
Name="Outline",
},{
ah("UIGradient",{
Rotation=65,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.55),
NumberSequenceKeypoint.new(0.5,0.8),
NumberSequenceKeypoint.new(1,0.6)
}
}),
ah("UIPadding",{
PaddingTop=UDim.new(0,an.Padding-2),
PaddingLeft=UDim.new(0,an.Padding),
PaddingRight=UDim.new(0,an.Padding),
PaddingBottom=UDim.new(0,an.Padding-2),
}),
ah("ImageLabel",{
Image=af.Icon(aw)[1],
ImageRectSize=af.Icon(aw)[2].ImageRectSize,
ImageRectOffset=af.Icon(aw)[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.1,
Size=UDim2.new(0,an.IconSize,0,an.IconSize)
}),
ah("Frame",{
Size=UDim2.new(1,-an.IconSize-an.Padding,0,0),
BackgroundTransparency=1,
},{
ah("TextLabel",{
Text=au,
ThemeTag={
TextColor3="Text",
},
TextSize=17,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(af.Font,Enum.FontWeight.Medium),
Size=UDim2.new(1,0,0,0),
TextTruncate="AtEnd",
AutomaticSize="Y",
Name="Title"
}),
ah("TextLabel",{
Text=av or"",
Visible=av and true or false,
ThemeTag={
TextColor3="Text",
},
TextSize=15,
TextTransparency=.3,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(af.Font,Enum.FontWeight.Medium),
Size=UDim2.new(1,0,0,0),
TextTruncate="AtEnd",
AutomaticSize="Y",
Name="Desc"
})or nil,
ah("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
})
}),
ah("UIListLayout",{
Padding=UDim.new(0,an.Padding),
FillDirection="Horizontal",
})
}),
},true),
ah("Frame",{
Name="ParentContainer",
Size=UDim2.new(1,-an.Padding,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Visible=ay,

},{
af.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,2,1,0),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Text"
},
ImageTransparency=.9,
}),
ah("Frame",{
Size=UDim2.new(1,-an.Padding-2,0,0),
Position=UDim2.new(0,an.Padding+2,0,0),
BackgroundTransparency=1,
},{
ah("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
}),
}),
ah("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
HorizontalAlignment="Right"
})
})



aA.Main.Size=UDim2.new(
1,
0,
0,
aA.Main.Outline.Frame.Desc.Visible and(((an.Padding-2)*2)+aA.Main.Outline.Frame.Title.TextBounds.Y+6+aA.Main.Outline.Frame.Desc.TextBounds.Y)
or(((an.Padding-2)*2)+aA.Main.Outline.Frame.Title.TextBounds.Y)
)

af.AddSignal(aA.Main.MouseEnter,function()
aj(aA.Main,.04,{ImageTransparency=.95}):Play()
aj(aA.Main.Outline,.04,{ImageTransparency=.7}):Play()
end)
af.AddSignal(aA.Main.InputEnded,function()
aj(aA.Main,.08,{ImageTransparency=1}):Play()
aj(aA.Main.Outline,.08,{ImageTransparency=1}):Play()
end)
af.AddSignal(aA.Main.MouseButton1Click,function()
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
for aw,ax in next,ak.Tabs do
local ay=ContainsText(ax.Title or"",au)
local az={}

for aA,aB in next,ax.Elements do
if aB.__type~="Section"then
local aC=ContainsText(aB.Title or"",au)
local aD=ContainsText(aB.Desc or"",au)

if aC or aD then
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

function an.Search(au,av)
av=av or""

local aw=Search(av)

aq.Visible=true
ar.Frame.Results.Frame.Visible=true
for ax,ay in next,aq:GetChildren()do
if ay.ClassName~="UIListLayout"and ay.ClassName~="UIPadding"then
ay:Destroy()
end
end

if aw and next(aw)~=nil then
for az,aA in next,aw do
local aB=an.Icons.Tab
local aC=CreateSearchTab(aA.Title,nil,aB,aq,true,function()
an:Close()
ak:SelectTab(az)
end)
if aA.Elements and next(aA.Elements)~=nil then
for aD,aE in next,aA.Elements do
local aF=an.Icons[aE.__type]
CreateSearchTab(aE.Title,aE.Desc,aF,aC:FindFirstChild"ParentContainer"and aC.ParentContainer.Frame or nil,false,function()
an:Close()
ak:SelectTab(az)
if aA.Tab.ScrollToTheElement then

aA.Tab:ScrollToTheElement(aE.Index)
end

end)

end
end
end
elseif av~=""then
ah("TextLabel",{
Size=UDim2.new(1,0,0,70),
BackgroundTransparency=1,
Text="No results found",
TextSize=16,
ThemeTag={
TextColor3="Text",
},
TextTransparency=.2,
BackgroundTransparency=1,
FontFace=Font.new(af.Font,Enum.FontWeight.Medium),
Parent=aq,
Name="NotFound",
})
else
aq.Visible=false
ar.Frame.Results.Frame.Visible=false
end
end

af.AddSignal(ao:GetPropertyChangedSignal"Text",function()
an:Search(ao.Text)
end)

af.AddSignal(aq.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()

aj(aq,.06,{Size=UDim2.new(
1,
0,
0,
math.clamp(aq.UIListLayout.AbsoluteContentSize.Y+(an.Padding*2),0,an.MaxHeight)
)},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()






end)

function an.Open(au)
task.spawn(function()
ar.Frame.Visible=true
as.Visible=true
aj(as.UIScale,.12,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end)
end

function an.Close(au)
task.spawn(function()
am()
ar.Frame.Visible=false
aj(as.UIScale,.12,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

task.wait(.12)
as.Visible=false
end)
end

af.AddSignal(ap.TextButton.MouseButton1Click,function()
an:Close()
end)

an:Open()

return an
end

return ae end function a.Y()
local aa=(cloneref or clonereference or function(aa)return aa end)

local ae=aa(game:GetService"UserInputService")
aa(game:GetService"RunService")

local af=workspace.CurrentCamera

local ah=a.load'q'

local aj=a.load'b'
local ak=aj.New
local al=aj.Tween


local am=a.load't'.New
local an=a.load'j'.New
local ao=a.load'u'.New
local ap=a.load'v'

local aq=a.load'w'



return function(ar)
local as={
Title=ar.Title or"UI Library",
Author=ar.Author,
Icon=ar.Icon,
IconSize=ar.IconSize or 22,
IconThemed=ar.IconThemed,
Folder=ar.Folder,
Resizable=ar.Resizable~=false,
Background=ar.Background,
BackgroundImageTransparency=ar.BackgroundImageTransparency or 0,
ShadowTransparency=ar.ShadowTransparency or 0.7,
User=ar.User or{},
Footer=ar.Footer or{},
Topbar=ar.Topbar or{Height=52,ButtonsType="Default"},

Size=ar.Size,

MinSize=ar.MinSize or Vector2.new(560,350),
MaxSize=ar.MaxSize or Vector2.new(850,560),

TopBarButtonIconSize=ar.TopBarButtonIconSize or 16,

ToggleKey=ar.ToggleKey,
ElementsRadius=ar.ElementsRadius,
Radius=ar.Radius or 16,
Transparent=ar.Transparent or false,
HideSearchBar=ar.HideSearchBar~=false,
ScrollBarEnabled=ar.ScrollBarEnabled or false,
SideBarWidth=ar.SideBarWidth or 200,
Acrylic=ar.Acrylic or false,
NewElements=ar.NewElements or false,
IgnoreAlerts=ar.IgnoreAlerts or false,
HidePanelBackground=ar.HidePanelBackground or false,
AutoScale=ar.AutoScale~=false,
OpenButton=ar.OpenButton,

Position=UDim2.new(0.5,0,0.5,0),
UICorner=nil,
UIPadding=14,
UIElements={},
CanDropdown=true,
Closed=false,
Parent=ar.Parent,
Destroyed=false,
IsFullscreen=false,
CanResize=ar.Resizable~=false,
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

as.UICorner=as.Radius

as.ElementConfig={
UIPadding=(as.NewElements and 10 or 13),
UICorner=as.ElementsRadius or(as.NewElements and 23 or 12),
}

local au=as.Size or UDim2.new(0,580,0,460)
as.Size=UDim2.new(
au.X.Scale,
math.clamp(au.X.Offset,as.MinSize.X,as.MaxSize.X),
au.Y.Scale,
math.clamp(au.Y.Offset,as.MinSize.Y,as.MaxSize.Y)
)

if as.Topbar=={}then
as.Topbar={Height=52,ButtonsType="Default"}
end

if as.Folder then
if not isfolder("WindUI/"..as.Folder)then
makefolder("WindUI/"..as.Folder)
end
if not isfolder("WindUI/"..as.Folder.."/assets")then
makefolder("WindUI/"..as.Folder.."/assets")
end
if not isfolder(as.Folder)then
makefolder(as.Folder)
end
if not isfolder(as.Folder.."/assets")then
makefolder(as.Folder.."/assets")
end
end

local av=ak("UICorner",{
CornerRadius=UDim.new(0,as.UICorner)
})

if as.Folder then
as.ConfigManager=aq:Init(as)
end


if as.Acrylic then local
aw, ax=ah.AcrylicPaint{UseAcrylic=as.Acrylic}

as.AcrylicPaint=aw
end

local aw=ak("Frame",{
Size=UDim2.new(0,32,0,32),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(.5,.5),
BackgroundTransparency=1,
ZIndex=99,
Active=true
},{
ak("ImageLabel",{
Size=UDim2.new(0,96,0,96),
BackgroundTransparency=1,
Image="rbxassetid://120997033468887",
Position=UDim2.new(0.5,-16,0.5,-16),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=1,
})
})
local ax=aj.NewRoundFrame(as.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
ZIndex=98,
Active=false,
},{
ak("ImageLabel",{
Size=UDim2.new(0,70,0,70),
Image=aj.Icon"expand"[1],
ImageRectOffset=aj.Icon"expand"[2].ImageRectPosition,
ImageRectSize=aj.Icon"expand"[2].ImageRectSize,
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=1,
}),
})

local ay=aj.NewRoundFrame(as.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
ZIndex=999,
Active=false,
})










as.UIElements.SideBar=ak("ScrollingFrame",{
Size=UDim2.new(
1,
as.ScrollBarEnabled and-3-(as.UIPadding/2)or 0,
1,
not as.HideSearchBar and-45 or 0
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
ak("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Name="Frame",
},{
ak("UIPadding",{



PaddingBottom=UDim.new(0,as.UIPadding/2),
}),
ak("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,as.Gap)
})
}),
ak("UIPadding",{

PaddingLeft=UDim.new(0,as.UIPadding/2),
PaddingRight=UDim.new(0,as.UIPadding/2),

}),

})

as.UIElements.SideBarContainer=ak("Frame",{
Size=UDim2.new(0,as.SideBarWidth,1,as.User.Enabled and-as.Topbar.Height-42-(as.UIPadding*2)or-as.Topbar.Height),
Position=UDim2.new(0,0,0,as.Topbar.Height),
BackgroundTransparency=1,
Visible=true,
},{
ak("Frame",{
Name="Content",
BackgroundTransparency=1,
Size=UDim2.new(
1,
0,
1,
not as.HideSearchBar and-45-as.UIPadding/2 or 0
),
Position=UDim2.new(0,0,1,0),
AnchorPoint=Vector2.new(0,1),
}),
as.UIElements.SideBar,
})

if as.ScrollBarEnabled then
ao(as.UIElements.SideBar,as.UIElements.SideBarContainer.Content,as,3)
end


as.UIElements.MainBar=ak("Frame",{
Size=UDim2.new(1,-as.UIElements.SideBarContainer.AbsoluteSize.X,1,-as.Topbar.Height),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,1),
BackgroundTransparency=1,
},{
aj.NewRoundFrame(as.UICorner-(as.UIPadding/2),"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
ZIndex=3,
ImageTransparency=.95,
Name="Background",
Visible=not as.HidePanelBackground
}),
ak("UIPadding",{

PaddingLeft=UDim.new(0,as.UIPadding/2),
PaddingRight=UDim.new(0,as.UIPadding/2),
PaddingBottom=UDim.new(0,as.UIPadding/2),
})
})

local az=ak("ImageLabel",{
Image="rbxassetid://8992230677",
ThemeTag={
ImageColor3="WindowShadow",

},
ImageTransparency=1,
Size=UDim2.new(1,120,1,116),
Position=UDim2.new(0,-60,0,-58),
ScaleType="Slice",
SliceCenter=Rect.new(99,99,99,99),
BackgroundTransparency=1,
ZIndex=-999999999999999,
Name="Blur",
})



if ae.TouchEnabled and not ae.KeyboardEnabled then
as.IsPC=false
elseif ae.KeyboardEnabled then
as.IsPC=true
else
as.IsPC=nil
end










local aA
if as.User then
local function GetUserThumb()local
aB, aC=aa(game:GetService"Players"):GetUserThumbnailAsync(
as.User.Anonymous and 1 or game.Players.LocalPlayer.UserId,
Enum.ThumbnailType.HeadShot,
Enum.ThumbnailSize.Size420x420
)
return aB
end


aA=ak("TextButton",{
Size=UDim2.new(0,
(as.UIElements.SideBarContainer.AbsoluteSize.X)-(as.UIPadding/2),
0,
42+(as.UIPadding)
),
Position=UDim2.new(0,as.UIPadding/2,1,-(as.UIPadding/2)),
AnchorPoint=Vector2.new(0,1),
BackgroundTransparency=1,
Visible=as.User.Enabled or false,
},{
aj.NewRoundFrame(as.UICorner-(as.UIPadding/2),"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Outline"
},{
ak("UIGradient",{
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
}
}),
}),
aj.NewRoundFrame(as.UICorner-(as.UIPadding/2),"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="UserIcon",
},{
ak("ImageLabel",{
Image=GetUserThumb(),
BackgroundTransparency=1,
Size=UDim2.new(0,42,0,42),
ThemeTag={
BackgroundColor3="Text",
},
BackgroundTransparency=.93,
},{
ak("UICorner",{
CornerRadius=UDim.new(1,0)
})
}),
ak("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
},{
ak("TextLabel",{
Text=as.User.Anonymous and"Anonymous"or game.Players.LocalPlayer.DisplayName,
TextSize=17,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(aj.Font,Enum.FontWeight.SemiBold),
AutomaticSize="Y",
BackgroundTransparency=1,
Size=UDim2.new(1,-27,0,0),
TextTruncate="AtEnd",
TextXAlignment="Left",
Name="DisplayName"
}),
ak("TextLabel",{
Text=as.User.Anonymous and"anonymous"or game.Players.LocalPlayer.Name,
TextSize=15,
TextTransparency=.6,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(aj.Font,Enum.FontWeight.Medium),
AutomaticSize="Y",
BackgroundTransparency=1,
Size=UDim2.new(1,-27,0,0),
TextTruncate="AtEnd",
TextXAlignment="Left",
Name="UserName"
}),
ak("UIListLayout",{
Padding=UDim.new(0,4),
HorizontalAlignment="Left",
})
}),
ak("UIListLayout",{
Padding=UDim.new(0,as.UIPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ak("UIPadding",{
PaddingLeft=UDim.new(0,as.UIPadding/2),
PaddingRight=UDim.new(0,as.UIPadding/2),
})
})
})


function as.User.Enable(aB)
as.User.Enabled=true
al(as.UIElements.SideBarContainer,.25,{Size=UDim2.new(0,as.SideBarWidth,1,-as.Topbar.Height-42-(as.UIPadding*2))},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
aA.Visible=true
end
function as.User.Disable(aB)
as.User.Enabled=false
al(as.UIElements.SideBarContainer,.25,{Size=UDim2.new(0,as.SideBarWidth,1,-as.Topbar.Height)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
aA.Visible=false
end
function as.User.SetAnonymous(aB,aC)
if aC~=false then aC=true end
as.User.Anonymous=aC
aA.UserIcon.ImageLabel.Image=GetUserThumb()
aA.UserIcon.Frame.DisplayName.Text=aC and"Anonymous"or game.Players.LocalPlayer.DisplayName
aA.UserIcon.Frame.UserName.Text=aC and"anonymous"or game.Players.LocalPlayer.Name
end

if as.User.Enabled then
as.User:Enable()
else
as.User:Disable()
end

if as.User.Callback then
aj.AddSignal(aA.MouseButton1Click,function()
as.User.Callback()
end)
aj.AddSignal(aA.MouseEnter,function()
al(aA.UserIcon,0.04,{ImageTransparency=.95}):Play()
al(aA.Outline,0.04,{ImageTransparency=.85}):Play()
end)
aj.AddSignal(aA.InputEnded,function()
al(aA.UserIcon,0.04,{ImageTransparency=1}):Play()
al(aA.Outline,0.04,{ImageTransparency=1}):Play()
end)
end
end

local aB
local aC


local aD=false
local aE

local aF=typeof(as.Background)=="string"and string.match(as.Background,"^video:(.+)")or nil
local b=typeof(as.Background)=="string"and not aF and string.match(as.Background,"^https?://.+")or nil

local function GetImageExtension(d)
local f=d:match"%.(%w+)$"or d:match"%.(%w+)%?"
if f then
f=f:lower()
if f=="jpg"or f=="jpeg"or f=="png"or f=="webp"then
return"."..f
end
end
return".png"
end

if typeof(as.Background)=="string"and aF then
aD=true

if string.find(aF,"http")then
local d=as.Folder.."/assets/."..aj.SanitizeFilename(aF)..".webm"
if not isfile(d)then
local f,g=pcall(function()
local f=aj.Request{Url=aF,Method="GET",Headers={["User-Agent"]="Roblox/Exploit"}}
writefile(d,f.Body)
end)
if not f then
warn("[ WindUI.Window.Background ] Failed to download video: "..tostring(g))
return
end
end

local f,g=pcall(function()
return getcustomasset(d)
end)
if not f then
warn("[ WindUI.Window.Background ] Failed to load custom asset: "..tostring(g))
return
end
warn"[ WindUI.Window.Background ] VideoFrame may not work with custom video"
aF=g
end

aE=ak("VideoFrame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Video=aF,
Looped=true,
Volume=0,
},{
ak("UICorner",{
CornerRadius=UDim.new(0,as.UICorner)
}),
})
aE:Play()

elseif b then
local d=as.Folder.."/assets/."..aj.SanitizeFilename(b)..GetImageExtension(b)
if not isfile(d)then
local f,g=pcall(function()
local f=aj.Request{Url=b,Method="GET",Headers={["User-Agent"]="Roblox/Exploit"}}
writefile(d,f.Body)
end)
if not f then
warn("[ Window.Background ] Failed to download image: "..tostring(g))
return
end
end

local f,g=pcall(function()
return getcustomasset(d)
end)
if not f then
warn("[ Window.Background ] Failed to load custom asset: "..tostring(g))
return
end

aE=ak("ImageLabel",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Image=g,
ImageTransparency=0,
ScaleType="Crop",
},{
ak("UICorner",{
CornerRadius=UDim.new(0,as.UICorner)
}),
})

elseif as.Background then
aE=ak("ImageLabel",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Image=typeof(as.Background)=="string"and as.Background or"",
ImageTransparency=1,
ScaleType="Crop",
},{
ak("UICorner",{
CornerRadius=UDim.new(0,as.UICorner)
}),
})
end


local d=aj.NewRoundFrame(99,"Squircle",{
ImageTransparency=.8,
ImageColor3=Color3.new(1,1,1),
Size=UDim2.new(0,0,0,4),
Position=UDim2.new(0.5,0,1,4),
AnchorPoint=Vector2.new(0.5,0),
},{
ak("TextButton",{
Size=UDim2.new(1,12,1,12),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,
ZIndex=99,
Name="Frame",
})
})

function createAuthor(f)
return ak("TextLabel",{
Text=f,
FontFace=Font.new(aj.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
TextTransparency=0.35,
AutomaticSize="XY",
Parent=as.UIElements.Main and as.UIElements.Main.Main.Topbar.Left.Title,
TextXAlignment="Left",
TextSize=13,
LayoutOrder=2,
ThemeTag={
TextColor3="WindowTopbarAuthor"
},
Name="Author",
})
end

local f
local g

if as.Author then
f=createAuthor(as.Author)
end


local h=ak("TextLabel",{
Text=as.Title,
FontFace=Font.new(aj.Font,Enum.FontWeight.SemiBold),
BackgroundTransparency=1,
AutomaticSize="XY",
Name="Title",
TextXAlignment="Left",
TextSize=16,
ThemeTag={
TextColor3="WindowTopbarTitle"
}
})

as.UIElements.Main=ak("Frame",{
Size=as.Size,
Position=as.Position,
BackgroundTransparency=1,
Parent=ar.Parent,
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,
},{
ar.WindUI.UIScaleObj,
as.AcrylicPaint and as.AcrylicPaint.Frame or nil,
az,
aj.NewRoundFrame(as.UICorner,"Squircle",{
ImageTransparency=1,
Size=UDim2.new(1,0,1,-240),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Background",
ThemeTag={
ImageColor3="WindowBackground"
},

},{
aE,
d,
aw,



}),
UIStroke,
av,
ax,
ay,
ak("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Name="Main",

Visible=false,
ZIndex=97,
},{
ak("UICorner",{
CornerRadius=UDim.new(0,as.UICorner)
}),
as.UIElements.SideBarContainer,
as.UIElements.MainBar,

aA,

aC,
ak("Frame",{
Size=UDim2.new(1,0,0,as.Topbar.Height),
BackgroundTransparency=1,
BackgroundColor3=Color3.fromRGB(50,50,50),
Name="Topbar"
},{
aB,






ak("Frame",{
AutomaticSize="X",
Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,
Name="Left"
},{
ak("UIListLayout",{
Padding=UDim.new(0,as.UIPadding+4),
SortOrder="LayoutOrder",
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ak("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
Name="Title",
Size=UDim2.new(0,0,1,0),
LayoutOrder=2,
},{
ak("UIListLayout",{
Padding=UDim.new(0,0),
SortOrder="LayoutOrder",
FillDirection="Vertical",
VerticalAlignment="Center",
}),
h,
f,
}),
ak("UIPadding",{
PaddingLeft=UDim.new(0,4)
})
}),
ak("ScrollingFrame",{
Name="Center",
BackgroundTransparency=1,
AutomaticSize="Y",
ScrollBarThickness=0,
ScrollingDirection="X",
AutomaticCanvasSize="X",
CanvasSize=UDim2.new(0,0,0,0),
Size=UDim2.new(0,0,1,0),
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,0,0.5,0),
Visible=false,
},{
ak("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
Padding=UDim.new(0,as.UIPadding/2)
})
}),
ak("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
Position=UDim2.new(as.Topbar.ButtonsType=="Default"and 1 or 0,0,0.5,0),
AnchorPoint=Vector2.new(as.Topbar.ButtonsType=="Default"and 1 or 0,0.5),
Name="Right",
},{
ak("UIListLayout",{
Padding=UDim.new(0,as.Topbar.ButtonsType=="Default"and 9 or 0),
FillDirection="Horizontal",
SortOrder="LayoutOrder",
}),

}),
ak("UIPadding",{
PaddingTop=UDim.new(0,as.UIPadding),
PaddingLeft=UDim.new(0,as.Topbar.ButtonsType=="Default"and as.UIPadding or as.UIPadding-2),
PaddingRight=UDim.new(0,8),
PaddingBottom=UDim.new(0,as.UIPadding),
})
})
})
})

aj.AddSignal(as.UIElements.Main.Main.Topbar.Left:GetPropertyChangedSignal"AbsoluteSize",function()
local j=0
local l=as.UIElements.Main.Main.Topbar.Right.UIListLayout.AbsoluteContentSize.X/ar.WindUI.UIScale





j=as.UIElements.Main.Main.Topbar.Left.AbsoluteSize.X/ar.WindUI.UIScale
if as.Topbar.ButtonsType~="Default"then
j=j+l+as.UIPadding-4
end



as.UIElements.Main.Main.Topbar.Center.Position=UDim2.new(
0,
j+(as.UIPadding/ar.WindUI.UIScale),
0.5,
0
)
as.UIElements.Main.Main.Topbar.Center.Size=UDim2.new(
1,
-j-l-((as.UIPadding*2)/ar.WindUI.UIScale),
1,
0
)
end)

if as.Topbar.ButtonsType~="Default"then
aj.AddSignal(as.UIElements.Main.Main.Topbar.Right:GetPropertyChangedSignal"AbsoluteSize",function()
as.UIElements.Main.Main.Topbar.Left.Position=UDim2.new(0,(as.UIElements.Main.Main.Topbar.Right.AbsoluteSize.X/ar.WindUI.UIScale)+as.UIPadding-4,0,0)
end)
end

function as.CreateTopbarButton(j,l,m,p,r,u,v)
local x=aj.Image(
m,
m,
0,
as.Folder,
"WindowTopbarIcon",
as.Topbar.ButtonsType=="Default"and true or false,
u,
"WindowTopbarButtonIcon"
)
x.Size=as.Topbar.ButtonsType=="Default"and UDim2.new(0,as.TopBarButtonIconSize,0,as.TopBarButtonIconSize)or UDim2.new(0,0,0,0)
x.AnchorPoint=Vector2.new(0.5,0.5)
x.Position=UDim2.new(0.5,0,0.5,0)
x.ImageLabel.ImageTransparency=as.Topbar.ButtonsType=="Default"and 0 or 1
if as.Topbar.ButtonsType~="Default"then
x.ImageLabel.ImageColor3=aj.GetTextColorForHSB(v)
end

local B=aj.NewRoundFrame(as.Topbar.ButtonsType=="Default"and as.UICorner-(as.UIPadding/2)or 999,"Squircle",{
Size=as.Topbar.ButtonsType=="Default"and UDim2.new(0,as.Topbar.Height-16,0,as.Topbar.Height-16)or UDim2.new(0,14,0,14),
LayoutOrder=r or 999,
Parent=as.Topbar.ButtonsType=="Default"and as.UIElements.Main.Main.Topbar.Right or nil,

ZIndex=9999,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ImageColor3=as.Topbar.ButtonsType~="Default"and(v or Color3.fromHex"#ff3030")or nil,
ThemeTag=as.Topbar.ButtonsType=="Default"and{
ImageColor3="Text"
}or nil,
ImageTransparency=as.Topbar.ButtonsType=="Default"and 1 or 0
},{
aj.NewRoundFrame(as.Topbar.ButtonsType=="Default"and as.UICorner-(as.UIPadding/2)or 999,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Black",
},
ImageTransparency=as.Topbar.ButtonsType=="Default"and 1 or.8,
Name="Outline"
},{
as.Topbar.ButtonsType=="Default"and ak("UIGradient",{
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
}
})or nil,
}),
x
},true)

ak("Frame",{
Size=UDim2.new(0,24,0,24),
BackgroundTransparency=1,
Parent=as.Topbar.ButtonsType~="Default"and as.UIElements.Main.Main.Topbar.Right or nil,
LayoutOrder=r or 999
},{
as.Topbar.ButtonsType~="Default"and B or nil,
})



as.TopBarButtons[100-r]={
Name=l,
Object=B
}

aj.AddSignal(B.MouseButton1Click,function()
p()
end)
aj.AddSignal(B.MouseEnter,function()
if as.Topbar.ButtonsType=="Default"then
al(B,.15,{ImageTransparency=.93}):Play()
al(B.Outline,.15,{ImageTransparency=.75}):Play()

else

al(x.ImageLabel,.1,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
al(x,.1,{Size=UDim2.new(0,11,0,11)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end)
aj.AddSignal(B.MouseLeave,function()
if as.Topbar.ButtonsType=="Default"then
al(B,.1,{ImageTransparency=1}):Play()
al(B.Outline,.1,{ImageTransparency=1}):Play()

else

al(x.ImageLabel,.1,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
al(x,.1,{Size=UDim2.new(0,0,0,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end)

return B
end



local j=aj.Drag(
as.UIElements.Main,
{as.UIElements.Main.Main.Topbar,d.Frame},
function(j,l)
if not as.Closed then
if j and l==d.Frame then
al(d,.1,{ImageTransparency=.35}):Play()
else
al(d,.2,{ImageTransparency=.8}):Play()
end
as.Position=as.UIElements.Main.Position
as.Dragging=j
end
end
)

if not aD and as.Background and typeof(as.Background)=="table"then

local l=ak"UIGradient"
for m,p in next,as.Background do
l[m]=p
end

as.UIElements.BackgroundGradient=aj.NewRoundFrame(as.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
Parent=as.UIElements.Main.Background,
ImageTransparency=as.Transparent and ar.WindUI.TransparencyValue or 0
},{
l
})
end














as.OpenButtonMain=a.load'x'.New(as)


task.spawn(function()
if as.Icon then

local l=ak("Frame",{
Size=UDim2.new(0,22,0,22),
BackgroundTransparency=1,
Parent=as.UIElements.Main.Main.Topbar.Left,
})

g=aj.Image(
as.Icon,
as.Title,
0,
as.Folder,
"Window",
true,
as.IconThemed,
"WindowTopbarIcon"
)
g.Parent=l
g.Size=UDim2.new(0,as.IconSize,0,as.IconSize)
g.Position=UDim2.new(0.5,0,0.5,0)
g.AnchorPoint=Vector2.new(0.5,0.5)

as.OpenButtonMain:SetIcon(as.Icon)











else
as.OpenButtonMain:SetIcon(as.Icon)

end
end)

function as.SetToggleKey(l,m)
as.ToggleKey=m
end

function as.SetTitle(l,m)
as.Title=m
h.Text=m
end

function as.SetAuthor(l,m)
as.Author=m
if not f then
f=createAuthor(as.Author)
end

f.Text=m
end

function as.SetBackgroundImage(l,m)
as.UIElements.Main.Background.ImageLabel.Image=m
end
function as.SetBackgroundImageTransparency(l,m)
if aE and aE:IsA"ImageLabel"then
aE.ImageTransparency=math.floor(m*10+0.5)/10
end
as.BackgroundImageTransparency=math.floor(m*10+0.5)/10
end

function as.SetBackgroundTransparency(l,m)
local p=math.floor(tonumber(m)*10+0.5)/10
ar.WindUI.TransparencyValue=p
as:ToggleTransparency(p>0)
end

local l
local m
aj.Icon"minimize"
aj.Icon"maximize"

as:CreateTopbarButton("Fullscreen","maximize",function()
as:ToggleFullscreen()
end,(as.Topbar.ButtonsType=="Default"and 998 or 999),nil,Color3.fromHex"#60C762")

function as.ToggleFullscreen(p)
local r=as.IsFullscreen

j:Set(r)

if not r then
l=as.UIElements.Main.Position
m=as.UIElements.Main.Size

as.CanResize=false
else
if as.Resizable then
as.CanResize=true
end
end

al(as.UIElements.Main,0.45,{Size=r and m or UDim2.new(1,-20,1,-72)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

al(as.UIElements.Main,0.45,{Position=r and l or UDim2.new(0.5,0,0.5,26)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()



as.IsFullscreen=not r
end


as:CreateTopbarButton("Minimize","minus",function()
as:Close()






















end,(as.Topbar.ButtonsType=="Default"and 997 or 998),nil,Color3.fromHex"#F4C948")

function as.OnOpen(p,r)
as.OnOpenCallback=r
end
function as.OnClose(p,r)
as.OnCloseCallback=r
end
function as.OnDestroy(p,r)
as.OnDestroyCallback=r
end

if ar.WindUI.UseAcrylic then
as.AcrylicPaint.AddParent(as.UIElements.Main)
end

function as.SetIconSize(p,r)
local u
if typeof(r)=="number"then
u=UDim2.new(0,r,0,r)
as.IconSize=r
elseif typeof(r)=="UDim2"then
u=r
as.IconSize=r.X.Offset
end

if g then
g.Size=u
end
end

function as.Open(p)
task.spawn(function()
if as.OnOpenCallback then
task.spawn(function()
aj.SafeCallback(as.OnOpenCallback)
end)
end


task.wait(.06)
as.Closed=false

al(as.UIElements.Main.Background,0.2,{
ImageTransparency=as.Transparent and ar.WindUI.TransparencyValue or 0,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

if as.UIElements.BackgroundGradient then
al(as.UIElements.BackgroundGradient,0.2,{
ImageTransparency=0,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

al(as.UIElements.Main.Background,0.4,{
Size=UDim2.new(1,0,1,0),
},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()

if aE then
if aE:IsA"VideoFrame"then
aE.Visible=true
else
al(aE,0.2,{
ImageTransparency=as.BackgroundImageTransparency,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

if as.OpenButtonMain and as.IsOpenButtonEnabled then
as.OpenButtonMain:Visible(false)
end


al(az,0.25,{ImageTransparency=as.ShadowTransparency},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if UIStroke then
al(UIStroke,0.25,{Transparency=.8},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

task.spawn(function()
task.wait(.3)
al(d,.45,{Size=UDim2.new(0,200,0,4),ImageTransparency=.8},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()
j:Set(true)
task.wait(.45)
if as.Resizable then
al(aw.ImageLabel,.45,{ImageTransparency=.8},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()
as.CanResize=true
end
end)


as.CanDropdown=true

as.UIElements.Main.Visible=true
task.spawn(function()
task.wait(.05)
as.UIElements.Main:WaitForChild"Main".Visible=true

ar.WindUI:ToggleAcrylic(true)
end)
end)
end
function as.Close(p)
local r={}

if as.OnCloseCallback then
task.spawn(function()
aj.SafeCallback(as.OnCloseCallback)
end)
end

ar.WindUI:ToggleAcrylic(false)

as.UIElements.Main:WaitForChild"Main".Visible=false

as.CanDropdown=false
as.Closed=true

al(as.UIElements.Main.Background,0.32,{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
if as.UIElements.BackgroundGradient then
al(as.UIElements.BackgroundGradient,0.32,{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
end

al(as.UIElements.Main.Background,0.4,{
Size=UDim2.new(1,0,1,-240),
},Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut):Play()


if aE then
if aE:IsA"VideoFrame"then
aE.Visible=false
else
al(aE,0.3,{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
al(az,0.25,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if UIStroke then
al(UIStroke,0.25,{Transparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

al(d,.3,{Size=UDim2.new(0,0,0,4),ImageTransparency=1},Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut):Play()
al(aw.ImageLabel,.3,{ImageTransparency=1},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()
j:Set(false)
as.CanResize=false

task.spawn(function()
task.wait(0.4)
as.UIElements.Main.Visible=false

if as.OpenButtonMain and not as.Destroyed and not as.IsPC and as.IsOpenButtonEnabled then
as.OpenButtonMain:Visible(true)
end
end)

function r.Destroy(u)
task.spawn(function()
if as.OnDestroyCallback then
task.spawn(function()
aj.SafeCallback(as.OnDestroyCallback)
end)
end
if as.AcrylicPaint and as.AcrylicPaint.Model then
as.AcrylicPaint.Model:Destroy()
end
as.Destroyed=true
task.wait(0.4)
ar.WindUI.ScreenGui:Destroy()
ar.WindUI.NotificationGui:Destroy()
ar.WindUI.DropdownGui:Destroy()
ar.WindUI.TooltipGui:Destroy()

aj.DisconnectAll()

return
end)
end

return r
end
function as.Destroy(p)
return as:Close():Destroy()
end
function as.Toggle(p)
if as.Closed then
as:Open()
else
as:Close()
end
end


function as.ToggleTransparency(p,r)

as.Transparent=r
ar.WindUI.Transparent=r

as.UIElements.Main.Background.ImageTransparency=r and ar.WindUI.TransparencyValue or 0

as.UIElements.MainBar.Background.ImageTransparency=r and 0.97 or 0.95

end

function as.LockAll(p)
for r,u in next,as.AllElements do
if u.Lock then u:Lock()end
end
end
function as.UnlockAll(p)
for r,u in next,as.AllElements do
if u.Unlock then u:Unlock()end
end
end
function as.GetLocked(p)
local r={}

for u,v in next,as.AllElements do
if v.Locked then table.insert(r,v)end
end

return r
end
function as.GetUnlocked(p)
local r={}

for u,v in next,as.AllElements do
if v.Locked==false then table.insert(r,v)end
end

return r
end

function as.GetUIScale(p,r)
return ar.WindUI.UIScale
end

function as.SetUIScale(p,r)
ar.WindUI.UIScale=r
al(ar.WindUI.UIScaleObj,.2,{Scale=r},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
return as
end

function as.SetToTheCenter(p)
al(as.UIElements.Main,0.45,{Position=UDim2.new(0.5,0,0.5,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
return as
end

function as.SetCurrentConfig(p,r)
as.CurrentConfig=r
end

do
local p=40
local r=af.ViewportSize
local u=as.UIElements.Main.AbsoluteSize

if not as.IsFullscreen and as.AutoScale then
local v=r.X-(p*2)
local x=r.Y-(p*2)

local B=v/u.X
local C=x/u.Y

local F=math.min(B,C)

local G=0.3
local H=1.0

local J=math.clamp(F,G,H)

local L=as:GetUIScale()or 1
local M=0.05

if math.abs(J-L)>M then
as:SetUIScale(J)
end
end
end


if as.OpenButtonMain and as.OpenButtonMain.Button then
aj.AddSignal(as.OpenButtonMain.Button.TextButton.MouseButton1Click,function()


as:Open()
end)
end

aj.AddSignal(ae.InputBegan,function(p,r)
if r then return end

if as.ToggleKey then
if p.KeyCode==as.ToggleKey then
as:Toggle()
end
end
end)

task.spawn(function()

as:Open()
end)

function as.EditOpenButton(p,r)
return as.OpenButtonMain:Edit(r)
end

if as.OpenButton and typeof(as.OpenButton)=="table"then
as:EditOpenButton(as.OpenButton)
end


local p=a.load'U'
local r=a.load'V'
local u=p.Init(as,ar.WindUI,ar.WindUI.TooltipGui)
u:OnChange(function(v)as.CurrentTab=v end)

as.TabModule=p

function as.Tab(v,x)
x.Parent=as.UIElements.SideBar.Frame
return u.New(x,ar.WindUI.UIScale)
end

function as.SelectTab(v,x)
u:SelectTab(x)
end

function as.Section(v,x)
return r.New(x,as.UIElements.SideBar.Frame,as.Folder,ar.WindUI.UIScale,as)
end

function as.IsResizable(v,x)
as.Resizable=x
as.CanResize=x
end

function as.Divider(v)
local x=ak("Frame",{
Size=UDim2.new(1,0,0,1),
Position=UDim2.new(0.5,0,0,0),
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=.9,
ThemeTag={
BackgroundColor3="Text"
}
})
local B=ak("Frame",{
Parent=as.UIElements.SideBar.Frame,

Size=UDim2.new(1,-7,0,5),
BackgroundTransparency=1,
},{
x
})

return B
end

local v=a.load'l'.Init(as,nil)
function as.Dialog(x,B)
local C={
Title=B.Title or"Dialog",
Width=B.Width or 320,
Content=B.Content,
Buttons=B.Buttons or{},

TextPadding=10,
}
local F=v.Create(false)

F.UIElements.Main.Size=UDim2.new(0,C.Width,0,0)

local G=ak("Frame",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=F.UIElements.Main
},{
ak("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,F.UIPadding),
VerticalAlignment="Center"
}),
ak("UIPadding",{
PaddingTop=UDim.new(0,C.TextPadding/2),
PaddingLeft=UDim.new(0,C.TextPadding/2),
PaddingRight=UDim.new(0,C.TextPadding/2),
})
})

local H
if B.Icon then
H=aj.Image(
B.Icon,
C.Title..":"..B.Icon,
0,
as,
"Dialog",
true,
B.IconThemed
)
H.Size=UDim2.new(0,22,0,22)
H.Parent=G
end

F.UIElements.UIListLayout=ak("UIListLayout",{
Padding=UDim.new(0,12),
FillDirection="Vertical",
HorizontalAlignment="Left",
Parent=F.UIElements.Main
})

ak("UISizeConstraint",{
MinSize=Vector2.new(180,20),
MaxSize=Vector2.new(400,math.huge),
Parent=F.UIElements.Main,
})


F.UIElements.Title=ak("TextLabel",{
Text=C.Title,
TextSize=20,
FontFace=Font.new(aj.Font,Enum.FontWeight.SemiBold),
TextXAlignment="Left",
TextWrapped=true,
RichText=true,
Size=UDim2.new(1,H and-26-F.UIPadding or 0,0,0),
AutomaticSize="Y",
ThemeTag={
TextColor3="Text"
},
BackgroundTransparency=1,
Parent=G
})
if C.Content then
ak("TextLabel",{
Text=C.Content,
TextSize=18,
TextTransparency=.4,
TextWrapped=true,
RichText=true,
FontFace=Font.new(aj.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
LayoutOrder=2,
ThemeTag={
TextColor3="Text"
},
BackgroundTransparency=1,
Parent=F.UIElements.Main
},{
ak("UIPadding",{
PaddingLeft=UDim.new(0,C.TextPadding/2),
PaddingRight=UDim.new(0,C.TextPadding/2),
PaddingBottom=UDim.new(0,C.TextPadding/2),
})
})
end

local J=ak("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
HorizontalAlignment="Right",
})

local L=ak("Frame",{
Size=UDim2.new(1,0,0,40),
AutomaticSize="None",
BackgroundTransparency=1,
Parent=F.UIElements.Main,
LayoutOrder=4,
},{
J,






})


local M={}

for N,O in next,C.Buttons do
local P=an(O.Title,O.Icon,O.Callback,O.Variant,L,F,false)
table.insert(M,P)
end

local function CheckButtonsOverflow()
J.FillDirection=Enum.FillDirection.Horizontal
J.HorizontalAlignment=Enum.HorizontalAlignment.Right
J.VerticalAlignment=Enum.VerticalAlignment.Center
L.AutomaticSize=Enum.AutomaticSize.None

for P,Q in ipairs(M)do
Q.Size=UDim2.new(0,0,1,0)
Q.AutomaticSize=Enum.AutomaticSize.X
end

wait()

local R=J.AbsoluteContentSize.X/ar.WindUI.UIScale
local S=L.AbsoluteSize.X/ar.WindUI.UIScale

if R>S then
J.FillDirection=Enum.FillDirection.Vertical
J.HorizontalAlignment=Enum.HorizontalAlignment.Right
J.VerticalAlignment=Enum.VerticalAlignment.Bottom
L.AutomaticSize=Enum.AutomaticSize.Y

for T,U in ipairs(M)do
U.Size=UDim2.new(1,0,0,40)
U.AutomaticSize=Enum.AutomaticSize.None
end
else
local T=S-R
if T>0 then
local U
local V=math.huge

for W,X in ipairs(M)do
local Y=X.AbsoluteSize.X/ar.WindUI.UIScale
if Y<V then
V=Y
U=X
end
end

if U then
U.Size=UDim2.new(0,V+T,1,0)
U.AutomaticSize=Enum.AutomaticSize.None
end
end
end
end

aj.AddSignal(F.UIElements.Main:GetPropertyChangedSignal"AbsoluteSize",CheckButtonsOverflow)
CheckButtonsOverflow()

wait()
F:Open()

return F
end


as:CreateTopbarButton("Close","x",function()
if not as.IgnoreAlerts then
as:SetToTheCenter()
as:Dialog{

Title="Close Window",
Content="Do you want to close this window? You will not be able to open it again.",
Buttons={
{
Title="Cancel",

Callback=function()end,
Variant="Secondary",
},
{
Title="Close Window",

Callback=function()as:Destroy()end,
Variant="Primary",
}
}
}
else
as:Destroy()
end
end,(as.Topbar.ButtonsType=="Default"and 999 or 997),nil,Color3.fromHex"#F4695F")

function as.Tag(x,B)
if as.UIElements.Main.Main.Topbar.Center.Visible==false then as.UIElements.Main.Main.Topbar.Center.Visible=true end
return ap:New(B,as.UIElements.Main.Main.Topbar.Center)
end


local function startResizing(x)
if as.CanResize then
isResizing=true
ax.Active=true
initialSize=as.UIElements.Main.Size
initialInputPosition=x.Position


al(aw.ImageLabel,0.1,{ImageTransparency=.35}):Play()

aj.AddSignal(x.Changed,function()
if x.UserInputState==Enum.UserInputState.End then
isResizing=false
ax.Active=false


al(aw.ImageLabel,0.17,{ImageTransparency=.8}):Play()
end
end)
end
end

aj.AddSignal(aw.InputBegan,function(x)
if x.UserInputType==Enum.UserInputType.MouseButton1 or x.UserInputType==Enum.UserInputType.Touch then
if as.CanResize then
startResizing(x)
end
end
end)

aj.AddSignal(ae.InputChanged,function(x)
if x.UserInputType==Enum.UserInputType.MouseMovement or x.UserInputType==Enum.UserInputType.Touch then
if isResizing and as.CanResize then
local B=x.Position-initialInputPosition
local C=UDim2.new(0,initialSize.X.Offset+B.X*2,0,initialSize.Y.Offset+B.Y*2)

C=UDim2.new(
C.X.Scale,
math.clamp(C.X.Offset,as.MinSize.X,as.MaxSize.X),
C.Y.Scale,
math.clamp(C.Y.Offset,as.MinSize.Y,as.MaxSize.Y)
)

al(as.UIElements.Main,0,{
Size=C
}):Play()

as.Size=C
end
end
end)




local x=0
local B=0.4
local C
local F=0

function onDoubleClick()
as:SetToTheCenter()
end

d.Frame.MouseButton1Up:Connect(function()
local G=tick()
local H=as.Position

F=F+1

if F==1 then
x=G
C=H

task.spawn(function()
task.wait(B)
if F==1 then
F=0
C=nil
end
end)

elseif F==2 then
if G-x<=B and H==C then
onDoubleClick()
end

F=0
C=nil
x=0
else
F=1
x=G
C=H
end
end)





if not as.HideSearchBar then
local G=a.load'X'
local H=false





















local J=am("Search","search",as.UIElements.SideBarContainer,true)
J.Size=UDim2.new(1,-as.UIPadding/2,0,39)
J.Position=UDim2.new(0,as.UIPadding/2,0,0)

aj.AddSignal(J.MouseButton1Click,function()
if H then return end

G.new(as.TabModule,as.UIElements.Main,function()

H=false
if as.Resizable then
as.CanResize=true
end

al(ay,0.1,{ImageTransparency=1}):Play()
ay.Active=false
end)
al(ay,0.1,{ImageTransparency=.65}):Play()
ay.Active=true

H=true
as.CanResize=false
end)
end




function as.DisableTopbarButtons(G,H)
for J,L in next,H do
for M,N in next,as.TopBarButtons do
if N.Name==L then
N.Object.Visible=false
end
end
end
end

return as
end end end
local aa={
Window=nil,
Theme=nil,
Creator=a.load'b',
LocalizationModule=a.load'c',
NotificationModule=a.load'd',
Themes=nil,
Transparent=false,

TransparencyValue=.15,

UIScale=1,

ConfigManager=nil,
Version="0.0.0",

Services=a.load'h',

OnThemeChangeFunction=nil,

cloneref=nil,
UIScaleObj=nil,
}


local ae=(cloneref or clonereference or function(ae)return ae end)

aa.cloneref=ae

local af=ae(game:GetService"HttpService")
local ah=ae(game:GetService"Players")
local aj=ae(game:GetService"CoreGui")local ak=

ah.LocalPlayer or nil

local al=af:JSONDecode(a.load'i')
if al then
aa.Version=al.version
end

local am=a.load'm'local an=

aa.Services


local ao=aa.Creator

local ap=ao.New local aq=
ao.Tween


local ar=a.load'q'


local as=protectgui or(syn and syn.protect_gui)or function()end

local au=gethui and gethui()or(aj or game.Players.LocalPlayer:WaitForChild"PlayerGui")

local av=ap("UIScale",{
Scale=aa.Scale,
})

aa.UIScaleObj=av

aa.ScreenGui=ap("ScreenGui",{
Name="WindUI",
Parent=au,
IgnoreGuiInset=true,
ScreenInsets="None",
},{

ap("Folder",{
Name="Window"
}),






ap("Folder",{
Name="KeySystem"
}),
ap("Folder",{
Name="Popups"
}),
ap("Folder",{
Name="ToolTips"
})
})

aa.NotificationGui=ap("ScreenGui",{
Name="WindUI/Notifications",
Parent=au,
IgnoreGuiInset=true,
})
aa.DropdownGui=ap("ScreenGui",{
Name="WindUI/Dropdowns",
Parent=au,
IgnoreGuiInset=true,
})
aa.TooltipGui=ap("ScreenGui",{
Name="WindUI/Tooltips",
Parent=au,
IgnoreGuiInset=true,
})
as(aa.ScreenGui)
as(aa.NotificationGui)
as(aa.DropdownGui)
as(aa.TooltipGui)

ao.Init(aa)


function aa.SetParent(aw,ax)
aa.ScreenGui.Parent=ax
aa.NotificationGui.Parent=ax
aa.DropdownGui.Parent=ax
end
math.clamp(aa.TransparencyValue,0,1)

local aw=aa.NotificationModule.Init(aa.NotificationGui)

function aa.Notify(ax,ay)
ay.Holder=aw.Frame
ay.Window=aa.Window

return aa.NotificationModule.New(ay)
end

function aa.SetNotificationLower(ax,ay)
aw.SetLower(ay)
end

function aa.SetFont(ax,ay)
ao.UpdateFont(ay)
end

function aa.OnThemeChange(ax,ay)
aa.OnThemeChangeFunction=ay
end

function aa.AddTheme(ax,ay)
aa.Themes[ay.Name]=ay
return ay
end

function aa.SetTheme(ax,ay)
if aa.Themes[ay]then
aa.Theme=aa.Themes[ay]
ao.SetTheme(aa.Themes[ay])

if aa.OnThemeChangeFunction then
aa.OnThemeChangeFunction(ay)
end


return aa.Themes[ay]
end
return nil
end

function aa.GetThemes(ax)
return aa.Themes
end
function aa.GetCurrentTheme(ax)
return aa.Theme.Name
end
function aa.GetTransparency(ax)
return aa.Transparent or false
end
function aa.GetWindowSize(ax)
return Window.UIElements.Main.Size
end
function aa.Localization(ax,ay)
return aa.LocalizationModule:New(ay,ao)
end

function aa.SetLanguage(ax,ay)
if ao.Localization then
return ao.SetLanguage(ay)
end
return false
end

function aa.ToggleAcrylic(ax,ay)
if aa.Window and aa.Window.AcrylicPaint and aa.Window.AcrylicPaint.Model then
aa.Window.Acrylic=ay
aa.Window.AcrylicPaint.Model.Transparency=ay and 0.98 or 1
if ay then
ar.Enable()
else
ar.Disable()
end
end
end



function aa.Gradient(ax,ay,az)
local aA={}
local aB={}

for aC,aD in next,ay do
local aE=tonumber(aC)
if aE then
aE=math.clamp(aE/100,0,1)
table.insert(aA,ColorSequenceKeypoint.new(aE,aD.Color))
table.insert(aB,NumberSequenceKeypoint.new(aE,aD.Transparency or 0))
end
end

table.sort(aA,function(aE,aF)return aE.Time<aF.Time end)
table.sort(aB,function(aE,aF)return aE.Time<aF.Time end)


if#aA<2 then
error"ColorSequence requires at least 2 keypoints"
end


local aE={
Color=ColorSequence.new(aA),
Transparency=NumberSequence.new(aB),
}

if az then
for aF,b in pairs(az)do
aE[aF]=b
end
end

return aE
end


function aa.Popup(ax,ay)
ay.WindUI=aa
return a.load'r'.new(ay)
end


aa.Themes=a.load's'(aa)

ao.Themes=aa.Themes


aa:SetTheme"Dark"
aa:SetLanguage(ao.Language)


function aa.CreateWindow(ax,ay)
local az=a.load'Y'

if not isfolder"WindUI"then
makefolder"WindUI"
end
if ay.Folder then
makefolder(ay.Folder)
else
makefolder(ay.Title)
end

ay.WindUI=aa
ay.Parent=aa.ScreenGui.Window

if aa.Window then
warn"You cannot create more than one window"
return
end

local aA=true

local aB=aa.Themes[ay.Theme or"Dark"]


ao.SetTheme(aB)


local aC=gethwid or function()
return ah.LocalPlayer.UserId
end

local aD=aC()

if ay.KeySystem then
aA=false

local function loadKeysystem()
am.new(ay,aD,function(aE)aA=aE end)
end

local aE=(ay.Folder or"Temp").."/"..aD..".key"

if ay.KeySystem.KeyValidator then
if ay.KeySystem.SaveKey and isfile(aE)then
local aF=readfile(aE)
local b=ay.KeySystem.KeyValidator(aF)

if b then
aA=true
else
loadKeysystem()
end
else
loadKeysystem()
end
elseif not ay.KeySystem.API then
if ay.KeySystem.SaveKey and isfile(aE)then
local aF=readfile(aE)
local b=(type(ay.KeySystem.Key)=="table")
and table.find(ay.KeySystem.Key,aF)
or tostring(ay.KeySystem.Key)==tostring(aF)

if b then
aA=true
else
loadKeysystem()
end
else
loadKeysystem()
end
else
if isfile(aE)then
local aF=readfile(aE)
local b=false

for d,f in next,ay.KeySystem.API do
local g=aa.Services[f.Type]
if g then
local h={}
for j,l in next,g.Args do
table.insert(h,f[l])
end

local m=g.New(table.unpack(h))
local p=m.Verify(aF)
if p then
b=true
break
end
end
end

aA=b
if not b then loadKeysystem()end
else
loadKeysystem()
end
end

repeat task.wait()until aA
end

local aE=az(ay)

aa.Transparent=ay.Transparent
aa.Window=aE

if ay.Acrylic then
ar.init()
end













return aE
end

return aa