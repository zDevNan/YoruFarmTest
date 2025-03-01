while true do
    task.wait(0.1) -- Pequeno delay para evitar sobrecarga

    local plr = game.Players.LocalPlayer
    local backpack = plr:FindFirstChild("Backpack")
    local character = plr.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not humanoidRootPart or not backpack then
        warn("[⚠] Erro: HumanoidRootPart ou Backpack não encontrado!")
        task.wait(0.2)
        continue
    end
    
    local function usarCompass()
        local compass = backpack:FindFirstChild("Compass")
        if not compass then return end -- Se não houver Compass, sai da função
        
        if compass:FindFirstChild("Poser") then
            plr.Character.Humanoid:UnequipTools()
            compass.Parent = character
            humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
            compass:Activate()
            task.wait(0.35) -- Tempo para garantir a ativação
        end
    end
    
    usarCompass() -- Executa o processo
end
