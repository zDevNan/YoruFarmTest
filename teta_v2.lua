while true do
    local plr = game.Players.LocalPlayer
    local backpack = plr.Backpack
    local humanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

    local missionStartTime = tick() -- Marca o tempo de início da missão
    local function isTakingTooLong()
        return (tick() - missionStartTime) > 25 -- Se passar de 20s, reseta
    end

    local function resetData()
        workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Stats:FireServer()
        wait(2)
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
        if needed <= 0 then return end -- Já tem 5, não precisa pegar mais

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
            wait(0.1)
        end
    end

    -- Pega os Compass rapidamente
    collectCompasses()

    -- Se já tem 5 Compass, usa eles
    if countCompasses() == 5 then
        local oldPosition = humanoidRootPart.Position

        repeat
            if isTakingTooLong() then
                resetData()
                return
            end

            local compass = backpack:FindFirstChild("Compass") or plr.Character:FindFirstChild("Compass")
            if compass then
                plr.Character.Humanoid:UnequipTools()
                compass.Parent = plr.Character
                humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
                compass:Activate()
                wait(0.2) -- Reduzi o tempo de espera pra agilizar
                humanoidRootPart.CFrame = CFrame.new(oldPosition)
            end
        until workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3").Value == 5
    end

    -- Coleta a missão semanal e reinicia rapidamente
    local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3")
    if WeeklyQuest.Value == 5 then
        workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId):WaitForChild("ChallengesRemote"):FireServer("Claim", "Weekly3")
        wait(1)
        resetData()
    end
end
