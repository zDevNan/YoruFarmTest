AutoCompassQuestXX = false

spawn(function()
    while wait(0.1) do
        pcall(function()
            if not AutoCompassQuestXX then return end
            local player = game.Players.LocalPlayer
            local Compass = player.Backpack:FindFirstChild("Compass") or player.Character:FindFirstChild("Compass")
            if Compass then
                local OldPosition = player.Character.HumanoidRootPart.CFrame
                player.Character.Humanoid:UnequipTools()
                Compass.Parent = player.Character
                wait(0.05)
                player.Character.HumanoidRootPart.CFrame = Compass.Poser.Value
                wait(0.05)
                Compass:Activate()
                wait(0.05)
                player.Character.HumanoidRootPart.CFrame = OldPosition
            end
        end)
    end
end)
