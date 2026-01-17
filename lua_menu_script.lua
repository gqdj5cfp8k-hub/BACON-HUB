--[[
Script para criar um menu cinza transparente com funcionalidades de minimizar, fechar e mover. Contém uma opção chamada 'Red Sky'.
Quando ativado, altera a cor do céu do jogo para vermelho para todos os jogadores.
]]

-- Criar um ScreenGui local ScreenGUI = Instance.new("ScreenGui")
ScreenGUI.Name = "RedSkyMenu"

-- Configuração do Frame principal local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
MainFrame.BackgroundTransparency = 0.5
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGUI

-- Título do menu local Title = Instance.new("TextLabel")
Title.Text = "Configurações"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Parent = MainFrame

-- Botão Minimize local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "_"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.Parent = MainFrame

-- Botão Fechar local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(128, 0, 0)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Parent = MainFrame

-- Red Sky Option local RedSkyFrame = Instance.new("Frame")
RedSkyFrame.Size = UDim2.new(1, 0, 0, 50)
RedSkyFrame.Position = UDim2.new(0, 0, 0, 35)
RedSkyFrame.BackgroundTransparency = 1
RedSkyFrame.Parent = MainFrame

local RedSkyLabel = Instance.new("TextLabel")
RedSkyLabel.Text = "Red Sky"
RedSkyLabel.Size = UDim2.new(0.7, 0, 1, 0)
RedSkyLabel.BackgroundTransparency = 1
RedSkyLabel.TextColor3 = Color3.new(1, 1, 1)
RedSkyLabel.Parent = RedSkyFrame

local RedSkyToggle = Instance.new("TextButton")
RedSkyToggle.Text = "Off"
RedSkyToggle.Size = UDim2.new(0.3, -10, 1, -10)
RedSkyToggle.Position = UDim2.new(0.7, 10, 0, 5)
RedSkyToggle.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
RedSkyToggle.TextColor3 = Color3.new(1, 1, 1)
RedSkyToggle.Parent = RedSkyFrame

-- Lógica para funcionalidades locais function ToggleRedSky()
    if RedSkyToggle.Text == "Off" then
        RedSkyToggle.Text = "On"
        RedSkyToggle.BackgroundColor3 = Color3.fromRGB(0, 128, 0)

        -- Altera o céu do jogo para vermelho
        local Lighting = game:GetService("Lighting")
        if Lighting then
            Lighting:SetAttribute("OriginalSky", Lighting:FindFirstChildOfClass("Sky"))

            local newSky = Instance.new("Sky")
            newSky.SkyboxBk = "rbxassetid://5537545244" -- Céu vermelho
            newSky.SkyboxFt = newSky.SkyboxBk
            newSky.SkyboxLf = newSky.SkyboxBk
            newSky.SkyboxRt = newSky.SkyboxBk
            newSky.SkyboxUp = newSky.SkyboxBk
            newSky.SkyboxDn = newSky.SkyboxBk
            newSky.Parent = Lighting

            if Lighting.OriginalSky then
                Lighting.OriginalSky:Destroy()
            end
        end
    else
        RedSkyToggle.Text = "Off"
        RedSkyToggle.BackgroundColor3 = Color3.fromRGB(128, 128, 128)

        -- Restaura o céu original
        local Lighting = game:GetService("Lighting")
        Lighting:SetAttribute("OriginalSky", Lighting.OriginalSky)
    end
end

RedSkyToggle.MouseButton1Click:Connect(ToggleRedSky)

MinimizeButton.MouseButton1Click:Connect(function()
    if MainFrame.Size.Y.Offset > 30 then
        MainFrame.Size = UDim2.new(0, 300, 0, 30)
    else
        MainFrame.Size = UDim2.new(0, 300, 0, 200)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGUI:Destroy()
end)

ScreenGUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")