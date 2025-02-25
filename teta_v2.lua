while true do
    wait(1) -- Pequeno delay para evitar sobrecarga

    local success, WeeklyQuest = pcall(function()
        return workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId).Data:WaitForChild("QQ_Weekly3")
    end)

    if success and WeeklyQuest and WeeklyQuest.Value == 5 then
        -- Coleta a missão semanal
        workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId):WaitForChild("ChallengesRemote"):FireServer("Claim", "Weekly3")
        wait(1)

        -- Executa o verdadeiro reset da data
        local userData = workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId)
        if userData and userData:FindFirstChild("Stats") then
            userData.Stats:FireServer() -- Esse comando pode ser o reset real
        end

        wait(2) -- Pequeno delay antes de continuar verificando
    end
end
