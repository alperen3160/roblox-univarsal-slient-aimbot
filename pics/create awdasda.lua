-- NovaLib v5 (Krallara Layık Sürüm 👑 + MrBeast Kalitesi)
-- Orion uyumlu fonksiyonlar + Şık Rainbow GUI + Tam Sistem

local NovaLib = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local GUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
GUI.Name = "NovaLibGUI"
GUI.ResetOnSpawn = false

--✨ Kaliteli Rainbow Arkaplan
local rainbowFrame = Instance.new("Frame", GUI)
rainbowFrame.Size = UDim2.new(0, 620, 0, 440)
rainbowFrame.Position = UDim2.new(0.5, -310, 0.5, -220)
rainbowFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
rainbowFrame.BorderSizePixel = 0
Instance.new("UICorner", rainbowFrame).CornerRadius = UDim.new(0, 14)

local rainbowGradient = Instance.new("UIGradient", rainbowFrame)
rainbowGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
})
rainbowGradient.Rotation = 0

spawn(function()
    while task.wait() do
        rainbowGradient.Rotation = (rainbowGradient.Rotation + 1) % 360
    end
end)

--🖋️ Başlık
local MainTitle = Instance.new("TextLabel", rainbowFrame)
MainTitle.Text = "NovaLib v5 UI"
MainTitle.Size = UDim2.new(1, 0, 0, 40)
MainTitle.BackgroundTransparency = 1
MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.Font = Enum.Font.GothamBlack
MainTitle.TextSize = 22

--📁 Sekmeler
local TabsHolder = Instance.new("Frame", rainbowFrame)
TabsHolder.Size = UDim2.new(1, 0, 0, 30)
TabsHolder.Position = UDim2.new(0, 0, 0, 40)
TabsHolder.BackgroundTransparency = 1
local TabsLayout = Instance.new("UIListLayout", TabsHolder)
TabsLayout.FillDirection = Enum.FillDirection.Horizontal
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Padding = UDim.new(0, 6)

--📦 İçerik Alanı
local ContentHolder = Instance.new("Frame", rainbowFrame)
ContentHolder.Position = UDim2.new(0, 0, 0, 75)
ContentHolder.Size = UDim2.new(1, 0, 1, -75)
ContentHolder.BackgroundTransparency = 1

local Tabs = {}

function NovaLib:MakeWindow(config)
    MainTitle.Text = config.Name or "NovaLib UI"
    return NovaLib
end

function NovaLib:MakeTab(tabConfig)
    local tabButton = Instance.new("TextButton", TabsHolder)
    tabButton.Size = UDim2.new(0, 120, 1, 0)
    tabButton.Text = tabConfig.Name
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 15
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 6)

    local contentFrame = Instance.new("ScrollingFrame", ContentHolder)
    contentFrame.Size = UDim2.new(1, 0, 1, 0)
    contentFrame.ScrollBarThickness = 3
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Visible = false
    local layout = Instance.new("UIListLayout", contentFrame)
    layout.Padding = UDim.new(0, 8)

    tabButton.MouseButton1Click:Connect(function()
        for _, child in ipairs(ContentHolder:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        contentFrame.Visible = true
    end)

    local tab = {}

    function tab:AddSection(info)
        local sectionTitle = Instance.new("TextLabel", contentFrame)
        sectionTitle.Text = "📂 " .. info.Name
        sectionTitle.Font = Enum.Font.GothamSemibold
        sectionTitle.TextSize = 17
        sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        sectionTitle.BackgroundTransparency = 1
        sectionTitle.Size = UDim2.new(1, -10, 0, 32)

        local section = {}

        function section:AddButton(data)
            local btn = Instance.new("TextButton", contentFrame)
            btn.Text = "🖱️ " .. data.Name
            btn.Size = UDim2.new(1, -10, 0, 36)
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
            btn.MouseButton1Click:Connect(data.Callback)
        end

        function section:AddToggle(data)
            local state = false
            local toggle = Instance.new("TextButton", contentFrame)
            toggle.Text = data.Name .. ": OFF"
            toggle.Size = UDim2.new(1, -10, 0, 36)
            toggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggle.Font = Enum.Font.Gotham
            toggle.TextSize = 14
            Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 4)
            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.Text = data.Name .. ": " .. (state and "ON" or "OFF")
                data.Callback(state)
            end)
        end

        function section:AddTextbox(data)
            local input = Instance.new("TextBox", contentFrame)
            input.PlaceholderText = data.Name or "Metin girin"
            input.Size = UDim2.new(1, -10, 0, 36)
            input.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            input.TextColor3 = Color3.fromRGB(255, 255, 255)
            input.Font = Enum.Font.Gotham
            input.TextSize = 14
            input.Text = ""
            Instance.new("UICorner", input).CornerRadius = UDim.new(0, 4)
            input.FocusLost:Connect(function()
                data.Callback(input.Text)
            end)
        end

        return section
    end

    table.insert(Tabs, tab)
    return tab
end

return NovaLib
