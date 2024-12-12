local LP = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

local function ActivateHaki(state)
    pcall(function()
        local userId = LP.UserId
        local hakiEvent = game.Workspace.UserData["User_" .. userId].UpdateHaki
        hakiEvent:FireServer()
    end)
end

-- Loop que equipa continuamente a ferramenta "Cannon Ball"
RunService.Heartbeat:Connect(function()
    if LP.Backpack:FindFirstChild("Cannon Ball") and not LP.Character:FindFirstChild("Cannon Ball") then
        LP.Character.Humanoid:EquipTool(LP.Backpack["Cannon Ball"])
    end
end)

-- Loop que trata dos inimigos
RunService.Heartbeat:Connect(function()
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") then
            v.HumanoidRootPart.Anchored = true
            v.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)

            -- Ativa o Haki antes de atacar
            ActivateHaki(true)

            if LP.Character:FindFirstChild("Cannon Ball") then
                local args = {
                    [1] = v.HumanoidRootPart.CFrame
                }
                LP.Character["Cannon Ball"].RemoteEvent:FireServer(unpack(args))
            end

            -- Verifica se o inimigo foi derrotado e desativa o Haki
            if v.Humanoid.Health <= 0 then
                ActivateHaki(false)
            end
        end
    end
end)
