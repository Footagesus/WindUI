return function(Creator)
	return {
		-- More soon!

		Primary = "Icon",

		White = Color3.new(1, 1, 1),
		Black = Color3.new(0, 0, 0),

		Dialog = "Accent",

		Background = "Accent",
		BackgroundTransparency = 0,
		Hover = "Text",

		PanelBackground = "White",
		PanelBackgroundTransparency = 0.95,

		WindowBackground = "Background",

		WindowShadow = "Black",
		--WindowShadowTransparency = .7,

		WindowTopbarTitle = "Text",
		WindowTopbarAuthor = "Text",
		WindowTopbarIcon = "Icon",
		WindowTopbarButtonIcon = "Icon",

		--WindowSearchBarBackground = "Background",
		WindowSearchBarBackground = "Dialog",

		TabBackground = "Hover",
		TabBackgroundHover = "Hover",
		TabBackgroundHoverTransparency = 0.97,
		TabBackgroundActive = "Hover",
		TabBackgroundActiveTransparency = 0.93,
		TabText = "Text",
		TabTextTransparency = 0.3,
		TabTextTransparencyActive = 0,
		TabTitle = "Text",
		TabIcon = "Icon",
		TabIconTransparency = 0.4,
		TabIconTransparencyActive = 0.1,
		TabBorderTransparency = 1,
		TabBorderTransparencyActive = 0.75,
		TabBorder = "White",

		ElementBackground = "Text",
		ElementBackgroundTransparency = 0.93,
		ElementBackgroundHover = Creator:AddColor("ElementBackground", "#ffffff", 1 / 10),
		ElementTitle = "Text",
		ElementDesc = "Text",
		ElementIcon = "Icon",

		PopupBackground = "Background",
		PopupBackgroundTransparency = "BackgroundTransparency",
		PopupTitle = "Text",
		PopupContent = "Text",
		PopupIcon = "Icon",

		DialogBackground = "Dialog",
		DialogBackgroundTransparency = "BackgroundTransparency",
		DialogTitle = "Text",
		DialogContent = "Text",
		DialogIcon = "Icon",

		Toggle = "Button",
		ToggleBar = "White",

		Checkbox = "Primary",
		CheckboxIcon = "White",
		CheckboxBorder = "White",
		CheckboxBorderTransparency = 0.75,

		SliderIcon = "Icon",

		Slider = "Primary",
		SliderThumb = "White",
		SliderIconFrom = "SliderIcon",
		SliderIconTo = "SliderIcon",

		Tooltip = Color3.fromHex("4C4C4C"),
		TooltipText = "White",
		TooltipSecondary = "Primary",
		TooltipSecondaryText = "White",

		TabSectionIcon = "Icon",

		SectionIcon = "Icon",

		SectionExpandIcon = "Icon",
		SectionExpandIconTransparency = 0.4,
		SectionBox = "Text",
		SectionBoxTransparency = 0.95,
		SectionBoxBorder = "White",
		SectionBoxBorderTransparency = 0.75,
		SectionBoxBackground = "ElementBackground",
		SectionBoxBackgroundTransparency = 0.5,

		SearchBarBorder = "White",
		SearchBarBorderTransparency = 0.75,

		Notification = "Background",
		Notification2 = "White",
		Notification2Transparency = 0.92,
		NotificationTitle = "Text",
		NotificationTitleTransparency = 0,
		NotificationContent = "Text",
		NotificationContentTransparency = 0.4,
		NotificationDuration = "White",
		NotificationDurationTransparency = 0.95,
		NotificationBorder = "White",
		NotificationBorderTransparency = 0.75,

		DropdownTabBorder = "White",
		DropdownTabBackground = "ElementBackground",
		DropdownBackground = "Background",

		LabelBackground = "White",
		LabelBackgroundTransparency = 0.95,

		ViewportBackground = "ElementBackground",
		ViewportBackgroundTransparency = "ElementBackgroundTransparency",
	}
end
