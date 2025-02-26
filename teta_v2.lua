--[[  
    Este script coleta e usa Compass para completar a missão semanal no jogo.
    Após obter 5 Compass, ele os utiliza para finalizar a missão e coletar a recompensa.
    No final, ele **força** o reset dos dados da missão para que possa ser refeita sem erros.
    Se o processo travar por muito tempo, o personagem é resetado para evitar falhas.
]]--

while true do
    task.wait(1) -- Delay inicial para evitar sobrecarga

    local plr = game.Players.LocalPlayer
    local backpack = plr:FindFirstChild("Backpack")
    local character = plr.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart or not backpack then
        warn("[⚠] Erro: HumanoidRootPart ou Backpack não encontrado!")
        task.wait(1)
        continue
    end

    -- Função para contar Compass na mochila
    local function countCompasses()
        local count = 0
        for _, item in pairs(backpack:GetChildren()) do
            if item.Name == "Compass" then
                count = count + 1
            end
        end
        return count
    end

    -- Função para coletar Compass do chão
    local function collectCompasses()
        local needed = 5 - countCompasses()
        if needed <= 0 then return end

        for _, item in pairs(game.Workspace:GetChildren()) do
            if needed <= 0 then break end
            if item:IsA("Tool") and item.Name == "Compass" and item:FindFirstChild("Handle") then
                firetouchinterest(humanoidRootPart, item.Handle, 0)
                firetouchinterest(humanoidRootPart, item.Handle, 1)
                task.wait(0.2) -- Delay para evitar falhas
                needed = needed - 1
            end
        end
    end

    -- Coleta Compass se necessário
    if countCompasses() < 5 then
        collectCompasses()
    end

    -- Usa os Compass para completar a missão
    if countCompasses() >= 5 then
        local oldPosition = humanoidRootPart.Position
        local userData = workspace:FindFirstChild("UserData") and workspace.UserData:FindFirstChild("User_" .. plr.UserId)
        local WeeklyQuest = userData and userData.Data:FindFirstChild("QQ_Weekly3")

        if not WeeklyQuest then
            warn("[⚠] Erro: Missão semanal não encontrada!")
            task.wait(1)
            continue
        end

        local startTime = tick() -- Marca o tempo inicial

        while WeeklyQuest.Value < 5 do
            if tick() - startTime > 30 then
                warn("[⚠] Tempo limite atingido! Resetando personagem...")
                plr.Character:BreakJoints()
                break
            end

            local compass = backpack:FindFirstChild("Compass") or character:FindFirstChild("Compass")
            if compass and compass:FindFirstChild("Poser") then
                plr.Character.Humanoid:UnequipTools()
                compass.Parent = character
                humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
                compass:Activate()
                task.wait(0.5)
                humanoidRootPart.CFrame = CFrame.new(oldPosition)
            end
            task.wait(0.1)
        end
    end

    -- Coleta a recompensa da missão
    local userData = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId)
    local WeeklyQuest = userData.Data:WaitForChild("QQ_Weekly3")

    if WeeklyQuest.Value == 5 then
        print("[✅] Missão semanal completa. Coletando recompensa...")
        local challengesRemote = userData:FindFirstChild("ChallengesRemote")
        if challengesRemote then
            challengesRemote:FireServer("Claim", "Weekly3")
        end
        task.wait(1)

        -- **Executa o verdadeiro reset da data**
        print("[♻] Resetando dados da missão...")
        local stats = userData:FindFirstChild("Stats")
        if stats then
            stats:FireServer() -- Comando correto para resetar
            task.wait(2) -- Aguarda para garantir que o reset foi feito
            print("[✔] Reset concluído! Missão pode ser refeita.")
        else
            warn("[⚠] Erro: Stats não encontrado! Não foi possível resetar a missão.")
        end
    end
end
