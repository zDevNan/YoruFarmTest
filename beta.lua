local Speeds = 2000 -- Define o valor fixo da velocidade do Yoru
local ToggleActive = false -- Controla se o spam está ativo ou não

-- Função para iniciar o spam
function StartYoruSpam()
    ToggleActive = true
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

-- Função para parar o spam
function StopYoruSpam()
    ToggleActive = false
end

-- Alterna entre iniciar e parar o spam
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then -- Pressione 'F' para alternar
        if not ToggleActive then
            print("Yoru Spam Ativado!")
            StartYoruSpam()
        else
            print("Yoru Spam Desativado!")
            StopYoruSpam()
        end
    end
end)
