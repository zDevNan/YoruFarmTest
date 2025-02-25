local function CheckAndReset()
    while true do
        if workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].Data.QQ_Weekly3.Value >= 5 then
            workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].UpdateClothing_Extras:FireServer("A", "\255", 31)
        end
        wait(1) -- Verifica a cada 1 segundo
    end
end

TabCompass:AddToggle({
    Name = "Auto Reset on Mission Complete",
    Default = false,
    Callback = function(Value)
        if Value then
            spawn(CheckAndReset)
        end
    end
})
