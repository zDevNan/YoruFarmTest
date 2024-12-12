-- Criação de Toggle para ativar/desativar a funcionalidade
local ToggleFarm = FarmTab:CreateToggle({ 
    Name = "Cannon Ball Mobs | All |",
    CurrentValue = false,
    Flag = "ToggleAutoBringMobs",
    Callback = function(state)
        _G.autocannon = state
    end    
})

-- Função para ativar/desativar Haki
function ActivateHaki(state)
    pcall(function()
        local userId = game.Players.LocalPlayer.UserId
        local hakiEvent = game.Workspace.UserData["User_" .. userId].UpdateHaki
        hakiEvent:FireServer()
        -- Adicione lógica adicional aqui, se necessário, para tratar diferentes estados
    end)
end

-- Loop para manipulação dos inimigos
spawn(function()
    while wait(0.1) do
        pcall(function()
            if _G.autocannon then
                for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                    -- Verifica se o inimigo é válido e contém a parte "HumanoidRootPart"
                    if enemy:FindFirstChild("HumanoidRootPart") and 
                       (string.find(enemy.Name, " Boar") or string.find(enemy.Name, "Crab") or 
                        string.find(enemy.Name, "Angry") or string.find(enemy.Name, "Bandit") or 
                        string.find(enemy.Name, "Thief") or string.find(enemy.Name, "Vokun") or 
                        string.find(enemy.Name, "Buster") or string.find(enemy.Name, "Freddy") or 
                        string.find(enemy.Name, "Bruno") or string.find(enemy.Name, "Thug") or 
                        string.find(enemy.Name, "Gunslinger") or string.find(enemy.Name, "Gunner") or 
                        string.find(enemy.Name, "Cave")) then

                        -- Configuração para reposicionar o inimigo
                        local rootPart = enemy.HumanoidRootPart
                        rootPart.CanCollide = false
                        rootPart.Size = Vector3.new(10, 10, 10)
                        rootPart.Anchored = true
                        rootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 4, -15)

                        -- Checa se o inimigo está morto e o remove
                        if enemy.Humanoid.Health == 0 then
                            rootPart.Size = Vector3.new(0, 0, 0)
                            enemy:Destroy()
                        end
                    end
                end
            end
        end)
    end
end)

-- Loop para equipar e usar "Cannon Ball"
spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if _G.autocannon then
                local Plr = game.Players.LocalPlayer
                local toolName = "Cannon Ball"

                -- Verifica e equipa a ferramenta, se disponível
                if Plr.Backpack:FindFirstChild(toolName) and not Plr.Character:FindFirstChild(toolName) then
                    Plr.Character.Humanoid:EquipTool(Plr.Backpack[toolName])
                end

                local cannon = Plr.Character:FindFirstChild(toolName)
                if cannon then
                    local args = {
                        [1] = CFrame.new(Plr.Character.HumanoidRootPart.Position)
                    }
                    cannon.RemoteEvent:FireServer(unpack(args))
                end
            end
        end)
    end
end)

-- Loop contínuo para garantir que a ferramenta "Cannon Ball" esteja equipada
local LP = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
    if LP.Backpack:FindFirstChild("Cannon Ball") and not LP.Character:FindFirstChild("Cannon Ball") then
        LP.Character.Humanoid:EquipTool(LP.Backpack["Cannon Ball"])
    end
end)

-- Loop para tratar inimigos com a ferramenta "Cannon Ball"
RunService.Heartbeat:Connect(function()
    if _G.autocannon then
        for _, enemy in pairs(workspace.Enemies:GetChildren()) do
            if enemy:FindFirstChild("HumanoidRootPart") then
                local rootPart = enemy.HumanoidRootPart
                rootPart.Anchored = true
                rootPart.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)
                
                if LP.Character:FindFirstChild("Cannon Ball") then
                    local args = {
                        [1] = rootPart.CFrame
                    }
                    LP.Character["Cannon Ball"].RemoteEvent:FireServer(unpack(args))
                end
            end
        end
    end
end)
