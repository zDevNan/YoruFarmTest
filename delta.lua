_G.Cestus = true -- Ativar spam
local Speedss = 5 -- Quantidade de execuções por ciclo

task.spawn(function()
    while _G.Cestus do
        task.wait()

        local Plr = game:GetService("Players").LocalPlayer
        if not Plr.Character then continue end

        local Cestus = Plr.Character:FindFirstChild("Seastone Cestus")
        if not Cestus then continue end

        local Environment = getsenv(Cestus["AnimationController"])
        if not Environment then continue end

        for _ = 1, Speedss do
            Cestus["RequestAnimation"]:FireServer(Environment.PlaceId)
        end
    end
end)
