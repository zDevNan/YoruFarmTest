while true do
    task.wait(0.001) -- Loop rápido sem travar o celular

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

    -- Pega a primeira Compass disponível
    local compass = backpack:FindFirstChild("Compass")
    if compass and compass:FindFirstChild("Poser") then
        humanoid:UnequipTools()
        compass.Parent = character
        humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
        compass:Activate()

        -- Guarda o nome da Compass que foi usada
        local compassNome = compass.Name

        -- Espera até que essa Compass desapareça do personagem e do inventário
        repeat
            task.wait(0.05)
        until not character:FindFirstChild(compassNome) and not backpack:FindFirstChild(compassNome)
    end
end
