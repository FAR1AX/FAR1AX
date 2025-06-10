--// Variáveis principais
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Criar GUI
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "HohoHub"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0

local UIListLayout = Instance.new("UIListLayout", MainFrame)
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

--// Função para criar botões
local function CreateButton(text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.Text = text
    btn.Parent = MainFrame
    return btn
end

--// Variáveis de controle
local autoFarm = false
local autoLevel = false

--// Remote para auto level (ajuste o nome conforme seu jogo)
local levelRemote = ReplicatedStorage:WaitForChild("AddPoint") -- Exemplo de nome

--// Função Auto Farm
local function runAutoFarm()
    spawn(function()
        while autoFarm do
            wait(0.5)
            for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                if enemy.Name == "Bandit" and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                    root.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                    VirtualInputManager:SendKeyEvent(true, "Z", false, game)
                    wait(0.1)
                    VirtualInputManager:SendKeyEvent(false, "Z", false, game)
                    repeat wait() until enemy.Humanoid.Health <= 0 or not autoFarm
                end
            end
        end
    end)
end

--// Função Auto Level
local function runAutoLevel()
    spawn(function()
        while autoLevel do
            wait(1)
            if levelRemote then
                levelRemote:FireServer("Strength") -- Parâmetro pode mudar conforme o jogo
            end
        end
    end)
end

--// Botão Auto Farm
local btnAutoFarm = CreateButton("Ativar Auto Farm")
btnAutoFarm.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    btnAutoFarm.Text = autoFarm and "Auto Farm Ligado" or "Ativar Auto Farm"
    if autoFarm then runAutoFarm() end
end)

--// Botão Auto Level
local btnAutoLevel = CreateButton("Ativar Auto Level")
btnAutoLevel.MouseButton1Click:Connect(function()
    autoLevel = not autoLevel
    btnAutoLevel.Text = autoLevel and "Auto Level Ligado" or "Ativar Auto Level"
    if autoLevel then runAutoLevel() end
end)

--// Botão Teleportar para Starter Island
local btnTeleport = CreateButton("Teleportar para Starter Island")
btnTeleport.MouseButton1Click:Connect(function()
    local starterIslandPos = CFrame.new(1037, 17, 1434) -- Ajuste conforme o mapa atual
    if character and root then
        character:SetPrimaryPartCFrame(starterIslandPos)
    end
end)

--// Botão fechar (esconde GUI)
local btnClose = CreateButton("Fechar GUI")
btnClose.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

--// Toggle para abrir/fechar GUI com tecla M
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.M then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)
local levelRemote = ReplicatedStorage:WaitForChild("AddPoint")
local levelRemote = ReplicatedStorage:WaitForChild("NomeDoRemoteQueVocêEncontrou")
levelRemote:FireServer("Strength") -- ou outro parâmetro correto

  end
end)
local testButton = Instance.new("TextButton")
testButton.Size = UDim2.new(1, -20, 0, 50)
testButton.Position = UDim2.new(0, 10, 0, 10)
testButton.Text = "Funcionou!"
testButton.Parent = MainFrame
repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
