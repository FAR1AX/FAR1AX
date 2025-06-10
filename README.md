![1000024100](https://github.com/user-attachments/assets/ef3548ec-0415-4e78-a64c-97f7c774090e)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Criar GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HohoHub"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainFrame
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function CreateButton(text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.Text = text
    btn.Parent = MainFrame
    return btn
end

-- Variáveis para toggle
local autoFarm = false
local autoLevel = false

-- Função Auto Farm
local function runAutoFarm()
    spawn(function()
        while autoFarm do
            wait(0.5)
            for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                if enemy.Name == "Bandit" and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    humanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                    VirtualInputManager:SendKeyEvent(true, "Z", false, game)
                    wait(0.1)
                    VirtualInputManager:SendKeyEvent(false, "Z", false, game)
                    repeat wait() until enemy.Humanoid.Health <= 0 or not autoFarm
                end
            end
        end
    end)
end

-- Função Auto Level
local function runAutoLevel()
    spawn(function()
        while autoLevel do
            wait(1)
            local stats = player:FindFirstChild("leaderstats")
            if stats and stats:FindFirstChild("Strength") then
                stats.Strength.Value = stats.Strength.Value + 1
            end
        end
    end)
end

-- Botão Auto Farm
local btnAutoFarm = CreateButton("Ativar Auto Farm")
btnAutoFarm.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    btnAutoFarm.Text = autoFarm and "Auto Farm Ligado" or "Ativar Auto Farm"
    if autoFarm then runAutoFarm() end
end)

-- Botão Auto Level
local btnAutoLevel = CreateButton("Ativar Auto Level")
btnAutoLevel.MouseButton1Click:Connect(function()
    autoLevel = not autoLevel
    btnAutoLevel.Text = autoLevel and "Auto Level Ligado" or "Ativar Auto Level"
    if autoLevel then runAutoLevel() end
end)

-- Botão Teleportar para Starter Island
local btnTeleport = CreateButton("Teleportar para Starter Island")
btnTeleport.MouseButton1Click:Connect(function()
    local starterIslandPos = CFrame.new(0, 100, 0)
    humanoidRootPart.CFrame = starterIslandPos
end)

-- Toggle mostrar/ocultar GUI com tecla M
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.M then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)
