-- Data Printer Teste
if game.PlaceId == 3237168 then
    for _, player in pairs(game.Players:GetPlayers()) do
        local userData = game.Workspace.UserData:FindFirstChild("User_" .. player.UserId)

        if userData and userData:FindFirstChild("Data") then
            local Data = userData.Data
            
            print("========== DADOS DO JOGADOR: " .. player.Name .. " ==========")
            print("User ID:", player.UserId)
            print("Beri:", Data.Cash.Value)
            print("Bounty:", Data.Bounty.Value)
            print("Compasses:", Data.CompassTokens.Value)
            print("Gems:", Data.Gems.Value)
            print("Kills:", Data.Kills.Value)
            print("DF1:", Data.DevilFruit.Value)
            print("DF2:", Data.DevilFruit2.Value)

            -- Impressão das frutas armazenadas (StoredDF1 a StoredDF12)
            for i = 1, 12 do
                local storedDF = Data:FindFirstChild("StoredDF" .. i)
                if storedDF then
                    print("StoredDF" .. i .. ":", storedDF.Value)
                end
            end
            print("===========================================")
        else
            warn("UserData não encontrado para o jogador:", player.Name)
        end
    end
end
