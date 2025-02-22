_G.Cestus = true -- Define que o spam já inicia ativado
local Speedss = 10 -- Define quantas vezes a animação será executada por ciclo

while _G.Cestus do
    wait()

    local success, err = pcall(function()
        local Players = game:GetService("Players")
        local Plr = Players.LocalPlayer
        local Character = Plr.Character
        local Cestus = Character:FindFirstChild("Seastone Cestus")

        if Cestus then
            local Environment
            for _, conn in pairs(getconnections(Cestus["RequestAnimation"].OnClientEvent)) do
                Environment = getsenv(Cestus["AnimationController"])
            end

            for _ = 1, Speedss do
                Cestus["RequestAnimation"]:FireServer(Environment.PlaceId)
            end
        end
    end)

    if not success then
        warn("Erro ao executar Seastone Cestus Spam:", err)
    end
end
