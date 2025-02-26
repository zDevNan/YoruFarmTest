while true do
    task.wait(1) -- Delay inicial para evitar sobrecarga

    local plr = game.Players.LocalPlayer
    local backpack = plr.Backpack
    local character = plr.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart then
        warn("HumanoidRootPart não encontrado!")
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

        -- Armazena Compass do Workspace em uma tabela
        local compasses = {}
        for _, item in pairs(game.Workspace:GetDescendants()) do
            if item.Name == "Compass" and item:FindFirstChild("Handle") then
                table.insert(compasses, item)
            end
        end

        for _, compass in pairs(compasses) do
            if needed <= 0 then break end
            firetouchinterest(humanoidRootPart, compass.Handle, 0) -- Inicia o toque
            firetouchinterest(humanoidRootPart, compass.Handle, 1) -- Finaliza o toque
            task.wait(0.2) -- Pequeno delay para garantir que o Compass seja coletado
            needed = needed - 1
        end
    end

    -- Coleta Compass se necessário
    if countCompasses() < 5 then
        print("Coletando Compass...")
        collectCompasses()
    else
        print("Já tem 5 Compass na mochila.")
    end

    -- Usa os Compass para completar a missão
    if countCompasses() >= 5 then
        local oldPosition = humanoidRootPart.Position
        local userData = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId)
        local WeeklyQuest = userData.Data:WaitForChild("QQ_Weekly3")

        while WeeklyQuest.Value < 5 do
            task.wait()
            pcall(function()
                local compass = backpack:FindFirstChild("Compass") or character:FindFirstChild("Compass")
                if compass then
                    plr.Character.Humanoid:UnequipTools()
                    compass.Parent = plr.Character
                    humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
                    compass:Activate()
                    task.wait(0.5)
                    humanoidRootPart.CFrame = CFrame.new(oldPosition)
                end
            end)
        end
    end

    -- Coleta a recompensa da missão
    local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3")
    if WeeklyQuest.Value == 5 then
        print("Missão semanal completa. Coletando recompensa...")
        workspace:WaitForChild
