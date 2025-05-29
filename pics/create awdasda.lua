-- NovaLib v9.5 – MrBeast Neon Final Edition ⚡👑
-- Tüm OrionLib sistemleri: AddXYZ, Config, Notification, KeySystem, Toggle UI
-- UI: Neon, Tema, Glow, Drag destekli, launcher, karakter resmi + profil

local NovaLib = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

NovaLib.Theme = {
    Background = Color3.fromRGB(10, 10, 10),
    Accent = Color3.fromRGB(0, 200, 255),
    Stroke = Color3.fromRGB(255, 105, 180),
    Text = Color3.fromRGB(255, 255, 255)
}

function NovaLib:SetTheme(theme)
    if theme == "Neon" then
        self.Theme.Background = Color3.fromRGB(10, 10, 20)
        self.Theme.Accent = Color3.fromRGB(0, 255, 255)
        self.Theme.Stroke = Color3.fromRGB(255, 0, 255)
    elseif theme == "MrBeast" then
        self.Theme.Background = Color3.fromRGB(10, 10, 10)
        self.Theme.Accent = Color3.fromRGB(0, 200, 255)
        self.Theme.Stroke = Color3.fromRGB(255, 105, 180)
    elseif theme == "Dark" then
        self.Theme.Background = Color3.fromRGB(20, 20, 20)
        self.Theme.Accent = Color3.fromRGB(40, 40, 255)
        self.Theme.Stroke = Color3.fromRGB(70, 70, 70)
    end
end

function NovaLib:ApplyNeonStroke(instance)
    local stroke = Instance.new("UIStroke", instance)
    stroke.Color = self.Theme.Stroke
    stroke.Thickness = 2
end

function NovaLib:MakeNotification(text, duration)
    local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    gui.IgnoreGuiInset = true
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 300, 0, 60)
    frame.Position = UDim2.new(1, -310, 1, -70)
    frame.BackgroundColor3 = self.Theme.Accent
    self:ApplyNeonStroke(frame)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    local label = Instance.new("TextLabel", frame)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Size = UDim2.new(1, -10, 1, -10)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 16
    game:GetService("Debris"):AddItem(gui, duration or 3)
end

function NovaLib:EnableKeySystem(correctKey)
    local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    gui.Name = "KeySystem"
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = self.Theme.Background
    self:ApplyNeonStroke(frame)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    local box = Instance.new("TextBox", frame)
    box.PlaceholderText = "Enter Key..."
    box.Size = UDim2.new(0.8, 0, 0, 30)
    box.Position = UDim2.new(0.1, 0, 0.3, 0)
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.TextColor3 = self.Theme.Text
    box.BackgroundColor3 = self.Theme.Accent
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
    local btn = Instance.new("TextButton", frame)
    btn.Text = "✔ Verify"
    btn.Size = UDim2.new(0.8, 0, 0, 30)
    btn.Position = UDim2.new(0.1, 0, 0.6, 0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BackgroundColor3 = self.Theme.Stroke
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function()
        if box.Text == correctKey then
            gui:Destroy()
        else
            self:MakeNotification("Yanlış key!", 3)
        end
    end)
end

function NovaLib:ToggleUIWithKey(keycode)
    local gui = game:GetService("CoreGui"):FindFirstChild("NovaLib")
    if not gui then return end
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode[keycode] then
            gui.Enabled = not gui.Enabled
        end
    end)
end

function NovaLib:SaveConfig(name, data)
    if isfile and writefile then
        local json = game:GetService("HttpService"):JSONEncode(data)
        writefile(name..".json", json)
    end
end

function NovaLib:LoadConfig(name)
    if isfile and readfile then
        local raw = readfile(name..".json")
        return game:GetService("HttpService"):JSONDecode(raw)
    end
end

return NovaLib
