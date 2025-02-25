local function GrabCompass()
    local count = 0
    while count < 5 do
        for _, Item in pairs(game.Workspace:GetChildren()) do
            if Item.Name == "Compass" and Item:FindFirstChild("Handle") then
                Item.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                count = count + 1
                if count >= 5 then return end
            end
        end
        wait(0.1)
    end
end

local function UseCompass()
    while workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].Data.QQ_Weekly3.Value < 5 do
        local Compass = game.Players.LocalPlayer.Backpack:FindFirstChild("Compass") or game.Players.LocalPlayer.Character:FindFirstChild("Compass")
        if Compass then
            local OldPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
            Compass.Parent = game.Players.LocalPlayer.Character
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Compass.Poser.Value
            Compass:Activate()
            wait(0.5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OldPosition
        end
        wait()
    end
end

local function ClaimChallenge()
    workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].ChallengesRemote:FireServer("Claim", "Weekly3")
    wait(1)
    workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].Stats:FireServer()
end

local function ResetPlayerData()
    workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].UpdateClothing_Extras:FireServer("A", "\255", 31)
end

local function AutoFarm()
    while true do
        GrabCompass()
        UseCompass()
        ClaimChallenge()
        ResetPlayerData()
        wait(2)
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
