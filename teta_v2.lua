local plr = game.Players.LocalPlayer
local backpack = plr:FindFirstChild("Backpack")
local humanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

local function resetData()
    workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Stats:FireServer()
    task.wait(1) -- Pequena pausa para garantir que resetou
    startFarming() -- Reinicia automaticamente
end

local function countCompasses()
    local count = 0
    for _, item in ipairs(backpack:GetChildren()) do
        if item.Name == "Compass" then
            count = count + 1
        end
    end
    return count
end

local function collectCompasses()
    while countCompasses() < 5 do
        local collected = 0
        for _, item in ipairs(game.Workspace:GetChildren()) do
            if item.Name == "Compass" and item:FindFirstChild("Handle") and collected < (5 - countCompasses()) then
                firetouchinterest(humanoidRootPart, item.Handle, 0)
                firetouchinterest(humanoidRootPart, item.Handle, 1)
                collected = collected + 1
                task.wait(0.2) -- Pequena espera para evitar problemas
            end
            if countCompasses() >= 5 then
                break
            end
        end
        task.wait(0.5) -- Pequeno delay para evitar loop infinito
    end
end

local function useCompasses()
    if countCompasses() == 5 then
        for _, compass in ipairs(backpack:GetChildren()) do
            if compass.Name == "Compass" then
                plr.Character.Humanoid:UnequipTools()
                compass.Parent = plr.Character
                compass:Activate()
                task.wait(0.5) -- Pequeno delay para garantir que cada um seja usado
            end
        end
    end
end

local function startFarming()
    while true do
        if countCompasses() < 5 then
            collectCompasses()
        end

        if countCompasses() == 5 then
            useCompasses()
        end

        -- Verifica se pode coletar a missão semanal
        local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3")
        if WeeklyQuest.Value == 5 then
            workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId):WaitForChild("ChallengesRemote"):FireServer("Claim", "Weekly3")
            resetData() -- Reseta e reinicia automaticamente
        end

        task.wait(1) -- Pequeno delay antes de repetir o ciclo
    end
end

-- Inicia o script
startFarming()
