while true do
    task.wait(0.001) -- Loop rápido sem sobrecarregar

    local plr = game.Players.LocalPlayer
    local backpack = plr:FindFirstChild("Backpack")
    local character = plr.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if not humanoidRootPart or not backpack or not humanoid then
        warn("[⚠] Erro: HumanoidRootPart, Backpack ou Humanoid não encontrado!")
        task.wait(0.01)
        continue
    end

    local compass = backpack:FindFirstChild("Compass")
    if compass and compass:FindFirstChild("Poser") then
        humanoid:UnequipTools()
        compass.Parent = character
        humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
        compass:Activate()

        -- Espera até que o item equipado seja uma "Box"
        repeat
            task.wait(0.05) -- Pequena espera para não travar o jogo
        until character:FindFirstChildOfClass("Tool") and string.match(character:FindFirstChildOfClass("Tool").Name, "Box$")
    end
end
