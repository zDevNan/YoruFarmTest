-- Carregando a Kavo UI Library
local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/ShadowLeaker/Kavo-UI-Fixed/main/main.lua"))()

-- Criando a Janela Principal
local Window = Kavo.CreateLib("Data Printer - OP:L", "DarkTheme")

-- Criando a Aba Principal
local Tab = Window:NewTab("Jogadores")

-- Criando a Seção dentro da Aba
local Section = Tab:NewSection("Lista de Jogadores")

-- Percorrendo todos os jogadores no servidor
for _, player in pairs(game.Players:GetPlayers()) do
    local userData = game.Workspace.UserData:FindFirstChild("User_" .. player.UserId)

    if userData and userData:FindFirstChild("Data") then
        local Data = userData.Data

        -- Criando um botão para cada jogador
        Section:NewButton(player.Name, "Clique para ver os dados", function()
            -- Criando uma nova aba para mostrar os dados do jogador
            local PlayerTab = Window:NewTab(player.Name)
            local PlayerSection = PlayerTab:NewSection("Estatísticas")

            -- Função para exibir os dados na interface
            local function addLabel(text)
                PlayerSection:NewLabel(text)
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
        end)
    else
        warn("UserData não encontrado para o jogador:", player.Name)
    end
end
