local function removeTextures(obj)
    for _, descendant in ipairs(obj:GetDescendants()) do
        if descendant:IsA("Texture") or descendant:IsA("Decal") then
            descendant:Destroy()
        elseif descendant:IsA("BasePart") then
            descendant.Transparency = 1 -- Deixa o objeto invisível
        end
    end
end

-- Remove texturas e torna objetos invisíveis
removeTextures(game.Workspace)

-- Monitora novos objetos que aparecem no jogo
game.Workspace.ChildAdded:Connect(function(child)
    task.wait(0.5) -- Pequeno delay para garantir que o objeto carregou
    removeTextures(child)
end)
