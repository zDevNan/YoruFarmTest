local Speeds = 50 -- Define o valor fixo da velocidade do Seastone Cestus
local ToggleActive = true -- Define que o spam já estará ativo ao iniciar

-- Função para iniciar o spam
function StartCestusSpam()
    while ToggleActive do
        wait()
        local success, err = pcall(function()
            local Players = game:GetService("Players")
            local Plr = Players.LocalPlayer
            local Character = Plr.Character
            local Cestus = Character:FindFirstChild("Seastone Cestus")
            local Environment

            -- Valida se o Cestus existe no personagem
            if Cestus then
                for _, conn in pairs(getconnections(Cestus["RequestAnimation"].OnClientEvent)) do
                    Environment = getsenv(Cestus["AnimationController"])
                end
                wait()

                -- Envia requisições ao servidor
                for _ = 1, Speeds do
                    Cestus["RequestAnimation"]:FireServer(Environment.PlaceId)
                end
            end
        end)

        if not success then
            warn("Erro ao executar Seastone Cestus Spam:", err)
        end
    end
end

-- Inicia o spam automaticamente
print("Seastone Cestus Spam Ativado!")
StartCestusSpam()
