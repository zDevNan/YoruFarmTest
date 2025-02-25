while true do
    wait(1) -- Delay para evitar sobrecarga

    local plr = game.Players.LocalPlayer
    local backpack = plr:FindFirstChild("Backpack")
    local humanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

    -- Função para contar quantos Compass o jogador tem na mochila
    local function countCompasses()
        local count = 0
        for _, item in ipairs(backpack:GetChildren()) do
            if item.Name == "Compass" then
                count = count + 1
            end
        end
        return count
    end

    -- Se ainda não tem 5 Compass, pega do chão
    while countCompasses() < 5 do
        wait(0.1)
        for _, item in ipairs(game.Workspace:GetChildren()) do
            if item.Name == "Compass" and item:FindFirstChild("Handle") then
                firetouchinterest(humanoidRootPart, item.Handle, 0)
                firetouchinterest(humanoidRootPart, item.Handle, 1)
                wait(0.2) -- Pequena espera para evitar problemas
                if countCompasses() >= 5 then break end
            end
        end
    end

    -- Agora que temos 5 Compass, usa eles
    if countCompasses() == 5 then
        local oldPosition = humanoidRootPart.Position
        local startTime = tick() -- Marca o tempo inicial para timeout

        repeat
            wait()
            pcall(function()
                local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3")
                if WeeklyQuest.Value < 5 then
                    local compass = backpack:FindFirstChild("Compass")
                    if compass and compass:FindFirstChild("Value") then
                        plr.Character.Humanoid:UnequipTools()
                        compass.Parent = plr.Character
                        humanoidRootPart.CFrame = CFrame.new(compass.Value.Value) -- Teleporta para a fruta
                        wait(0.2)
                        compass:Activate() -- Usa o Compass corretamente
                        wait(1) -- Pequena espera para evitar problemas
                        humanoidRootPart.CFrame = CFrame.new(oldPosition) -- Volta para a posição inicial
                    end
                end
            end)

            -- Se demorar mais de 15 segundos para completar, reseta a data
            if tick() - startTime > 15 then
                workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Stats:FireServer()
                break -- Sai do loop para reiniciar tudo
            end
        until workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3").Value == 5
    end

    -- Coleta a missão semanal se estiver pronta
    local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3")
    if WeeklyQuest.Value == 5 then
        workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId):WaitForChild("ChallengesRemote"):FireServer("Claim", "Weekly3")
        wait(1)

        -- Reset Data corretamente
        local userData = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId)
        if userData and userData:FindFirstChild("Stats") then
            userData.Stats:FireServer()
        end
    end
end
