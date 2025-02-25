local plr = game.Players.LocalPlayer
local backpack = plr.Backpack
local humanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

local function resetData()
    workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Stats:FireServer()
    task.wait(1) -- Pequena pausa para garantir que resetou
    startFarming() -- Reinicia automaticamente
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
    while countCompasses() < 5 do
        local collected = 0
        for _, item in pairs(game.Workspace:GetChildren()) do
            if item.Name == "Compass" and item:FindFirstChild("Handle") and collected < 5 then
                firetouchinterest(humanoidRootPart, item.Handle, 0)
                firetouchinterest(humanoidRootPart, item.Handle, 1)
                collected = collected + 1

                if countCompasses() >= 5 then
                    break
                end
            end
        end
        task.wait(0.1)
    end
end

local function useCompasses()
    if countCompasses() == 5 then
        for _, compass in pairs(backpack:GetChildren()) do
            if compass.Name == "Compass" then
                plr.Character.Humanoid:UnequipTools()
                compass.Parent = plr.Character
                compass:Activate()
                task.wait(0.1)
            end
        end
    end
end

local function startFarming()
    collectCompasses() -- Pega os Compass (5 no máximo)
    useCompasses() -- Usa os Compass se tiver 5

    -- Coleta a missão semanal e reseta a data
    local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3")
    if WeeklyQuest.Value == 5 then
        workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId):WaitForChild("ChallengesRemote"):FireServer("Claim", "Weekly3")
        resetData() -- Reseta e reinicia automaticamente
    else
        task.wait(1)
        startFarming() -- Continua farmando
    end
end

-- Inicia o script
startFarming()
