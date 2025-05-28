-- NovaLib v8.1 – Kalite Şov Sürümü 👑
-- Şık UI geliştirmeleri, animasyonlar, glow efekti, hover renkleri, ikonlu sekmeler

local NovaLib = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local CoreGui = game:GetService("CoreGui")
local GUI = Instance.new("ScreenGui", CoreGui)
GUI.Name = "NovaLib"
GUI.ResetOnSpawn = false

-- === LAUNCHER BUTTON (Sol Altta Açma Tuşu) ===
local launcher = Instance.new("TextButton", GUI)
launcher.Size = UDim2.new(0, 130, 0, 36)
launcher.Position = UDim2.new(0, 10, 1, -50)
launcher.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
launcher.TextColor3 = Color3.fromRGB(255, 255, 255)
launcher.Font = Enum.Font.GothamBold
launcher.Text = "📂 Aç NovaLib"
launcher.TextSize = 14
Instance.new("UICorner", launcher).CornerRadius = UDim.new(0, 6)
local glow = Instance.new("UIStroke", launcher)
glow.Thickness = 2
glow.Color = Color3.fromRGB(255, 0, 100)

-- === ANA PENCERE ===
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 720, 0, 460)
MainFrame.Position = UDim2.new(0.5, -360, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 0, 60)
MainFrame.Visible = false
MainFrame.Parent = GUI
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(255, 0, 0)
stroke.Thickness = 2

-- 3 RENKLİ BLOK ARKAPLAN
local blockColors = {
    Color3.fromRGB(255, 0, 100),
    Color3.fromRGB(128, 0, 255),
    Color3.fromRGB(255, 170, 0)
}
for i = 0, 2 do
    local block = Instance.new("Frame", MainFrame)
    block.Size = UDim2.new(1/3, 0, 1, 0)
    block.Position = UDim2.new(i/3, 0, 0, 0)
    block.BackgroundColor3 = blockColors[i+1]
    block.BackgroundTransparency = 0.7
    block.ZIndex = 0
end

-- === SEKME MENÜSÜ (SOLDA) ===
local TabsHolder = Instance.new("Frame", MainFrame)
TabsHolder.Name = "TabsHolder"
TabsHolder.Size = UDim2.new(0, 160, 1, 0)
TabsHolder.Position = UDim2.new(0, 0, 0, 0)
TabsHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", TabsHolder).CornerRadius = UDim.new(0, 8)
local TabsLayout = Instance.new("UIListLayout", TabsHolder)
TabsLayout.FillDirection = Enum.FillDirection.Vertical
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Padding = UDim.new(0, 5)

-- === HOVER EFEKTLİ TAB BUTON FONKSİYONU ===
local function createTabButton(name, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Text = (icon and icon .. " " or "") .. name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(50, 50, 255)
    stroke.Thickness = 1
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    return btn
end

-- === İÇERİK ALANI (SAĞDA) ===
local ContentHolder = Instance.new("Frame", MainFrame)
ContentHolder.Name = "ContentHolder"
ContentHolder.Size = UDim2.new(1, -160, 1, 0)
ContentHolder.Position = UDim2.new(0, 160, 0, 0)
ContentHolder.BackgroundTransparency = 1

-- === PROFİL PANELİ ===
local Profile = Instance.new("Frame", MainFrame)
Profile.Name = "Profile"
Profile.Size = UDim2.new(0, 150, 0, 60)
Profile.Position = UDim2.new(0, 5, 1, -65)
Profile.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", Profile).CornerRadius = UDim.new(0, 6)
Profile.ZIndex = 3

local PFP = Instance.new("ImageLabel", Profile)
PFP.Size = UDim2.new(0, 40, 0, 40)
PFP.Position = UDim2.new(0, 8, 0.5, -20)
PFP.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Players.LocalPlayer.UserId .. "&width=420&height=420&format=png"
PFP.BackgroundTransparency = 1

local NameLabel = Instance.new("TextLabel", Profile)
NameLabel.Text = Players.LocalPlayer.Name
NameLabel.Position = UDim2.new(0, 55, 0.5, -10)
NameLabel.Size = UDim2.new(0, 90, 0, 20)
NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NameLabel.Font = Enum.Font.GothamBold
NameLabel.TextSize = 14
NameLabel.BackgroundTransparency = 1

-- === AÇ/KAPAT SİSTEMİ ===
launcher.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- === Orion API Başlangıç ===
local Tabs = {}

function NovaLib:MakeWindow(config)
    return NovaLib
end

-- Daha fazla fonksiyon Orion uyumlu şekilde eklenecektir...

return NovaLib
