while wait(8) do
    local player = game.Players.LocalPlayer
    local playerId = player.UserId
    local userDataName = game.Workspace.UserData["User_" .. playerId]

    -- Valores permitidos para afinidade
    local valoresPermitidos = {
        [1.7] = true, 
        [1.8] = true, 
        [1.9] = true, 
        [2.0] = true
    }

    local function verificaValor(valor)
        return valoresPermitidos[valor] ~= nil
    end

    -- DFT1 Variables
    local AffMelee1 = userDataName.Data.DFT1Melee.Value
    local AffSniper1 = userDataName.Data.DFT1Sniper.Value
    local AffDefense1 = userDataName.Data.DFT1Defense.Value
    local AffSword1 = userDataName.Data.DFT1Sword.Value

    -- DFT2 Variables
    local AffMelee2 = userDataName.Data.DFT2Melee.Value
    local AffSniper2 = userDataName.Data.DFT2Sniper.Value
    local AffDefense2 = userDataName.Data.DFT2Defense.Value
    local AffSword2 = userDataName.Data.DFT2Sword.Value

    -- Check for DFT1
    if verificaValor(AffSniper1) and verificaValor(AffSword1) and verificaValor(AffMelee1) and verificaValor(AffDefense1) then
        script.Parent:Destroy()
    end

    -- Check for DFT2
    if verificaValor(AffSniper2) and verificaValor(AffSword2) and verificaValor(AffMelee2) and verificaValor(AffDefense2) then
        script.Parent:Destroy()
    end

    local args1 = {
        [1] = "DFT1",
        [2] = false,  -- defense
        [3] = false,  -- melee
        [4] = false,  -- sniper
        [5] = false,  -- sword
        [6] = "Gems"
    }

    local args2 = {
        [1] = "DFT2",
        [2] = false,  -- defense
        [3] = false,  -- melee
        [4] = false,  -- sniper
        [5] = false,  -- sword
        [6] = "Gems"
    }

    if verificaValor(AffDefense1) then
        args1[2] = 0/0
    end

    if verificaValor(AffMelee1) then
        args1[3] = 0/0
    end

    if verificaValor(AffSniper1) then
        args1[4] = 0/0
    end

    if verificaValor(AffSword1) then
        args1[5] = 0/0
    end

    if verificaValor(AffDefense2) then
        args2[2] = 0/0
    end

    if verificaValor(AffMelee2) then
        args2[3] = 0/0
    end

    if verificaValor(AffSniper2) then
        args2[4] = 0/0
    end

    if verificaValor(AffSword2) then
        args2[5] = 0/0
    end

    workspace:WaitForChild("Merchants"):WaitForChild("AffinityMerchant"):WaitForChild("Clickable"):WaitForChild("Retum"):FireServer(unpack(args1))
    workspace:WaitForChild("Merchants"):WaitForChild("AffinityMerchant"):WaitForChild("Clickable"):WaitForChild("Retum"):FireServer(unpack(args2))
end
