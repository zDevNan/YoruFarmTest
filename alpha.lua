_G.autocannon = false

function ActivateHaki(state)
    pcall(function()
        local userId = game.Players.LocalPlayer.UserId
        local hakiEvent = game.Workspace.UserData["User_" .. userId].UpdateHaki
        hakiEvent:FireServer()
    end)
end

local LP = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
    if _G.autocannon then
        for _, enemy in pairs(workspace.Enemies:GetChildren()) do
            if enemy:FindFirstChild("HumanoidRootPart") and 
               (string.find(enemy.Name, " Boar") or string.find(enemy.Name, "Crab") or 
                string.find(enemy.Name, "Angry") or string.find(enemy.Name, "Bandit") or 
                string.find(enemy.Name, "Thief") or string.find(enemy.Name, "Vokun") or 
                string.find(enemy.Name, "Buster") or string.find(enemy.Name, "Freddy") or 
                string.find(enemy.Name, "Bruno") or string.find(enemy.Name, "Thug") or 
                string.find(enemy.Name, "Gunslinger") or string.find(enemy.Name, "Gunner") or 
                string.find(enemy.Name, "Cave")) then

                local rootPart = enemy.HumanoidRootPart
                rootPart.CanCollide = false
                rootPart.Size = Vector3.new(10, 10, 10)
                rootPart.Anchored = true
                rootPart.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 4, -15)

                if enemy.Humanoid.Health == 0 then
                    rootPart.Size = Vector3.new(0, 0, 0)
                    enemy:Destroy()
                end
            end
        end

        if LP.Backpack:FindFirstChild("Cannon Ball") and not LP.Character:FindFirstChild("Cannon Ball") then
            LP.Character.Humanoid:EquipTool(LP.Backpack["Cannon Ball"])
        end

        if LP.Character:FindFirstChild("Cannon Ball") then
            local cannon = LP.Character["Cannon Ball"]
            for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("HumanoidRootPart") then
                    local args = {
                        [1] = enemy.HumanoidRootPart.CFrame
                    }
                    cannon.RemoteEvent:FireServer(unpack(args))
                end
            end
        end
    end
end)
