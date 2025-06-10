local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HohoHub"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 300)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainFrame
UIListLayout.Padding = UDim.new(0, 10)

local function CreateButton(text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.Text = text
    btn.Parent = MainFrame
    return btn
end

-- Botões e variáveis
local autoFarm = false

local btnAutoFarm = CreateButton("Ativar Auto Farm")
btnAutoFarm.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    btnAutoFarm.Text = autoFarm and "Auto Farm Ligado" or "Ativar Auto Farm"
    
    if autoFarm then
        task.spawn(function()
            while autoFarm do
                for _, enemy in pairs(workspace:GetDescendants()) do
                    if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
                        if string.find(enemy.Name, "Bandit") then -- Nome parcial funciona com Blox Fruits
                            humanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                            VirtualInputManager:SendKeyEvent(true, "Z", false, game)
                            task.wait(0.1)
                            VirtualInputManager:SendKeyEvent(false, "Z", false, game)
                            repeat task.wait() until enemy.Humanoid.Health <= 0 or not autoFarm
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end
end)

local btnTeleport = CreateButton("Teleportar para Ilha Inicial")
btnTeleport.MouseButton1Click:Connect(function()
    humanoidRootPart.CFrame = CFrame.new(1037, 16, 1434) -- Posição próxima à Starter Island
end)

-- Botão para fechar GUI
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 18
closeBtn.Parent = MainFrame

closeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Toggle com tecla "M"
UIS.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.M then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
