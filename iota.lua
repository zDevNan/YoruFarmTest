while true do
    task.wait() -- Usa o menor delay possível sem travar o jogo

    local plr = game.Players.LocalPlayer
    local backpack = plr and plr:FindFirstChild("Backpack")
    local character = plr and plr.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if not humanoidRootPart or not backpack or not humanoid then
        continue -- Se algo estiver errado, pula para a próxima iteração
    end

    -- Pega a primeira Compass disponível
    local compass = backpack:FindFirstChild("Compass")
    if compass and compass:FindFirstChild("Poser") then
        humanoid:UnequipTools()
        compass.Parent = character
        humanoidRootPart.CFrame = compass.Poser.Value -- Evita criar um novo CFrame desnecessariamente
        compass:Activate()

        task.wait(0.25) -- Delay reduzido para garantir eficiência
    end
end
