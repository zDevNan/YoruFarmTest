local Speeds = 500000 -- Define o valor fixo da velocidade do Yoru
local ToggleActive = true -- Define que o spam já estará ativo ao iniciar

-- Função para iniciar o spam
function StartYoruSpam()
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

-- Inicia o spam automaticamente
print("Yoru Spam Ativado!")
StartYoruSpam()
