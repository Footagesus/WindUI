local WindUI = require("../src/Init")

local Window = WindUI:CreateWindow({
	Title = "ProgressBar Test",
})

local Tab = Window:Tab({
	Title = "ProgressBar",
})

local Bar = Tab:ProgressBar({
	Title = "Determinate bar",
	Value = {
		Min = 0,
		Max = 100,
		Default = 25,
	},
})

assert(Bar.Indeterminate == false)
assert(Bar:Get() == 25)
assert(Bar:GetPercentage() == 25)
assert(Bar.ControlGap == 16)

Bar:Set(150)
assert(Bar:Get() == 100)

local IndeterminateBar = Tab:ProgressBar({
	Title = "Indeterminate bar",
	Indeterminate = true,
})

assert(IndeterminateBar.Indeterminate == true)
