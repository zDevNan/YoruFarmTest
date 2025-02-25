while true do
    wait(1) -- Pequeno delay para evitar sobrecarga

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

    -- Função para contar quantos Compass estão na mochila
    local function countCompasses()
        local count = 0
        for _, item in pairs(backpack:GetChildren()) do
            if item.Name == "Compass" then
                count = count + 1
            end
        end
        return count
    end

    -- Se o jogador não tem Compass na mochila, tenta pegar 5 do chão
    local function collectCompasses()
        local needed = 5 - countCompasses() -- Calcula quantos Compass faltam
        local collected = 0

        while collected < needed do
            if isTakingTooLong() then
                resetData()
                return
            end

            wait(0.1)
            for _, item in pairs(game.Workspace:GetChildren()) do
                if item.Name == "Compass" and item:FindFirstChild("Handle") then
                    firetouchinterest(humanoidRootPart, item.Handle, 0)
                    firetouchinterest(humanoidRootPart, item.Handle, 1)
                    wait(0.5)
                    collected = collected + 1
                    if collected >= needed then
                        break
                    end
                end
            end
        end
    end

    -- Se o jogador não tem 5 Compass, coleta até ter exatamente 5
    if countCompasses() < 5 then
        collectCompasses()
    end

    -- Agora que temos 5 Compass, usa eles
    if countCompasses() == 5 then
        local oldPosition = humanoidRootPart.Position

        repeat
            if isTakingTooLong() then
                resetData()
                return
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
