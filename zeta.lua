local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
    Name = "Teste Rayfield",
    LoadingTitle = "Carregando...",
    LoadingSubtitle = "Aguarde...",
})

local Tab = Window:CreateTab("Geral", 4483362458)

Tab:CreateButton({
    Name = "Botão de Teste",
    Callback = function()
        print("Botão Clicado!")
    end
})
