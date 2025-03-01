local AutoCompassQuest = true -- Ativado automaticamente

spawn(function()
    while AutoCompassQuest do
        task.wait(0.1) -- Pequeno delay para evitar sobrecarga
        pcall(function()
            local plr = game.Players.LocalPlayer
            local character = plr.Character
            local backpack = plr:FindFirstChild("Backpack")

            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            
            local compass = backpack and backpack:FindFirstChild("Compass") or character:FindFirstChild("Compass")
            if compass and compass:FindFirstChild("Poser") then
                compass.Parent = character
                character.Humanoid:UnequipTools()
                character.HumanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
                compass:Activate()
                task.wait(0.1) -- Tempo reduzido para mais rapidez
            end
        end)
    end
end)
