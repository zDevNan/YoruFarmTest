-- Define as coordenadas para onde o jogador será teleportado
local targetPosition = CFrame.new(-1526.0230712891, 364.99990844727, 10510.020507812)

-- Define o valor fixo da velocidade do Yoru
local Speeds = 500000
local ToggleActive = true -- Define que o spam já estará ativo ao iniciar

-- Teleporta o jogador para as coordenadas antes de iniciar o spam
local function teleportPlayer()
    local LP = game.Players.LocalPlayer
    local char = LP.Character or LP.CharacterAdded:Wait()

    -- Verifica se o personagem tem um HumanoidRootPart para teleportar
    if char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = targetPosition
        print("Jogador teleportado para as coordenadas.")
    else
        warn("HumanoidRootPart não encontrado no personagem.")
    end
end

-- Função para iniciar o spam
local function StartYoruSpam()
    while ToggleActive do
        wait()
        local success, err = pcall(function()
            local Players = game:GetService("Players")
            local Plr = Players.LocalPlayer
            local Character = Plr.Character
            local Yoru = Character:FindFirstChild("Yoru")
            local Environment

            -- Valida se o Yoru existe no personagem
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

-- Primeiro, teleporta o jogador para o local desejado
teleportPlayer()

-- Inicia o spam automaticamente
print("Yoru Spam Ativado!")
StartYoruSpam()
