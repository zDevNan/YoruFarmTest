while true do
    wait(1) -- Delay para evitar sobrecarga

    local plr = game.Players.LocalPlayer
    local backpack = plr.Backpack
    local humanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

    local missionStartTime = tick() -- Marca o tempo de início da missão
    local function isTakingTooLong()
        return (tick() - missionStartTime) > 30
    end

    local function resetData()
        workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Stats:FireServer()
        wait(3)
    end

    -- Verifica quantos Compass existem na mochila
    local function countCompasses()
        local count = 0
        for _, item in pairs(backpack:GetChildren()) do
            if item.Name == "Compass" then
                count = count + 1
            end
        end
        return count
    end

    local compassCount = countCompasses()

    -- Se ainda não tem 5 Compass, pega do chão
    while compassCount < 5 do
        if isTakingTooLong() then
            resetData()
            break
        end

        wait(0.1)
        for _, item in pairs(game.Workspace:GetChildren()) do
            if item.Name == "Compass" and item:FindFirstChild("Handle") then
                firetouchinterest(humanoidRootPart, item.Handle, 0)
                firetouchinterest(humanoidRootPart, item.Handle, 1)
                compassCount = countCompasses()
                if compassCount >= 5 then break end
            end
        end
    end

    -- Agora que temos 5 Compass, usa eles
    if compassCount >= 5 then
        local oldPosition = humanoidRootPart.Position

        repeat
            if isTakingTooLong() then
                resetData()
                break
            end

            wait()
            pcall(function()
                local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3")
                if WeeklyQuest.Value < 5 then
                    local compass = backpack:FindFirstChild("Compass") or plr.Character:FindFirstChild("Compass")
                    if compass then
                        plr.Character.Humanoid:UnequipTools()
                        compass.Parent = plr.Character
                        humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
                        compass:Activate()
                        wait(0.5)
                        humanoidRootPart.CFrame = CFrame.new(oldPosition)
                    end
                end
            end)
        until workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3").Value == 5
    end

    -- Coleta a missão semanal se estiver pronta
    local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3")
    if WeeklyQuest.Value == 5 then
        workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId):WaitForChild("ChallengesRemote"):FireServer("Claim", "Weekly3")
        wait(1)

        -- Reset Data corretamente
        resetData()
    end
end
