local WindUI = require("../src/Init")

local Window = WindUI:CreateWindow({
	Title = "Markdown Test",
	Folder = "WindUI_Markdown_Test",
})

local Tab = Window:Tab({ Title = "Markdown", Icon = "file-text" })

local Markdown = Tab:Markdown({
	Content = [[
# WindUI Markdown Full Test

## Headings
### Heading level 3
#### Heading level 4

Полный **rich content**, _italic_, ~~strikethrough~~, `inline code` и [link](https://github.com/Footagesus/WindUI).

> Markdown теперь рендерится нативными Roblox-компонентами.

---

- Unordered item
- Another **formatted** item

1. Ordered item
2. Second item

| Возможность | Mobile | Статус |
|:--|:--:|--:|
| Markdown | Да | Ready |
| Images | Да | Ready |
| Video | Скоро | WIP |

```lua
local Page = Tab:Markdown({
    Content = "# Hello"
})
```

![WindUI](https://raw.githubusercontent.com/Footagesus/WindUI/main/docs/banner-dark.png)
]],
})

assert(#Markdown.Elements == 12, "Expected every Markdown block to render")
assert(Markdown.Elements[1]:IsA("TextLabel"), "Heading must render as text")
assert(Markdown.Elements[6]:IsA("ImageLabel"), "Quote must render as a WindUI card")
assert(Markdown.Elements[10]:IsA("ImageLabel"), "Table must render as a WindUI card")
assert(Markdown.Elements[12]:IsA("ImageLabel"), "Image must render inside a WindUI card")

Markdown:SetContent([[# Updated

> Re-render passed

| A | B |
|---|---|
| 1 | 2 |

- Final item]])

assert(#Markdown.Elements == 4, "SetContent must replace the old content")
