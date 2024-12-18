local LP = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local targetIds = {71401978, 974757757,4881721574,4392085423} -- Substitua pelos IDs dos jogadores alvos

-- Equipar continuamente a ferramenta "Cannon Ball"
RunService.Heartbeat:Connect(function()
    if LP.Backpack:FindFirstChild("Cannon Ball") and not LP.Character:FindFirstChild("Cannon Ball") then
        LP.Character.Humanoid:EquipTool(LP.Backpack["Cannon Ball"])
    end
end)

-- Função para atacar os jogadores específicos
local function attackTargets()
    for _, player in pairs(game.Players:GetPlayers()) do
        if table.find(targetIds, player.UserId) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
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
end

-- Atualizar continuamente os jogadores alvos e atacar
RunService.Heartbeat:Connect(function()
    attackTargets()
end)
