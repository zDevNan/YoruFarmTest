local LP = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Equipar continuamente a ferramenta "Cannon Ball"
RunService.Heartbeat:Connect(function()
    if LP.Backpack:FindFirstChild("Cannon Ball") and not LP.Character:FindFirstChild("Cannon Ball") then
        LP.Character.Humanoid:EquipTool(LP.Backpack["Cannon Ball"])
    end
end)

-- Atacar apenas o jogador específico
RunService.Heartbeat:Connect(function()
    local targetPlayer = game.Players:FindFirstChild("IIGamerUp")
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and targetPlayer.Character:FindFirstChild("Humanoid") and targetPlayer.Character.Humanoid.Health > 0 then
        local targetRoot = targetPlayer.Character.HumanoidRootPart

        -- Posicionar o jogador alvo perto do jogador local
        targetRoot.Anchored = true
        targetRoot.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)

        -- Atacar o jogador alvo
        if LP.Character:FindFirstChild("Cannon Ball") then
            local cannonBall = LP.Character["Cannon Ball"]
            local args = {
                [1] = targetRoot.CFrame
            }
            cannonBall.RemoteEvent:FireServer(unpack(args))
        end
    end
end)
