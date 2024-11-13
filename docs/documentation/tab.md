# Tab

On this page
[[toc]]

## Tab
### Create Tab
```lua
local Tab = Window:Tab({
    Title = "Main",
    Icon = "folder", -- lucide or rbxassetid
})
```

### Select Tab
```lua
Window:SelectTab(2) -- Number of Tab
```

::: warning
Lucide icons are used in the tabs. Some icons have not been added to the library.
:::