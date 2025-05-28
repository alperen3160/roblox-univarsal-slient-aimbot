-- NovaLib v7 (Kral Ultra Fix Edition™)
-- Geliştirilmiş sol sekmeli tasarım, 3 renkli statik arka plan, karakter bilgisi, modern toggle görünümü

local NovaLib = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local GUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
GUI.Name = "NovaLibGUI"
GUI.ResetOnSpawn = false

-- Sabit 3 Renkli Arkaplan
local MainFrame = Instance.new("Frame", GUI)
MainFrame.Size = UDim2.new(0, 620, 0, 440)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -220)
MainFrame.BackgroundColor3 = Color3.fromRGB(80, 0, 120) -- Mor ton
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

-- Sol Menü (Sekmeler buraya alınacak)
local TabsHolder = Instance.new("Frame", MainFrame)
TabsHolder.Size = UDim2.new(0, 150, 1, 0)
TabsHolder.Position = UDim2.new(0, 0, 0, 0)
TabsHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local TabsLayout = Instance.new("UIListLayout", TabsHolder)
TabsLayout.FillDirection = Enum.FillDirection.Vertical
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Padding = UDim.new(0, 4)

-- Karakter Bilgisi Paneli
local Profile = Instance.new("Frame", MainFrame)
Profile.Size = UDim2.new(0, 150, 0, 60)
Profile.Position = UDim2.new(0, 0, 1, -60)
Profile.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", Profile).CornerRadius = UDim.new(0, 6)

local PFP = Instance.new("ImageLabel", Profile)
PFP.Size = UDim2.new(0, 40, 0, 40)
PFP.Position = UDim2.new(0, 10, 0.5, -20)
PFP.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Players.LocalPlayer.UserId .. "&width=420&height=420&format=png"
PFP.BackgroundTransparency = 1

local NameLabel = Instance.new("TextLabel", Profile)
NameLabel.Text = Players.LocalPlayer.Name
NameLabel.Position = UDim2.new(0, 60, 0.5, -10)
NameLabel.Size = UDim2.new(0, 80, 0, 20)
NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NameLabel.Font = Enum.Font.GothamBold
NameLabel.TextSize = 14
NameLabel.BackgroundTransparency = 1

-- Sağdaki içerik alanı
local ContentHolder = Instance.new("Frame", MainFrame)
ContentHolder.Position = UDim2.new(0, 155, 0, 0)
ContentHolder.Size = UDim2.new(1, -155, 1, 0)
ContentHolder.BackgroundTransparency = 1

-- Başlık kaldırıldı çünkü içerik alanı ayrı oldu
local Tabs = {}

function NovaLib:MakeWindow(config)
    return NovaLib
end

function NovaLib:MakeTab(tabConfig)
    local tabBtn = Instance.new("TextButton", TabsHolder)
    tabBtn.Size = UDim2.new(1, -10, 0, 35)
    tabBtn.Text = tabConfig.Name
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 15
    tabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 4)

    local contentFrame = Instance.new("ScrollingFrame", ContentHolder)
    contentFrame.Size = UDim2.new(1, 0, 1, 0)
    contentFrame.ScrollBarThickness = 3
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Visible = false
    local layout = Instance.new("UIListLayout", contentFrame)
    layout.Padding = UDim.new(0, 8)

    tabBtn.MouseButton1Click:Connect(function()
        for _, v in ipairs(ContentHolder:GetChildren()) do
            if v:IsA("ScrollingFrame") then v.Visible = false end
        end
        contentFrame.Visible = true
    end)

    local tab = {}

    function tab:AddSection(sectionData)
        local label = Instance.new("TextLabel", contentFrame)
        label.Text = "📂 " .. sectionData.Name
        label.Font = Enum.Font.GothamSemibold
        label.TextSize = 17
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(1, -10, 0, 30)

        local section = {}

        function section:AddToggle(data)
            local frame = Instance.new("Frame", contentFrame)
            frame.Size = UDim2.new(1, -10, 0, 35)
            frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            frame.BorderSizePixel = 0
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)

            local label = Instance.new("TextLabel", frame)
            label.Text = data.Name
            label.Size = UDim2.new(0.7, 0, 1, 0)
            label.Position = UDim2.new(0, 10, 0, 0)
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.BackgroundTransparency = 1

            local toggleBtn = Instance.new("TextButton", frame)
            toggleBtn.Size = UDim2.new(0.2, 0, 0.6, 0)
            toggleBtn.Position = UDim2.new(0.75, 0, 0.2, 0)
            toggleBtn.Text = "🔴"
            toggleBtn.Font = Enum.Font.GothamBold
            toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

            local state = false
            toggleBtn.MouseButton1Click:Connect(function()
                state = not state
                toggleBtn.Text = state and "🟢" or "🔴"
                data.Callback(state)
            end)
        end

        return section
    end

    table.insert(Tabs, tab)
    return tab
end

return NovaLib
