local TabCompassButtonToggle3

local function GrabCompass()
    while true do
        wait(0.1)
        for _, Item in pairs(game.Workspace:GetChildren()) do
            if Item.Name == "Compass" and Item:FindFirstChild("Handle") then
                Item.Handle.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
            end
        end
    end
end

local function UseCompass()
    local CompassCount = 0
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Compass" then
            CompassCount = CompassCount + 1
        end
    end
    
    if CompassCount >= 5 then
        local OldPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        repeat
            wait()
            pcall(function()
                if workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId).Data:WaitForChild("QQ_Weekly3").Value < 5 then
                    local Compass = game.Players.LocalPlayer.Backpack:FindFirstChild("Compass") or game.Players.LocalPlayer.Character:FindFirstChild("Compass")
                    if Compass then
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                        Compass.Parent = game.Players.LocalPlayer.Character
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Compass.Poser.Value)
                        Compass:Activate()
                        wait(0.5)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OldPosition)
                    end
                end
            end)
        until workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId).Data:WaitForChild("QQ_Weekly3").Value == 5
    end
end

local function ClaimChallenge()
    local args = {
        [1] = "Claim",
        [2] = "Weekly3"
    }
    workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId):WaitForChild("ChallengesRemote"):FireServer(unpack(args))
    wait(1)
    workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId):WaitForChild("Stats"):FireServer()
    ResetPlayerData()
end

local function ResetPlayerData()
    workspace:WaitForChild("UserData"):WaitForChild("User_"..game.Players.LocalPlayer.UserId):WaitForChild("UpdateClothing_Extras"):FireServer("A","\255",31)
end

local function AutoFarm()
    while true do
        GrabCompass()
        UseCompass()
        ClaimChallenge()
        wait(2) -- Pequeno delay antes de repetir
    end
end

TabCompass:AddToggle({
    Name = "Auto Farm Compass",
    Default = false,
    Callback = function(Value)
        if Value then
            spawn(AutoFarm)
        end
    end
})
