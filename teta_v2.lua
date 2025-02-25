while true do
    local plr = game.Players.LocalPlayer
    local backpack = plr.Backpack
    local humanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

    local missionStartTime = tick() -- Tempo de início
    local function isTakingTooLong()
        return (tick() - missionStartTime) > 15 -- Se passar de 15s, reseta
    end

    local function resetData()
        workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Stats:FireServer()
    end

    local function countCompasses()
        local count = 0
        for _, item in pairs(backpack:GetChildren()) do
            if item.Name == "Compass" then
                count = count + 1
            end
        end
        return count
    end

    local function collectCompasses()
        local needed = 5 - countCompasses()
        if needed <= 0 then return end

        local collected = 0
        while collected < needed do
            if isTakingTooLong() then
                resetData()
                return
            end

            for _, item in pairs(game.Workspace:GetChildren()) do
                if item.Name == "Compass" and item:FindFirstChild("Handle") then
                    firetouchinterest(humanoidRootPart, item.Handle, 0)
                    firetouchinterest(humanoidRootPart, item.Handle, 1)
                    collected = collected + 1
                    if collected >= needed then
                        return
                    end
                end
            end
            task.wait(0.05) -- Espera mínima para evitar lag
        end
    end

    -- Pega os Compass rapidamente
    collectCompasses()

    -- Se já tem 5 Compass, usa eles
    if countCompasses() == 5 then
        repeat
            if isTakingTooLong() then
                resetData()
                return
            end

            local compass = backpack:FindFirstChild("Compass") or plr.Character:FindFirstChild("Compass")
            if compass then
                plr.Character.Humanoid:UnequipTools()
                compass.Parent = plr.Character
                compass:Activate()
                task.wait(0.1) -- Pequena pausa para garantir que ativa corretamente
            end
        until workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3").Value == 5
    end

    -- Coleta a missão semanal e reseta a data
    local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3")
    if WeeklyQuest.Value == 5 then
        workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId):WaitForChild("ChallengesRemote"):FireServer("Claim", "Weekly3")
        resetData() -- Reinicia imediatamente sem esperar
    end
end
