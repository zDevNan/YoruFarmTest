local LP = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

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
            if LP.Character:FindFirstChild("Cannon Ball") then
                local args = {
                    [1] = v.HumanoidRootPart.CFrame
                }
                game:GetService("Players").LocalPlayer.Character["Cannon Ball"].RemoteEvent:FireServer(unpack(args))
            end
        end
    end
end)
