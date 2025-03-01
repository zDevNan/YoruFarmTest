-- Lista de caixas que devem ser verificadas antes de pegar outro Compass
local caixasValidas = {
    ["Rare Box"] = true,
    ["Ultra Rare Box"] = true,
    ["Uncommon Box"] = true,
    ["Common Box"] = true -- Corrigi a escrita de "Common"
}

while true do
    task.wait(0.001) -- Pequena pausa para evitar sobrecarga

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

    -- Encontra um Compass no inventário
    local compass = backpack:FindFirstChild("Compass")
    if compass and compass:FindFirstChild("Poser") then
        humanoid:UnequipTools()
        compass.Parent = character
        humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
        compass:Activate()

        -- Aguarda até que um item válido apareça no Backpack antes de seguir para outro Compass
        local itemColetado = false
        repeat
            task.wait(0.1) -- Pequeno delay para verificar
            for _, item in pairs(backpack:GetChildren()) do
                if caixasValidas[item.Name] then
                    itemColetado = true
                    break
                end
            end
        until itemColetado
    end
end
