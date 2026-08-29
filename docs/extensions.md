# WindUI Extensions

## Persistent themes

```luau
WindUI:CreateTheme("Ocean", "Dark")
WindUI:EditTheme("Ocean", { Primary = Color3.fromHex("#38BDF8") })
WindUI:SaveTheme("Ocean")

local theme = WindUI:LoadTheme("WindUI/themes/Ocean.json")
if theme then WindUI:SetTheme(theme.Name) end
```

`ListSavedThemes()` returns the saved JSON files. `DeleteSavedTheme(name)` removes one saved theme.

## Plugin manifests

Put one manifest per `.lua` file in `WindUI/plugins/`. Each file must return a table:

```luau
return {
    Name = "My tools",
    Version = "1.0.0",
    Description = "Adds project-specific controls.",
    Init = function(WindUI)
        -- register tabs, callbacks, or shared state here
    end,
    Destroy = function(WindUI)
        -- disconnect and clean up here
    end,
}
```

```luau
local loaded, errors = WindUI:LoadPlugins()
WindUI:SavePluginState()
WindUI:DisablePlugin("My tools")
WindUI:EnablePlugin("My tools")
```

`LoadPlugins()` respects `WindUI/plugins/state.json`, so disabled plugins remain disabled after the next load. Use `ListPlugins()` for a sorted list suitable for a manager UI.

## Profiles

```luau
local profiles = Window.ConfigManager
profiles:CreateProfile("legit")
profiles:SaveProfile("legit")
profiles:SetProfileAutoLoad("legit", true)
profiles:LoadProfile("legit")
profiles:DeleteProfile("legit")
```

## Markdown additions

Nested lists and task lists are supported:

```markdown
- [x] Renderer
  - Tables
  - Images
- [ ] Upload video asset
```
