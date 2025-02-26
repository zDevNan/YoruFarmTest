--[[  
    Script separado em 4 sistemas independentes para evitar falhas:
    1. Coleta Compass automaticamente
    2. Usa os Compass quando tiver 5
    3. Coleta a recompensa quando a missão estiver completa
    4. Reseta os dados para refazer a missão
    Se um sistema falhar, os outros continuam rodando normalmente!
]]--

local plr = game.Players.LocalPlayer
local backpack = plr:FindFirstChild("Backpack")

-- Sistema 1: Coleta Compass
task.spawn(function()
    while true do
        task.wait(1)
        if not backpack then backpack = plr:FindFirstChild("Backpack") end
        if not backpack then continue end

        local count = 0
        for _, item in pairs(backpack:GetChildren()) do
            if item.Name == "Compass" then count = count + 1 end
        end

        if count < 5 then
            for _, item in pairs(game.Workspace:GetChildren()) do
                if count >= 5 then break end
                if item:IsA("Tool") and item.Name == "Compass" and item:FindFirstChild("Handle") then
                    firetouchinterest(plr.Character.HumanoidRootPart, item.Handle, 0)
                    firetouchinterest(plr.Character.HumanoidRootPart, item.Handle, 1)
                    task.wait(0.2)
                    count = count + 1
                end
            end
        end
    end
end)

-- Sistema 2: Usa Compass quando tiver 5
task.spawn(function()
    while true do
        task.wait(1)
        if not backpack then continue end
        local count = 0
        for _, item in pairs(backpack:GetChildren()) do
            if item.Name == "Compass" then count = count + 1 end
        end

        if count >= 5 then
            print("[🧭] 5 Compass coletados. Usando...")
            local userData = workspace:FindFirstChild("UserData"):FindFirstChild("User_" .. plr.UserId)
            local WeeklyQuest = userData and userData.Data:FindFirstChild("QQ_Weekly3")

            if WeeklyQuest and WeeklyQuest.Value < 5 then
                for _, compass in pairs(backpack:GetChildren()) do
                    if compass.Name == "Compass" and compass:FindFirstChild("Poser") then
                        plr.Character.Humanoid:UnequipTools()
                        compass.Parent = plr.Character
                        plr.Character.HumanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
                        compass:Activate()
                        task.wait(0.5)
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
                challengesRemote:FireServer("Claim", "Weekly3")
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
                stats:FireServer()
                task.wait(2)
                print("[✔] Reset concluído! Missão pode ser refeita.")
            else
                warn("[⚠] Erro: Stats não encontrado! Não foi possível resetar a missão.")
            end
        end
    end
end)
