local LP = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

-- Função para ativar/desativar o Haki
local function ActivateHaki(state)
    pcall(function()
        local userId = LP.UserId
        local hakiEvent = game.Workspace.UserData["User_" .. userId].UpdateHaki
        hakiEvent:FireServer()
    end)
end

-- Loop que equipa continuamente a ferramenta "Cannon Ball"
RunService.Heartbeat:Connect(function()
    if LP.Backpack:FindFirstChild("Cannon Ball") and not LP.Character:FindFirstChild("Cannon Ball") then
        LP.Character.Humanoid:EquipTool(LP.Backpack["Cannon Ball"])
    end
end)

-- Loop que trata dos inimigos com atualização mais rápida
spawn(function()
    while task.wait(0.001) do -- Reduz o tempo de espera para atualização mais rápida
        pcall(function()
            for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") then
                    local enemyHumanoid = enemy.Humanoid
                    local enemyRoot = enemy.HumanoidRootPart

                    -- Apenas interage com inimigos vivos
                    if enemyHumanoid.Health > 0 then
                        -- Ativa o Haki antes de atacar
                        ActivateHaki(true)

                        -- Move o inimigo para perto do jogador
                        enemyRoot.Anchored = true
                        enemyRoot.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)

                        -- Ataca o inimigo
                        if LP.Character:FindFirstChild("Cannon Ball") then
                            local cannonBall = LP.Character["Cannon Ball"]
                            local args = {
                                [1] = enemyRoot.CFrame
                            }
                            cannonBall.RemoteEvent:FireServer(unpack(args))
                        end
                    else
                        -- Caso o inimigo esteja morto, desativa o Haki
                        ActivateHaki(false)
                    end
                end
            end
        end)
    end
end)

-- Anti-AFK
LP.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

-- Reconectar ao servidor
local function Reconnect()
    while true do
        task.wait(1)
        if not pcall(function()
            local testConnection = game:GetService("Players").LocalPlayer
        end) then
            TeleportService:Teleport(game.PlaceId)
        end
    end
end

spawn(Reconnect)
