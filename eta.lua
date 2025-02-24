for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    if v:FindFirstChild("DF_Script") then
        local Message = v.Data.Value
        local SplitMessage = string.split(Message, ",")
        local AuraValue = tonumber(SplitMessage[6])
        
        if AuraValue == 1 then
            game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
end
