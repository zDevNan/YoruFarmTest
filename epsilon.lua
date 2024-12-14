-- Captura todos os jogadores no servidor
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Função para aplicar poderes em todos os jogadores
local function applyPowerToPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local playerRootPart = player.Character.HumanoidRootPart

            -- Configuração do movimento e ancoragem
            playerRootPart.CanCollide = false
            playerRootPart.Anchored = true
            playerRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 4, -15)

            -- Dispara o poder no jogador
            pcall(function()
                local RemoteEvent = game:GetService("ReplicatedStorage").RemoteEvent -- Substitua pelo evento correto
                RemoteEvent:FireServer("Power", player)
            end)
        end
    end
end

-- Função para acompanhar continuamente os jogadores
spawn(function()
    while task.wait(0.5) do
        pcall(applyPowerToPlayers)
    end
end)

-- Verificação contínua de novos jogadores
Players.PlayerAdded:Connect(function(newPlayer)
    task.wait(1) -- Pequeno atraso para garantir que o personagem seja carregado
    if newPlayer.Character and newPlayer.Character:FindFirstChild("HumanoidRootPart") then
        applyPowerToPlayers()
    end
end)
