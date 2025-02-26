--[[ 
    Este script automatiza o processo de coleta e uso de Compass para completar a missão semanal no jogo.
    Ele verifica se o jogador possui 5 Compass na mochila, caso contrário, coleta do chão.
    Após obter 5 Compass, ele os utiliza corretamente para completar a missão e, em seguida, reseta os dados.
    Caso o processo demore muito, ele faz um reset para evitar falhas.
]]--

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
            firetouchinterest(humanoidRootPart, compass.Handle, 0)
            firetouchinterest(humanoidRootPart, compass.Handle, 1)
            task.wait(0.1) -- Pequeno delay para evitar sobrecarga
            needed = needed - 1
        end
    end

    -- Coleta Compass se necessário
    if countCompasses() < 5 then
        collectCompasses()
    end

    -- Usa os Compass para completar a missão
    if countCompasses() >= 5 then
        local oldPosition = humanoidRootPart.Position
        local userData = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId)
        local WeeklyQuest = userData.Data:WaitForChild("QQ_Weekly3")

        while WeeklyQuest.Value < 5 do
            local compass = backpack:FindFirstChild("Compass") or character:FindFirstChild("Compass")
            if compass then
                plr.Character.Humanoid:UnequipTools()
                compass.Parent = plr.Character
                humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
                compass:Activate()
                task.wait(0.5)
                humanoidRootPart.CFrame = CFrame.new(oldPosition)
            end
            task.wait(0.1) -- Pequeno delay para evitar sobrecarga
        end
    end

    -- Coleta a recompensa da missão
    local WeeklyQuest = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId).Data:WaitForChild("QQ_Weekly3")
    if WeeklyQuest.Value == 5 then
        workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId):WaitForChild("ChallengesRemote"):FireServer("Claim", "Weekly3")
        task.wait(1)

        -- Reseta os dados
        local userData = workspace:WaitForChild("UserData"):WaitForChild("User_" .. plr.UserId)
        if userData:FindFirstChild("Stats") then
            userData.Stats:FireServer()
        end
    end
end
