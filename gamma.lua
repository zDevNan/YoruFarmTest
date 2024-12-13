local LP = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local targetId = 71401978 -- Substitua pelo ID do jogador alvo

-- Equipar continuamente a ferramenta "Cannon Ball"
RunService.Heartbeat:Connect(function()
    if LP.Backpack:FindFirstChild("Cannon Ball") and not LP.Character:FindFirstChild("Cannon Ball") then
        LP.Character.Humanoid:EquipTool(LP.Backpack["Cannon Ball"])
    end
end)

-- Atacar apenas o jogador específico pelo ID
RunService.Heartbeat:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.UserId == targetId and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local targetRoot = player.Character.HumanoidRootPart

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
    end
end)
