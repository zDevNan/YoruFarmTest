local LP = game.Players.LocalPlayer
local targetPosition = CFrame.new(-1526.0230712891, 364.99990844727, 10510.020507812)

local Speeds = 100000 -- Velocidade do Yoru Spam
local ToggleActive = true -- Controle para ativar/desativar o Yoru Spam
local isAnchored = true -- Controle para ancorar o jogador

-- Função para teleportar o jogador para a posição alvo
local function teleportPlayer()
    local char = LP.Character or LP.CharacterAdded:Wait()

    if char:FindFirstChild("HumanoidRootPart") then
        local rootPart = char.HumanoidRootPart
        rootPart.CFrame = targetPosition
        print("Jogador teleportado para a posição alvo.")
    else
        warn("HumanoidRootPart não encontrado no jogador.")
    end
end

-- Função para fixar o jogador na posição alvo
local function fixPlayerPosition()
    local char = LP.Character or LP.CharacterAdded:Wait()

    if char:FindFirstChild("HumanoidRootPart") then
        local rootPart = char.HumanoidRootPart
        while true do
            wait(0.1)
            rootPart.CFrame = targetPosition -- Mantém o jogador na posição alvo
            rootPart.Anchored = isAnchored -- Define a ancoragem do jogador
        end
    else
        warn("HumanoidRootPart não encontrado no jogador.")
    end
end

-- Função para iniciar o Yoru Spam
local function StartYoruSpam()
    while ToggleActive do
        wait()
        local success, err = pcall(function()
            local Character = LP.Character
            local Yoru = Character:FindFirstChild("Yoru")
            local Environment

            if Yoru then
                for _, conn in pairs(getconnections(Yoru["RequestAnimation"].OnClientEvent)) do
                    Environment = getsenv(Yoru["AnimationController"])
                end
                wait()

                -- Envia requisições ao servidor
                for _ = 1, Speeds do
                    Yoru["RequestAnimation"]:FireServer(Environment.PlaceId)
                end
            end
        end)

        if not success then
            warn("Erro ao executar Yoru Spam:", err)
        end
    end
end

-- Função para seguir o inimigo chamado "Kaizu"
local function followEnemy()
    local char = LP.Character or LP.CharacterAdded:Wait()
    local humanoidRootPart = char:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart then
        while true do
            wait(0.1)
            local enemy = nil

            for _, obj in pairs(workspace.Enemies:GetChildren()) do
                if obj.Name == "Kaizu" and obj:FindFirstChild("HumanoidRootPart") and obj:FindFirstChild("Humanoid") then
                    enemy = obj
                    break
                end
            end

            if enemy then
                local enemyRoot = enemy.HumanoidRootPart
                humanoidRootPart.CFrame = enemyRoot.CFrame -- Atualiza a posição do jogador para o inimigo
            else
                print("Inimigo 'Kaizu' não encontrado.")
            end
        end
    else
        warn("HumanoidRootPart não encontrado no jogador.")
    end
end

-- Inicializa os processos em threads separadas
spawn(function()
    teleportPlayer() -- Teleporta o jogador para a posição inicial
    fixPlayerPosition() -- Mantém o jogador fixado na posição inicial
end)

spawn(function()
    StartYoruSpam() -- Inicia o spam do Yoru
end)

spawn(function()
    followEnemy() -- Faz o jogador seguir o inimigo "Kaizu"
end)

print("Script ativado! O jogador está sendo teleportado, fixado e seguindo o inimigo 'Kaizu'.")
