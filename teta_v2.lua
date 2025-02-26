local plr = game.Players.LocalPlayer
local backpack = plr:FindFirstChild("Backpack")

-- Função para contar Compass na mochila
local function countCompasses()
    local count = 0
    for _, item in pairs(backpack:GetChildren()) do
        if item.Name == "Compass" then
            count = count + 1
        end
    end
    return count
end

-- Sistema 1: Coleta Compass
task.spawn(function()
    while true do
        task.wait(1)
        if not backpack then backpack = plr:FindFirstChild("Backpack") end
        if not backpack then continue end

        local count = countCompasses()
        if count < 5 then
            print("[🧭] Coletando Compass...")
            for _, item in pairs(game.Workspace:GetDescendants()) do
                if count >= 5 then break end
                if item:IsA("Tool") and item.Name == "Compass" and item:FindFirstChild("Handle") then
                    pcall(function()
                        firetouchinterest(plr.Character.HumanoidRootPart, item.Handle, 0)
                        firetouchinterest(plr.Character.HumanoidRootPart, item.Handle, 1)
                        task.wait(0.2)
                        count = count + 1
                        print("[🧭] Compass coletado: " .. count .. "/5")
                    end)
                end
            end
        else
            print("[🧭] Já tem 5 Compass na mochila.")
        end
    end
end)

-- Sistema 2: Usa Compass quando tiver 5
task.spawn(function()
    while true do
        task.wait(1)
        if not backpack then continue end

        local count = countCompasses()
        if count >= 5 then
            print("[🧭] 5 Compass coletados. Usando...")
            local userData = workspace:FindFirstChild("UserData"):FindFirstChild("User_" .. plr.UserId)
            local WeeklyQuest = userData and userData.Data:FindFirstChild("QQ_Weekly3")

            if WeeklyQuest and WeeklyQuest.Value < 5 then
                for _, compass in pairs(backpack:GetChildren()) do
                    if compass.Name == "Compass" and compass:FindFirstChild("Poser") then
                        pcall(function()
                            plr.Character.Humanoid:UnequipTools()
                            compass.Parent = plr.Character
                            plr.Character.HumanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
                            compass:Activate()
                            task.wait(0.5)
                            print("[🧭] Compass usado: " .. compass.Poser.Value)
                        end)
                    end
                end
            end
        end
    end
end)

-- Sistema 3: Coleta Recompensa
task.spawn(function()
    while true do
        task.wait(1)
        local userData = workspace:FindFirstChild("UserData"):FindFirstChild("User_" .. plr.UserId)
        local WeeklyQuest = userData and userData.Data:FindFirstChild("QQ_Weekly3")

        if WeeklyQuest and WeeklyQuest.Value == 5 then
            print("[✅] Missão completa. Coletando recompensa...")
            local challengesRemote = userData:FindFirstChild("ChallengesRemote")
            if challengesRemote then
                pcall(function()
                    challengesRemote:FireServer("Claim", "Weekly3")
                    print("[✅] Recompensa coletada!")
                end)
            end
        end
    end
end)

-- Sistema 4: Reseta os dados da missão
task.spawn(function()
    while true do
        task.wait(3)
        local userData = workspace:FindFirstChild("UserData"):FindFirstChild("User_" .. plr.UserId)
        local WeeklyQuest = userData and userData.Data:FindFirstChild("QQ_Weekly3")

        if WeeklyQuest and WeeklyQuest.Value == 5 then
            print("[♻] Resetando dados da missão...")
            local stats = userData:FindFirstChild("Stats")
            if stats then
                pcall(function()
                    stats:FireServer()
                    task.wait(2)
                    print("[✔] Reset concluído! Missão pode ser refeita.")
                end)
            else
                warn("[⚠] Erro: Stats não encontrado! Não foi possível resetar a missão.")
            end
        end
    end
end)
