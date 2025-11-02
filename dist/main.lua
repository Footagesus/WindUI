--[[
     _      ___         ____  ______
    | | /| / (_)__  ___/ / / / /  _/
    | |/ |/ / / _ \/ _  / /_/ // /  
    |__/|__/_/_//_/\_,_/\____/___/
    
    v1.6.6  |  2025-11-02  |  Roblox UI Library for scripts
    
    To view the source code, see the `src/` folder on the official GitHub repository.
    
    Author: Footagesus (Footages, .ftgs, oftgs)
    Github: https://github.com/Footagesus/WindUI
    Discord: https://discord.gg/ftgs-development-hub-1300692552005189632
    License: MIT
]]

local a a={cache={}, load=function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}end return a.cache[b].c end}do function a.a()return{


Dialog="Accent",

Background="Accent",
BackgroundTransparency=0,
Hover="Text",

WindowBackground="Background",

WindowShadow=Color3.new(0,0,0),


WindowTopbarButtonIcon="Icon",
WindowTopbarTitle="Text",
WindowTopbarAuthor="Text",
WindowTopbarIcon="Text",

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


}end function a.b()
local b=game:GetService"RunService"local d=
b.Heartbeat
local e=game:GetService"UserInputService"
local f=game:GetService"TweenService"
local g=game:GetService"LocalizationService"
local h=game:GetService"HttpService"

local i="https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"

local j=loadstring(
game.HttpGetAsync and game:HttpGetAsync(i)
or h:GetAsync(i)
)()
j.SetIconsType"lucide"

local l

local m={
Font="rbxassetid://12187365364",
Localization=nil,
CanDraggable=true,
Theme=nil,
Themes=nil,
Icons=j,
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

function m.Init(p)
l=p
end

function m.AddSignal(p,r)
local u=p:Connect(r)
table.insert(m.Signals,u)
return u
end

function m.DisconnectAll()
for p,r in next,m.Signals do
local u=table.remove(m.Signals,p)
u:Disconnect()
end
end

function m.SafeCallback(p,...)
if not p then
return
end

local r,u=pcall(p,...)
if not r then
if l and l.Window and l.Window.Debug then local
v, x=u:find":%d+: "

warn("[ WindUI: DEBUG Mode ] "..u)

return l:Notify{
Title="DEBUG Mode: Error",
Content=not x and u or u:sub(x+1),
Duration=8,
}
end
end
end

function m.Gradient(p,r)
if l and l.Gradient then
return l:Gradient(p,r)
end

local u={}
local v={}

for x,z in next,p do
local A=tonumber(x)
if A then
A=math.clamp(A/100,0,1)
table.insert(u,ColorSequenceKeypoint.new(A,z.Color))
table.insert(v,NumberSequenceKeypoint.new(A,z.Transparency or 0))
end
end

table.sort(u,function(A,B)return A.Time<B.Time end)
table.sort(v,function(A,B)return A.Time<B.Time end)

if#u<2 then
error"ColorSequence requires at least 2 keypoints"
end

local A={
Color=ColorSequence.new(u),
Transparency=NumberSequence.new(v),
}

if r then
for B,C in pairs(r)do
A[B]=C
end
end

return A
end

function m.SetTheme(p)
m.Theme=p
m.UpdateTheme(nil,true)
end

function m.AddFontObject(p)
table.insert(m.FontObjects,p)
m.UpdateFont(m.Font)
end

function m.UpdateFont(p)
m.Font=p
for r,u in next,m.FontObjects do
u.FontFace=Font.new(p,u.FontFace.Weight,u.FontFace.Style)
end
end

function m.GetThemeProperty(p,r)
local function getValue(u,v)
local x=v[u]

if x==nil then return nil end

if type(x)=="string"and string.sub(x,1,1)=="#"then
return Color3.fromHex(x)
end

if typeof(x)=="Color3"then
return x
end

if type(x)=="number"then
return x
end

if type(x)=="table"and x.Color and x.Transparency then
return x
end

if type(x)=="function"then
return x()
end

return x
end

local u=getValue(p,r)
if u~=nil then
if type(u)=="string"and string.sub(u,1,1)~="#"then
local v=m.GetThemeProperty(u,r)
if v~=nil then
return v
end
else
return u
end
end

local v=m.ThemeFallbacks[p]
if v~=nil then
if type(v)=="string"and string.sub(v,1,1)~="#"then
return m.GetThemeProperty(v,r)
else
return getValue(p,{[p]=v})
end
end

u=getValue(p,m.Themes.Dark)
if u~=nil then
if type(u)=="string"and string.sub(u,1,1)~="#"then
local x=m.GetThemeProperty(u,m.Themes.Dark)
if x~=nil then
return x
end
else
return u
end
end

if v~=nil then
if type(v)=="string"and string.sub(v,1,1)~="#"then
return m.GetThemeProperty(v,m.Themes.Dark)
else
return getValue(p,{[p]=v})
end
end

return nil
end

function m.AddThemeObject(p,r)
m.Objects[p]={Object=p,Properties=r}
m.UpdateTheme(p,false)
return p
end

function m.AddLangObject(p)
local r=m.LocalizationObjects[p]
local u=r.Object
local v=currentObjTranslationId
m.UpdateLang(u,v)
return u
end

function m.UpdateTheme(p,r)
local function ApplyTheme(u)
for v,x in pairs(u.Properties or{})do
local z=m.GetThemeProperty(x,m.Theme)
if z~=nil then
if typeof(z)=="Color3"then
local A=u.Object:FindFirstChild"WindUIGradient"
if A then
A:Destroy()
end

if not r then
u.Object[v]=z
else
m.Tween(u.Object,0.08,{[v]=z}):Play()
end
elseif type(z)=="table"and z.Color and z.Transparency then
u.Object[v]=Color3.new(1,1,1)

local A=u.Object:FindFirstChild"WindUIGradient"
if not A then
A=Instance.new"UIGradient"
A.Name="WindUIGradient"
A.Parent=u.Object
end

A.Color=z.Color
A.Transparency=z.Transparency

for B,C in pairs(z)do
if B~="Color"and B~="Transparency"and A[B]~=nil then
A[B]=C
end
end
elseif type(z)=="number"then
if not r then
u.Object[v]=z
else
m.Tween(u.Object,0.08,{[v]=z}):Play()
end
end
else

local A=u.Object:FindFirstChild"WindUIGradient"
if A then
A:Destroy()
end
end
end
end

if p then
local u=m.Objects[p]
if u then
ApplyTheme(u)
end
else
for u,v in pairs(m.Objects)do
ApplyTheme(v)
end
end
end

function m.SetLangForObject(p)
if m.Localization and m.Localization.Enabled then
local r=m.LocalizationObjects[p]
if not r then return end

local u=r.Object
local v=r.TranslationId

local x=m.Localization.Translations[m.Language]
if x and x[v]then
u.Text=x[v]
else
local z=m.Localization and m.Localization.Translations and m.Localization.Translations.en or nil
if z and z[v]then
u.Text=z[v]
else
u.Text="["..v.."]"
end
end
end
end

function m.ChangeTranslationKey(p,r,u)
if m.Localization and m.Localization.Enabled then
local v=string.match(u,"^"..m.Localization.Prefix.."(.+)")
if v then
for x,z in ipairs(m.LocalizationObjects)do
if z.Object==r then
z.TranslationId=v
m.SetLangForObject(x)
return
end
end

table.insert(m.LocalizationObjects,{
TranslationId=v,
Object=r
})
m.SetLangForObject(#m.LocalizationObjects)
end
end
end

function m.UpdateLang(p)
if p then
m.Language=p
end

for r=1,#m.LocalizationObjects do
local u=m.LocalizationObjects[r]
if u.Object and u.Object.Parent~=nil then
m.SetLangForObject(r)
else
m.LocalizationObjects[r]=nil
end
end
end

function m.SetLanguage(p)
m.Language=p
m.UpdateLang()
end

function m.Icon(p)
return j.Icon(p)
end

function m.AddIcons(p,r)
return j.AddIcons(p,r)
end

function m.New(p,r,u)
local v=Instance.new(p)

for x,z in next,m.DefaultProperties[p]or{}do
v[x]=z
end

for A,B in next,r or{}do
if A~="ThemeTag"then
v[A]=B
end
if m.Localization and m.Localization.Enabled and A=="Text"then
local C=string.match(B,"^"..m.Localization.Prefix.."(.+)")
if C then
local F=#m.LocalizationObjects+1
m.LocalizationObjects[F]={TranslationId=C,Object=v}

m.SetLangForObject(F)
end
end
end

for C,F in next,u or{}do
F.Parent=v
end

if r and r.ThemeTag then
m.AddThemeObject(v,r.ThemeTag)
end
if r and r.FontFace then
m.AddFontObject(v)
end
return v
end

function m.Tween(p,r,u,...)
return f:Create(p,TweenInfo.new(r,...),u)
end

function m.NewRoundFrame(p,r,u,v,A,B)
local function getImageForType(C)
return m.Shapes[C]
end

local function getSliceCenterForType(C)
return C~="Shadow-sm"and Rect.new(256
,256
,256
,256

)or Rect.new(512,512,512,512)
end

local C=m.New(A and"ImageButton"or"ImageLabel",{
Image=getImageForType(r),
ScaleType="Slice",
SliceCenter=getSliceCenterForType(r),
SliceScale=1,
BackgroundTransparency=1,
ThemeTag=u.ThemeTag and u.ThemeTag
},v)

for F,G in pairs(u or{})do
if F~="ThemeTag"then
C[F]=G
end
end

local function UpdateSliceScale(H)
local J=r~="Shadow-sm"and(H/(256))or(H/512)
C.SliceScale=math.max(J,0.0001)
end

local H={}

function H.SetRadius(J,L)
UpdateSliceScale(L)
end

function H.SetType(J,L)
r=L
C.Image=getImageForType(L)
C.SliceCenter=getSliceCenterForType(L)
UpdateSliceScale(p)
end

function H.UpdateShape(J,L,M)
if M then
r=M
C.Image=getImageForType(M)
C.SliceCenter=getSliceCenterForType(M)
end
if L then
p=L
end
UpdateSliceScale(p)
end

function H.GetRadius(J)
return p
end

function H.GetType(J)
return r
end

UpdateSliceScale(p)

return C,B and H or nil
end

local p=m.New local r=
m.Tween

function m.SetDraggable(u)
m.CanDraggable=u
end



function m.Drag(u,v,A)
local B
local C,F,G
local H={
CanDraggable=true
}

if not v or type(v)~="table"then
v={u}
end

local function update(J)
if not C or not H.CanDraggable then return end

local L=J.Position-F
m.Tween(u,0.02,{Position=UDim2.new(
G.X.Scale,G.X.Offset+L.X,
G.Y.Scale,G.Y.Offset+L.Y
)}):Play()
end

for J,L in pairs(v)do
L.InputBegan:Connect(function(M)
if(M.UserInputType==Enum.UserInputType.MouseButton1 or M.UserInputType==Enum.UserInputType.Touch)and H.CanDraggable then
if B==nil then
B=L
C=true
F=M.Position
G=u.Position

if A and type(A)=="function"then
A(true,B)
end

M.Changed:Connect(function()
if M.UserInputState==Enum.UserInputState.End then
C=false
B=nil

if A and type(A)=="function"then
A(false,nil)
end
end
end)
end
end
end)

L.InputChanged:Connect(function(M)
if C and B==L then
if M.UserInputType==Enum.UserInputType.MouseMovement or M.UserInputType==Enum.UserInputType.Touch then
update(M)
end
end
end)
end

e.InputChanged:Connect(function(M)
if C and B~=nil then
if M.UserInputType==Enum.UserInputType.MouseMovement or M.UserInputType==Enum.UserInputType.Touch then
update(M)
end
end
end)

function H.Set(M,N)
H.CanDraggable=N
end

return H
end


j.Init(p,"Icon")


function m.SanitizeFilename(u)
local v=u:match"([^/]+)$"or u

v=v:gsub("%.[^%.]+$","")

v=v:gsub("[^%w%-_]","_")

if#v>50 then
v=v:sub(1,50)
end

return v
end

function m.Image(u,v,A,B,C,F,G,H)
B=B or"Temp"
v=m.SanitizeFilename(v)

local J=p("Frame",{
Size=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
},{
p("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ScaleType="Crop",
ThemeTag=(m.Icon(u)or G)and{
ImageColor3=F and(H or"Icon")or nil
}or nil,
},{
p("UICorner",{
CornerRadius=UDim.new(0,A)
})
})
})
if m.Icon(u)then
J.ImageLabel:Destroy()

local L=j.Image{
Icon=u,
Size=UDim2.new(1,0,1,0),
Colors={
(F and"Icon"or false),
"Button"
}
}.IconFrame
L.Parent=J
elseif string.find(u,"http")then
local L="WindUI/"..B.."/assets/."..C.."-"..v..".png"
local M,N=pcall(function()
task.spawn(function()
local M=m.Request{
Url=u,
Method="GET",
}.Body

writefile(L,M)


local N,O=pcall(getcustomasset,L)
if N then
J.ImageLabel.Image=O
else
warn(string.format("[ WindUI.Creator ] Failed to load custom asset '%s': %s",L,tostring(O)))
J:Destroy()

return
end
end)
end)
if not M then
warn("[ WindUI.Creator ]  '"..identifyexecutor().."' doesnt support the URL Images. Error: "..N)

J:Destroy()
end
elseif u==""then
J.Visible=false
else
J.ImageLabel.Image=u
end

return J
end


return m end function a.c()

local b={}







function b.New(e,f,g)
local h={
Enabled=f.Enabled or false,
Translations=f.Translations or{},
Prefix=f.Prefix or"loc:",
DefaultLanguage=f.DefaultLanguage or"en"
}

g.Localization=h

return h
end



return b end function a.d()
local b=a.load'b'
local e=b.New
local f=b.Tween

local g={
Size=UDim2.new(0,300,1,-156),
SizeLower=UDim2.new(0,300,1,-56),
UICorner=13,
UIPadding=14,

Holder=nil,
NotificationIndex=0,
Notifications={}
}

function g.Init(h)
local i={
Lower=false
}

function i.SetLower(j)
i.Lower=j
i.Frame.Size=j and g.SizeLower or g.Size
end

i.Frame=e("Frame",{
Position=UDim2.new(1,-29,0,56),
AnchorPoint=Vector2.new(1,0),
Size=g.Size,
Parent=h,
BackgroundTransparency=1,




},{
e("UIListLayout",{
HorizontalAlignment="Center",
SortOrder="LayoutOrder",
VerticalAlignment="Bottom",
Padding=UDim.new(0,8),
}),
e("UIPadding",{
PaddingBottom=UDim.new(0,29)
})
})
return i
end

function g.New(h)
local i={
Title=h.Title or"Notification",
Content=h.Content or nil,
Icon=h.Icon or nil,
IconThemed=h.IconThemed,
Background=h.Background,
BackgroundImageTransparency=h.BackgroundImageTransparency,
Duration=h.Duration or 5,
Buttons=h.Buttons or{},
CanClose=true,
UIElements={},
Closed=false,
}
if i.CanClose==nil then
i.CanClose=true
end
g.NotificationIndex=g.NotificationIndex+1
g.Notifications[g.NotificationIndex]=i









local j

if i.Icon then





















j=b.Image(
i.Icon,
i.Title..":"..i.Icon,
0,
h.Window,
"Notification",
i.IconThemed
)
j.Size=UDim2.new(0,26,0,26)
j.Position=UDim2.new(0,g.UIPadding,0,g.UIPadding)

end

local l
if i.CanClose then
l=e("ImageButton",{
Image=b.Icon"x"[1],
ImageRectSize=b.Icon"x"[2].ImageRectSize,
ImageRectOffset=b.Icon"x"[2].ImageRectPosition,
BackgroundTransparency=1,
Size=UDim2.new(0,16,0,16),
Position=UDim2.new(1,-g.UIPadding,0,g.UIPadding),
AnchorPoint=Vector2.new(1,0),
ThemeTag={
ImageColor3="Text"
},
ImageTransparency=.4,
},{
e("TextButton",{
Size=UDim2.new(1,8,1,8),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Text="",
})
})
end

local m=e("Frame",{
Size=UDim2.new(0,0,1,0),
BackgroundTransparency=.95,
ThemeTag={
BackgroundColor3="Text",
},

})

local p=e("Frame",{
Size=UDim2.new(1,
i.Icon and-28-g.UIPadding or 0,
1,0),
Position=UDim2.new(1,0,0,0),
AnchorPoint=Vector2.new(1,0),
BackgroundTransparency=1,
AutomaticSize="Y",
},{
e("UIPadding",{
PaddingTop=UDim.new(0,g.UIPadding),
PaddingLeft=UDim.new(0,g.UIPadding),
PaddingRight=UDim.new(0,g.UIPadding),
PaddingBottom=UDim.new(0,g.UIPadding),
}),
e("TextLabel",{
AutomaticSize="Y",
Size=UDim2.new(1,-30-g.UIPadding,0,0),
TextWrapped=true,
TextXAlignment="Left",
RichText=true,
BackgroundTransparency=1,
TextSize=16,
ThemeTag={
TextColor3="Text"
},
Text=i.Title,
FontFace=Font.new(b.Font,Enum.FontWeight.Medium)
}),
e("UIListLayout",{
Padding=UDim.new(0,g.UIPadding/3)
})
})

if i.Content then
e("TextLabel",{
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
Text=i.Content,
FontFace=Font.new(b.Font,Enum.FontWeight.Medium),
Parent=p
})
end


local r=b.NewRoundFrame(g.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
Position=UDim2.new(2,0,1,0),
AnchorPoint=Vector2.new(0,1),
AutomaticSize="Y",
ImageTransparency=.05,
ThemeTag={
ImageColor3="Background"
},

},{
e("CanvasGroup",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
m,
e("UICorner",{
CornerRadius=UDim.new(0,g.UICorner),
})

}),
e("ImageLabel",{
Name="Background",
Image=i.Background,
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
ScaleType="Crop",
ImageTransparency=i.BackgroundImageTransparency

},{
e("UICorner",{
CornerRadius=UDim.new(0,g.UICorner),
})
}),

p,
j,l,
})

local u=e("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Parent=h.Holder
},{
r
})

function i.Close(v)
if not i.Closed then
i.Closed=true
f(u,0.45,{Size=UDim2.new(1,0,0,-8)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
f(r,0.55,{Position=UDim2.new(2,0,1,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
task.wait(.45)
u:Destroy()
end
end

task.spawn(function()
task.wait()
f(u,0.45,{Size=UDim2.new(
1,
0,
0,
r.AbsoluteSize.Y
)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
f(r,0.45,{Position=UDim2.new(0,0,1,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if i.Duration then
f(m,i.Duration,{Size=UDim2.new(1,0,1,0)},Enum.EasingStyle.Linear,Enum.EasingDirection.InOut):Play()
task.wait(i.Duration)
i:Close()
end
end)

if l then
b.AddSignal(l.TextButton.MouseButton1Click,function()
i:Close()
end)
end


return i
end

return g end function a.e()











local b=4294967296;local e=b-1;local function c(f,g)local h,i=0,1;while f~=0 or g~=0 do local j,l=f%2,g%2;local m=(j+l)%2;h=h+m*i;f=math.floor(f/2)g=math.floor(g/2)i=i*2 end;return h%b end;local function k(f,g,h,...)local i;if g then f=f%b;g=g%b;i=c(f,g)if h then i=k(i,h,...)end;return i elseif f then return f%b else return 0 end end;local function n(f,g,h,...)local i;if g then f=f%b;g=g%b;i=(f+g-c(f,g))/2;if h then i=n(i,h,...)end;return i elseif f then return f%b else return e end end;local function o(f)return e-f end;local function q(f,g)if g<0 then return lshift(f,-g)end;return math.floor(f%4294967296/2^g)end;local function s(f,g)if g>31 or g<-31 then return 0 end;return q(f%b,g)end;local function lshift(f,g)if g<0 then return s(f,-g)end;return f*2^g%4294967296 end;local function t(f,g)f=f%b;g=g%32;local h=n(f,2^g-1)return s(f,g)+lshift(h,32-g)end;local f={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(g)return string.gsub(g,".",function(h)return string.format("%02x",string.byte(h))end)end;local function y(g,h)local i=""for j=1,h do local l=g%256;i=string.char(l)..i;g=(g-l)/256 end;return i end;local function D(g,h)local i=0;for j=h,h+3 do i=i*256+string.byte(g,j)end;return i end;local function E(g,h)local i=64-(h+9)%64;h=y(8*h,8)g=g.."\128"..string.rep("\0",i)..h;assert(#g%64==0)return g end;local function I(g)g[1]=0x6a09e667;g[2]=0xbb67ae85;g[3]=0x3c6ef372;g[4]=0xa54ff53a;g[5]=0x510e527f;g[6]=0x9b05688c;g[7]=0x1f83d9ab;g[8]=0x5be0cd19;return g end;local function K(g,h,i)local j={}for l=1,16 do j[l]=D(g,h+(l-1)*4)end;for l=17,64 do local m=j[l-15]local p=k(t(m,7),t(m,18),s(m,3))m=j[l-2]j[l]=(j[l-16]+p+j[l-7]+k(t(m,17),t(m,19),s(m,10)))%b end;local l,m,p,r,u,v,A,B=i[1],i[2],i[3],i[4],i[5],i[6],i[7],i[8]for C=1,64 do local F=k(t(l,2),t(l,13),t(l,22))local G=k(n(l,m),n(l,p),n(m,p))local H=(F+G)%b;local J=k(t(u,6),t(u,11),t(u,25))local L=k(n(u,v),n(o(u),A))local M=(B+J+L+f[C]+j[C])%b;B=A;A=v;v=u;u=(r+M)%b;r=p;p=m;m=l;l=(M+H)%b end;i[1]=(i[1]+l)%b;i[2]=(i[2]+m)%b;i[3]=(i[3]+p)%b;i[4]=(i[4]+r)%b;i[5]=(i[5]+u)%b;i[6]=(i[6]+v)%b;i[7]=(i[7]+A)%b;i[8]=(i[8]+B)%b end;local function Z(g)g=E(g,#g)local h=I{}for i=1,#g,64 do K(g,i,h)end;return w(y(h[1],4)..y(h[2],4)..y(h[3],4)..y(h[4],4)..y(h[5],4)..y(h[6],4)..y(h[7],4)..y(h[8],4))end;local g;local h={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local i={["/"]="/"}for j,l in pairs(h)do i[l]=j end;local m=function(m)return"\\"..(h[m]or string.format("u%04x",m:byte()))end;local p=function(p)return"null"end;local r=function(r,u)local v={}u=u or{}if u[r]then error"circular reference"end;u[r]=true;if rawget(r,1)~=nil or next(r)==nil then local A=0;for B in pairs(r)do if type(B)~="number"then error"invalid table: mixed or invalid key types"end;A=A+1 end;if A~=#r then error"invalid table: sparse array"end;for C,F in ipairs(r)do table.insert(v,g(F,u))end;u[r]=nil;return"["..table.concat(v,",").."]"else for A,B in pairs(r)do if type(A)~="string"then error"invalid table: mixed or invalid key types"end;table.insert(v,g(A,u)..":"..g(B,u))end;u[r]=nil;return"{"..table.concat(v,",").."}"end end;local u=function(u)return'"'..u:gsub('[%z\1-\31\\"]',m)..'"'end;local v=function(v)if v~=v or v<=-math.huge or v>=math.huge then error("unexpected number value '"..tostring(v).."'")end;return string.format("%.14g",v)end;local A={["nil"]=p,table=r,string=u,number=v,boolean=tostring}g=function(B,C)local F=type(B)local G=A[F]if G then return G(B,C)end;error("unexpected type '"..F.."'")end;local B=function(B)return g(B)end;local C;local F=function(...)local F={}for G=1,select("#",...)do F[select(G,...)]=true end;return F end;local G=F(" ","\t","\r","\n")local H=F(" ","\t","\r","\n","]","}",",")local J=F("\\","/",'"',"b","f","n","r","t","u")local L=F("true","false","null")local M={["true"]=true,["false"]=false,null=nil}local N=function(N,O,P,Q)for R=O,#N do if P[N:sub(R,R)]~=Q then return R end end;return#N+1 end;local O=function(O,P,Q)local R=1;local S=1;for T=1,P-1 do S=S+1;if O:sub(T,T)=="\n"then R=R+1;S=1 end end;error(string.format("%s at line %d col %d",Q,R,S))end;local P=function(P)local Q=math.floor;if P<=0x7f then return string.char(P)elseif P<=0x7ff then return string.char(Q(P/64)+192,P%64+128)elseif P<=0xffff then return string.char(Q(P/4096)+224,Q(P%4096/64)+128,P%64+128)elseif P<=0x10ffff then return string.char(Q(P/262144)+240,Q(P%262144/4096)+128,Q(P%4096/64)+128,P%64+128)end;error(string.format("invalid unicode codepoint '%x'",P))end;local Q=function(Q)local R=tonumber(Q:sub(1,4),16)local S=tonumber(Q:sub(7,10),16)if S then return P((R-0xd800)*0x400+S-0xdc00+0x10000)else return P(R)end end;local R=function(R,S)local T=""local U=S+1;local V=U;while U<=#R do local W=R:byte(U)if W<32 then O(R,U,"control character in string")elseif W==92 then T=T..R:sub(V,U-1)U=U+1;local X=R:sub(U,U)if X=="u"then local Y=R:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",U+1)or R:match("^%x%x%x%x",U+1)or O(R,U-1,"invalid unicode escape in string")T=T..Q(Y)U=U+#Y else if not J[X]then O(R,U-1,"invalid escape char '"..X.."' in string")end;T=T..i[X]end;V=U+1 elseif W==34 then T=T..R:sub(V,U-1)return T,U+1 end;U=U+1 end;O(R,S,"expected closing quote for string")end;local S=function(S,T)local U=N(S,T,H)local V=S:sub(T,U-1)local W=tonumber(V)if not W then O(S,T,"invalid number '"..V.."'")end;return W,U end;local T=function(T,U)local V=N(T,U,H)local W=T:sub(U,V-1)if not L[W]then O(T,U,"invalid literal '"..W.."'")end;return M[W],V end;local U=function(U,V)local W={}local X=1;V=V+1;while 1 do local Y;V=N(U,V,G,true)if U:sub(V,V)=="]"then V=V+1;break end;Y,V=C(U,V)W[X]=Y;X=X+1;V=N(U,V,G,true)local _=U:sub(V,V)V=V+1;if _=="]"then break end;if _~=","then O(U,V,"expected ']' or ','")end end;return W,V end;local aa=function(V,W)local X={}W=W+1;while 1 do local Y,_;W=N(V,W,G,true)if V:sub(W,W)=="}"then W=W+1;break end;if V:sub(W,W)~='"'then O(V,W,"expected string for key")end;Y,W=C(V,W)W=N(V,W,G,true)if V:sub(W,W)~=":"then O(V,W,"expected ':' after key")end;W=N(V,W+1,G,true)_,W=C(V,W)X[Y]=_;W=N(V,W,G,true)local aa=V:sub(W,W)W=W+1;if aa=="}"then break end;if aa~=","then O(V,W,"expected '}' or ','")end end;return X,W end;local V={['"']=R,["0"]=S,["1"]=S,["2"]=S,["3"]=S,["4"]=S,["5"]=S,["6"]=S,["7"]=S,["8"]=S,["9"]=S,["-"]=S,t=T,f=T,n=T,["["]=U,["{"]=aa}C=function(W,X)local Y=W:sub(X,X)local _=V[Y]if _ then return _(W,X)end;O(W,X,"unexpected character '"..Y.."'")end;local W=function(W)if type(W)~="string"then error("expected argument of type string, got "..type(W))end;local X,Y=C(W,N(W,1,G,true))Y=N(W,Y,G,true)if Y<=#W then O(W,Y,"trailing garbage")end;return X end;
local X,Y,_=B,W,Z;





local ab={}


function ab.New(ac,ad)

local ae=ac;
local af=ad;
local ag=true;


local ah=function(ah)end;


repeat task.wait(1)until game:IsLoaded();


local ai=false;
local aj,ak,al,am,an,ao,ap,aq,ar=setclipboard or toclipboard,request or http_request or syn_request,string.char,tostring,string.sub,os.time,math.random,math.floor,gethwid or function()return game:GetService"Players".LocalPlayer.UserId end
local as,at="",0;


local au="https://api.platoboost.app";
local av=ak{
Url=au.."/public/connectivity",
Method="GET"
};
if av.StatusCode~=200 and av.StatusCode~=429 then
au="https://api.platoboost.net";
end


function cacheLink()
if at+(600)<ao()then
local aw=ak{
Url=au.."/public/start",
Method="POST",
Body=X{
service=ae,
identifier=_(ar())
},
Headers={
["Content-Type"]="application/json",
["User-Agent"]="Roblox/Exploit"
}
};

if aw.StatusCode==200 then
local ax=Y(aw.Body);

if ax.success==true then
as=ax.data.url;
at=ao();
return true,as
else
ah(ax.message);
return false,ax.message
end
elseif aw.StatusCode==429 then
local ax="you are being rate limited, please wait 20 seconds and try again.";
ah(ax);
return false,ax
end

local ax="Failed to cache link.";
ah(ax);
return false,ax
else
return true,as
end
end

cacheLink();


local aw=function()
local aw=""
for ax=1,16 do
aw=aw..al(aq(ap()*(26))+97)
end
return aw
end


for ax=1,5 do
local ay=aw();
task.wait(0.2)
if aw()==ay then
local az="platoboost nonce error.";
ah(az);
error(az);
end
end


local ax=function()
local ax,ay=cacheLink();

if ax then
aj(ay);
end
end


local ay=function(ay)
local az=aw();
local aA=au.."/public/redeem/"..am(ae);

local aB={
identifier=_(ar()),
key=ay
}

if ag then
aB.nonce=az;
end

local aC=ak{
Url=aA,
Method="POST",
Body=X(aB),
Headers={
["Content-Type"]="application/json"
}
};

if aC.StatusCode==200 then
local aD=Y(aC.Body);

if aD.success==true then
if aD.data.valid==true then
if ag then
if aD.data.hash==_("true".."-"..az.."-"..af)then
return true
else
ah"failed to verify integrity.";
return false
end
else
return true
end
else
ah"key is invalid.";
return false
end
else
if an(aD.message,1,27)=="unique constraint violation"then
ah"you already have an active key, please wait for it to expire before redeeming it.";
return false
else
ah(aD.message);
return false
end
end
elseif aC.StatusCode==429 then
ah"you are being rate limited, please wait 20 seconds and try again.";
return false
else
ah"server returned an invalid status code, please try again later.";
return false
end
end


local az=function(az)
if ai==true then
return false,("A request is already being sent, please slow down.")
else
ai=true;
end

local aA=aw();
local aB=au.."/public/whitelist/"..am(ae).."?identifier=".._(ar()).."&key="..az;

if ag then
aB=aB.."&nonce="..aA;
end

local aC=ak{
Url=aB,
Method="GET",
};

ai=false;

if aC.StatusCode==200 then
local aD=Y(aC.Body);

if aD.success==true then
if aD.data.valid==true then
if ag then
if aD.data.hash==_("true".."-"..aA.."-"..af)then
return true,""
else
return false,("failed to verify integrity.")
end
else
return true
end
else
if an(az,1,4)=="KEY_"then
return true,ay(az)
else
return false,("Key is invalid.")
end
end
else
return false,(aD.message)
end
elseif aC.StatusCode==429 then
return false,("You are being rate limited, please wait 20 seconds and try again.")
else
return false,("Server returned an invalid status code, please try again later.")
end
end


local aA=function(aA)
local aB=aw();
local aC=au.."/public/flag/"..am(ae).."?name="..aA;

if ag then
aC=aC.."&nonce="..aB;
end

local aD=ak{
Url=aC,
Method="GET",
};

if aD.StatusCode==200 then
local aE=Y(aD.Body);

if aE.success==true then
if ag then
if aE.data.hash==_(am(aE.data.value).."-"..aB.."-"..af)then
return aE.data.value
else
ah"failed to verify integrity.";
return nil
end
else
return aE.data.value
end
else
ah(aE.message);
return nil
end
else
return nil
end
end


return{
Verify=az,
GetFlag=aA,
Copy=ax,
}
end


return ab end function a.f()








local aa=game:GetService"HttpService"
local ab={}


function ab.New(ac)
local ad=gethwid or function()return game:GetService"Players".LocalPlayer.UserId end
local ae,af=request or http_request or syn_request,setclipboard or toclipboard

function ValidateKey(ag)
local ah="https://pandadevelopment.net/v2_validation?key="..tostring(ag).."&service="..tostring(ac).."&hwid="..tostring(ad())


local ai,aj=pcall(function()
return ae{
Url=ah,
Method="GET",
Headers={["User-Agent"]="Roblox/Exploit"}
}
end)

if ai and aj then
if aj.Success then
local ak,al=pcall(function()
return aa:JSONDecode(aj.Body)
end)

if ak and al then
if al.V2_Authentication and al.V2_Authentication=="success"then

return true,"Authenticated"
else
local am=al.Key_Information.Notes or"Unknown reason"

return false,"Authentication failed: "..am
end
else

return false,"JSON decode error"
end
else
warn("[Pelinda Ov2.5] HTTP request was not successful. Code: "..tostring(aj.StatusCode).." Message: "..aj.StatusMessage)
return false,"HTTP request failed: "..aj.StatusMessage
end
else

return false,"Request pcall error"
end
end

function GetKeyLink()
return"https://pandadevelopment.net/getkey?service="..tostring(ac).."&hwid="..tostring(ad())
end

function CopyLink()
return af(GetKeyLink())
end

return{
Verify=ValidateKey,
Copy=CopyLink
}
end

return ab end function a.g()








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
    "version": "1.6.6",
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

function aa.new(ag,ah,ai)
local aj=a.load'l'.Init(nil,ag.WindUI.ScreenGui.KeySystem)
local ak=aj.Create(true)

local al={}

local am

local an=(ag.KeySystem.Thumbnail and ag.KeySystem.Thumbnail.Width)or 200

local ao=430
if ag.KeySystem.Thumbnail and ag.KeySystem.Thumbnail.Image then
ao=430+(an/2)
end

ak.UIElements.Main.AutomaticSize="Y"
ak.UIElements.Main.Size=UDim2.new(0,ao,0,0)

local ap

if ag.Icon then

ap=ab.Image(
ag.Icon,
ag.Title..":"..ag.Icon,
0,
"Temp",
"KeySystem",
ag.IconThemed
)
ap.Size=UDim2.new(0,24,0,24)
ap.LayoutOrder=-1
end

local aq=ac("TextLabel",{
AutomaticSize="XY",
BackgroundTransparency=1,
Text=ag.Title,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
TextSize=20
})
local ar=ac("TextLabel",{
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

local as=ac("Frame",{
BackgroundTransparency=1,
AutomaticSize="XY",
},{
ac("UIListLayout",{
Padding=UDim.new(0,14),
FillDirection="Horizontal",
VerticalAlignment="Center"
}),
ap,aq
})

local at=ac("Frame",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
},{





as,ar,
})

local au=af("Enter Key","key",nil,"Input",function(au)
am=au
end)

local av
if ag.KeySystem.Note and ag.KeySystem.Note~=""then
av=ac("TextLabel",{
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

local aw=ac("Frame",{
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


local ax
if ag.KeySystem.Thumbnail and ag.KeySystem.Thumbnail.Image then
local ay
if ag.KeySystem.Thumbnail.Title then
ay=ac("TextLabel",{
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
ax=ac("ImageLabel",{
Image=ag.KeySystem.Thumbnail.Image,
BackgroundTransparency=1,
Size=UDim2.new(0,an,1,-12),
Position=UDim2.new(0,6,0,6),
Parent=ak.UIElements.Main,
ScaleType="Crop"
},{
ay,
ac("UICorner",{
CornerRadius=UDim.new(0,20),
})
})
end

ac("Frame",{

Size=UDim2.new(1,ax and-an or 0,1,0),
Position=UDim2.new(0,ax and an or 0,0,0),
BackgroundTransparency=1,
Parent=ak.UIElements.Main
},{
ac("Frame",{

Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ac("UIListLayout",{
Padding=UDim.new(0,18),
FillDirection="Vertical",
}),
at,
av,
au,
aw,
ac("UIPadding",{
PaddingTop=UDim.new(0,16),
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
PaddingBottom=UDim.new(0,16),
})
}),
})





local ay=ae("Exit","log-out",function()
ak:Close()()
end,"Tertiary",aw.Frame)

if ax then
ay.Parent=ax
ay.Size=UDim2.new(0,0,0,42)
ay.Position=UDim2.new(0,10,1,-10)
ay.AnchorPoint=Vector2.new(0,1)
end

if ag.KeySystem.URL then
ae("Get key","key",function()
setclipboard(ag.KeySystem.URL)
end,"Secondary",aw.Frame)
end

if ag.KeySystem.API then








local az=240
local aA=false
local aB=ae("Get key","key",nil,"Secondary",aw.Frame)

local aC=ab.NewRoundFrame(99,"Squircle",{
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
Parent=aB.Frame,
},{
aC,
ac("UIPadding",{
PaddingLeft=UDim.new(0,5),
PaddingRight=UDim.new(0,5),
})
})

local aD=ab.Image(
"chevron-down",
"chevron-down",
0,
"Temp",
"KeySystem",
true
)

aD.Size=UDim2.new(1,0,1,0)

ac("Frame",{
Size=UDim2.new(0,21,0,21),
Parent=aB.Frame,
BackgroundTransparency=1,
},{
aD
})

local aE=ab.NewRoundFrame(15,"Squircle",{
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
Size=UDim2.new(0,az,0,0),
ClipsDescendants=true,
AnchorPoint=Vector2.new(1,0),
Parent=aB,
Position=UDim2.new(1,0,1,15)
},{
aE
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
Parent=aE,
},{
ac("UIPadding",{
PaddingTop=UDim.new(0,10),
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingBottom=UDim.new(0,10),
})
})

for e,g in next,ag.KeySystem.API do
local h=ag.WindUI.Services[g.Type]
if h then
local i={}
for j,l in next,h.Args do
table.insert(i,g[l])
end

local m=h.New(table.unpack(i))
m.Type=g.Type
table.insert(al,m)

local p=ab.Image(
g.Icon or h.Icon or Icons[g.Type]or"user",
g.Icon or h.Icon or Icons[g.Type]or"user",
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
Parent=aE,
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
Text=g.Title or h.Name,
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
Text=g.Desc or"",
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
ThemeTag={TextColor3="Text"},
TextTransparency=0.2,
TextSize=16,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
TextWrapped=true,
Visible=g.Desc and true or false,
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

ab.AddSignal(aB.MouseButton1Click,function()
if not aA then
ad(b,.3,{Size=UDim2.new(0,az,0,aE.AbsoluteSize.Y+1)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(aD,.3,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
else
ad(b,.25,{Size=UDim2.new(0,az,0,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(aD,.25,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
aA=not aA
end)

end

local function handleSuccess(az)
ak:Close()()
writefile((ag.Folder or"Temp").."/"..ah..".key",tostring(az))
task.wait(.4)
ai(true)
end

local az=ae("Submit","arrow-right",function()
local az=tostring(am or"empty")local aA=
ag.Folder or ag.Title

if not ag.KeySystem.API then
local aB=type(ag.KeySystem.Key)=="table"
and table.find(ag.KeySystem.Key,az)
or ag.KeySystem.Key==az

if aB then
if ag.KeySystem.SaveKey then
handleSuccess(az)
else
ak:Close()()
task.wait(.4)
ai(true)
end
end
else
local aB,aC
for aD,aE in next,al do
local b,e=aE.Verify(az)
if b then
aB,aC=true,e
break
end
aC=e
end

if aB then
handleSuccess(az)
else
ag.WindUI:Notify{
Title="Key System. Error",
Content=aC,
Icon="triangle-alert",
}
end
end
end,"Primary",aw)

az.AnchorPoint=Vector2.new(1,0.5)
az.Position=UDim2.new(1,0,0.5,0)










ak:Open()
end

return aa end function a.n()


local function map(aa,ab,ac,ad,ae)
return(aa-ab)*(ae-ad)/(ac-ab)+ad
end

local function viewportPointToWorld(aa,ab)
local ac=game:GetService"Workspace".CurrentCamera:ScreenPointToRay(aa.X,aa.Y)
return ac.Origin+ac.Direction*ab
end

local function getOffset()
local aa=game:GetService"Workspace".CurrentCamera.ViewportSize.Y
return map(aa,0,2560,8,56)
end

return{viewportPointToWorld,getOffset}end function a.o()



local aa=a.load'b'
local ab=aa.New


local ac,ad=unpack(a.load'n')
local ae=Instance.new("Folder",game:GetService"Workspace".CurrentCamera)


local function createAcrylic()
local af=ab("Part",{
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
ab("SpecialMesh",{
MeshType=Enum.MeshType.Brick,
Offset=Vector3.new(0,0,-1E-6),
}),
})

return af
end


local function createAcrylicBlur(af)
local ag={}

af=af or 0.001
local ah={
topLeft=Vector2.new(),
topRight=Vector2.new(),
bottomRight=Vector2.new(),
}
local ai=createAcrylic()
ai.Parent=ae

local function updatePositions(aj,ak)
ah.topLeft=ak
ah.topRight=ak+Vector2.new(aj.X,0)
ah.bottomRight=ak+aj
end

local function render()
local aj=game:GetService"Workspace".CurrentCamera
if aj then
aj=aj.CFrame
end
local ak=aj
if not ak then
ak=CFrame.new()
end

local al=ak
local am=ah.topLeft
local an=ah.topRight
local ao=ah.bottomRight

local ap=ac(am,af)
local aq=ac(an,af)
local ar=ac(ao,af)

local as=(aq-ap).Magnitude
local at=(aq-ar).Magnitude

ai.CFrame=
CFrame.fromMatrix((ap+ar)/2,al.XVector,al.YVector,al.ZVector)
ai.Mesh.Scale=Vector3.new(as,at,0)
end

local function onChange(aj)
local ak=ad()
local al=aj.AbsoluteSize-Vector2.new(ak,ak)
local am=aj.AbsolutePosition+Vector2.new(ak/2,ak/2)

updatePositions(al,am)
task.spawn(render)
end

local function renderOnChange()
local aj=game:GetService"Workspace".CurrentCamera
if not aj then
return
end

table.insert(ag,aj:GetPropertyChangedSignal"CFrame":Connect(render))
table.insert(ag,aj:GetPropertyChangedSignal"ViewportSize":Connect(render))
table.insert(ag,aj:GetPropertyChangedSignal"FieldOfView":Connect(render))
task.spawn(render)
end

ai.Destroying:Connect(function()
for aj,ak in ag do
pcall(function()
ak:Disconnect()
end)
end
end)

renderOnChange()

return onChange,ai
end

return function(af)
local ag={}
local ah,ai=createAcrylicBlur(af)

local aj=ab("Frame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
})

aa.AddSignal(aj:GetPropertyChangedSignal"AbsolutePosition",function()
ah(aj)
end)

aa.AddSignal(aj:GetPropertyChangedSignal"AbsoluteSize",function()
ah(aj)
end)

ag.AddParent=function(ak)
aa.AddSignal(ak:GetPropertyChangedSignal"Visible",function()
ag.SetVisibility(ak.Visible)
end)
end

ag.SetVisibility=function(ak)
ai.Transparency=ak and 0.98 or 1
end

ag.Frame=aj
ag.Model=ai

return ag
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



local aa={
AcrylicBlur=a.load'o',

AcrylicPaint=a.load'p',
}

function aa.init()
local ab=Instance.new"DepthOfFieldEffect"
ab.FarIntensity=0
ab.InFocusRadius=0.1
ab.NearIntensity=1

local ac={}

function aa.Enable()
for ad,ae in pairs(ac)do
ae.Enabled=false
end
ab.Parent=game:GetService"Lighting"
end

function aa.Disable()
for ad,ae in pairs(ac)do
ae.Enabled=ae.enabled
end
ab.Parent=nil
end

local function registerDefaults()
local function register(ad)
if ad:IsA"DepthOfFieldEffect"then
ac[ad]={enabled=ad.Enabled}
end
end

for ad,ae in pairs(game:GetService"Lighting":GetChildren())do
register(ae)
end

if game:GetService"Workspace".CurrentCamera then
for af,ag in pairs(game:GetService"Workspace".CurrentCamera:GetChildren())do
register(ag)
end
end
end

registerDefaults()
aa.Enable()
end

return aa end function a.r()

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
Icon=Color3.fromHex"#a1a1aa"
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

local ab=game:GetService"UserInputService"

local ac=a.load'b'
local ad=ac.New local ae=
ac.Tween


function aa.New(af,ag,ah,ai)
local aj=ad("Frame",{
Size=UDim2.new(0,ai,1,0),
BackgroundTransparency=1,
Position=UDim2.new(1,0,0,0),
AnchorPoint=Vector2.new(1,0),
Parent=ag,
ZIndex=999,
Active=true,
})

local ak=ac.NewRoundFrame(ai/2,"Squircle",{
Size=UDim2.new(1,0,0,0),
ImageTransparency=0.85,
ThemeTag={ImageColor3="Text"},
Parent=aj,
})

local al=ad("Frame",{
Size=UDim2.new(1,12,1,12),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Active=true,
ZIndex=999,
Parent=ak,
})

local am=false
local an=0

local function updateSliderSize()
local ao=af
local ap=ao.AbsoluteCanvasSize.Y
local aq=ao.AbsoluteWindowSize.Y

if ap<=aq then
ak.Visible=false
return
end

local ar=math.clamp(aq/ap,0.1,1)
ak.Size=UDim2.new(1,0,ar,0)
ak.Visible=true
end

local function updateScrollingFramePosition()
local ao=ak.Position.Y.Scale
local ap=af.AbsoluteCanvasSize.Y
local aq=af.AbsoluteWindowSize.Y
local ar=math.max(ap-aq,0)

if ar<=0 then return end

local as=math.max(1-ak.Size.Y.Scale,0)
if as<=0 then return end

local at=ao/as

af.CanvasPosition=Vector2.new(
af.CanvasPosition.X,
at*ar
)
end

local function updateThumbPosition()
if am then return end

local ao=af.CanvasPosition.Y
local ap=af.AbsoluteCanvasSize.Y
local aq=af.AbsoluteWindowSize.Y
local ar=math.max(ap-aq,0)

if ar<=0 then
ak.Position=UDim2.new(0,0,0,0)
return
end

local as=ao/ar
local at=math.max(1-ak.Size.Y.Scale,0)
local au=math.clamp(as*at,0,at)

ak.Position=UDim2.new(0,0,au,0)
end

ac.AddSignal(aj.InputBegan,function(ao)
if(ao.UserInputType==Enum.UserInputType.MouseButton1 or ao.UserInputType==Enum.UserInputType.Touch)then
local ap=ak.AbsolutePosition.Y
local aq=ap+ak.AbsoluteSize.Y

if not(ao.Position.Y>=ap and ao.Position.Y<=aq)then
local ar=aj.AbsolutePosition.Y
local as=aj.AbsoluteSize.Y
local at=ak.AbsoluteSize.Y

local au=ao.Position.Y-ar-at/2
local av=as-at

local aw=math.clamp(au/av,0,1-ak.Size.Y.Scale)

ak.Position=UDim2.new(0,0,aw,0)
updateScrollingFramePosition()
end
end
end)

ac.AddSignal(al.InputBegan,function(ao)
if ao.UserInputType==Enum.UserInputType.MouseButton1 or ao.UserInputType==Enum.UserInputType.Touch then
am=true
an=ao.Position.Y-ak.AbsolutePosition.Y

local ap
local aq

ap=ab.InputChanged:Connect(function(ar)
if ar.UserInputType==Enum.UserInputType.MouseMovement or ar.UserInputType==Enum.UserInputType.Touch then
local as=aj.AbsolutePosition.Y
local at=aj.AbsoluteSize.Y
local au=ak.AbsoluteSize.Y

local av=ar.Position.Y-as-an
local aw=at-au

local ax=math.clamp(av/aw,0,1-ak.Size.Y.Scale)

ak.Position=UDim2.new(0,0,ax,0)
updateScrollingFramePosition()
end
end)

aq=ab.InputEnded:Connect(function(ar)
if ar.UserInputType==Enum.UserInputType.MouseButton1 or ar.UserInputType==Enum.UserInputType.Touch then
am=false
if ap then ap:Disconnect()end
if aq then aq:Disconnect()end
end
end)
end
end)

ac.AddSignal(af:GetPropertyChangedSignal"AbsoluteWindowSize",function()
updateSliderSize()
updateThumbPosition()
end)

ac.AddSignal(af:GetPropertyChangedSignal"AbsoluteCanvasSize",function()
updateSliderSize()
updateThumbPosition()
end)

ac.AddSignal(af:GetPropertyChangedSignal"CanvasPosition",function()
if not am then
updateThumbPosition()
end
end)

updateSliderSize()
updateThumbPosition()

return aj
end


return aa end function a.v()
local aa={}


local ab=a.load'b'
local ac=ab.New
local ad=ab.Tween

local function Color3ToHSB(ae)
local af,ag,ah=ae.R,ae.G,ae.B
local ai=math.max(af,ag,ah)
local aj=math.min(af,ag,ah)
local ak=ai-aj

local al=0
if ak~=0 then
if ai==af then
al=(ag-ah)/ak%6
elseif ai==ag then
al=(ah-af)/ak+2
else
al=(af-ag)/ak+4
end
al=al*60
else
al=0
end

local am=(ai==0)and 0 or(ak/ai)
local an=ai

return{
h=math.floor(al+0.5),
s=am,
b=an
}
end

local function GetPerceivedBrightness(ae)
local af=ae.R
local ag=ae.G
local ah=ae.B
return 0.299*af+0.587*ag+0.114*ah
end

local function GetTextColorForHSB(ae)
local af=Color3ToHSB(ae)local
ag, ah, ai=af.h, af.s, af.b
if GetPerceivedBrightness(ae)>0.5 then
return Color3.fromHSV(ag/360,0,0.05)
else
return Color3.fromHSV(ag/360,0,0.98)
end
end

local function GetAverageColor(ae)
local af,ag,ah=0,0,0
local ai=ae.Color.Keypoints
for aj,ak in ipairs(ai)do

af=af+ak.Value.R
ag=ag+ak.Value.G
ah=ah+ak.Value.B
end
local al=#ai
return Color3.new(af/al,ag/al,ah/al)
end


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
ai.ImageLabel.ImageColor3=typeof(ah.Color)=="Color3"and GetTextColorForHSB(ah.Color)or nil
end

local aj=ac("TextLabel",{
BackgroundTransparency=1,
AutomaticSize="XY",
TextSize=ah.TextSize,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
Text=ah.Title,
TextColor3=typeof(ah.Color)=="Color3"and GetTextColorForHSB(ah.Color)or nil,
})

local ak

if typeof(ah.Color)=="table"then

ak=ac"UIGradient"
for al,am in next,ah.Color do
ak[al]=am
end

aj.TextColor3=GetTextColorForHSB(GetAverageColor(ak))
if ai then
ai.ImageLabel.ImageColor3=GetTextColorForHSB(GetAverageColor(ak))
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
local ao=GetAverageColor(an)
ad(aj,.06,{TextColor3=GetTextColorForHSB(ao)}):Play()
local ap=al:FindFirstChildOfClass"UIGradient"or ac("UIGradient",{Parent=al})
for aq,ar in next,an do ap[aq]=ar end
ad(al,.06,{ImageColor3=Color3.new(1,1,1)}):Play()
else
if ak then
ak:Destroy()
end
ad(aj,.06,{TextColor3=GetTextColorForHSB(an)}):Play()
if ai then
ad(ai.ImageLabel,.06,{ImageColor3=GetTextColorForHSB(an)}):Play()
end
ad(al,.06,{ImageColor3=an}):Play()
end
end


return ah
end


return aa end function a.w()
local aa=game:GetService"HttpService"

local ab

local ac
ac={
Folder=nil,
Path=nil,
Configs={},
Parser={
Colorpicker={
Save=function(ad)
return{
__type=ad.__type,
value=ad.Default:ToHex(),
transparency=ad.Transparency or nil,
}
end,
Load=function(ad,ae)
if ad and ad.Update then
ad:Update(Color3.fromHex(ae.value),ae.transparency or nil)
end
end
},
Dropdown={
Save=function(ad)
return{
__type=ad.__type,
value=ad.Value,
}
end,
Load=function(ad,ae)
if ad and ad.Select then
ad:Select(ae.value)
end
end
},
Input={
Save=function(ad)
return{
__type=ad.__type,
value=ad.Value,
}
end,
Load=function(ad,ae)
if ad and ad.Set then
ad:Set(ae.value)
end
end
},
Keybind={
Save=function(ad)
return{
__type=ad.__type,
value=ad.Value,
}
end,
Load=function(ad,ae)
if ad and ad.Set then
ad:Set(ae.value)
end
end
},
Slider={
Save=function(ad)
return{
__type=ad.__type,
value=ad.Value.Default,
}
end,
Load=function(ad,ae)
if ad and ad.Set then
ad:Set(tonumber(ae.value))
end
end
},
Toggle={
Save=function(ad)
return{
__type=ad.__type,
value=ad.Value,
}
end,
Load=function(ad,ae)
if ad and ad.Set then
ad:Set(ae.value)
end
end
},
}
}

function ac.Init(ad,ae)
if not ae.Folder then
warn"[ WindUI.ConfigManager ] Window.Folder is not specified."
return false
end

ab=ae
ac.Folder=ab.Folder
ac.Path="WindUI/"..tostring(ac.Folder).."/config/"

if not isfolder("WindUI/"..ac.Folder)then
makefolder("WindUI/"..ac.Folder)
if not isfolder("WindUI/"..ac.Folder.."/config/")then
makefolder("WindUI/"..ac.Folder.."/config/")
end
end

local af=ac:AllConfigs()

for ag,ah in next,af do
if isfile and readfile and isfile(ah..".json")then
ac.Configs[ah]=readfile(ah..".json")
end
end

return ac
end

function ac.CreateConfig(ad,ae)
local af={
Path=ac.Path..ae..".json",
Elements={},
CustomData={},
Version=1.1
}

if not ae then
return false,"No config file is selected"
end

function af.SetAsCurrent(ag)
ab:SetCurrentConfig(af)
end

function af.Register(ag,ah,ai)
af.Elements[ah]=ai
end

function af.Set(ag,ah,ai)
af.CustomData[ah]=ai
end

function af.Get(ag,ah)
return af.CustomData[ah]
end

function af.Save(ag)
if ab.PendingFlags then
for ah,ai in next,ab.PendingFlags do
af:Register(ah,ai)
end
end

local ah={
__version=af.Version,
__elements={},
__custom=af.CustomData
}

for ai,aj in next,af.Elements do
if ac.Parser[aj.__type]then
ah.__elements[tostring(ai)]=ac.Parser[aj.__type].Save(aj)
end
end

local ak=aa:JSONEncode(ah)
if writefile then
writefile(af.Path,ak)
end

return ah
end

function af.Load(ag)
if isfile and not isfile(af.Path)then
return false,"Config file does not exist"
end

local ah,ai=pcall(function()
local ah=readfile or function()
warn"[ WindUI.ConfigManager ] The config system doesn't work in the studio."
return nil
end
return aa:JSONDecode(ah(af.Path))
end)

if not ah then
return false,"Failed to parse config file"
end

if not ai.__version then
local aj={
__version=af.Version,
__elements=ai,
__custom={}
}
ai=aj
end

if ab.PendingFlags then
for aj,ak in next,ab.PendingFlags do
af:Register(aj,ak)
end
end

for aj,ak in next,(ai.__elements or{})do
if af.Elements[aj]and ac.Parser[ak.__type]then
task.spawn(function()
ac.Parser[ak.__type].Load(af.Elements[aj],ak)
end)
end
end

af.CustomData=ai.__custom or{}

return af.CustomData
end

function af.Delete(ag)
if not delfile then
return false,"delfile function is not available"
end

if not isfile(af.Path)then
return false,"Config file does not exist"
end

local ah,ai=pcall(function()
delfile(af.Path)
end)

if not ah then
return false,"Failed to delete config file: "..tostring(ai)
end

ac.Configs[ae]=nil

if ab.CurrentConfig==af then
ab.CurrentConfig=nil
end

return true,"Config deleted successfully"
end

function af.GetData(ag)
return{
elements=af.Elements,
custom=af.CustomData
}
end

af:SetAsCurrent()
ac.Configs[ae]=af
return af
end

function ac.DeleteConfig(ad,ae)
if not delfile then
return false,"delfile function is not available"
end

local af=ac.Path..ae..".json"

if not isfile(af)then
return false,"Config file does not exist"
end

local ag,ah=pcall(function()
delfile(af)
end)

if not ag then
return false,"Failed to delete config file: "..tostring(ah)
end

ac.Configs[ae]=nil

if ab.CurrentConfig and ab.CurrentConfig.Path==af then
ab.CurrentConfig=nil
end

return true,"Config deleted successfully"
end

function ac.AllConfigs(ad)
if not listfiles then return{}end

local ae={}
if not isfolder(ac.Path)then
makefolder(ac.Path)
return ae
end

for af,ag in next,listfiles(ac.Path)do
local ah=ag:match"([^\\/]+)%.json$"
if ah then
table.insert(ae,ah)
end
end

return ae
end

function ac.GetConfig(ad,ae)
return ac.Configs[ae]
end

return ac end function a.x()
local aa={}

local ab=a.load'b'
local ac=ab.New
local ad=ab.Tween

game:GetService"UserInputService"


function aa.New(ae)
local af={
Button=nil
}

local ag













local ah=ac("TextLabel",{
Text=ae.Title,
TextSize=17,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
AutomaticSize="XY",
})

local ai=ac("Frame",{
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
local aj=ac("Frame",{
Size=UDim2.new(0,1,1,0),
Position=UDim2.new(0,36,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=.9,
})

local ak=ac("Frame",{
Size=UDim2.new(0,0,0,0),
Position=UDim2.new(0.5,0,0,28),
AnchorPoint=Vector2.new(0.5,0.5),
Parent=ae.Parent,
BackgroundTransparency=1,
Active=true,
Visible=false,
})
local al=ac("TextButton",{
Size=UDim2.new(0,0,0,44),
AutomaticSize="X",
Parent=ak,
Active=false,
BackgroundTransparency=.25,
ZIndex=99,
BackgroundColor3=Color3.new(0,0,0),
},{



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
ai,
aj,

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
ag,
ac("UIListLayout",{
Padding=UDim.new(0,ae.UIPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ah,
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

af.Button=al



function af.SetIcon(am,an)
if ag then
ag:Destroy()
end
if an then
ag=ab.Image(
an,
ae.Title,
0,
ae.Folder,
"OpenButton",
true,
ae.IconThemed
)
ag.Size=UDim2.new(0,22,0,22)
ag.LayoutOrder=-1
ag.Parent=af.Button.TextButton
end
end

if ae.Icon then
af:SetIcon(ae.Icon)
end



ab.AddSignal(al:GetPropertyChangedSignal"AbsoluteSize",function()
ak.Size=UDim2.new(
0,al.AbsoluteSize.X,
0,al.AbsoluteSize.Y
)
end)

ab.AddSignal(al.TextButton.MouseEnter,function()
ad(al.TextButton,.1,{BackgroundTransparency=.93}):Play()
end)
ab.AddSignal(al.TextButton.MouseLeave,function()
ad(al.TextButton,.1,{BackgroundTransparency=1}):Play()
end)

local am=ab.Drag(ak)


function af.Visible(an,ao)
ak.Visible=ao
end

function af.Edit(an,ao)
local ap={
Title=ao.Title,
Icon=ao.Icon,
Enabled=ao.Enabled,
Position=ao.Position,
OnlyIcon=ao.OnlyIcon or false,
Draggable=ao.Draggable or nil,
OnlyMobile=ao.OnlyMobile,
CornerRadius=ao.CornerRadius or UDim.new(1,0),
StrokeThickness=ao.StrokeThickness or 2,
Color=ao.Color
or ColorSequence.new(Color3.fromHex"40c9ff",Color3.fromHex"e81cff"),
}



if ap.Enabled==false then
ae.IsOpenButtonEnabled=false
end

if ap.OnlyMobile~=false then
ap.OnlyMobile=true
else
ae.IsPC=false
end


if ap.Draggable==false and ai and aj then
ai.Visible=ap.Draggable
aj.Visible=ap.Draggable

if am then
am:Set(ap.Draggable)
end
end

if ap.Position and ak then
ak.Position=ap.Position
end

if ap.OnlyIcon==true and ah then
ah.Visible=false
al.TextButton.UIPadding.PaddingLeft=UDim.new(0,7)
al.TextButton.UIPadding.PaddingRight=UDim.new(0,7)
elseif ap.OnlyIcon==false then
ah.Visible=true
al.TextButton.UIPadding.PaddingLeft=UDim.new(0,11)
al.TextButton.UIPadding.PaddingRight=UDim.new(0,11)
end





if ah then
if ap.Title then
ah.Text=ap.Title
ab:ChangeTranslationKey(ah,ap.Title)
elseif ap.Title==nil then

end
end

if ap.Icon then
af:SetIcon(ap.Icon)
end

al.UIStroke.UIGradient.Color=ap.Color
if Glow then
Glow.UIGradient.Color=ap.Color
end

al.UICorner.CornerRadius=ap.CornerRadius
al.TextButton.UICorner.CornerRadius=UDim.new(ap.CornerRadius.Scale,ap.CornerRadius.Offset-4)
al.UIStroke.Thickness=ap.StrokeThickness
end

return af
end



return aa end function a.y()
local aa={}

local ab=a.load'b'
local ac=ab.New
local ad=ab.Tween


function aa.New(ae,af)
local ag={
Container=nil,
ToolTipSize=16,
}

local ah=ac("TextLabel",{
AutomaticSize="XY",
TextWrapped=true,
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
Text=ae,
TextSize=17,
TextTransparency=1,
ThemeTag={
TextColor3="Text",
}
})

local ai=ac("UIScale",{
Scale=.9
})

local aj=ac("Frame",{
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
Visible=false
},{
ac("ImageLabel",{
Size=UDim2.new(0,ag.ToolTipSize,0,ag.ToolTipSize/2),
BackgroundTransparency=1,
Rotation=180,
Image="rbxassetid://89524607682719",
ThemeTag={
ImageColor3="Accent",
},
},{
ac("ImageLabel",{
Size=UDim2.new(0,ag.ToolTipSize,0,ag.ToolTipSize/2),
BackgroundTransparency=1,
LayoutOrder=99,
ImageTransparency=.9,
Image="rbxassetid://89524607682719",
ThemeTag={
ImageColor3="Text",
},
}),
}),
}),
ab.NewRoundFrame(14,"Squircle",{
AutomaticSize="XY",
ThemeTag={
ImageColor3="Accent",
},
ImageTransparency=1,
Name="Background",
},{



ac("Frame",{
ThemeTag={
BackgroundColor3="Text",
},
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

ah,
ac("UIPadding",{
PaddingTop=UDim.new(0,12),
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
PaddingBottom=UDim.new(0,12),
}),
})
}),
ai,
ac("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
})
ag.Container=aj

function ag.Open(ak)
aj.Visible=true


ad(aj.Background,.2,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(ah,.2,{TextTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(ai,.18,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

function ag.Close(ak)

ad(aj.Background,.3,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(ah,.3,{TextTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(ai,.35,{Scale=.9},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

task.wait(.35)

aj.Visible=false
aj:Destroy()
end

return ag
end



return aa end function a.z()
local aa=a.load'b'
local ab=aa.New
local ac=aa.NewRoundFrame
local ad=aa.Tween

game:GetService"UserInputService"


local function Color3ToHSB(ae)
local af,ag,ah=ae.R,ae.G,ae.B
local ai=math.max(af,ag,ah)
local aj=math.min(af,ag,ah)
local ak=ai-aj

local al=0
if ak~=0 then
if ai==af then
al=(ag-ah)/ak%6
elseif ai==ag then
al=(ah-af)/ak+2
else
al=(af-ag)/ak+4
end
al=al*60
else
al=0
end

local am=(ai==0)and 0 or(ak/ai)
local an=ai

return{
h=math.floor(al+0.5),
s=am,
b=an
}
end

local function GetPerceivedBrightness(ae)
local af=ae.R
local ag=ae.G
local ah=ae.B
return 0.299*af+0.587*ag+0.114*ah
end

local function GetTextColorForHSB(ae)
local af=Color3ToHSB(ae)local
ag, ah, ai=af.h, af.s, af.b
if GetPerceivedBrightness(ae)>0.5 then
return Color3.fromHSV(ag/360,0,0.05)
else
return Color3.fromHSV(ag/360,0,0.98)
end
end


local function getElementPosition(ae,af)
if type(af)~="number"or af~=math.floor(af)then
return nil,1
end






local ag=#ae


if ag==0 or af<1 or af>ag then
return nil,2
end

local function isDelimiter(ah)
if ah==nil then return true end
local ai=ah.__type
return ai=="Divider"or ai=="Space"or ai=="Section"or ai=="Code"
end

if isDelimiter(ae[af])then
return nil,3
end

local function calculate(ah,ai)
if ai==1 then return"Squircle"end
if ah==1 then return"Squircle-TL-TR"end
if ah==ai then return"Squircle-BL-BR"end
return"Square"
end

local ah=1
local ai=0

for aj=1,ag do
local ak=ae[aj]
if isDelimiter(ak)then
if af>=ah and af<=aj-1 then
local al=af-ah+1
return calculate(al,ai)
end
ah=aj+1
ai=0
else
ai=ai+1
end
end


if af>=ah and af<=ag then
local aj=af-ah+1
return calculate(aj,ai)
end

return nil,4
end


return function(ae)
local af={
Title=ae.Title,
Desc=ae.Desc or nil,
Hover=ae.Hover,
Thumbnail=ae.Thumbnail,
ThumbnailSize=ae.ThumbnailSize or 80,
Image=ae.Image,
IconThemed=ae.IconThemed or false,
ImageSize=ae.ImageSize or 30,
Color=ae.Color,
Scalable=ae.Scalable,
Parent=ae.Parent,
Justify=ae.Justify or"Between",
UIPadding=ae.Window.ElementConfig.UIPadding,
UICorner=ae.Window.ElementConfig.UICorner,
UIElements={},

Index=ae.Index
}

local ag=af.ImageSize
local ah=af.ThumbnailSize
local ai=true


local aj=0

local ak
local al
if af.Thumbnail then
ak=aa.Image(
af.Thumbnail,
af.Title,
ae.Window.NewElements and af.UICorner-11 or(af.UICorner-4),
ae.Window.Folder,
"Thumbnail",
false,
af.IconThemed
)
ak.Size=UDim2.new(1,0,0,ah)
end
if af.Image then
al=aa.Image(
af.Image,
af.Title,
ae.Window.NewElements and af.UICorner-11 or(af.UICorner-4),
ae.Window.Folder,
"Image",
af.IconThemed,
not af.Color and true or false,
"ElementIcon"
)
if typeof(af.Color)=="string"then
al.ImageLabel.ImageColor3=GetTextColorForHSB(Color3.fromHex(aa.Colors[af.Color]))
elseif typeof(af.Color)=="Color3"then
al.ImageLabel.ImageColor3=GetTextColorForHSB(af.Color)
end

al.Size=UDim2.new(0,ag,0,ag)

aj=ag
end

local function CreateText(am,an)
local ao=typeof(af.Color)=="string"
and GetTextColorForHSB(Color3.fromHex(aa.Colors[af.Color]))
or typeof(af.Color)=="Color3"
and GetTextColorForHSB(af.Color)

return ab("TextLabel",{
BackgroundTransparency=1,
Text=am or"",
TextSize=an=="Desc"and 15 or 17,
TextXAlignment="Left",
ThemeTag={
TextColor3=not af.Color and("Element"..an)or nil,
},
TextColor3=af.Color and ao or nil,
TextTransparency=an=="Desc"and.3 or 0,
TextWrapped=true,
Size=UDim2.new(af.Justify=="Between"and 1 or 0,0,0,0),
AutomaticSize=af.Justify=="Between"and"Y"or"XY",
FontFace=Font.new(aa.Font,an=="Desc"and Enum.FontWeight.Medium or Enum.FontWeight.SemiBold)
})
end

local am=CreateText(af.Title,"Title")
local an=CreateText(af.Desc,"Desc")
if not af.Desc or af.Desc==""then
an.Visible=false
end

af.UIElements.Container=ab("Frame",{
Size=UDim2.new(1,0,1,0),
AutomaticSize="Y",
BackgroundTransparency=1,
},{
ab("UIListLayout",{
Padding=UDim.new(0,af.UIPadding),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment=af.Justify=="Between"and"Left"or"Center",
}),
ak,
ab("Frame",{
Size=UDim2.new(
af.Justify=="Between"and 1 or 0,
af.Justify=="Between"and-ae.TextOffset or 0,
0,
0
),
AutomaticSize=af.Justify=="Between"and"Y"or"XY",
BackgroundTransparency=1,
Name="TitleFrame",
},{
ab("UIListLayout",{
Padding=UDim.new(0,af.UIPadding),
FillDirection="Horizontal",
VerticalAlignment=ae.Window.NewElements and(af.Justify=="Between"and"Top"or"Center")or"Center",
HorizontalAlignment=af.Justify~="Between"and af.Justify or"Center",
}),
al,
ab("Frame",{
BackgroundTransparency=1,
AutomaticSize=af.Justify=="Between"and"Y"or"XY",
Size=UDim2.new(
af.Justify=="Between"and 1 or 0,
af.Justify=="Between"and(al and-aj-af.UIPadding or-aj)or 0,
1,
0
),
Name="TitleFrame",
},{
ab("UIPadding",{
PaddingTop=UDim.new(0,ae.Window.NewElements and af.UIPadding/2 or 0),
PaddingLeft=UDim.new(0,ae.Window.NewElements and af.UIPadding/2 or 0),
PaddingRight=UDim.new(0,ae.Window.NewElements and af.UIPadding/2 or 0),
PaddingBottom=UDim.new(0,ae.Window.NewElements and af.UIPadding/2 or 0),
}),
ab("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
am,
an
}),
})
})






local ao=aa.Image(
"lock",
"lock",
0,
ae.Window.Folder,
"Lock",
false
)
ao.Size=UDim2.new(0,20,0,20)
ao.ImageLabel.ImageColor3=Color3.new(1,1,1)
ao.ImageLabel.ImageTransparency=.4

local ap=ab("TextLabel",{
Text="Locked",
TextSize=18,
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
AutomaticSize="XY",
BackgroundTransparency=1,
TextColor3=Color3.new(1,1,1),
TextTransparency=.05,
})

local aq=ab("Frame",{
Size=UDim2.new(1,af.UIPadding*2,1,af.UIPadding*2),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ZIndex=9999999,
})

local ar,as=ac(af.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=.25,
ImageColor3=Color3.new(0,0,0),
Visible=false,
Active=false,
Parent=aq,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8)
}),
ao,ap
},nil,true)

local at,au=ac(af.UICorner,"Squircle-Outline",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=aq,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8)
}),
},nil,true)

local av,aw=ac(af.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=aq,
},{
ab("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8)
}),
},nil,true)

local ax,ay=ac(af.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ImageTransparency=af.Color and.05 or.93,



Parent=ae.Parent,
ThemeTag={
ImageColor3=not af.Color and"ElementBackground"or nil
},
ImageColor3=af.Color and
(
typeof(af.Color)=="string"
and Color3.fromHex(aa.Colors[af.Color])
or typeof(af.Color)=="Color3"
and af.Color
)or nil
},{
af.UIElements.Container,
aq,
ab("UIPadding",{
PaddingTop=UDim.new(0,af.UIPadding),
PaddingLeft=UDim.new(0,af.UIPadding),
PaddingRight=UDim.new(0,af.UIPadding),
PaddingBottom=UDim.new(0,af.UIPadding),
}),
},true,true)

af.UIElements.Main=ax
af.UIElements.Locked=ar

if af.Hover then
aa.AddSignal(ax.MouseEnter,function()
if ai then
ad(ax,.05,{ImageTransparency=af.Color and.15 or.9}):Play()
end
end)
aa.AddSignal(ax.InputEnded,function()
if ai then
ad(ax,.05,{ImageTransparency=af.Color and.05 or.93}):Play()
end
end)
end

function af.SetTitle(az,aA)
af.Title=aA
am.Text=aA
end

function af.SetDesc(az,aA)
af.Desc=aA
an.Text=aA or""
if not aA then
an.Visible=false
elseif not an.Visible then
an.Visible=true
end
end


function af.Colorize(az,aA,aB)
if af.Color then
aA[aB]=typeof(af.Color)=="string"
and GetTextColorForHSB(Color3.fromHex(aa.Colors[af.Color]))
or typeof(af.Color)=="Color3"
and GetTextColorForHSB(af.Color)
or nil
end
end

if ae.ElementTable then
aa.AddSignal(am:GetPropertyChangedSignal"Text",function()
if af.Title~=am.Text then
af:SetTitle(am.Text)
ae.ElementTable.Title=am.Text
end
end)
aa.AddSignal(an:GetPropertyChangedSignal"Text",function()
if af.Desc~=an.Text then
af:SetDesc(an.Text)
ae.ElementTable.Desc=an.Text
end
end)
end





function af.SetThumbnail(az,aA,aB)
af.Thumbnail=aA
if aB then
af.ThumbnailSize=aB
ah=aB
end

if ak then
if aA then
ak:Destroy()
ak=aa.Image(
aA,
af.Title,
af.UICorner-3,
ae.Window.Folder,
"Thumbnail",
false,
af.IconThemed
)
ak.Size=UDim2.new(1,0,0,ah)
ak.Parent=af.UIElements.Container
local aC=af.UIElements.Container:FindFirstChild"UIListLayout"
if aC then
ak.LayoutOrder=-1
end
else
ak.Visible=false
end
else
if aA then
ak=aa.Image(
aA,
af.Title,
af.UICorner-3,
ae.Window.Folder,
"Thumbnail",
false,
af.IconThemed
)
ak.Size=UDim2.new(1,0,0,ah)
ak.Parent=af.UIElements.Container
local aC=af.UIElements.Container:FindFirstChild"UIListLayout"
if aC then
ak.LayoutOrder=-1
end
end
end
end

function af.SetImage(az,aA,aB)
af.Image=aA
if aB then
af.ImageSize=aB
ag=aB
end

if aA then
al=aa.Image(
aA,
af.Title,
af.UICorner-3,
ae.Window.Folder,
"Image",
not af.Color and true or false
)

if typeof(af.Color)=="string"then
al.ImageLabel.ImageColor3=GetTextColorForHSB(Color3.fromHex(aa.Colors[af.Color]))
elseif typeof(af.Color)=="Color3"then
al.ImageLabel.ImageColor3=GetTextColorForHSB(af.Color)
end

al.Visible=true

al.Size=UDim2.new(0,ag,0,ag)
aj=ag

else
if al then
al.Visible=true
end
aj=0
end

af.UIElements.Container.TitleFrame.TitleFrame.Size=UDim2.new(1,-aj,1,0)
end

function af.Destroy(az)
ax:Destroy()
end


function af.Lock(az)
ai=false
ar.Active=true
ar.Visible=true
end

function af.Unlock(az)
ai=true
ar.Active=false
ar.Visible=false
end

function af.Highlight(az)
local aA=ab("UIGradient",{
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
Parent=at
})

local aB=ab("UIGradient",{
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
Parent=av
})

at.ImageTransparency=0.25
av.ImageTransparency=0.88

ad(aA,0.75,{
Offset=Vector2.new(1,0)
}):Play()

ad(aB,0.75,{
Offset=Vector2.new(1,0)
}):Play()


task.spawn(function()
task.wait(.75)
at.ImageTransparency=1
av.ImageTransparency=1
aA:Destroy()
aB:Destroy()
end)
end


function af.UpdateShape(az)
if ae.Window.NewElements then
local aA=getElementPosition(az.Elements,af.Index)
if aA and ax then
ay:SetType(aA)
as:SetType(aA)
aw:SetType(aA)
au:SetType(aA.."-Outline")
end
end
end





return af
end end function a.A()
local aa=a.load'b'
local ab=aa.New

local ac={}

local ad=a.load'j'.New

function ac.New(ae,af)
af.Hover=false
af.TextOffset=0
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


function aa.New(ae,af,ag,ah)
local ai={}


local aj=13
local ak
if af and af~=""then
ak=ac("ImageLabel",{
Size=UDim2.new(1,-7,1,-7),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Image=ab.Icon(af)[1],
ImageRectOffset=ab.Icon(af)[2].ImageRectPosition,
ImageRectSize=ab.Icon(af)[2].ImageRectSize,
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
})
end

local al=ab.NewRoundFrame(aj,"Squircle",{
ImageTransparency=.93,
ThemeTag={
ImageColor3="Text"
},
Parent=ag,
Size=UDim2.new(0,41.6,0,26),
},{
ab.NewRoundFrame(aj,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Layer",
ThemeTag={
ImageColor3="Button",
},
ImageTransparency=1,
}),
ab.NewRoundFrame(aj,"SquircleOutline",{
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


ab.NewRoundFrame(aj,"Squircle",{
Size=UDim2.new(0,18,0,18),
Position=UDim2.new(0,3,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
ImageTransparency=0,
ImageColor3=Color3.new(1,1,1),



Name="Frame",
},{
ak,
})
})


function ai.Set(am,an,ao)
if an then
ad(al.Frame,0.15,{
Position=UDim2.new(1,-22,0.5,0),

},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(al.Layer,0.1,{
ImageTransparency=0,
}):Play()
ad(al.Stroke,0.1,{
ImageTransparency=0.95,
}):Play()

if ak then
ad(ak,0.1,{
ImageTransparency=0,
}):Play()
end
else
ad(al.Frame,0.15,{
Position=UDim2.new(0,4,0.5,0),
Size=UDim2.new(0,18,0,18),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ad(al.Layer,0.1,{
ImageTransparency=1,
}):Play()
ad(al.Stroke,0.1,{
ImageTransparency=1,
}):Play()

if ak then
ad(ak,0.1,{
ImageTransparency=1,
}):Play()
end
end

if ao~=false then ao=true end

task.spawn(function()
if ah and ao then
ab.SafeCallback(ah,an)
end
end)


end

return al,ai
end


return aa end function a.D()
local aa={}

local ab=a.load'b'
local ac=ab.New
local ad=ab.Tween


function aa.New(ae,af,ag,ah)
local ai={}

af=af or"check"

local aj=10
local ak=ac("ImageLabel",{
Size=UDim2.new(1,-10,1,-10),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Image=ab.Icon(af)[1],
ImageRectOffset=ab.Icon(af)[2].ImageRectPosition,
ImageRectSize=ab.Icon(af)[2].ImageRectSize,
ImageTransparency=1,
ImageColor3=Color3.new(1,1,1),
})

local al=ab.NewRoundFrame(aj,"Squircle",{
ImageTransparency=.95,
ThemeTag={
ImageColor3="Text"
},
Parent=ag,
Size=UDim2.new(0,27,0,27),
},{
ab.NewRoundFrame(aj,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Layer",
ThemeTag={
ImageColor3="Button",
},
ImageTransparency=1,
}),
ab.NewRoundFrame(aj,"SquircleOutline",{
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

ak,
})

function ai.Set(am,an)
if an then
ad(al.Layer,0.06,{
ImageTransparency=0,
}):Play()
ad(al.Stroke,0.06,{
ImageTransparency=0.95,
}):Play()
ad(ak,0.06,{
ImageTransparency=0,
}):Play()
else
ad(al.Layer,0.05,{
ImageTransparency=1,
}):Play()
ad(al.Stroke,0.05,{
ImageTransparency=1,
}):Play()
ad(ak,0.06,{
ImageTransparency=1,
}):Play()
end

task.spawn(function()
if ah then
ab.SafeCallback(ah,an)
end
end)
end

return al,ai
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
Type=ah.Type or"Toggle",
Callback=ah.Callback or function()end,
UIElements={}
}
ai.ToggleFrame=a.load'z'{
Title=ai.Title,
Desc=ai.Desc,




Window=ah.Window,
Parent=ah.Parent,
TextOffset=44,
Hover=false,
Tab=ah.Tab,
Index=ah.Index,
ElementTable=ai,
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
al,am=ad(ak,ai.Icon,ai.ToggleFrame.UIElements.Main,ai.Callback)
elseif ai.Type=="Checkbox"then
al,am=ae(ak,ai.Icon,ai.ToggleFrame.UIElements.Main,ai.Callback)
else
error("Unknown Toggle Type: "..tostring(ai.Type))
end

al.AnchorPoint=Vector2.new(1,ah.Window.NewElements and 0 or 0.5)
al.Position=UDim2.new(1,0,ah.Window.NewElements and 0 or 0.5,0)

function ai.Set(an,ao,ap)
if aj then
am:Set(ao,ap)
ak=ao
ai.Value=ao
end
end

ai:Set(ak,false)

aa.AddSignal(ai.ToggleFrame.UIElements.Main.MouseButton1Click,function()
ai:Set(not ak)
end)

return ai.__type,ai
end

return af end function a.F()
local aa=a.load'b'
local ac=aa.New
local ad=aa.Tween

local ae={}

local af=false

function ae.New(ag,ah)
local ai={
__type="Slider",
Title=ah.Title or"Slider",
Desc=ah.Desc or nil,
Locked=ah.Locked or nil,
Value=ah.Value or{},
Step=ah.Step or 1,
Callback=ah.Callback or function()end,
UIElements={},
IsFocusing=false,

Width=130,
TextBoxWidth=30,
ThumbSize=13,
}
local aj
local ak
local al
local am=ai.Value.Default or ai.Value.Min or 0

local an=am
local ao=(am-(ai.Value.Min or 0))/((ai.Value.Max or 100)-(ai.Value.Min or 0))

local ap=true
local aq=ai.Step%1~=0

local function FormatValue(ar)
if aq then
return string.format("%.2f",ar)
else
return tostring(math.floor(ar+0.5))
end
end

local function CalculateValue(ar)
if aq then
return math.floor(ar/ai.Step+0.5)*ai.Step
else
return math.floor(ar/ai.Step+0.5)*ai.Step
end
end

ai.SliderFrame=a.load'z'{
Title=ai.Title,
Desc=ai.Desc,
Parent=ah.Parent,
TextOffset=ai.Width,
Hover=false,
Tab=ah.Tab,
Index=ah.Index,
Window=ah.Window,
ElementTable=ai,
}

ai.UIElements.SliderIcon=aa.NewRoundFrame(99,"Squircle",{
ImageTransparency=.95,
Size=UDim2.new(1,-ai.TextBoxWidth-8,0,4),
Name="Frame",
ThemeTag={
ImageColor3="Text",
},
},{
aa.NewRoundFrame(99,"Squircle",{
Name="Frame",
Size=UDim2.new(ao,0,1,0),
ImageTransparency=.1,
ThemeTag={
ImageColor3="Button",
},
},{
aa.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,ai.ThumbSize,0,ai.ThumbSize),
Position=UDim2.new(1,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="Text",
},
Name="Thumb",
})
})
})

ai.UIElements.SliderContainer=ac("Frame",{
Size=UDim2.new(0,ai.Width,0,0),
AutomaticSize="Y",
Position=UDim2.new(1,ah.Window.NewElements and-12 or 0,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Parent=ai.SliderFrame.UIElements.Main,
},{
ac("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ai.UIElements.SliderIcon,
ac("TextBox",{
Size=UDim2.new(0,ai.TextBoxWidth,0,0),
TextXAlignment="Left",
Text=FormatValue(am),
ThemeTag={
TextColor3="Text"
},
TextTransparency=.4,
AutomaticSize="Y",
TextSize=15,
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
LayoutOrder=-1,
})
})

function ai.Lock(ar)
ai.Locked=true
ap=false
return ai.SliderFrame:Lock()
end
function ai.Unlock(ar)
ai.Locked=false
ap=true
return ai.SliderFrame:Unlock()
end

if ai.Locked then
ai:Lock()
end

local ar=ai.SliderFrame.Parent:IsA"ScrollingFrame"and ai.SliderFrame.Parent or ai.SliderFrame.Parent.Parent.Parent

function ai.Set(as,at,au)
if ap then
if not ai.IsFocusing and not af and(not au or(au.UserInputType==Enum.UserInputType.MouseButton1 or au.UserInputType==Enum.UserInputType.Touch))then
at=math.clamp(at,ai.Value.Min or 0,ai.Value.Max or 100)

local av=math.clamp((at-(ai.Value.Min or 0))/((ai.Value.Max or 100)-(ai.Value.Min or 0)),0,1)
at=CalculateValue(ai.Value.Min+av*(ai.Value.Max-ai.Value.Min))

if at~=an then
ad(ai.UIElements.SliderIcon.Frame,0.05,{Size=UDim2.new(av,0,1,0)}):Play()
ai.UIElements.SliderContainer.TextBox.Text=FormatValue(at)
ai.Value.Default=FormatValue(at)
an=at
aa.SafeCallback(ai.Callback,FormatValue(at))
end

if au then
aj=(au.UserInputType==Enum.UserInputType.Touch)
ar.ScrollingEnabled=false
af=true
ak=game:GetService"RunService".RenderStepped:Connect(function()
local aw=aj and au.Position.X or game:GetService"UserInputService":GetMouseLocation().X
local ax=math.clamp((aw-ai.UIElements.SliderIcon.AbsolutePosition.X)/ai.UIElements.SliderIcon.AbsoluteSize.X,0,1)
at=CalculateValue(ai.Value.Min+ax*(ai.Value.Max-ai.Value.Min))

if at~=an then
ad(ai.UIElements.SliderIcon.Frame,0.05,{Size=UDim2.new(ax,0,1,0)}):Play()
ai.UIElements.SliderContainer.TextBox.Text=FormatValue(at)
ai.Value.Default=FormatValue(at)
an=at
aa.SafeCallback(ai.Callback,FormatValue(at))
end
end)
al=game:GetService"UserInputService".InputEnded:Connect(function(aw)
if(aw.UserInputType==Enum.UserInputType.MouseButton1 or aw.UserInputType==Enum.UserInputType.Touch)and au==aw then
ak:Disconnect()
al:Disconnect()
af=false
ar.ScrollingEnabled=true

ad(ai.UIElements.SliderIcon.Frame.Thumb,.12,{Size=UDim2.new(0,ai.ThumbSize,0,ai.ThumbSize)},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
end
end)
end
end
end
end

function ai.SetMax(as,at)
ai.Value.Max=at

local au=tonumber(ai.Value.Default)or an
if au>at then
ai:Set(at)
else
local av=math.clamp((au-(ai.Value.Min or 0))/(at-(ai.Value.Min or 0)),0,1)
ad(ai.UIElements.SliderIcon.Frame,0.1,{Size=UDim2.new(av,0,1,0)}):Play()
end
end

function ai.SetMin(as,at)
ai.Value.Min=at

local au=tonumber(ai.Value.Default)or an
if au<at then
ai:Set(at)
else
local av=math.clamp((au-at)/((ai.Value.Max or 100)-at),0,1)
ad(ai.UIElements.SliderIcon.Frame,0.1,{Size=UDim2.new(av,0,1,0)}):Play()
end
end

aa.AddSignal(ai.UIElements.SliderContainer.TextBox.FocusLost,function(as)
if as then
local at=tonumber(ai.UIElements.SliderContainer.TextBox.Text)
if at then
ai:Set(at)
else
ai.UIElements.SliderContainer.TextBox.Text=FormatValue(an)
end
end
end)

aa.AddSignal(ai.UIElements.SliderContainer.InputBegan,function(as)
ai:Set(am,as)

if as.UserInputType==Enum.UserInputType.MouseButton1 or as.UserInputType==Enum.UserInputType.Touch then
ad(ai.UIElements.SliderIcon.Frame.Thumb,.12,{Size=UDim2.new(0,ai.ThumbSize+8,0,ai.ThumbSize+8)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end)

return ai.__type,ai
end

return ae end function a.G()
local aa=game:GetService"UserInputService"

local ac=a.load'b'
local ad=ac.New local ae=
ac.Tween

local af={
UICorner=6,
UIPadding=8,
}

local ag=a.load't'.New

function af.New(ah,ai)
local aj={
__type="Keybind",
Title=ai.Title or"Keybind",
Desc=ai.Desc or nil,
Locked=ai.Locked or false,
Value=ai.Value or"F",
Callback=ai.Callback or function()end,
CanChange=ai.CanChange or true,
Picking=false,
UIElements={},
}

local ak=true

aj.KeybindFrame=a.load'z'{
Title=aj.Title,
Desc=aj.Desc,
Parent=ai.Parent,
TextOffset=85,
Hover=aj.CanChange,
Tab=ai.Tab,
Index=ai.Index,
Window=ai.Window,
ElementTable=aj,
}

aj.UIElements.Keybind=ag(aj.Value,nil,aj.KeybindFrame.UIElements.Main)

aj.UIElements.Keybind.Size=UDim2.new(
0,24
+aj.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,
0,
42
)
aj.UIElements.Keybind.AnchorPoint=Vector2.new(1,0.5)
aj.UIElements.Keybind.Position=UDim2.new(1,0,0.5,0)

ad("UIScale",{
Parent=aj.UIElements.Keybind,
Scale=.85,
})

ac.AddSignal(aj.UIElements.Keybind.Frame.Frame.TextLabel:GetPropertyChangedSignal"TextBounds",function()
aj.UIElements.Keybind.Size=UDim2.new(
0,24
+aj.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,
0,
42
)
end)

function aj.Lock(al)
aj.Locked=true
ak=false
return aj.KeybindFrame:Lock()
end
function aj.Unlock(al)
aj.Locked=false
ak=true
return aj.KeybindFrame:Unlock()
end

function aj.Set(al,am)
aj.Value=am
aj.UIElements.Keybind.Frame.Frame.TextLabel.Text=am
end

if aj.Locked then
aj:Lock()
end

ac.AddSignal(aj.KeybindFrame.UIElements.Main.MouseButton1Click,function()
if ak then
if aj.CanChange then
aj.Picking=true
aj.UIElements.Keybind.Frame.Frame.TextLabel.Text="..."

task.wait(0.2)

local al
al=aa.InputBegan:Connect(function(am)
local an

if am.UserInputType==Enum.UserInputType.Keyboard then
an=am.KeyCode.Name
elseif am.UserInputType==Enum.UserInputType.MouseButton1 then
an="MouseLeft"
elseif am.UserInputType==Enum.UserInputType.MouseButton2 then
an="MouseRight"
end

local ao
ao=aa.InputEnded:Connect(function(ap)
if ap.KeyCode.Name==an or an=="MouseLeft"and ap.UserInputType==Enum.UserInputType.MouseButton1 or an=="MouseRight"and ap.UserInputType==Enum.UserInputType.MouseButton2 then
aj.Picking=false

aj.UIElements.Keybind.Frame.Frame.TextLabel.Text=an
aj.Value=an

al:Disconnect()
ao:Disconnect()
end
end)
end)
end
end
end)

ac.AddSignal(aa.InputBegan,function(al,am)
if aa:GetFocusedTextBox()then
return
end

if not ak then
return
end

if al.UserInputType==Enum.UserInputType.Keyboard then
if al.KeyCode.Name==aj.Value then
ac.SafeCallback(aj.Callback,al.KeyCode.Name)
end
elseif al.UserInputType==Enum.UserInputType.MouseButton1 and aj.Value=="MouseLeft"then
ac.SafeCallback(aj.Callback,"MouseLeft")
elseif al.UserInputType==Enum.UserInputType.MouseButton2 and aj.Value=="MouseRight"then
ac.SafeCallback(aj.Callback,"MouseRight")
end
end)

return aj.__type,aj
end

return af end function a.H()
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
Size=UDim2.new(1,0,0,1),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=.9,
ThemeTag={
BackgroundColor3="Text"
}
})
local ai=ac("Frame",{
Parent=ag.Parent,
Size=UDim2.new(1,-7,0,7),
BackgroundTransparency=1,
},{
ah
})

return"Divider",{__type="Divider",ElementFrame=ai}
end

return ae end function a.J()
local aa={}

local ac=game:GetService"UserInputService"
local ae=game:GetService"Players".LocalPlayer:GetMouse()
local af=game:GetService"Workspace".CurrentCamera

local ag=workspace.CurrentCamera

local ah=a.load'k'.New


local ai=a.load'b'
local aj=ai.New
local ak=ai.Tween

function aa.New(al,am,an,ao,ap)
local aq={}

if not am.Callback then
ap="Menu"
end

am.UIElements.UIListLayout=aj("UIListLayout",{
Padding=UDim.new(0,an.MenuPadding/1.5),
FillDirection="Vertical",
HorizontalAlignment="Center",
})

am.UIElements.Menu=ai.NewRoundFrame(an.MenuCorner,"Squircle",{
ThemeTag={
ImageColor3="Background",
},
ImageTransparency=1,
Size=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,0,0,0),
},{
aj("UIPadding",{
PaddingTop=UDim.new(0,an.MenuPadding),
PaddingLeft=UDim.new(0,an.MenuPadding),
PaddingRight=UDim.new(0,an.MenuPadding),
PaddingBottom=UDim.new(0,an.MenuPadding),
}),
aj("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,an.MenuPadding)
}),
aj("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,am.SearchBarEnabled and-an.MenuPadding-an.SearchBarHeight),

ClipsDescendants=true,
LayoutOrder=999,
},{
aj("UICorner",{
CornerRadius=UDim.new(0,an.MenuCorner-an.MenuPadding),
}),
aj("ScrollingFrame",{
Size=UDim2.new(1,0,1,0),
ScrollBarThickness=0,
ScrollingDirection="Y",
AutomaticCanvasSize="Y",
CanvasSize=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
ScrollBarImageTransparency=1,
},{
am.UIElements.UIListLayout,
})
})
})

am.UIElements.MenuCanvas=aj("Frame",{
Size=UDim2.new(0,am.MenuWidth,0,300),
BackgroundTransparency=1,
Position=UDim2.new(-10,0,-10,0),
Visible=false,
Active=false,

Parent=al.WindUI.DropdownGui,
AnchorPoint=Vector2.new(1,0),
},{
am.UIElements.Menu,






aj("UISizeConstraint",{
MinSize=Vector2.new(170,0),
MaxSize=Vector2.new(300,400),
})
})



local function RecalculateCanvasSize()
am.UIElements.Menu.Frame.ScrollingFrame.CanvasSize=UDim2.fromOffset(0,am.UIElements.UIListLayout.AbsoluteContentSize.Y)

end

local function RecalculateListSize()
local ar=ag.ViewportSize.Y*0.6

local as=am.UIElements.UIListLayout.AbsoluteContentSize.Y
local at=am.SearchBarEnabled and(an.SearchBarHeight+(an.MenuPadding*3))or(an.MenuPadding*2)
local au=(as)+at

if au>ar then
am.UIElements.MenuCanvas.Size=UDim2.fromOffset(
am.UIElements.MenuCanvas.AbsoluteSize.X,
ar
)
else
am.UIElements.MenuCanvas.Size=UDim2.fromOffset(
am.UIElements.MenuCanvas.AbsoluteSize.X,
au
)
end
end

function UpdatePosition()
local ar=am.UIElements.Dropdown or am.DropdownFrame.UIElements.Main
local as=am.UIElements.MenuCanvas

local at=af.ViewportSize.Y-(ar.AbsolutePosition.Y+ar.AbsoluteSize.Y)-an.MenuPadding-54
local au=as.AbsoluteSize.Y+an.MenuPadding

local av=-54
if at<au then
av=au-at-54
end

as.Position=UDim2.new(
0,
ar.AbsolutePosition.X+ar.AbsoluteSize.X,
0,
ar.AbsolutePosition.Y+ar.AbsoluteSize.Y-av+(an.MenuPadding*2)
)
end

local ar

function aq.Display(as)
local at=am.Values
local au=""

if am.Multi then
local av={}
if typeof(am.Value)=="table"then
for aw,ax in ipairs(am.Value)do
local ay=typeof(ax)=="table"and ax.Title or ax
av[ay]=true
end
end

for aw,ax in ipairs(at)do
local ay=typeof(ax)=="table"and ax.Title or ax
if av[ay]then
au=au..ay..", "
end
end

if#au>0 then
au=au:sub(1,#au-2)
end
else
au=typeof(am.Value)=="table"and am.Value.Title or am.Value or""
end

if am.UIElements.Dropdown then
am.UIElements.Dropdown.Frame.Frame.TextLabel.Text=(au==""and"--"or au)
end
end


local function Callback(as)
aq:Display()
if am.Callback then
task.spawn(function()
ai.SafeCallback(am.Callback,am.Value)
end)
else
task.spawn(function()
ai.SafeCallback(as)
end)
end
end


function aq.Refresh(as,at)
for au,av in next,am.UIElements.Menu.Frame.ScrollingFrame:GetChildren()do
if not av:IsA"UIListLayout"then
av:Destroy()
end
end

am.Tabs={}

if am.SearchBarEnabled then
if not ar then
ar=ah("Search...","search",am.UIElements.Menu,nil,function(aw)
for ax,ay in next,am.Tabs do
if string.find(string.lower(ay.Name),string.lower(aw),1,true)then
ay.UIElements.TabItem.Visible=true
else
ay.UIElements.TabItem.Visible=false
end
RecalculateListSize()
RecalculateCanvasSize()
end
end,true)
ar.Size=UDim2.new(1,0,0,an.SearchBarHeight)
ar.Position=UDim2.new(0,0,0,0)
ar.Name="SearchBar"
end
end

for aw,ax in next,at do
if(ax.Type~="Divider")then

local ay={
Name=typeof(ax)=="table"and ax.Title or ax,
Desc=typeof(ax)=="table"and ax.Desc or nil,
Icon=typeof(ax)=="table"and ax.Icon or nil,
Original=ax,
Selected=false,
UIElements={},
}
local az
if ay.Icon then
az=ai.Image(
ay.Icon,
ay.Icon,
0,
al.Window.Folder,
"Dropdown",
true
)
az.Size=UDim2.new(0,an.TabIcon,0,an.TabIcon)
az.ImageLabel.ImageTransparency=ap=="Dropdown"and.2 or 0
ay.UIElements.TabIcon=az
end
ay.UIElements.TabItem=ai.NewRoundFrame(an.MenuCorner-an.MenuPadding,"Squircle",{
Size=UDim2.new(1,0,0,36),
AutomaticSize=ay.Desc and"Y",
ImageTransparency=1,
Parent=am.UIElements.Menu.Frame.ScrollingFrame,

ImageColor3=Color3.new(1,1,1),

},{
ai.NewRoundFrame(an.MenuCorner-an.MenuPadding,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
ImageTransparency=1,
Name="Highlight",
},{
aj("UIGradient",{
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
aj("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
aj("UIListLayout",{
Padding=UDim.new(0,an.TabPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
aj("UIPadding",{
PaddingTop=UDim.new(0,an.TabPadding),
PaddingLeft=UDim.new(0,an.TabPadding),
PaddingRight=UDim.new(0,an.TabPadding),
PaddingBottom=UDim.new(0,an.TabPadding),
}),
aj("UICorner",{
CornerRadius=UDim.new(0,an.MenuCorner-an.MenuPadding)
}),













az,
aj("Frame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Name="Title",
},{
aj("TextLabel",{
Text=ay.Name,
TextXAlignment="Left",
FontFace=Font.new(ai.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
BackgroundColor3="Text"
},
TextSize=15,
BackgroundTransparency=1,
TextTransparency=ap=="Dropdown"and.4 or.05,
LayoutOrder=999,
AutomaticSize="Y",

Size=UDim2.new(1,az and-an.TabPadding-an.TabIcon or 0,0,0),
}),
aj("TextLabel",{
Text=ay.Desc or"",
TextXAlignment="Left",
FontFace=Font.new(ai.Font,Enum.FontWeight.Regular),
ThemeTag={
TextColor3="Text",
BackgroundColor3="Text"
},
TextSize=15,
BackgroundTransparency=1,
TextTransparency=ap=="Dropdown"and.6 or.35,
LayoutOrder=999,
AutomaticSize="Y",

Size=UDim2.new(1,0,0,0),
Visible=ay.Desc and true or false,
Name="Desc",
}),
aj("UIListLayout",{
Padding=UDim.new(0,an.TabPadding/3),
FillDirection="Vertical",

}),
})
})
},true)

if am.Multi and typeof(am.Value)=="string"then
for aA,aB in next,am.Values do
if typeof(aB)=="table"then
if aB.Title==am.Value then am.Value={aB}end
else
if aB==am.Value then am.Value={am.Value}end
end
end


end

if am.Multi then
local aA=false
if typeof(am.Value)=="table"then
for aB,aC in ipairs(am.Value)do
local aD=typeof(aC)=="table"and aC.Title or aC
if aD==ay.Name then
aA=true
break
end
end
end
ay.Selected=aA
else
local aA=typeof(am.Value)=="table"and am.Value.Title or am.Value
ay.Selected=aA==ay.Name
end

if ay.Selected then
ay.UIElements.TabItem.ImageTransparency=.95
ay.UIElements.TabItem.Highlight.ImageTransparency=.75


ay.UIElements.TabItem.Frame.Title.TextLabel.TextTransparency=0
if ay.UIElements.TabIcon then
ay.UIElements.TabIcon.ImageLabel.ImageTransparency=0
end
end

am.Tabs[aw]=ay

aq:Display()



if ap=="Dropdown"then
ai.AddSignal(ay.UIElements.TabItem.MouseButton1Click,function()
if am.Multi then
if not ay.Selected then
ay.Selected=true
ak(ay.UIElements.TabItem,0.1,{ImageTransparency=.95}):Play()
ak(ay.UIElements.TabItem.Highlight,0.1,{ImageTransparency=.75}):Play()

ak(ay.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if ay.UIElements.TabIcon then
ak(ay.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
table.insert(am.Value,ay.Original)
else
if not am.AllowNone and#am.Value==1 then
return
end
ay.Selected=false
ak(ay.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()
ak(ay.UIElements.TabItem.Highlight,0.1,{ImageTransparency=1}):Play()

ak(ay.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=.4}):Play()
if ay.UIElements.TabIcon then
ak(ay.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=.2}):Play()
end

for aA,aB in next,am.Value do
if typeof(aB)=="table"and(aB.Title==ay.Name)or(aB==ay.Name)then
table.remove(am.Value,aA)
break
end
end
end
else
for aA,aB in next,am.Tabs do

ak(aB.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()
ak(aB.UIElements.TabItem.Highlight,0.1,{ImageTransparency=1}):Play()

ak(aB.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=.4}):Play()
if aB.UIElements.TabIcon then
ak(aB.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=.2}):Play()
end
aB.Selected=false
end
ay.Selected=true
ak(ay.UIElements.TabItem,0.1,{ImageTransparency=.95}):Play()
ak(ay.UIElements.TabItem.Highlight,0.1,{ImageTransparency=.75}):Play()

ak(ay.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if ay.UIElements.TabIcon then
ak(ay.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
am.Value=ay.Original
end
Callback()
end)
elseif ap=="Menu"then
ai.AddSignal(ay.UIElements.TabItem.MouseEnter,function()
ak(ay.UIElements.TabItem,0.08,{ImageTransparency=.95}):Play()
end)
ai.AddSignal(ay.UIElements.TabItem.InputEnded,function()
ak(ay.UIElements.TabItem,0.08,{ImageTransparency=1}):Play()
end)
ai.AddSignal(ay.UIElements.TabItem.MouseButton1Click,function()
Callback(ax.Callback or function()end)
end)
end

RecalculateCanvasSize()
RecalculateListSize()
else a.load'I'
:New{Parent=am.UIElements.Menu.Frame.ScrollingFrame}
end
end

local ay=am.MenuWidth or 0
if ay==0 then
for az,aA in next,am.Tabs do
if aA.UIElements.TabItem.Frame.UIListLayout then

local aB=aA.UIElements.TabItem.Frame.UIListLayout.AbsoluteContentSize.X
ay=math.max(ay,aB)
end
end
end

am.UIElements.MenuCanvas.Size=UDim2.new(0,ay+6+6+5+5+18+6+6,am.UIElements.MenuCanvas.Size.Y.Scale,am.UIElements.MenuCanvas.Size.Y.Offset)

Callback()

am.Values=at
end


aq:Refresh(am.Values)

function aq.Select(as,at)
if at then
am.Value=at
else
if am.Multi then
am.Value={}
else
am.Value=nil

end
end
aq:Refresh(am.Values)
end







RecalculateListSize()
RecalculateCanvasSize()

function aq.Open(as)
if ao then
am.UIElements.Menu.Visible=true
am.UIElements.MenuCanvas.Visible=true
am.UIElements.MenuCanvas.Active=true
am.UIElements.Menu.Size=UDim2.new(
1,0,
0,0
)
ak(am.UIElements.Menu,0.1,{
Size=UDim2.new(
1,0,
1,0
),
ImageTransparency=0.05
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(.1)
am.Opened=true
end)




UpdatePosition()
end
end
function aq.Close(as)
am.Opened=false

ak(am.UIElements.Menu,0.25,{
Size=UDim2.new(
1,0,
0,0
),
ImageTransparency=1,
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()


task.spawn(function()
task.wait(.1)
am.UIElements.Menu.Visible=false
end)

task.spawn(function()
task.wait(.25)
am.UIElements.MenuCanvas.Visible=false
am.UIElements.MenuCanvas.Active=false
end)
end

ai.AddSignal((am.UIElements.Dropdown and am.UIElements.Dropdown.MouseButton1Click or am.DropdownFrame.UIElements.Main.MouseButton1Click),function()
aq:Open()
end)

ai.AddSignal(ac.InputBegan,function(as)
if as.UserInputType==Enum.UserInputType.MouseButton1 or as.UserInputType==Enum.UserInputType.Touch then
local at=am.UIElements.MenuCanvas
local au,av=at.AbsolutePosition,at.AbsoluteSize

local aw=am.UIElements.Dropdown or am.DropdownFrame.UIElements.Main
local ax=aw.AbsolutePosition
local ay=aw.AbsoluteSize

local az=
ae.X>=ax.X and
ae.X<=ax.X+ay.X and
ae.Y>=ax.Y and
ae.Y<=ax.Y+ay.Y

local aA=
ae.X>=au.X and
ae.X<=au.X+av.X and
ae.Y>=au.Y and
ae.Y<=au.Y+av.Y

if al.Window.CanDropdown and am.Opened and not az and not aA then
aq:Close()
end
end
end)

ai.AddSignal(
am.UIElements.Dropdown and am.UIElements.Dropdown:GetPropertyChangedSignal"AbsolutePosition"or
am.DropdownFrame.UIElements.Main:GetPropertyChangedSignal"AbsolutePosition",
UpdatePosition
)


return aq
end


return aa end function a.K()
game:GetService"UserInputService"
game:GetService"Players".LocalPlayer:GetMouse()local aa=
game:GetService"Workspace".CurrentCamera

local ac=a.load'b'
local ae=ac.New local af=
ac.Tween

local ag=a.load't'.New local ah=a.load'k'
.New
local ai=a.load'J'.New local aj=

workspace.CurrentCamera

local ak={
UICorner=10,
UIPadding=12,
MenuCorner=15,
MenuPadding=5,
TabPadding=10,
SearchBarHeight=39,
TabIcon=18,
}

function ak.New(al,am)
local an={
__type="Dropdown",
Title=am.Title or"Dropdown",
Desc=am.Desc or nil,
Locked=am.Locked or false,
Values=am.Values or{},
MenuWidth=am.MenuWidth,
Value=am.Value,
AllowNone=am.AllowNone,
SearchBarEnabled=am.SearchBarEnabled or false,
Multi=am.Multi,
Callback=am.Callback or nil,

UIElements={},

Opened=false,
Tabs={},

Width=150,
}

if an.Multi and not an.Value then
an.Value={}
end

local ao=true

an.DropdownFrame=a.load'z'{
Title=an.Title,
Desc=an.Desc,
Parent=am.Parent,
TextOffset=an.Width,
Hover=not an.Callback and true or false,
Tab=am.Tab,
Index=am.Index,
Window=am.Window,
ElementTable=an,
}


if an.Callback then
an.UIElements.Dropdown=ag("",nil,an.DropdownFrame.UIElements.Main,nil,am.Window.NewElements and 12 or 10)

an.UIElements.Dropdown.Frame.Frame.TextLabel.TextTruncate="AtEnd"
an.UIElements.Dropdown.Frame.Frame.TextLabel.Size=UDim2.new(1,an.UIElements.Dropdown.Frame.Frame.TextLabel.Size.X.Offset-18-12-12,0,0)

an.UIElements.Dropdown.Size=UDim2.new(0,an.Width,0,36)
an.UIElements.Dropdown.Position=UDim2.new(1,0,am.Window.NewElements and 0 or 0.5,0)
an.UIElements.Dropdown.AnchorPoint=Vector2.new(1,am.Window.NewElements and 0 or 0.5)








end

an.DropdownMenu=ai(am,an,ak,ao,"Dropdown")


an.Display=an.DropdownMenu.Display
an.Refresh=an.DropdownMenu.Refresh
an.Select=an.DropdownMenu.Select
an.Open=an.DropdownMenu.Open
an.Close=an.DropdownMenu.Close

ae("ImageLabel",{
Image=ac.Icon"chevrons-up-down"[1],
ImageRectOffset=ac.Icon"chevrons-up-down"[2].ImageRectPosition,
ImageRectSize=ac.Icon"chevrons-up-down"[2].ImageRectSize,
Size=UDim2.new(0,18,0,18),
Position=UDim2.new(
1,
an.UIElements.Dropdown and-12 or 0,
0.5,
0
),
ThemeTag={
ImageColor3="Icon"
},
AnchorPoint=Vector2.new(1,0.5),
Parent=an.UIElements.Dropdown and an.UIElements.Dropdown.Frame or an.DropdownFrame.UIElements.Main
})



function an.Lock(ap)
an.Locked=true
ao=false
return an.DropdownFrame:Lock()
end
function an.Unlock(ap)
an.Locked=false
ao=true
return an.DropdownFrame:Unlock()
end

if an.Locked then
an:Lock()
end


return an.__type,an
end

return ak end function a.L()






local ac={}
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

local ag={
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

local function createKeywordSet(ai)
local aj={}
for ak,al in ipairs(ai)do
aj[al]=true
end
return aj
end

local ai=createKeywordSet(ae.lua)
local aj=createKeywordSet(ae.rbx)
local ak=createKeywordSet(ae.operators)

local function getHighlight(al,am)
local an=al[am]

if ag[an.."_color"]then
return ag[an.."_color"]
end

if tonumber(an)then
return ag.numbers
elseif an=="nil"then
return ag.null
elseif an:sub(1,2)=="--"then
return ag.comment
elseif ak[an]then
return ag.operator
elseif ai[an]then
return ag.lua
elseif aj[an]then
return ag.rbx
elseif an:sub(1,1)=="\""or an:sub(1,1)=="\'"then
return ag.str
elseif an=="true"or an=="false"then
return ag.boolean
end

if al[am+1]=="("then
if al[am-1]==":"then
return ag.self_call
end

return ag.call
end

if al[am-1]=="."then
if al[am-2]=="Enum"then
return ag.rbx
end

return ag.local_property
end
end

function ac.run(al)
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

return ac end function a.M()
local ac={}

local ae=a.load'b'
local ag=ae.New
local ai=ae.Tween

local aj=a.load'L'

function ac.New(ak,al,am,an,ao)
local ap={
Radius=12,
Padding=10
}

local aq=ag("TextLabel",{
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
ag("UIPadding",{
PaddingTop=UDim.new(0,ap.Padding+3),
PaddingLeft=UDim.new(0,ap.Padding+3),
PaddingRight=UDim.new(0,ap.Padding+3),
PaddingBottom=UDim.new(0,ap.Padding+3),
})
})
aq.Font="Code"

local ar=ag("ScrollingFrame",{
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

local as=ag("TextButton",{
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
ag("UIScale",{
Scale=1,
}),
ag("ImageLabel",{
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
ai(as.Button,.05,{ImageTransparency=.95}):Play()
ai(as.Button.UIScale,.05,{Scale=.9}):Play()
end)
ae.AddSignal(as.InputEnded,function()
ai(as.Button,.08,{ImageTransparency=1}):Play()
ai(as.Button.UIScale,.08,{Scale=1}):Play()
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
ag("Frame",{
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
ag("ImageLabel",{
Size=UDim2.new(0,18,0,18),
BackgroundTransparency=1,
Image="rbxassetid://132464694294269",



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=.2,
}),
ag("TextLabel",{
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
ag("UIPadding",{

PaddingLeft=UDim.new(0,ap.Padding+3),
PaddingRight=UDim.new(0,ap.Padding+3),

}),
ag("UIListLayout",{
Padding=UDim.new(0,ap.Padding),
FillDirection="Horizontal",
VerticalAlignment="Center",
})
}),
ar,
ag("UIListLayout",{
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


return ac end function a.N()
local ac=a.load'b'local ae=
ac.New


local ag=a.load'M'

local ai={}

function ai.New(aj,ak)
local al={
__type="Code",
Title=ak.Title,
Code=ak.Code,
OnCopy=ak.OnCopy,
}

local am=not al.Locked











local an=ag.New(al.Code,al.Title,ak.Parent,function()
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

return ai end function a.O()
local ac=a.load'b'
local ae=ac.New local ag=
ac.Tween

local ai=game:GetService"UserInputService"
game:GetService"TouchInputService"
local aj=game:GetService"RunService"
local ak=game:GetService"Players"

local al=aj.RenderStepped
local am=ak.LocalPlayer
local an=am:GetMouse()

local ao=a.load'j'.New
local ap=a.load'k'.New

local aq={
UICorner=8,
UIPadding=8
}

function aq.Colorpicker(ar,as,at,au)
local av={
__type="Colorpicker",
Title=as.Title,
Desc=as.Desc,
Default=as.Default,
Callback=as.Callback,
Transparency=as.Transparency,
UIElements=as.UIElements,

TextPadding=10,
}

function av.SetHSVFromRGB(aw,ax)
local ay,az,aA=Color3.toHSV(ax)
av.Hue=ay
av.Sat=az
av.Vib=aA
end

av:SetHSVFromRGB(av.Default)

local aw=a.load'l'.Init(at)
local ax=aw.Create()

av.ColorpickerFrame=ax

ax.UIElements.Main.Size=UDim2.new(1,0,0,0)



local ay,az,aA=av.Hue,av.Sat,av.Vib

av.UIElements.Title=ae("TextLabel",{
Text=av.Title,
TextSize=20,
FontFace=Font.new(ac.Font,Enum.FontWeight.SemiBold),
TextXAlignment="Left",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ThemeTag={
TextColor3="Text"
},
BackgroundTransparency=1,
Parent=ax.UIElements.Main
},{
ae("UIPadding",{
PaddingTop=UDim.new(0,av.TextPadding/2),
PaddingLeft=UDim.new(0,av.TextPadding/2),
PaddingRight=UDim.new(0,av.TextPadding/2),
PaddingBottom=UDim.new(0,av.TextPadding/2),
})
})





local aB=ae("Frame",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
Parent=HueDragHolder,
BackgroundColor3=av.Default
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

av.UIElements.SatVibMap=ae("ImageLabel",{
Size=UDim2.fromOffset(160,158),
Position=UDim2.fromOffset(0,40+av.TextPadding),
Image="rbxassetid://4155801252",
BackgroundColor3=Color3.fromHSV(ay,1,1),
BackgroundTransparency=0,
Parent=ax.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),
ac.NewRoundFrame(8,"SquircleOutline",{
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

aB,
})

av.UIElements.Inputs=ae("Frame",{
AutomaticSize="XY",
Size=UDim2.new(0,0,0,0),
Position=UDim2.fromOffset(av.Transparency and 240 or 210,40+av.TextPadding),
BackgroundTransparency=1,
Parent=ax.UIElements.Main
},{
ae("UIListLayout",{
Padding=UDim.new(0,4),
FillDirection="Vertical",
})
})





local aC=ae("Frame",{
BackgroundColor3=av.Default,
Size=UDim2.fromScale(1,1),
BackgroundTransparency=av.Transparency,
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
Position=UDim2.fromOffset(85,208+av.TextPadding),
Size=UDim2.fromOffset(75,24),
Parent=ax.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),
ac.NewRoundFrame(8,"SquircleOutline",{
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







aC,
})

local aD=ae("Frame",{
BackgroundColor3=av.Default,
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
Position=UDim2.fromOffset(0,208+av.TextPadding),
Size=UDim2.fromOffset(75,24),
Parent=ax.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(0,8),
}),







ac.NewRoundFrame(8,"SquircleOutline",{
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

local aE={}

for b=0,1,0.1 do
table.insert(aE,ColorSequenceKeypoint.new(b,Color3.fromHSV(b,1,1)))
end

local b=ae("UIGradient",{
Color=ColorSequence.new(aE),
Rotation=90,
})

local e=ae("Frame",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
})

local g=ae("Frame",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
Parent=e,


BackgroundColor3=av.Default
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

local h=ae("Frame",{
Size=UDim2.fromOffset(6,192),
Position=UDim2.fromOffset(180,40+av.TextPadding),
Parent=ax.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=UDim.new(1,0),
}),
b,
e,
})


function CreateNewInput(i,j)
local l=ap(i,nil,av.UIElements.Inputs)

ae("TextLabel",{
BackgroundTransparency=1,
TextTransparency=.4,
TextSize=17,
FontFace=Font.new(ac.Font,Enum.FontWeight.Regular),
AutomaticSize="XY",
ThemeTag={
TextColor3="Placeholder",
},
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-12,0.5,0),
Parent=l.Frame,
Text=i,
})

ae("UIScale",{
Parent=l,
Scale=.85,
})

l.Frame.Frame.TextBox.Text=j
l.Size=UDim2.new(0,150,0,42)

return l
end

local function ToRGB(i)
return{
R=math.floor(i.R*255),
G=math.floor(i.G*255),
B=math.floor(i.B*255)
}
end

local i=CreateNewInput("Hex","#"..av.Default:ToHex())

local j=CreateNewInput("Red",ToRGB(av.Default).R)
local l=CreateNewInput("Green",ToRGB(av.Default).G)
local m=CreateNewInput("Blue",ToRGB(av.Default).B)
local p
if av.Transparency then
p=CreateNewInput("Alpha",((1-av.Transparency)*100).."%")
end

local r=ae("Frame",{
Size=UDim2.new(1,0,0,40),
AutomaticSize="Y",
Position=UDim2.new(0,0,0,254+av.TextPadding),
BackgroundTransparency=1,
Parent=ax.UIElements.Main,
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
Callback=function()au(Color3.fromHSV(av.Hue,av.Sat,av.Vib),av.Transparency)end
}
}

for v,A in next,u do
local B=ao(A.Title,A.Icon,A.Callback,A.Variant,r,ax,false)
B.Size=UDim2.new(0.5,-3,0,40)
B.AutomaticSize="None"
end



local B,C,F
if av.Transparency then
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
Position=UDim2.fromOffset(210,40+av.TextPadding),
Parent=ax.UIElements.Main,
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

function av.Round(G,H,J)
if J==0 then
return math.floor(H)
end
H=tostring(H)
return H:find"%."and tonumber(H:sub(1,H:find"%."+J))or H
end


function av.Update(G,H,J)
if H then ay,az,aA=Color3.toHSV(H)else ay,az,aA=av.Hue,av.Sat,av.Vib end

av.UIElements.SatVibMap.BackgroundColor3=Color3.fromHSV(ay,1,1)
aB.Position=UDim2.new(az,0,1-aA,0)
aB.BackgroundColor3=Color3.fromHSV(ay,az,aA)
aD.BackgroundColor3=Color3.fromHSV(ay,az,aA)
g.BackgroundColor3=Color3.fromHSV(ay,1,1)
g.Position=UDim2.new(0.5,0,ay,0)

i.Frame.Frame.TextBox.Text="#"..Color3.fromHSV(ay,az,aA):ToHex()
j.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(ay,az,aA)).R
l.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(ay,az,aA)).G
m.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(ay,az,aA)).B

if J or av.Transparency then
aD.BackgroundTransparency=av.Transparency or J
F.BackgroundColor3=Color3.fromHSV(ay,az,aA)
C.BackgroundColor3=Color3.fromHSV(ay,az,aA)
C.BackgroundTransparency=av.Transparency or J
C.Position=UDim2.new(0.5,0,1-av.Transparency or J,0)
p.Frame.Frame.TextBox.Text=av:Round((1-av.Transparency or J)*100,0).."%"
end
end

av:Update(av.Default,av.Transparency)




local function GetRGB()
local G=Color3.fromHSV(av.Hue,av.Sat,av.Vib)
return{R=math.floor(G.r*255),G=math.floor(G.g*255),B=math.floor(G.b*255)}
end



local function clamp(G,H,J)
return math.clamp(tonumber(G)or 0,H,J)
end

ac.AddSignal(i.Frame.Frame.TextBox.FocusLost,function(G)
if G then
local H=i.Frame.Frame.TextBox.Text:gsub("#","")
local J,L=pcall(Color3.fromHex,H)
if J and typeof(L)=="Color3"then
av.Hue,av.Sat,av.Vib=Color3.toHSV(L)
av:Update()
av.Default=L
end
end
end)

local function updateColorFromInput(G,H)
ac.AddSignal(G.Frame.Frame.TextBox.FocusLost,function(J)
if J then
local L=G.Frame.Frame.TextBox
local M=GetRGB()
local N=clamp(L.Text,0,255)
L.Text=tostring(N)

M[H]=N
local O=Color3.fromRGB(M.R,M.G,M.B)
av.Hue,av.Sat,av.Vib=Color3.toHSV(O)
av:Update()
end
end)
end

updateColorFromInput(j,"R")
updateColorFromInput(l,"G")
updateColorFromInput(m,"B")

if av.Transparency then
ac.AddSignal(p.Frame.Frame.TextBox.FocusLost,function(G)
if G then
local H=p.Frame.Frame.TextBox
local J=clamp(H.Text,0,100)
H.Text=tostring(J)

av.Transparency=1-J*0.01
av:Update(nil,av.Transparency)
end
end)
end



local G=av.UIElements.SatVibMap
ac.AddSignal(G.InputBegan,function(H)
if H.UserInputType==Enum.UserInputType.MouseButton1 or H.UserInputType==Enum.UserInputType.Touch then
while ai:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local J=G.AbsolutePosition.X
local L=J+G.AbsoluteSize.X
local M=math.clamp(an.X,J,L)

local N=G.AbsolutePosition.Y
local O=N+G.AbsoluteSize.Y
local P=math.clamp(an.Y,N,O)

av.Sat=(M-J)/(L-J)
av.Vib=1-((P-N)/(O-N))
av:Update()

al:Wait()
end
end
end)

ac.AddSignal(h.InputBegan,function(H)
if H.UserInputType==Enum.UserInputType.MouseButton1 or H.UserInputType==Enum.UserInputType.Touch then
while ai:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local J=h.AbsolutePosition.Y
local L=J+h.AbsoluteSize.Y
local M=math.clamp(an.Y,J,L)

av.Hue=((M-J)/(L-J))
av:Update()

al:Wait()
end
end
end)

if av.Transparency then
ac.AddSignal(B.InputBegan,function(H)
if H.UserInputType==Enum.UserInputType.MouseButton1 or H.UserInputType==Enum.UserInputType.Touch then
while ai:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local J=B.AbsolutePosition.Y
local L=J+B.AbsoluteSize.Y
local M=math.clamp(an.Y,J,L)

av.Transparency=1-((M-J)/(L-J))
av:Update()

al:Wait()
end
end
end)
end

return av
end

function aq.New(ar,as)
local at={
__type="Colorpicker",
Title=as.Title or"Colorpicker",
Desc=as.Desc or nil,
Locked=as.Locked or false,
Default=as.Default or Color3.new(1,1,1),
Callback=as.Callback or function()end,

UIScale=as.UIScale,
Transparency=as.Transparency,
UIElements={}
}

local au=true

if as.Window.NewElements then aq.UICorner=14 end

at.ColorpickerFrame=a.load'z'{
Title=at.Title,
Desc=at.Desc,
Parent=as.Parent,
TextOffset=40,
Hover=false,
Tab=as.Tab,
Index=as.Index,
Window=as.Window,
ElementTable=at,
}

at.UIElements.Colorpicker=ac.NewRoundFrame(aq.UICorner,"Squircle",{
ImageTransparency=0,
Active=true,
ImageColor3=at.Default,
Parent=at.ColorpickerFrame.UIElements.Main,
Size=UDim2.new(0,30,0,30),
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,0,0,0),
ZIndex=2
},nil,true)


function at.Lock(av)
at.Locked=true
au=false
return at.ColorpickerFrame:Lock()
end
function at.Unlock(av)
at.Locked=false
au=true
return at.ColorpickerFrame:Unlock()
end

if at.Locked then
at:Lock()
end


function at.Update(av,aw,ax)
at.UIElements.Colorpicker.ImageTransparency=ax or 0
at.UIElements.Colorpicker.ImageColor3=aw
at.Default=aw
if ax then
at.Transparency=ax
end
end

function at.Set(av,aw,ax)
return at:Update(aw,ax)
end

ac.AddSignal(at.UIElements.Colorpicker.MouseButton1Click,function()
if au then
aq:Colorpicker(at,as.Window,function(av,aw)
at:Update(av,aw)
at.Default=av
at.Transparency=aw
ac.SafeCallback(at.Callback,av,aw)
end).ColorpickerFrame:Open()
end
end)

return at.__type,at
end

return aq end function a.P()
local ac=a.load'b'
local ae=ac.New
local ag=ac.Tween

local ai={}

function ai.New(aj,ak)
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
am=ac.Image(
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
Image=ac.Icon"chevron-down"[1],
ImageRectSize=ac.Icon"chevron-down"[2].ImageRectSize,
ImageRectOffset=ac.Icon"chevron-down"[2].ImageRectPosition,
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
FontFace=Font.new(ac.Font,al.FontWeight),


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


local ap=ac.NewRoundFrame(ak.Window.ElementConfig.UICorner,"Squircle",{
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
PaddingLeft=UDim.new(0,ak.Window.ElementConfig.UIPadding),
PaddingRight=UDim.new(0,ak.Window.ElementConfig.UIPadding),
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
ag(ap,0.33,{
Size=UDim2.new(1,0,0,al.HeaderSize+(ap.Content.AbsoluteSize.Y/ak.UIScale))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

ag(an.ImageLabel,0.1,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
function al.Close(ar)
if al.Expandable then
al.Opened=false
ag(ap,0.26,{
Size=UDim2.new(1,0,0,al.HeaderSize)
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ag(an.ImageLabel,0.1,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

ac.AddSignal(ap.Top.MouseButton1Click,function()
if al.Expandable then
if al.Opened then
al:Close()
else
al:Open()
end
end
end)

task.spawn(function()
task.wait(0.02)
if al.Expandable then








ap.Size=UDim2.new(1,0,0,al.HeaderSize)
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

return ai end function a.Q()
local ac=a.load'b'
local ae=ac.New

local ag={}

function ag.New(ai,aj)
local ak=ae("Frame",{
Parent=aj.Parent,
Size=UDim2.new(1,-7,0,7*(aj.Columns or 1)),
BackgroundTransparency=1,
})

return"Space",{__type="Space",ElementFrame=ak}
end

return ag end function a.R()
local ac=a.load'b'
local ae=ac.New

local ag={}

local function ParseAspectRatio(ai)
if type(ai)=="string"then
local aj,ak=ai:match"(%d+):(%d+)"
if aj and ak then
return tonumber(aj)/tonumber(ak)
end
elseif type(ai)=="number"then
return ai
end
return nil
end

function ag.New(ai,aj)
local ak={
__type="Image",
Image=aj.Image or"",
AspectRatio=aj.AspectRatio or"16:9",
Radius=aj.Radius or aj.Window.ElementConfig.UICorner,
}
local al=ac.Image(
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

return ag end function a.S()
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

},
Load=function(ac,ae,ag,ai,aj,ak,al,am,an)
for ao,ap in next,ag do
ac[ao]=function(aq,ar)
ar=ar or{}
ar.Tab=an or ac
ar.ParentTable=ac
ar.Index=#ac.Elements+1
ar.GlobalIndex=#ai.AllElements+1
ar.Parent=ae
ar.Window=ai
ar.WindUI=aj
ar.UIScale=am
ar.ElementsModule=al local

as, at=ap:New(ar)

if ar.Flag and typeof(ar.Flag)=="string"then
if ai.CurrentConfig then
ai.CurrentConfig:Register(ar.Flag,at)

if ai.PendingConfigData and ai.PendingConfigData[ar.Flag]then
local au=ai.PendingConfigData[ar.Flag]

local av=ai.ConfigManager
if av.Parser[au.__type]then
task.defer(function()
local aw,ax=pcall(function()
av.Parser[au.__type].Load(at,au)
end)

if aw then
ai.PendingConfigData[ar.Flag]=nil
else
warn("[ WindUI ] Failed to apply pending config for '"..ar.Flag.."': "..tostring(ax))
end
end)
end
end
else
ai.PendingFlags=ai.PendingFlags or{}
ai.PendingFlags[ar.Flag]=at
end
end

local au
for av,aw in pairs(at)do
if typeof(aw)=="table"and av:match"Frame$"then
au=aw
break
end
end

if au then
at.ElementFrame=au.UIElements.Main
function at.SetTitle(ax,ay)
au:SetTitle(ay)
end
function at.SetDesc(ax,ay)
au:SetDesc(ay)
end
function at.Highlight(ax)
au:Highlight()
end
function at.Destroy(ax)
au:Destroy()

table.remove(ai.AllElements,ar.GlobalIndex)
table.remove(ac.Elements,ar.Index)
table.remove(an.Elements,ar.Index)
ac:UpdateAllElementShapes(ac)
end
end



ai.AllElements[ar.Index]=at
ac.Elements[ar.Index]=at
if an then an.Elements[ar.Index]=at end

if ai.NewElements then
ac:UpdateAllElementShapes(ac)
end

if ak then
ak()
end
return at
end
end
function ac.UpdateAllElementShapes(aq,ar)
for as,at in next,ar.Elements do
local au
for av,aw in pairs(at)do
if typeof(aw)=="table"and av:match"Frame$"then
au=aw
break
end
end

if au then

au.Index=as
if au.UpdateShape then

au.UpdateShape(ar)
end
end
end
end
end,

}end function a.T()
game:GetService"UserInputService"
local ac=game.Players.LocalPlayer:GetMouse()

local ae=a.load'b'
local ag=ae.New
local ai=ae.Tween

local aj=a.load'y'.New
local ak=a.load'u'.New





local al={


Tabs={},
Containers={},
SelectedTab=nil,
TabCount=0,
ToolTipParent=nil,
TabHighlight=nil,

OnChangeFunc=function(al)end
}

function al.Init(am,an,ao,ap)
Window=am
WindUI=an
al.ToolTipParent=ao
al.TabHighlight=ap
return al
end

function al.New(am,an)
local ao={
__type="Tab",
Title=am.Title or"Tab",
Desc=am.Desc,
Icon=am.Icon,
IconThemed=am.IconThemed,
Locked=am.Locked,
ShowTabTitle=am.ShowTabTitle,
Selected=false,
Index=nil,
Parent=am.Parent,
UIElements={},
Elements={},
ContainerFrame=nil,
UICorner=Window.UICorner-(Window.UIPadding/2),

Gap=Window.NewElements and 1 or 6,
}

al.TabCount=al.TabCount+1

local ap=al.TabCount
ao.Index=ap

ao.UIElements.Main=ae.NewRoundFrame(ao.UICorner,"Squircle",{
BackgroundTransparency=1,
Size=UDim2.new(1,-7,0,0),
AutomaticSize="Y",
Parent=am.Parent,
ThemeTag={
ImageColor3="TabBackground",
},
ImageTransparency=1,
},{
ae.NewRoundFrame(ao.UICorner,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Outline"
},{
ag("UIGradient",{
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
ae.NewRoundFrame(ao.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Frame",
},{
ag("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ag("TextLabel",{
Text=ao.Title,
ThemeTag={
TextColor3="TabTitle"
},
TextTransparency=not ao.Locked and 0.4 or.7,
TextSize=15,
Size=UDim2.new(1,0,0,0),
FontFace=Font.new(ae.Font,Enum.FontWeight.Medium),
TextWrapped=true,
RichText=true,
AutomaticSize="Y",
LayoutOrder=2,
TextXAlignment="Left",
BackgroundTransparency=1,
}),
ag("UIPadding",{
PaddingTop=UDim.new(0,2+(Window.UIPadding/2)),
PaddingLeft=UDim.new(0,4+(Window.UIPadding/2)),
PaddingRight=UDim.new(0,4+(Window.UIPadding/2)),
PaddingBottom=UDim.new(0,2+(Window.UIPadding/2)),
})
}),
},true)

local aq=0
local ar
local as

if ao.Icon then
ar=ae.Image(
ao.Icon,
ao.Icon..":"..ao.Title,
0,
Window.Folder,
ao.__type,
true,
ao.IconThemed,
"TabIcon"
)
ar.Size=UDim2.new(0,16,0,16)
ar.Parent=ao.UIElements.Main.Frame
ar.ImageLabel.ImageTransparency=not ao.Locked and 0 or.7
ao.UIElements.Main.Frame.TextLabel.Size=UDim2.new(1,-30,0,0)
aq=-30

ao.UIElements.Icon=ar


as=ae.Image(
ao.Icon,
ao.Icon..":"..ao.Title,
0,
Window.Folder,
ao.__type,
true,
ao.IconThemed
)
as.Size=UDim2.new(0,16,0,16)
as.ImageLabel.ImageTransparency=not ao.Locked and 0 or.7
aq=-30




end

ao.UIElements.ContainerFrame=ag("ScrollingFrame",{
Size=UDim2.new(1,0,1,ao.ShowTabTitle and-((Window.UIPadding*2.4)+12)or 0),
BackgroundTransparency=1,
ScrollBarThickness=0,
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
AnchorPoint=Vector2.new(0,1),
Position=UDim2.new(0,0,1,0),
AutomaticCanvasSize="Y",

ScrollingDirection="Y",
},{
ag("UIPadding",{
PaddingTop=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingLeft=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingRight=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingBottom=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
}),
ag("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,ao.Gap),
HorizontalAlignment="Center",
})
})





ao.UIElements.ContainerFrameCanvas=ag("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Visible=false,
Parent=Window.UIElements.MainBar,
ZIndex=5,
},{
ao.UIElements.ContainerFrame,
ag("Frame",{
Size=UDim2.new(1,0,0,((Window.UIPadding*2.4)+12)),
BackgroundTransparency=1,
Visible=ao.ShowTabTitle or false,
Name="TabTitle"
},{
as,
ag("TextLabel",{
Text=ao.Title,
ThemeTag={
TextColor3="Text"
},
TextSize=20,
TextTransparency=.1,
Size=UDim2.new(1,-aq,1,0),
FontFace=Font.new(ae.Font,Enum.FontWeight.SemiBold),
TextTruncate="AtEnd",
RichText=true,
LayoutOrder=2,
TextXAlignment="Left",
BackgroundTransparency=1,
}),
ag("UIPadding",{
PaddingTop=UDim.new(0,20),
PaddingLeft=UDim.new(0,20),
PaddingRight=UDim.new(0,20),
PaddingBottom=UDim.new(0,20),
}),
ag("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
})
}),
ag("Frame",{
Size=UDim2.new(1,0,0,1),
BackgroundTransparency=.9,
ThemeTag={
BackgroundColor3="Text"
},
Position=UDim2.new(0,0,0,((Window.UIPadding*2.4)+12)),
Visible=ao.ShowTabTitle or false,
})
})

al.Containers[ap]=ao.UIElements.ContainerFrameCanvas
al.Tabs[ap]=ao

ao.ContainerFrame=ContainerFrameCanvas

ae.AddSignal(ao.UIElements.Main.MouseButton1Click,function()
if not ao.Locked then
al:SelectTab(ap)
end
end)

if Window.ScrollBarEnabled then
ak(ao.UIElements.ContainerFrame,ao.UIElements.ContainerFrameCanvas,Window,3)
end

local at
local au
local av
local aw=false



if ao.Desc then


ae.AddSignal(ao.UIElements.Main.InputBegan,function()
aw=true
au=task.spawn(function()
task.wait(0.35)
if aw and not at then
at=aj(ao.Desc,al.ToolTipParent)

local function updatePosition()
if at then
at.Container.Position=UDim2.new(0,ac.X,0,ac.Y-20)
end
end

updatePosition()
av=ac.Move:Connect(updatePosition)
at:Open()
end
end)
end)

end

ae.AddSignal(ao.UIElements.Main.MouseEnter,function()
if not ao.Locked then
ai(ao.UIElements.Main.Frame,0.08,{ImageTransparency=.97}):Play()
end
end)
ae.AddSignal(ao.UIElements.Main.InputEnded,function()
if ao.Desc then
aw=false
if au then
task.cancel(au)
au=nil
end
if av then
av:Disconnect()
av=nil
end
if at then
at:Close()
at=nil
end
end

if not ao.Locked then
ai(ao.UIElements.Main.Frame,0.08,{ImageTransparency=1}):Play()
end
end)



function ao.ScrollToTheElement(ax,ay)
ao.UIElements.ContainerFrame.ScrollingEnabled=false
ai(ao.UIElements.ContainerFrame,.45,
{
CanvasPosition=Vector2.new(
0,

ao.Elements[ay].ElementFrame.AbsolutePosition.Y
-ao.UIElements.ContainerFrame.AbsolutePosition.Y
-ao.UIElements.ContainerFrame.UIPadding.PaddingTop.Offset
)
},
Enum.EasingStyle.Quint,Enum.EasingDirection.Out
):Play()

task.spawn(function()
task.wait(.48)

if ao.Elements[ay].Highlight then
ao.Elements[ay]:Highlight()
ao.UIElements.ContainerFrame.ScrollingEnabled=true
end
end)

return ao
end





ao.ElementsModule=a.load'S'

ao.ElementsModule.Load(ao,ao.UIElements.ContainerFrame,ao.ElementsModule.Elements,Window,WindUI,nil,ao.ElementsModule,an)



function ao.LockAll(ax)

for ay,az in next,Window.AllElements do
if az.Tab and az.Tab.Index and az.Tab.Index==ao.Index and az.Lock then
az:Lock()
end
end
end
function ao.UnlockAll(ax)
for ay,az in next,Window.AllElements do
if az.Tab and az.Tab.Index and az.Tab.Index==ao.Index and az.Unlock then
az:Unlock()
end
end
end
function ao.GetLocked(ax)
local ay={}

for az,aA in next,Window.AllElements do
if aA.Tab and aA.Tab.Index and aA.Tab.Index==ao.Index and aA.Locked==true then
table.insert(ay,aA)
end
end

return ay
end
function ao.GetUnlocked(ax)
local ay={}

for az,aA in next,Window.AllElements do
if aA.Tab and aA.Tab.Index and aA.Tab.Index==ao.Index and aA.Locked==false then
table.insert(ay,aA)
end
end

return ay
end

function ao.Select(ax)
return al:SelectTab(ao.Index)
end

task.spawn(function()
local ax=ag("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,-Window.UIElements.Main.Main.Topbar.AbsoluteSize.Y),
Parent=ao.UIElements.ContainerFrame
},{
ag("UIListLayout",{
Padding=UDim.new(0,8),
SortOrder="LayoutOrder",
VerticalAlignment="Center",
HorizontalAlignment="Center",
FillDirection="Vertical",
}),
ag("ImageLabel",{
Size=UDim2.new(0,48,0,48),
Image=ae.Icon"frown"[1],
ImageRectOffset=ae.Icon"frown"[2].ImageRectPosition,
ImageRectSize=ae.Icon"frown"[2].ImageRectSize,
ThemeTag={
ImageColor3="Icon"
},
BackgroundTransparency=1,
ImageTransparency=.6,
}),
ag("TextLabel",{
AutomaticSize="XY",
Text="This tab is empty",
ThemeTag={
TextColor3="Text"
},
TextSize=18,
TextTransparency=.5,
BackgroundTransparency=1,
FontFace=Font.new(ae.Font,Enum.FontWeight.Medium),
})
})





local ay
ay=ae.AddSignal(ao.UIElements.ContainerFrame.ChildAdded,function()
ax.Visible=false
ay:Disconnect()
end)
end)

return ao
end

function al.OnChange(am,an)
al.OnChangeFunc=an
end

function al.SelectTab(am,an)
if not al.Tabs[an].Locked then
al.SelectedTab=an

for ao,ap in next,al.Tabs do
if not ap.Locked then
ai(ap.UIElements.Main,0.15,{ImageTransparency=1}):Play()
ai(ap.UIElements.Main.Outline,0.15,{ImageTransparency=1}):Play()
ai(ap.UIElements.Main.Frame.TextLabel,0.15,{TextTransparency=0.3}):Play()
if ap.UIElements.Icon then
ai(ap.UIElements.Icon.ImageLabel,0.15,{ImageTransparency=0.4}):Play()
end
ap.Selected=false
end
end
ai(al.Tabs[an].UIElements.Main,0.15,{ImageTransparency=0.95}):Play()
ai(al.Tabs[an].UIElements.Main.Outline,0.15,{ImageTransparency=0.85}):Play()
ai(al.Tabs[an].UIElements.Main.Frame.TextLabel,0.15,{TextTransparency=0}):Play()
if al.Tabs[an].UIElements.Icon then
ai(al.Tabs[an].UIElements.Icon.ImageLabel,0.15,{ImageTransparency=0.1}):Play()
end
al.Tabs[an].Selected=true


task.spawn(function()
for aq,ar in next,al.Containers do
ar.AnchorPoint=Vector2.new(0,0.05)
ar.Visible=false
end
al.Containers[an].Visible=true
ai(al.Containers[an],0.15,{AnchorPoint=Vector2.new(0,0)},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()
end)

al.OnChangeFunc(an)
end
end

return al end function a.U()
local ac={}


local ae=a.load'b'
local ag=ae.New
local ai=ae.Tween

local aj=a.load'T'

function ac.New(ak,al,am,an,ao)
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

local ar=ag("Frame",{
Size=UDim2.new(0,ap.IconSize,0,ap.IconSize),
BackgroundTransparency=1,
Visible=false
},{
ag("ImageLabel",{
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

local as=ag("Frame",{
Size=UDim2.new(1,0,0,ap.HeaderSize),
BackgroundTransparency=1,
Parent=al,
ClipsDescendants=true,
},{
ag("TextButton",{
Size=UDim2.new(1,0,0,ap.HeaderSize),
BackgroundTransparency=1,
Text="",
},{
aq,
ag("TextLabel",{
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
ag("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
Padding=UDim.new(0,10)
}),
ar,
ag("UIPadding",{
PaddingLeft=UDim.new(0,11),
PaddingRight=UDim.new(0,11),
})
}),
ag("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
Name="Content",
Visible=true,
Position=UDim2.new(0,0,0,ap.HeaderSize)
},{
ag("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,ao.Gap),
VerticalAlignment="Bottom",
}),
})
})


function ap.Tab(at,au)
if not ap.Expandable then
ap.Expandable=true
ar.Visible=true
end
au.Parent=as.Content
return aj.New(au,an)
end

function ap.Open(at)
if ap.Expandable then
ap.Opened=true
ai(as,0.33,{
Size=UDim2.new(1,0,0,ap.HeaderSize+(as.Content.AbsoluteSize.Y/an))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

ai(ar.ImageLabel,0.1,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
function ap.Close(at)
if ap.Expandable then
ap.Opened=false
ai(as,0.26,{
Size=UDim2.new(1,0,0,ap.HeaderSize)
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ai(ar.ImageLabel,0.1,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
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

if ap.Opened then
task.spawn(function()
task.wait()
ap:Open()
end)
end



return ap
end


return ac end function a.V()
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
}end function a.W()
game:GetService"UserInputService"

local ac={
Margin=8,
Padding=9,
}


local ae=a.load'b'
local ag=ae.New
local ai=ae.Tween


function ac.new(aj,ak,al)
local am={
IconSize=18,
Padding=14,
Radius=22,
Width=400,
MaxHeight=380,

Icons=a.load'V'
}


local an=ag("TextBox",{
Text="",
PlaceholderText="Search...",
ThemeTag={
PlaceholderColor3="Placeholder",
TextColor3="Text",
},
Size=UDim2.new(
1,
-((am.IconSize*2)+(am.Padding*2)),
0,
0
),
AutomaticSize="Y",
ClipsDescendants=true,
ClearTextOnFocus=false,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(ae.Font,Enum.FontWeight.Regular),
TextSize=18,
})

local ao=ag("ImageLabel",{
Image=ae.Icon"x"[1],
ImageRectSize=ae.Icon"x"[2].ImageRectSize,
ImageRectOffset=ae.Icon"x"[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.1,
Size=UDim2.new(0,am.IconSize,0,am.IconSize)
},{
ag("TextButton",{
Size=UDim2.new(1,8,1,8),
BackgroundTransparency=1,
Active=true,
ZIndex=999999999,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Text="",
})
})

local ap=ag("ScrollingFrame",{
Size=UDim2.new(1,0,0,0),
AutomaticCanvasSize="Y",
ScrollingDirection="Y",
ElasticBehavior="Never",
ScrollBarThickness=0,
CanvasSize=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
Visible=false
},{
ag("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
ag("UIPadding",{
PaddingTop=UDim.new(0,am.Padding),
PaddingLeft=UDim.new(0,am.Padding),
PaddingRight=UDim.new(0,am.Padding),
PaddingBottom=UDim.new(0,am.Padding),
})
})

local aq=ae.NewRoundFrame(am.Radius,"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Background",
},
ImageTransparency=0,
},{
ae.NewRoundFrame(am.Radius,"Squircle",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,

Visible=false,
ImageColor3=Color3.new(1,1,1),
ImageTransparency=.98,
Name="Frame",
},{
ag("Frame",{
Size=UDim2.new(1,0,0,46),
BackgroundTransparency=1,
},{








ag("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ag("ImageLabel",{
Image=ae.Icon"search"[1],
ImageRectSize=ae.Icon"search"[2].ImageRectSize,
ImageRectOffset=ae.Icon"search"[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.1,
Size=UDim2.new(0,am.IconSize,0,am.IconSize)
}),
an,
ao,
ag("UIListLayout",{
Padding=UDim.new(0,am.Padding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ag("UIPadding",{
PaddingLeft=UDim.new(0,am.Padding),
PaddingRight=UDim.new(0,am.Padding),
})
})
}),
ag("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Name="Results",
},{
ag("Frame",{
Size=UDim2.new(1,0,0,1),
ThemeTag={
BackgroundColor3="Outline",
},
BackgroundTransparency=.9,
Visible=false,
}),
ap,
ag("UISizeConstraint",{
MaxSize=Vector2.new(am.Width,am.MaxHeight),
}),
}),
ag("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
})
})

local ar=ag("Frame",{
Size=UDim2.new(0,am.Width,0,0),
AutomaticSize="Y",
Parent=ak,
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Visible=false,

ZIndex=99999999,
},{
ag("UIScale",{
Scale=.9,
}),
aq,
ae.NewRoundFrame(am.Radius,"SquircleOutline2",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Outline",
},
ImageTransparency=1,
},{
ag("UIGradient",{
Rotation=45,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.55),
NumberSequenceKeypoint.new(0.5,0.8),
NumberSequenceKeypoint.new(1,0.6)
}
})
})
})

local function CreateSearchTab(as,at,au,av,aw,ax)
local ay=ag("TextButton",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=av or nil
},{
ae.NewRoundFrame(am.Radius-11,"Squircle",{
Size=UDim2.new(1,0,0,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),

ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Main"
},{
ae.NewRoundFrame(am.Radius-11,"SquircleOutline2",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="Outline",
},
ImageTransparency=1,
Name="Outline",
},{
ag("UIGradient",{
Rotation=65,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.55),
NumberSequenceKeypoint.new(0.5,0.8),
NumberSequenceKeypoint.new(1,0.6)
}
}),
ag("UIPadding",{
PaddingTop=UDim.new(0,am.Padding-2),
PaddingLeft=UDim.new(0,am.Padding),
PaddingRight=UDim.new(0,am.Padding),
PaddingBottom=UDim.new(0,am.Padding-2),
}),
ag("ImageLabel",{
Image=ae.Icon(au)[1],
ImageRectSize=ae.Icon(au)[2].ImageRectSize,
ImageRectOffset=ae.Icon(au)[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.1,
Size=UDim2.new(0,am.IconSize,0,am.IconSize)
}),
ag("Frame",{
Size=UDim2.new(1,-am.IconSize-am.Padding,0,0),
BackgroundTransparency=1,
},{
ag("TextLabel",{
Text=as,
ThemeTag={
TextColor3="Text",
},
TextSize=17,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(ae.Font,Enum.FontWeight.Medium),
Size=UDim2.new(1,0,0,0),
TextTruncate="AtEnd",
AutomaticSize="Y",
Name="Title"
}),
ag("TextLabel",{
Text=at or"",
Visible=at and true or false,
ThemeTag={
TextColor3="Text",
},
TextSize=15,
TextTransparency=.3,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(ae.Font,Enum.FontWeight.Medium),
Size=UDim2.new(1,0,0,0),
TextTruncate="AtEnd",
AutomaticSize="Y",
Name="Desc"
})or nil,
ag("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
})
}),
ag("UIListLayout",{
Padding=UDim.new(0,am.Padding),
FillDirection="Horizontal",
})
}),
},true),
ag("Frame",{
Name="ParentContainer",
Size=UDim2.new(1,-am.Padding,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Visible=aw,

},{
ae.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,2,1,0),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Text"
},
ImageTransparency=.9,
}),
ag("Frame",{
Size=UDim2.new(1,-am.Padding-2,0,0),
Position=UDim2.new(0,am.Padding+2,0,0),
BackgroundTransparency=1,
},{
ag("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
}),
}),
ag("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
HorizontalAlignment="Right"
})
})



ay.Main.Size=UDim2.new(
1,
0,
0,
ay.Main.Outline.Frame.Desc.Visible and(((am.Padding-2)*2)+ay.Main.Outline.Frame.Title.TextBounds.Y+6+ay.Main.Outline.Frame.Desc.TextBounds.Y)
or(((am.Padding-2)*2)+ay.Main.Outline.Frame.Title.TextBounds.Y)
)

ae.AddSignal(ay.Main.MouseEnter,function()
ai(ay.Main,.04,{ImageTransparency=.95}):Play()
ai(ay.Main.Outline,.04,{ImageTransparency=.7}):Play()
end)
ae.AddSignal(ay.Main.InputEnded,function()
ai(ay.Main,.08,{ImageTransparency=1}):Play()
ai(ay.Main.Outline,.08,{ImageTransparency=1}):Play()
end)
ae.AddSignal(ay.Main.MouseButton1Click,function()
if ax then
ax()
end
end)

return ay
end

local function ContainsText(as,at)
if not at or at==""then
return false
end

if not as or as==""then
return false
end

local au=string.lower(as)
local av=string.lower(at)

return string.find(au,av,1,true)~=nil
end

local function Search(as)
if not as or as==""then
return{}
end

local at={}
for au,av in next,aj.Tabs do
local aw=ContainsText(av.Title or"",as)
local ax={}

for ay,az in next,av.Elements do
if az.__type~="Section"then
local aA=ContainsText(az.Title or"",as)
local aB=ContainsText(az.Desc or"",as)

if aA or aB then
ax[ay]={
Title=az.Title,
Desc=az.Desc,
Original=az,
__type=az.__type,
Index=ay,
}
end
end
end

if aw or next(ax)~=nil then
at[au]={
Tab=av,
Title=av.Title,
Icon=av.Icon,
Elements=ax,
}
end
end
return at
end

function am.Search(as,at)
at=at or""

local au=Search(at)

ap.Visible=true
aq.Frame.Results.Frame.Visible=true
for av,aw in next,ap:GetChildren()do
if aw.ClassName~="UIListLayout"and aw.ClassName~="UIPadding"then
aw:Destroy()
end
end

if au and next(au)~=nil then
for ax,ay in next,au do
local az=am.Icons.Tab
local aA=CreateSearchTab(ay.Title,nil,az,ap,true,function()
am:Close()
aj:SelectTab(ax)
end)
if ay.Elements and next(ay.Elements)~=nil then
for aB,aC in next,ay.Elements do
local aD=am.Icons[aC.__type]
CreateSearchTab(aC.Title,aC.Desc,aD,aA:FindFirstChild"ParentContainer"and aA.ParentContainer.Frame or nil,false,function()
am:Close()
aj:SelectTab(ax)
if ay.Tab.ScrollToTheElement then

ay.Tab:ScrollToTheElement(aC.Index)
end

end)

end
end
end
elseif at~=""then
ag("TextLabel",{
Size=UDim2.new(1,0,0,70),
BackgroundTransparency=1,
Text="No results found",
TextSize=16,
ThemeTag={
TextColor3="Text",
},
TextTransparency=.2,
BackgroundTransparency=1,
FontFace=Font.new(ae.Font,Enum.FontWeight.Medium),
Parent=ap,
Name="NotFound",
})
else
ap.Visible=false
aq.Frame.Results.Frame.Visible=false
end
end

ae.AddSignal(an:GetPropertyChangedSignal"Text",function()
am:Search(an.Text)
end)

ae.AddSignal(ap.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()

ai(ap,.06,{Size=UDim2.new(
1,
0,
0,
math.clamp(ap.UIListLayout.AbsoluteContentSize.Y+(am.Padding*2),0,am.MaxHeight)
)},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()






end)

function am.Open(as)
task.spawn(function()
aq.Frame.Visible=true
ar.Visible=true
ai(ar.UIScale,.12,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end)
end

function am.Close(as)
task.spawn(function()
al()
aq.Frame.Visible=false
ai(ar.UIScale,.12,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

task.wait(.12)
ar.Visible=false
end)
end

ae.AddSignal(ao.TextButton.MouseButton1Click,function()
am:Close()
end)

am:Open()

return am
end

return ac end function a.X()

local ac=game:GetService"UserInputService"
game:GetService"RunService"

local ae=workspace.CurrentCamera

local ag=a.load'q'

local ai=a.load'b'
local aj=ai.New
local ak=ai.Tween


local al=a.load't'.New
local am=a.load'j'.New
local an=a.load'u'.New
local ao=a.load'v'

local ap=a.load'w'



return function(aq)
local ar={
Title=aq.Title or"UI Library",
Author=aq.Author,
Icon=aq.Icon,
IconSize=aq.IconSize or 22,
IconThemed=aq.IconThemed,
Folder=aq.Folder,
Resizable=aq.Resizable~=false,
Background=aq.Background,
BackgroundImageTransparency=aq.BackgroundImageTransparency or 0,
ShadowTransparency=aq.ShadowTransparency or 0.7,
User=aq.User or{},

Size=aq.Size,

MinSize=aq.MinSize or Vector2.new(560,350),
MaxSize=aq.MaxSize or Vector2.new(850,560),

TopBarButtonIconSize=aq.TopBarButtonIconSize or 16,

ToggleKey=aq.ToggleKey,
ElementsRadius=aq.ElementsRadius,
Radius=aq.Radius or 16,
Transparent=aq.Transparent or false,
HideSearchBar=aq.HideSearchBar~=false,
ScrollBarEnabled=aq.ScrollBarEnabled or false,
SideBarWidth=aq.SideBarWidth or 200,
Acrylic=aq.Acrylic or false,
NewElements=aq.NewElements or false,
IgnoreAlerts=aq.IgnoreAlerts or false,
HidePanelBackground=aq.HidePanelBackground or false,
AutoScale=aq.AutoScale~=false,
OpenButton=aq.OpenButton,

Position=UDim2.new(0.5,0,0.5,0),
UICorner=nil,
UIPadding=14,
UIElements={},
CanDropdown=true,
Closed=false,
Parent=aq.Parent,
Destroyed=false,
IsFullscreen=false,
CanResize=aq.Resizable~=false,
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
}

ar.UICorner=ar.Radius

ar.ElementConfig={
UIPadding=(ar.NewElements and 10 or 13),
UICorner=ar.ElementsRadius or(ar.NewElements and 23 or 12),
}

local as=ar.Size or UDim2.new(0,580,0,460)
ar.Size=UDim2.new(
as.X.Scale,
math.clamp(as.X.Offset,ar.MinSize.X,ar.MaxSize.X),
as.Y.Scale,
math.clamp(as.Y.Offset,ar.MinSize.Y,ar.MaxSize.Y)
)

if ar.Folder then
if not isfolder("WindUI/"..ar.Folder)then
makefolder("WindUI/"..ar.Folder)
end
if not isfolder("WindUI/"..ar.Folder.."/assets")then
makefolder("WindUI/"..ar.Folder.."/assets")
end
if not isfolder(ar.Folder)then
makefolder(ar.Folder)
end
if not isfolder(ar.Folder.."/assets")then
makefolder(ar.Folder.."/assets")
end
end

local at=aj("UICorner",{
CornerRadius=UDim.new(0,ar.UICorner)
})

if ar.Folder then
ar.ConfigManager=ap:Init(ar)
end


if ar.Acrylic then local
au, av=ag.AcrylicPaint{UseAcrylic=ar.Acrylic}

ar.AcrylicPaint=au
end

local au=aj("Frame",{
Size=UDim2.new(0,32,0,32),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(.5,.5),
BackgroundTransparency=1,
ZIndex=99,
Active=true
},{
aj("ImageLabel",{
Size=UDim2.new(0,96,0,96),
BackgroundTransparency=1,
Image="rbxassetid://120997033468887",
Position=UDim2.new(0.5,-16,0.5,-16),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=1,
})
})
local av=ai.NewRoundFrame(ar.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
ZIndex=98,
Active=false,
},{
aj("ImageLabel",{
Size=UDim2.new(0,70,0,70),
Image=ai.Icon"expand"[1],
ImageRectOffset=ai.Icon"expand"[2].ImageRectPosition,
ImageRectSize=ai.Icon"expand"[2].ImageRectSize,
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=1,
}),
})

local aw=ai.NewRoundFrame(ar.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
ZIndex=999,
Active=false,
})










ar.UIElements.SideBar=aj("ScrollingFrame",{
Size=UDim2.new(
1,
ar.ScrollBarEnabled and-3-(ar.UIPadding/2)or 0,
1,
not ar.HideSearchBar and-45 or 0
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
aj("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Name="Frame",
},{
aj("UIPadding",{
PaddingTop=UDim.new(0,ar.UIPadding/2),


PaddingBottom=UDim.new(0,ar.UIPadding/2),
}),
aj("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,ar.Gap)
})
}),
aj("UIPadding",{

PaddingLeft=UDim.new(0,ar.UIPadding/2),
PaddingRight=UDim.new(0,ar.UIPadding/2),

}),

})

ar.UIElements.SideBarContainer=aj("Frame",{
Size=UDim2.new(0,ar.SideBarWidth,1,ar.User.Enabled and-94-(ar.UIPadding*2)or-52),
Position=UDim2.new(0,0,0,52),
BackgroundTransparency=1,
Visible=true,
},{
aj("Frame",{
Name="Content",
BackgroundTransparency=1,
Size=UDim2.new(
1,
0,
1,
not ar.HideSearchBar and-45-ar.UIPadding/2 or 0
),
Position=UDim2.new(0,0,1,0),
AnchorPoint=Vector2.new(0,1),
}),
ar.UIElements.SideBar,
})

if ar.ScrollBarEnabled then
an(ar.UIElements.SideBar,ar.UIElements.SideBarContainer.Content,ar,3)
end


ar.UIElements.MainBar=aj("Frame",{
Size=UDim2.new(1,-ar.UIElements.SideBarContainer.AbsoluteSize.X,1,-52),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,1),
BackgroundTransparency=1,
},{
ai.NewRoundFrame(ar.UICorner-(ar.UIPadding/2),"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
ZIndex=3,
ImageTransparency=.95,
Name="Background",
Visible=not ar.HidePanelBackground
}),
aj("UIPadding",{
PaddingTop=UDim.new(0,ar.UIPadding/2),
PaddingLeft=UDim.new(0,ar.UIPadding/2),
PaddingRight=UDim.new(0,ar.UIPadding/2),
PaddingBottom=UDim.new(0,ar.UIPadding/2),
})
})

local ax=aj("ImageLabel",{
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



if ac.TouchEnabled and not ac.KeyboardEnabled then
ar.IsPC=false
elseif ac.KeyboardEnabled then
ar.IsPC=true
else
ar.IsPC=nil
end










local ay
if ar.User then
local function GetUserThumb()local
az, aA=game:GetService"Players":GetUserThumbnailAsync(
ar.User.Anonymous and 1 or game.Players.LocalPlayer.UserId,
Enum.ThumbnailType.HeadShot,
Enum.ThumbnailSize.Size420x420
)
return az
end


ay=aj("TextButton",{
Size=UDim2.new(0,
(ar.UIElements.SideBarContainer.AbsoluteSize.X)-(ar.UIPadding/2),
0,
42+(ar.UIPadding)
),
Position=UDim2.new(0,ar.UIPadding/2,1,-(ar.UIPadding/2)),
AnchorPoint=Vector2.new(0,1),
BackgroundTransparency=1,
Visible=ar.User.Enabled or false,
},{
ai.NewRoundFrame(ar.UICorner-(ar.UIPadding/2),"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Outline"
},{
aj("UIGradient",{
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
ai.NewRoundFrame(ar.UICorner-(ar.UIPadding/2),"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="UserIcon",
},{
aj("ImageLabel",{
Image=GetUserThumb(),
BackgroundTransparency=1,
Size=UDim2.new(0,42,0,42),
ThemeTag={
BackgroundColor3="Text",
},
BackgroundTransparency=.93,
},{
aj("UICorner",{
CornerRadius=UDim.new(1,0)
})
}),
aj("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
},{
aj("TextLabel",{
Text=ar.User.Anonymous and"Anonymous"or game.Players.LocalPlayer.DisplayName,
TextSize=17,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(ai.Font,Enum.FontWeight.SemiBold),
AutomaticSize="Y",
BackgroundTransparency=1,
Size=UDim2.new(1,-27,0,0),
TextTruncate="AtEnd",
TextXAlignment="Left",
Name="DisplayName"
}),
aj("TextLabel",{
Text=ar.User.Anonymous and"anonymous"or game.Players.LocalPlayer.Name,
TextSize=15,
TextTransparency=.6,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(ai.Font,Enum.FontWeight.Medium),
AutomaticSize="Y",
BackgroundTransparency=1,
Size=UDim2.new(1,-27,0,0),
TextTruncate="AtEnd",
TextXAlignment="Left",
Name="UserName"
}),
aj("UIListLayout",{
Padding=UDim.new(0,4),
HorizontalAlignment="Left",
})
}),
aj("UIListLayout",{
Padding=UDim.new(0,ar.UIPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
aj("UIPadding",{
PaddingLeft=UDim.new(0,ar.UIPadding/2),
PaddingRight=UDim.new(0,ar.UIPadding/2),
})
})
})


function ar.User.Enable(az)
ar.User.Enabled=true
ak(ar.UIElements.SideBarContainer,.25,{Size=UDim2.new(0,ar.SideBarWidth,1,-94-(ar.UIPadding*2))},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ay.Visible=true
end
function ar.User.Disable(az)
ar.User.Enabled=false
ak(ar.UIElements.SideBarContainer,.25,{Size=UDim2.new(0,ar.SideBarWidth,1,-52)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ay.Visible=false
end
function ar.User.SetAnonymous(az,aA)
if aA~=false then aA=true end
ar.User.Anonymous=aA
ay.UserIcon.ImageLabel.Image=GetUserThumb()
ay.UserIcon.Frame.DisplayName.Text=aA and"Anonymous"or game.Players.LocalPlayer.DisplayName
ay.UserIcon.Frame.UserName.Text=aA and"anonymous"or game.Players.LocalPlayer.Name
end

if ar.User.Enabled then
ar.User:Enable()
else
ar.User:Disable()
end

if ar.User.Callback then
ai.AddSignal(ay.MouseButton1Click,function()
ar.User.Callback()
end)
ai.AddSignal(ay.MouseEnter,function()
ak(ay.UserIcon,0.04,{ImageTransparency=.95}):Play()
ak(ay.Outline,0.04,{ImageTransparency=.85}):Play()
end)
ai.AddSignal(ay.InputEnded,function()
ak(ay.UserIcon,0.04,{ImageTransparency=1}):Play()
ak(ay.Outline,0.04,{ImageTransparency=1}):Play()
end)
end
end

local az
local aA


local aB=false
local aC

local aD=typeof(ar.Background)=="string"and string.match(ar.Background,"^video:(.+)")or nil
local aE=typeof(ar.Background)=="string"and not aD and string.match(ar.Background,"^https?://.+")or nil

local function GetImageExtension(b)
local e=b:match"%.(%w+)$"or b:match"%.(%w+)%?"
if e then
e=e:lower()
if e=="jpg"or e=="jpeg"or e=="png"or e=="webp"then
return"."..e
end
end
return".png"
end

if typeof(ar.Background)=="string"and aD then
aB=true

if string.find(aD,"http")then
local b=ar.Folder.."/assets/."..ai.SanitizeFilename(aD)..".webm"
if not isfile(b)then
local e,g=pcall(function()
local e=ai.Request{Url=aD,Method="GET",Headers={["User-Agent"]="Roblox/Exploit"}}
writefile(b,e.Body)
end)
if not e then
warn("[ WindUI.Window.Background ] Failed to download video: "..tostring(g))
return
end
end

local e,g=pcall(function()
return getcustomasset(b)
end)
if not e then
warn("[ WindUI.Window.Background ] Failed to load custom asset: "..tostring(g))
return
end
warn"[ WindUI.Window.Background ] VideoFrame may not work with custom video"
aD=g
end

aC=aj("VideoFrame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Video=aD,
Looped=true,
Volume=0,
},{
aj("UICorner",{
CornerRadius=UDim.new(0,ar.UICorner)
}),
})
aC:Play()

elseif aE then
local b=ar.Folder.."/assets/."..ai.SanitizeFilename(aE)..GetImageExtension(aE)
if not isfile(b)then
local e,g=pcall(function()
local e=ai.Request{Url=aE,Method="GET",Headers={["User-Agent"]="Roblox/Exploit"}}
writefile(b,e.Body)
end)
if not e then
warn("[ Window.Background ] Failed to download image: "..tostring(g))
return
end
end

local e,g=pcall(function()
return getcustomasset(b)
end)
if not e then
warn("[ Window.Background ] Failed to load custom asset: "..tostring(g))
return
end

aC=aj("ImageLabel",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Image=g,
ImageTransparency=0,
ScaleType="Crop",
},{
aj("UICorner",{
CornerRadius=UDim.new(0,ar.UICorner)
}),
})

elseif ar.Background then
aC=aj("ImageLabel",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Image=typeof(ar.Background)=="string"and ar.Background or"",
ImageTransparency=1,
ScaleType="Crop",
},{
aj("UICorner",{
CornerRadius=UDim.new(0,ar.UICorner)
}),
})
end


local b=ai.NewRoundFrame(99,"Squircle",{
ImageTransparency=.8,
ImageColor3=Color3.new(1,1,1),
Size=UDim2.new(0,0,0,4),
Position=UDim2.new(0.5,0,1,4),
AnchorPoint=Vector2.new(0.5,0),
},{
aj("TextButton",{
Size=UDim2.new(1,12,1,12),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,
ZIndex=99,
Name="Frame",
})
})

function createAuthor(e)
return aj("TextLabel",{
Text=e,
FontFace=Font.new(ai.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
TextTransparency=0.35,
AutomaticSize="XY",
Parent=ar.UIElements.Main and ar.UIElements.Main.Main.Topbar.Left.Title,
TextXAlignment="Left",
TextSize=13,
LayoutOrder=2,
ThemeTag={
TextColor3="WindowTopbarAuthor"
},
Name="Author",
})
end

local e
local g

if ar.Author then
e=createAuthor(ar.Author)
end


local h=aj("TextLabel",{
Text=ar.Title,
FontFace=Font.new(ai.Font,Enum.FontWeight.SemiBold),
BackgroundTransparency=1,
AutomaticSize="XY",
Name="Title",
TextXAlignment="Left",
TextSize=16,
ThemeTag={
TextColor3="WindowTopbarTitle"
}
})

ar.UIElements.Main=aj("Frame",{
Size=ar.Size,
Position=ar.Position,
BackgroundTransparency=1,
Parent=aq.Parent,
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,
},{
ar.AcrylicPaint and ar.AcrylicPaint.Frame or nil,
ax,
ai.NewRoundFrame(ar.UICorner,"Squircle",{
ImageTransparency=1,
Size=UDim2.new(1,0,1,-240),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Background",
ThemeTag={
ImageColor3="WindowBackground"
},

},{
aC,
b,
au,



}),
UIStroke,
at,
av,
aw,
aj("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Name="Main",

Visible=false,
ZIndex=97,
},{
aj("UICorner",{
CornerRadius=UDim.new(0,ar.UICorner)
}),
ar.UIElements.SideBarContainer,
ar.UIElements.MainBar,

ay,

aA,
aj("Frame",{
Size=UDim2.new(1,0,0,52),
BackgroundTransparency=1,
BackgroundColor3=Color3.fromRGB(50,50,50),
Name="Topbar"
},{
az,






aj("Frame",{
AutomaticSize="X",
Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,
Name="Left"
},{
aj("UIListLayout",{
Padding=UDim.new(0,ar.UIPadding+4),
SortOrder="LayoutOrder",
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
aj("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
Name="Title",
Size=UDim2.new(0,0,1,0),
LayoutOrder=2,
},{
aj("UIListLayout",{
Padding=UDim.new(0,0),
SortOrder="LayoutOrder",
FillDirection="Vertical",
VerticalAlignment="Center",
}),
h,
e,
}),
aj("UIPadding",{
PaddingLeft=UDim.new(0,4)
})
}),
aj("ScrollingFrame",{
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
aj("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
Padding=UDim.new(0,ar.UIPadding/2)
})
}),
aj("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
Position=UDim2.new(1,0,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
Name="Right",
},{
aj("UIListLayout",{
Padding=UDim.new(0,9),
FillDirection="Horizontal",
SortOrder="LayoutOrder",
}),

}),
aj("UIPadding",{
PaddingTop=UDim.new(0,ar.UIPadding),
PaddingLeft=UDim.new(0,ar.UIPadding),
PaddingRight=UDim.new(0,8),
PaddingBottom=UDim.new(0,ar.UIPadding),
})
})
})
})

ai.AddSignal(ar.UIElements.Main.Main.Topbar.Left:GetPropertyChangedSignal"AbsoluteSize",function()
local i=0
local j=ar.UIElements.Main.Main.Topbar.Right.UIListLayout.AbsoluteContentSize.X/aq.WindUI.UIScale
if h and e then
i=math.max(h.TextBounds.X/aq.WindUI.UIScale,e.TextBounds.X/aq.WindUI.UIScale)
else
i=h.TextBounds.X/aq.WindUI.UIScale
end
if g then
i=i+(ar.IconSize/aq.WindUI.UIScale)+(ar.UIPadding/aq.WindUI.UIScale)+(4/aq.WindUI.UIScale)
end
ar.UIElements.Main.Main.Topbar.Center.Position=UDim2.new(
0,
i+(ar.UIPadding/aq.WindUI.UIScale),
0.5,
0
)
ar.UIElements.Main.Main.Topbar.Center.Size=UDim2.new(
1,
-i-j-((ar.UIPadding*2)/aq.WindUI.UIScale),
1,
0
)
end)

function ar.CreateTopbarButton(i,j,l,m,p,r)
local u=ai.Image(
l,
l,
0,
ar.Folder,
"WindowTopbarIcon",
true,
r,
"WindowTopbarButtonIcon"
)
u.Size=UDim2.new(0,ar.TopBarButtonIconSize,0,ar.TopBarButtonIconSize)
u.AnchorPoint=Vector2.new(0.5,0.5)
u.Position=UDim2.new(0.5,0,0.5,0)

local v=ai.NewRoundFrame(ar.UICorner-(ar.UIPadding/2),"Squircle",{
Size=UDim2.new(0,36,0,36),
LayoutOrder=p or 999,
Parent=ar.UIElements.Main.Main.Topbar.Right,

ZIndex=9999,
ThemeTag={
ImageColor3="Text"
},
ImageTransparency=1
},{
ai.NewRoundFrame(ar.UICorner-(ar.UIPadding/2),"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Outline"
},{
aj("UIGradient",{
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
u
},true)



ar.TopBarButtons[100-p]={
Name=j,
Object=v
}

ai.AddSignal(v.MouseButton1Click,function()
m()
end)
ai.AddSignal(v.MouseEnter,function()
ak(v,.15,{ImageTransparency=.93}):Play()
ak(v.Outline,.15,{ImageTransparency=.75}):Play()

end)
ai.AddSignal(v.MouseLeave,function()
ak(v,.1,{ImageTransparency=1}):Play()
ak(v.Outline,.1,{ImageTransparency=1}):Play()

end)

return v
end



local i=ai.Drag(
ar.UIElements.Main,
{ar.UIElements.Main.Main.Topbar,b.Frame},
function(i,j)
if not ar.Closed then
if i and j==b.Frame then
ak(b,.1,{ImageTransparency=.35}):Play()
else
ak(b,.2,{ImageTransparency=.8}):Play()
end
ar.Position=ar.UIElements.Main.Position
ar.Dragging=i
end
end
)

if not aB and ar.Background and typeof(ar.Background)=="table"then

local j=aj"UIGradient"
for l,m in next,ar.Background do
j[l]=m
end

ar.UIElements.BackgroundGradient=ai.NewRoundFrame(ar.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
Parent=ar.UIElements.Main.Background,
ImageTransparency=ar.Transparent and aq.WindUI.TransparencyValue or 0
},{
j
})
end














ar.OpenButtonMain=a.load'x'.New(ar)


task.spawn(function()
if ar.Icon then

g=ai.Image(
ar.Icon,
ar.Title,
0,
ar.Folder,
"Window",
true,
ar.IconThemed,
"WindowTopbarIcon"
)
g.Parent=ar.UIElements.Main.Main.Topbar.Left
g.Size=UDim2.new(0,ar.IconSize,0,ar.IconSize)

ar.OpenButtonMain:SetIcon(ar.Icon)











else
ar.OpenButtonMain:SetIcon(ar.Icon)

end
end)

function ar.SetToggleKey(j,l)
ar.ToggleKey=l
end

function ar.SetTitle(j,l)
ar.Title=l
h.Text=l
end

function ar.SetAuthor(j,l)
ar.Author=l
if not e then
e=createAuthor(ar.Author)
end

e.Text=l
end

function ar.SetBackgroundImage(j,l)
ar.UIElements.Main.Background.ImageLabel.Image=l
end
function ar.SetBackgroundImageTransparency(j,l)
if aC and aC:IsA"ImageLabel"then
aC.ImageTransparency=math.floor(l*10+0.5)/10
end
ar.BackgroundImageTransparency=math.floor(l*10+0.5)/10
end

function ar.SetBackgroundTransparency(j,l)
local m=math.floor(tonumber(l)*10+0.5)/10
aq.WindUI.TransparencyValue=m
ar:ToggleTransparency(m>0)
end

local j
local l
ai.Icon"minimize"
ai.Icon"maximize"

ar:CreateTopbarButton("Fullscreen","maximize",function()
ar:ToggleFullscreen()
end,998)

function ar.ToggleFullscreen(m)
local p=ar.IsFullscreen

i:Set(p)

if not p then
j=ar.UIElements.Main.Position
l=ar.UIElements.Main.Size

ar.CanResize=false
else
if ar.Resizable then
ar.CanResize=true
end
end

ak(ar.UIElements.Main,0.45,{Size=p and l or UDim2.new(1,-20,1,-72)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

ak(ar.UIElements.Main,0.45,{Position=p and j or UDim2.new(0.5,0,0.5,26)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()



ar.IsFullscreen=not p
end


ar:CreateTopbarButton("Minimize","minus",function()
ar:Close()






















end,997)

function ar.OnOpen(m,p)
ar.OnOpenCallback=p
end
function ar.OnClose(m,p)
ar.OnCloseCallback=p
end
function ar.OnDestroy(m,p)
ar.OnDestroyCallback=p
end

if aq.WindUI.UseAcrylic then
ar.AcrylicPaint.AddParent(ar.UIElements.Main)
end

function ar.SetIconSize(m,p)
local r
if typeof(p)=="number"then
r=UDim2.new(0,p,0,p)
ar.IconSize=p
elseif typeof(p)=="UDim2"then
r=p
ar.IconSize=p.X.Offset
end

if g then
g.Size=r
end
end

function ar.Open(m)
task.spawn(function()
if ar.OnOpenCallback then
task.spawn(function()
ai.SafeCallback(ar.OnOpenCallback)
end)
end


task.wait(.06)
ar.Closed=false

ak(ar.UIElements.Main.Background,0.2,{
ImageTransparency=ar.Transparent and aq.WindUI.TransparencyValue or 0,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

if ar.UIElements.BackgroundGradient then
ak(ar.UIElements.BackgroundGradient,0.2,{
ImageTransparency=0,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

ak(ar.UIElements.Main.Background,0.4,{
Size=UDim2.new(1,0,1,0),
},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()

if aC then
if aC:IsA"VideoFrame"then
aC.Visible=true
else
ak(aC,0.2,{
ImageTransparency=ar.BackgroundImageTransparency,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

if ar.OpenButtonMain and ar.IsOpenButtonEnabled then
ar.OpenButtonMain:Visible(false)
end


ak(ax,0.25,{ImageTransparency=ar.ShadowTransparency},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if UIStroke then
ak(UIStroke,0.25,{Transparency=.8},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

task.spawn(function()
task.wait(.3)
ak(b,.45,{Size=UDim2.new(0,200,0,4),ImageTransparency=.8},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()
i:Set(true)
task.wait(.45)
if ar.Resizable then
ak(au.ImageLabel,.45,{ImageTransparency=.8},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()
ar.CanResize=true
end
end)


ar.CanDropdown=true

ar.UIElements.Main.Visible=true
task.spawn(function()
task.wait(.05)
ar.UIElements.Main:WaitForChild"Main".Visible=true

aq.WindUI:ToggleAcrylic(true)
end)
end)
end
function ar.Close(m)
local p={}

if ar.OnCloseCallback then
task.spawn(function()
ai.SafeCallback(ar.OnCloseCallback)
end)
end

aq.WindUI:ToggleAcrylic(false)

ar.UIElements.Main:WaitForChild"Main".Visible=false

ar.CanDropdown=false
ar.Closed=true

ak(ar.UIElements.Main.Background,0.32,{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
if ar.UIElements.BackgroundGradient then
ak(ar.UIElements.BackgroundGradient,0.32,{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
end

ak(ar.UIElements.Main.Background,0.4,{
Size=UDim2.new(1,0,1,-240),
},Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut):Play()


if aC then
if aC:IsA"VideoFrame"then
aC.Visible=false
else
ak(aC,0.3,{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
ak(ax,0.25,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
if UIStroke then
ak(UIStroke,0.25,{Transparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

ak(b,.3,{Size=UDim2.new(0,0,0,4),ImageTransparency=1},Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut):Play()
ak(au.ImageLabel,.3,{ImageTransparency=1},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()
i:Set(false)
ar.CanResize=false

task.spawn(function()
task.wait(0.4)
ar.UIElements.Main.Visible=false

if ar.OpenButtonMain and not ar.Destroyed and not ar.IsPC and ar.IsOpenButtonEnabled then
ar.OpenButtonMain:Visible(true)
end
end)

function p.Destroy(r)
task.spawn(function()
if ar.OnDestroyCallback then
task.spawn(function()
ai.SafeCallback(ar.OnDestroyCallback)
end)
end
if ar.AcrylicPaint and ar.AcrylicPaint.Model then
ar.AcrylicPaint.Model:Destroy()
end
ar.Destroyed=true
task.wait(0.4)
aq.WindUI.ScreenGui:Destroy()
aq.WindUI.NotificationGui:Destroy()
aq.WindUI.DropdownGui:Destroy()

ai.DisconnectAll()

return
end)
end

return p
end
function ar.Destroy(m)
return ar:Close():Destroy()
end
function ar.Toggle(m)
if ar.Closed then
ar:Open()
else
ar:Close()
end
end


function ar.ToggleTransparency(m,p)

ar.Transparent=p
aq.WindUI.Transparent=p

ar.UIElements.Main.Background.ImageTransparency=p and aq.WindUI.TransparencyValue or 0

ar.UIElements.MainBar.Background.ImageTransparency=p and 0.97 or 0.95

end

function ar.LockAll(m)
for p,r in next,ar.AllElements do
if r.Lock then r:Lock()end
end
end
function ar.UnlockAll(m)
for p,r in next,ar.AllElements do
if r.Unlock then r:Unlock()end
end
end
function ar.GetLocked(m)
local p={}

for r,u in next,ar.AllElements do
if u.Locked then table.insert(p,u)end
end

return p
end
function ar.GetUnlocked(m)
local p={}

for r,u in next,ar.AllElements do
if u.Locked==false then table.insert(p,u)end
end

return p
end

function ar.GetUIScale(m,p)
return aq.WindUI.UIScale
end

function ar.SetUIScale(m,p)
aq.WindUI.UIScale=p
ak(aq.WindUI.ScreenGui.UIScale,.2,{Scale=p},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
return ar
end

function ar.SetToTheCenter(m)
ak(ar.UIElements.Main,0.45,{Position=UDim2.new(0.5,0,0.5,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
return ar
end

function ar.SetCurrentConfig(m,p)
ar.CurrentConfig=p
end

do
local m=40
local p=ae.ViewportSize
local r=ar.UIElements.Main.AbsoluteSize

if not ar.IsFullscreen and ar.AutoScale then
local u=p.X-(m*2)
local v=p.Y-(m*2)

local A=u/r.X
local B=v/r.Y

local C=math.min(A,B)

local F=0.3
local G=1.0

local H=math.clamp(C,F,G)

local J=ar:GetUIScale()or 1
local L=0.05

if math.abs(H-J)>L then
ar:SetUIScale(H)
end
end
end


if ar.OpenButtonMain and ar.OpenButtonMain.Button then
ai.AddSignal(ar.OpenButtonMain.Button.TextButton.MouseButton1Click,function()


ar:Open()
end)
end

ai.AddSignal(ac.InputBegan,function(m,p)
if p then return end

if ar.ToggleKey then
if m.KeyCode==ar.ToggleKey then
ar:Toggle()
end
end
end)

task.spawn(function()

ar:Open()
end)

function ar.EditOpenButton(m,p)
return ar.OpenButtonMain:Edit(p)
end

if ar.OpenButton and typeof(ar.OpenButton)=="table"then
ar:EditOpenButton(ar.OpenButton)
end


local m=a.load'T'
local p=a.load'U'
local r=m.Init(ar,aq.WindUI,aq.Parent.Parent.ToolTips)
r:OnChange(function(u)ar.CurrentTab=u end)

ar.TabModule=m

function ar.Tab(u,v)
v.Parent=ar.UIElements.SideBar.Frame
return r.New(v,aq.WindUI.UIScale)
end

function ar.SelectTab(u,v)
r:SelectTab(v)
end

function ar.Section(u,v)
return p.New(v,ar.UIElements.SideBar.Frame,ar.Folder,aq.WindUI.UIScale,ar)
end

function ar.IsResizable(u,v)
ar.Resizable=v
ar.CanResize=v
end

function ar.Divider(u)
local v=aj("Frame",{
Size=UDim2.new(1,0,0,1),
Position=UDim2.new(0.5,0,0,0),
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=.9,
ThemeTag={
BackgroundColor3="Text"
}
})
local A=aj("Frame",{
Parent=ar.UIElements.SideBar.Frame,

Size=UDim2.new(1,-7,0,5),
BackgroundTransparency=1,
},{
v
})

return A
end

local u=a.load'l'.Init(ar,nil)
function ar.Dialog(v,A)
local B={
Title=A.Title or"Dialog",
Width=A.Width or 320,
Content=A.Content,
Buttons=A.Buttons or{},

TextPadding=10,
}
local C=u.Create(false)

C.UIElements.Main.Size=UDim2.new(0,B.Width,0,0)

local F=aj("Frame",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=C.UIElements.Main
},{
aj("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,C.UIPadding),
VerticalAlignment="Center"
}),
aj("UIPadding",{
PaddingTop=UDim.new(0,B.TextPadding/2),
PaddingLeft=UDim.new(0,B.TextPadding/2),
PaddingRight=UDim.new(0,B.TextPadding/2),
})
})

local G
if A.Icon then
G=ai.Image(
A.Icon,
B.Title..":"..A.Icon,
0,
ar,
"Dialog",
true,
A.IconThemed
)
G.Size=UDim2.new(0,22,0,22)
G.Parent=F
end

C.UIElements.UIListLayout=aj("UIListLayout",{
Padding=UDim.new(0,12),
FillDirection="Vertical",
HorizontalAlignment="Left",
Parent=C.UIElements.Main
})

aj("UISizeConstraint",{
MinSize=Vector2.new(180,20),
MaxSize=Vector2.new(400,math.huge),
Parent=C.UIElements.Main,
})


C.UIElements.Title=aj("TextLabel",{
Text=B.Title,
TextSize=20,
FontFace=Font.new(ai.Font,Enum.FontWeight.SemiBold),
TextXAlignment="Left",
TextWrapped=true,
RichText=true,
Size=UDim2.new(1,G and-26-C.UIPadding or 0,0,0),
AutomaticSize="Y",
ThemeTag={
TextColor3="Text"
},
BackgroundTransparency=1,
Parent=F
})
if B.Content then
aj("TextLabel",{
Text=B.Content,
TextSize=18,
TextTransparency=.4,
TextWrapped=true,
RichText=true,
FontFace=Font.new(ai.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
LayoutOrder=2,
ThemeTag={
TextColor3="Text"
},
BackgroundTransparency=1,
Parent=C.UIElements.Main
},{
aj("UIPadding",{
PaddingLeft=UDim.new(0,B.TextPadding/2),
PaddingRight=UDim.new(0,B.TextPadding/2),
PaddingBottom=UDim.new(0,B.TextPadding/2),
})
})
end

local H=aj("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
HorizontalAlignment="Right",
})

local J=aj("Frame",{
Size=UDim2.new(1,0,0,40),
AutomaticSize="None",
BackgroundTransparency=1,
Parent=C.UIElements.Main,
LayoutOrder=4,
},{
H,






})


local L={}

for M,N in next,B.Buttons do
local O=am(N.Title,N.Icon,N.Callback,N.Variant,J,C,false)
table.insert(L,O)
end

local function CheckButtonsOverflow()
H.FillDirection=Enum.FillDirection.Horizontal
H.HorizontalAlignment=Enum.HorizontalAlignment.Right
H.VerticalAlignment=Enum.VerticalAlignment.Center
J.AutomaticSize=Enum.AutomaticSize.None

for O,P in ipairs(L)do
P.Size=UDim2.new(0,0,1,0)
P.AutomaticSize=Enum.AutomaticSize.X
end

wait()

local Q=H.AbsoluteContentSize.X/aq.WindUI.UIScale
local R=J.AbsoluteSize.X/aq.WindUI.UIScale

if Q>R then
H.FillDirection=Enum.FillDirection.Vertical
H.HorizontalAlignment=Enum.HorizontalAlignment.Right
H.VerticalAlignment=Enum.VerticalAlignment.Bottom
J.AutomaticSize=Enum.AutomaticSize.Y

for S,T in ipairs(L)do
T.Size=UDim2.new(1,0,0,40)
T.AutomaticSize=Enum.AutomaticSize.None
end
else
local S=R-Q
if S>0 then
local T
local U=math.huge

for V,W in ipairs(L)do
local X=W.AbsoluteSize.X/aq.WindUI.UIScale
if X<U then
U=X
T=W
end
end

if T then
T.Size=UDim2.new(0,U+S,1,0)
T.AutomaticSize=Enum.AutomaticSize.None
end
end
end
end

ai.AddSignal(C.UIElements.Main:GetPropertyChangedSignal"AbsoluteSize",CheckButtonsOverflow)
CheckButtonsOverflow()

wait()
C:Open()

return C
end


ar:CreateTopbarButton("Close","x",function()
if not ar.IgnoreAlerts then
ar:SetToTheCenter()
ar:Dialog{

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

Callback=function()ar:Destroy()end,
Variant="Primary",
}
}
}
else
ar:Destroy()
end
end,999)

function ar.Tag(v,A)
if ar.UIElements.Main.Main.Topbar.Center.Visible==false then ar.UIElements.Main.Main.Topbar.Center.Visible=true end
return ao:New(A,ar.UIElements.Main.Main.Topbar.Center)
end


local function startResizing(v)
if ar.CanResize then
isResizing=true
av.Active=true
initialSize=ar.UIElements.Main.Size
initialInputPosition=v.Position


ak(au.ImageLabel,0.1,{ImageTransparency=.35}):Play()

ai.AddSignal(v.Changed,function()
if v.UserInputState==Enum.UserInputState.End then
isResizing=false
av.Active=false


ak(au.ImageLabel,0.17,{ImageTransparency=.8}):Play()
end
end)
end
end

ai.AddSignal(au.InputBegan,function(v)
if v.UserInputType==Enum.UserInputType.MouseButton1 or v.UserInputType==Enum.UserInputType.Touch then
if ar.CanResize then
startResizing(v)
end
end
end)

ai.AddSignal(ac.InputChanged,function(v)
if v.UserInputType==Enum.UserInputType.MouseMovement or v.UserInputType==Enum.UserInputType.Touch then
if isResizing and ar.CanResize then
local A=v.Position-initialInputPosition
local B=UDim2.new(0,initialSize.X.Offset+A.X*2,0,initialSize.Y.Offset+A.Y*2)

B=UDim2.new(
B.X.Scale,
math.clamp(B.X.Offset,ar.MinSize.X,ar.MaxSize.X),
B.Y.Scale,
math.clamp(B.Y.Offset,ar.MinSize.Y,ar.MaxSize.Y)
)

ak(ar.UIElements.Main,0,{
Size=B
}):Play()

ar.Size=B
end
end
end)




local v=0
local A=0.4
local B
local C=0

function onDoubleClick()
ar:SetToTheCenter()
end

b.Frame.MouseButton1Up:Connect(function()
local F=tick()
local G=ar.Position

C=C+1

if C==1 then
v=F
B=G

task.spawn(function()
task.wait(A)
if C==1 then
C=0
B=nil
end
end)

elseif C==2 then
if F-v<=A and G==B then
onDoubleClick()
end

C=0
B=nil
v=0
else
C=1
v=F
B=G
end
end)





if not ar.HideSearchBar then
local F=a.load'W'
local G=false





















local H=al("Search","search",ar.UIElements.SideBarContainer,true)
H.Size=UDim2.new(1,-ar.UIPadding/2,0,39)
H.Position=UDim2.new(0,ar.UIPadding/2,0,ar.UIPadding/2)

ai.AddSignal(H.MouseButton1Click,function()
if G then return end

F.new(ar.TabModule,ar.UIElements.Main,function()

G=false
if ar.Resizable then
ar.CanResize=true
end

ak(aw,0.1,{ImageTransparency=1}):Play()
aw.Active=false
end)
ak(aw,0.1,{ImageTransparency=.65}):Play()
aw.Active=true

G=true
ar.CanResize=false
end)
end




function ar.DisableTopbarButtons(F,G)
for H,J in next,G do
for L,M in next,ar.TopBarButtons do
if M.Name==J then
M.Object.Visible=false
end
end
end
end

return ar
end end end
local ac={
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
}


local ae=game:GetService"HttpService"


local ag=ae:JSONDecode(a.load'i')
if ag then
ac.Version=ag.version
end

local ai=a.load'm'local aj=

ac.Services


local ak=ac.Creator

local al=ak.New local am=
ak.Tween


local an=a.load'q'local ao=

game:GetService"Players"and game:GetService"Players".LocalPlayer or nil

local ap=protectgui or(syn and syn.protect_gui)or function()end

local aq=gethui and gethui()or(game.CoreGui or game.Players.LocalPlayer:WaitForChild"PlayerGui")


ac.ScreenGui=al("ScreenGui",{
Name="WindUI",
Parent=aq,
IgnoreGuiInset=true,
ScreenInsets="None",
},{
al("UIScale",{
Scale=ac.Scale,
}),
al("Folder",{
Name="Window"
}),






al("Folder",{
Name="KeySystem"
}),
al("Folder",{
Name="Popups"
}),
al("Folder",{
Name="ToolTips"
})
})

ac.NotificationGui=al("ScreenGui",{
Name="WindUI/Notifications",
Parent=aq,
IgnoreGuiInset=true,
})
ac.DropdownGui=al("ScreenGui",{
Name="WindUI/Dropdowns",
Parent=aq,
IgnoreGuiInset=true,
})
ap(ac.ScreenGui)
ap(ac.NotificationGui)
ap(ac.DropdownGui)

ak.Init(ac)

math.clamp(ac.TransparencyValue,0,1)

local ar=ac.NotificationModule.Init(ac.NotificationGui)

function ac.Notify(as,at)
at.Holder=ar.Frame
at.Window=ac.Window

return ac.NotificationModule.New(at)
end

function ac.SetNotificationLower(as,at)
ar.SetLower(at)
end

function ac.SetFont(as,at)
ak.UpdateFont(at)
end

function ac.OnThemeChange(as,at)
ac.OnThemeChangeFunction=at
end

function ac.AddTheme(as,at)
ac.Themes[at.Name]=at
return at
end

function ac.SetTheme(as,at)
if ac.Themes[at]then
ac.Theme=ac.Themes[at]
ak.SetTheme(ac.Themes[at])

if ac.OnThemeChangeFunction then
ac.OnThemeChangeFunction(at)
end


return ac.Themes[at]
end
return nil
end

function ac.GetThemes(as)
return ac.Themes
end
function ac.GetCurrentTheme(as)
return ac.Theme.Name
end
function ac.GetTransparency(as)
return ac.Transparent or false
end
function ac.GetWindowSize(as)
return Window.UIElements.Main.Size
end
function ac.Localization(as,at)
return ac.LocalizationModule:New(at,ak)
end

function ac.SetLanguage(as,at)
if ak.Localization then
return ak.SetLanguage(at)
end
return false
end

function ac.ToggleAcrylic(as,at)
if ac.Window and ac.Window.AcrylicPaint and ac.Window.AcrylicPaint.Model then
ac.Window.Acrylic=at
ac.Window.AcrylicPaint.Model.Transparency=at and 0.98 or 1
if at then
an.Enable()
else
an.Disable()
end
end
end



function ac.Gradient(as,at,au)
local av={}
local aw={}

for ax,ay in next,at do
local az=tonumber(ax)
if az then
az=math.clamp(az/100,0,1)
table.insert(av,ColorSequenceKeypoint.new(az,ay.Color))
table.insert(aw,NumberSequenceKeypoint.new(az,ay.Transparency or 0))
end
end

table.sort(av,function(az,aA)return az.Time<aA.Time end)
table.sort(aw,function(az,aA)return az.Time<aA.Time end)


if#av<2 then
error"ColorSequence requires at least 2 keypoints"
end


local az={
Color=ColorSequence.new(av),
Transparency=NumberSequence.new(aw),
}

if au then
for aA,aB in pairs(au)do
az[aA]=aB
end
end

return az
end


function ac.Popup(as,at)
at.WindUI=ac
return a.load'r'.new(at)
end


ac.Themes=a.load's'(ac)

ak.Themes=ac.Themes


ac:SetTheme"Dark"
ac:SetLanguage(ak.Language)


function ac.CreateWindow(as,at)
local au=a.load'X'

if not isfolder"WindUI"then
makefolder"WindUI"
end
if at.Folder then
makefolder(at.Folder)
else
makefolder(at.Title)
end

at.WindUI=ac
at.Parent=ac.ScreenGui.Window

if ac.Window then
warn"You cannot create more than one window"
return
end

local av=true

local aw=ac.Themes[at.Theme or"Dark"]


ak.SetTheme(aw)


local ax=gethwid or function()
return game:GetService"Players".LocalPlayer.UserId
end

local ay=ax()

if at.KeySystem then
av=false

local function loadKeysystem()
ai.new(at,ay,function(az)av=az end)
end

local az=(at.Folder or"Temp").."/"..ay..".key"

if not at.KeySystem.API then
if at.KeySystem.SaveKey and isfile(az)then
local aA=readfile(az)
local aB=(type(at.KeySystem.Key)=="table")
and table.find(at.KeySystem.Key,aA)
or tostring(at.KeySystem.Key)==tostring(aA)

if aB then
av=true
else
loadKeysystem()
end
else
loadKeysystem()
end
else
if isfile(az)then
local aA=readfile(az)
local aB=false

for aC,aD in next,at.KeySystem.API do
local aE=ac.Services[aD.Type]
if aE then
local b={}
for e,g in next,aE.Args do
table.insert(b,aD[g])
end

local h=aE.New(table.unpack(b))
local i=h.Verify(aA)
if i then
aB=true
break
end
end
end

av=aB
if not aB then loadKeysystem()end
else
loadKeysystem()
end
end

repeat task.wait()until av
end

local az=au(at)

ac.Transparent=at.Transparent
ac.Window=az

if at.Acrylic then
an.init()
end













return az
end

return ac