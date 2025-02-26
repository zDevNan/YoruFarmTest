local TabCompassButtonToggle2 = TabCompass:AddToggle({
    Name = "Auto Teleport Compass",
    Default = false,
    Callback = function(value)
        TabCompasstoggle2 = value
        
        -- Loop de teleporte até o Compass
        if TabCompasstoggle2 then
            while TabCompasstoggle2 do
                task.wait(0.5)
                pcall(function()
                    local Compass = game.Players.LocalPlayer.Backpack:FindFirstChild("Compass") or game.Players.LocalPlayer.Character:FindFirstChild("Compass")
                    if Compass then
                        local OldPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                        Compass.Parent = game.Players.LocalPlayer.Character
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Compass.Poser.Value)
                        Compass:Activate()
                        task.wait(0.3)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OldPosition)
                    end
                end)
            end
        end
    end
})

-- Função para contar Compass na mochila
local function countCompasses()
    local count = 0
    for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if item.Name == "Compass" then
            count = count + 1
        end
    end
    return count
end

-- Função para coletar Compass do chão
local function collectCompasses()
    local needed = 5 - countCompasses()
    if needed <= 0 then return end

    local humanoidRootPart = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    -- Armazena Compass do Workspace em uma tabela
    local compasses = {}
    for _, item in pairs(game.Workspace:GetDescendants()) do
        if item.Name == "Compass" and item:FindFirstChild("Handle") then
            table.insert(compasses, item)
        end
    end

    for _, compass in pairs(compasses) do
        if needed <= 0 then break end
        firetouchinterest(humanoidRootPart, compass.Handle, 0)
        firetouchinterest(humanoidRootPart, compass.Handle, 1)
        task.wait(0.1) -- Pequeno delay para evitar sobrecarga
        needed = needed - 1
    end
end

-- Função para resetar os dados
local function resetData()
    local userData = workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId)
    if userData:FindFirstChild("Stats") then
        userData.Stats:FireServer()
    end
end

-- Loop principal para coletar Compass e resetar dados
while true do
    task.wait(1) -- Delay inicial para evitar sobrecarga

    -- Coleta Compass se necessário
    if countCompasses() < 5 then
        collectCompasses()
    end

    -- Verifica se a missão foi completada
    local userData = workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId)
    local WeeklyQuest = userData.Data:WaitForChild("QQ_Weekly3")
    if WeeklyQuest.Value == 5 then
        -- Coleta a recompensa da missão
        userData:WaitForChild("ChallengesRemote"):FireServer("Claim", "Weekly3")
        task.wait(1)

        -- Reseta os dados
        resetData()
        task.wait(3) -- Delay para garantir que os dados sejam resetados
    end
end
