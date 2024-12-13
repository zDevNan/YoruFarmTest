local LP = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Equipar continuamente a ferramenta "Cannon Ball"
RunService.Heartbeat:Connect(function()
    if LP.Backpack:FindFirstChild("Cannon Ball") and not LP.Character:FindFirstChild("Cannon Ball") then
        LP.Character.Humanoid:EquipTool(LP.Backpack["Cannon Ball"])
    end
end)

-- Atualizar e atacar jogadores
RunService.Heartbeat:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local playerRoot = player.Character.HumanoidRootPart

            -- Move o jogador alvo para uma posição relativa
            playerRoot.Anchored = true
            playerRoot.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)

            -- Ataca o jogador
            if LP.Character:FindFirstChild("Cannon Ball") then
                local cannonBall = LP.Character["Cannon Ball"]
                local args = {
                    [1] = playerRoot.CFrame
                }
                cannonBall.RemoteEvent:FireServer(unpack(args))
            end
        end
    end
end)
