-- Certifique-se de que a biblioteca Rayfield está carregada
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

if game.PlaceId == 3237168 then
    -- Criando a Janela Principal da UI
    local Window = Rayfield:CreateWindow({
        Name = "Data Printer - OP:L",
        LoadingTitle = "Carregando Dados...",
        LoadingSubtitle = "Aguarde...",
        ConfigurationSaving = {
            Enabled = false
        }
    })

    -- Criando a Aba de Jogadores
    local PlayerTab = Window:CreateTab("Jogadores", 4483362458) -- Ícone de player

    -- Criando a Seção Principal
    local PlayerSection = PlayerTab:CreateSection("Lista de Jogadores")

    -- Percorrendo todos os jogadores no servidor
    for _, player in pairs(game.Players:GetPlayers()) do
        local userData = game.Workspace.UserData:FindFirstChild("User_" .. player.UserId)

        if userData and userData:FindFirstChild("Data") then
            local Data = userData.Data

            -- Criando um botão para cada jogador
            PlayerTab:CreateButton({
                Name = player.Name,
                Callback = function()
                    -- Criando uma aba específica para o jogador selecionado
                    local PlayerStatsTab = Window:CreateTab(player.Name, 4483362458)
                    
                    -- Criando uma seção dentro da aba
                    local StatsSection = PlayerStatsTab:CreateSection("Estatísticas de " .. player.Name)

                    -- Função para exibir os dados na interface
                    local function addLabel(text)
                        PlayerStatsTab:CreateLabel(text)
                    end

                    addLabel("User ID: " .. player.UserId)
                    addLabel("Beri: " .. Data.Cash.Value)
                    addLabel("Bounty: " .. Data.Bounty.Value)
                    addLabel("Compasses: " .. Data.CompassTokens.Value)
                    addLabel("Gems: " .. Data.Gems.Value)
                    addLabel("Kills: " .. Data.Kills.Value)
                    addLabel("DF1: " .. Data.DevilFruit.Value)
                    addLabel("DF2: " .. Data.DevilFruit2.Value)

                    -- Adicionando as frutas armazenadas (StoredDF1 a StoredDF12)
                    for i = 1, 12 do
                        local storedDF = Data:FindFirstChild("StoredDF" .. i)
                        if storedDF then
                            addLabel("StoredDF" .. i .. ": " .. storedDF.Value)
                        end
                    end
                end
            })
        else
            warn("UserData não encontrado para o jogador:", player.Name)
        end
    end
end
