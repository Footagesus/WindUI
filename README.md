local player = game.Players.LocalPlayer
local menu = script.Parent

for _, button in pairs(menu:GetChildren()) do
	
	if button:IsA("ImageButton") then
		
		button.MouseButton1Click:Connect(function()
			
			local character = player.Character or player.CharacterAdded:Wait()
			local root = character:WaitForChild("HumanoidRootPart")
			
			local warpPart = workspace:FindFirstChild(button.Name)
			
			if warpPart then
				root.CFrame = warpPart.CFrame + Vector3.new(0, 3, 0)
			else
				warn("ไม่พบ Part ชื่อ "..button.Name)
			end
			
		end)
		
	end
	
end
