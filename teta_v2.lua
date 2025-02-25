local plr = game.Players.LocalPlayer
local backpack = plr.Backpack
local humanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

local function resetData()
    workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Stats:FireServer()
    task.wait(1) -- Pequena pausa para garantir que resetou

    -- Recarrega o script atualizado do GitHub
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zDevNan/YoruFarmTest/refs/heads/main/teta_v2.lua", true))()
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
        for _, item in pairs(game.Workspace:GetChildren()) do
            if item.Name == "Compass" and item:FindFirstChild("Handle") then
                firetouchinterest(humanoidRootPart, item.Handle, 0)
                firetouchinterest(humanoidRootPart, item.Handle, 1)
            end
        end
        task.wait(0.1)
    end
end

-- Pega os Compass rapidamente
collectCompasses()

-- Se já tem 5 Compass, usa eles
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

-- Coleta a missão semanal e reseta a data
local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3")
if WeeklyQuest.Value == 5 then
    workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId):WaitForChild("ChallengesRemote"):FireServer("Claim", "Weekly3")
    resetData() -- Reseta e recarrega o script automaticamente
end
