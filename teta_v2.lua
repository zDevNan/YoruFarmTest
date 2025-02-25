while true do
    -- Pega 5 Compass do chão
    local count = 0
    while count < 5 do
        wait(0.1)
        for _, Item in pairs(game.Workspace:GetChildren()) do
            if Item.Name == "Compass" and Item:FindFirstChild("Handle") then
                Item.Handle.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
                count = count + 1
                if count >= 5 then break end
            end
        end
    end

    -- Salva a posição original do jogador
    local OldPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    local CompassCount = 0

    repeat
        wait()
        pcall(function()
            local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId).Data:WaitForChild("QQ_Weekly3")
            if WeeklyQuest.Value < 5 then
                local Compass = game.Players.LocalPlayer.Backpack:FindFirstChild("Compass") or game.Players.LocalPlayer.Character:FindFirstChild("Compass")
                if Compass then
                    game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                    Compass.Parent = game.Players.LocalPlayer.Character
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Compass.Poser.Value) -- Vai até o CFrame do Compass
                    Compass:Activate()
                    CompassCount = CompassCount + 1
                    wait(0.5)
                end
            end
        end)
    until CompassCount >= 5

    -- Retorna o jogador para a posição original
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OldPosition)

    -- Coleta a missão
    workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId):WaitForChild("ChallengesRemote"):FireServer("Claim", "Weekly3")
    wait(1)

    -- Reseta a data do jogador
    workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId):WaitForChild("UpdateClothing_Extras"):FireServer("A","\255",31)

    wait(2) -- Pequeno delay antes de repetir
end
