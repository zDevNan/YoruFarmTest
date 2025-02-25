while true do
    wait(1) -- Pequeno delay para evitar sobrecarga

    local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId).Data:WaitForChild("QQ_Weekly3")

    if WeeklyQuest.Value == 5 then
        -- Coleta a missão
        workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId):WaitForChild("ChallengesRemote"):FireServer("Claim", "Weekly3")
        wait(1)

        -- Reseta a data do jogador
        workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId):WaitForChild("UpdateClothing_Extras"):FireServer("A","\255",31)

        wait(2) -- Pequeno delay antes de continuar verificando
    end
end
