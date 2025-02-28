while true do
    local plr = game.Players.LocalPlayer
    local backpack = plr:FindFirstChild("Backpack")
    local character = plr.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart or not backpack then
        continue
    end

    -- Procura um Compass na mochila
    local compass = backpack:FindFirstChild("Compass")
    
    -- Se encontrou, equipa e usa
    if compass and compass:FindFirstChild("Poser") then
        plr.Character.Humanoid:UnequipTools()
        compass.Parent = character
        humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
        compass:Activate()
    end
end
