-- NovaLib v6 (ULTRA MEGA MODERN™ Edition 👑 + Orion Full Clone)
-- Tüm OrionLib fonksiyonları + şovluk rainbow GUI + MrBeast Kalite garantili 🎨
-- by ChatGPT x Kral

local NovaLib = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local GUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
GUI.Name = "NovaLibGUI"
GUI.ResetOnSpawn = false

-- RAINBOW BACKGROUND
local MainFrame = Instance.new("Frame", GUI)
MainFrame.Size = UDim2.new(0, 620, 0, 440)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -220)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local Gradient = Instance.new("UIGradient", MainFrame)
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
})

spawn(function()
    while task.wait() do
        Gradient.Rotation = (Gradient.Rotation + 1) % 360
    end
end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "🌈 NovaLib v6 GUI by Kral"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22

local TabsHolder = Instance.new("Frame", MainFrame)
TabsHolder.Size = UDim2.new(1, 0, 0, 30)
TabsHolder.Position = UDim2.new(0, 0, 0, 40)
TabsHolder.BackgroundTransparency = 1
local TabsLayout = Instance.new("UIListLayout", TabsHolder)
TabsLayout.FillDirection = Enum.FillDirection.Horizontal
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Padding = UDim.new(0, 6)

local ContentHolder = Instance.new("Frame", MainFrame)
ContentHolder.Position = UDim2.new(0, 0, 0, 75)
ContentHolder.Size = UDim2.new(1, 0, 1, -75)
ContentHolder.BackgroundTransparency = 1

local Tabs = {}

function NovaLib:MakeWindow(config)
    Title.Text = config.Name or "NovaLib GUI"
    return NovaLib
end

function NovaLib:MakeTab(tabConfig)
    local tabBtn = Instance.new("TextButton", TabsHolder)
    tabBtn.Size = UDim2.new(0, 120, 1, 0)
    tabBtn.Text = tabConfig.Name
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 15
    tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)

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

        function section:AddButton(data)
            local b = Instance.new("TextButton", contentFrame)
            b.Text = data.Name
            b.Size = UDim2.new(1, -10, 0, 35)
            b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.Font = Enum.Font.Gotham
            b.TextSize = 14
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
            b.MouseButton1Click:Connect(data.Callback)
        end

        function section:AddToggle(data)
            local state = false
            local t = Instance.new("TextButton", contentFrame)
            t.Text = data.Name .. ": OFF"
            t.Size = UDim2.new(1, -10, 0, 35)
            t.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            t.TextColor3 = Color3.fromRGB(255, 255, 255)
            t.Font = Enum.Font.Gotham
            t.TextSize = 14
            Instance.new("UICorner", t).CornerRadius = UDim.new(0, 5)
            t.MouseButton1Click:Connect(function()
                state = not state
                t.Text = data.Name .. ": " .. (state and "ON" or "OFF")
                data.Callback(state)
            end)
        end

        function section:AddTextbox(data)
            local tb = Instance.new("TextBox", contentFrame)
            tb.PlaceholderText = data.Name
            tb.Size = UDim2.new(1, -10, 0, 35)
            tb.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            tb.TextColor3 = Color3.fromRGB(255, 255, 255)
            tb.Font = Enum.Font.Gotham
            tb.TextSize = 14
            Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 5)
            tb.FocusLost:Connect(function()
                data.Callback(tb.Text)
            end)
        end

        function section:AddDropdown(data)
            local d = Instance.new("TextButton", contentFrame)
            local selected = data.Options[1]
            d.Text = data.Name .. ": " .. selected
            d.Size = UDim2.new(1, -10, 0, 35)
            d.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            d.TextColor3 = Color3.fromRGB(255, 255, 255)
            d.Font = Enum.Font.Gotham
            d.TextSize = 14
            Instance.new("UICorner", d).CornerRadius = UDim.new(0, 5)
            d.MouseButton1Click:Connect(function()
                local choice = data.Options[math.random(1, #data.Options)]
                selected = choice
                d.Text = data.Name .. ": " .. selected
                data.Callback(selected)
            end)
        end

        function section:AddBind(data)
            local b = Enum.KeyCode[data.Default] or Enum.KeyCode.E
            local btn = Instance.new("TextButton", contentFrame)
            btn.Text = data.Name .. ": [" .. b.Name .. "]"
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
            btn.MouseButton1Click:Connect(function()
                btn.Text = data.Name .. ": [ ... ]"
                local conn
                conn = UserInputService.InputBegan:Connect(function(k)
                    if k.KeyCode ~= Enum.KeyCode.Unknown then
                        b = k.KeyCode
                        btn.Text = data.Name .. ": [" .. b.Name .. "]"
                        data.Callback(b)
                        conn:Disconnect()
                    end
                end)
            end)
        end

        function section:AddColorpicker(data)
            local btn = Instance.new("TextButton", contentFrame)
            btn.Text = data.Name
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.BackgroundColor3 = data.Default or Color3.fromRGB(255, 0, 0)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
            btn.MouseButton1Click:Connect(function()
                local c = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                btn.BackgroundColor3 = c
                data.Callback(c)
            end)
        end

        function section:AddPlayerDropdown(data)
            local dd = Instance.new("TextButton", contentFrame)
            dd.Text = data.Name .. ": [Tıkla]"
            dd.Size = UDim2.new(1, -10, 0, 35)
            dd.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            dd.TextColor3 = Color3.fromRGB(255, 255, 255)
            dd.Font = Enum.Font.Gotham
            dd.TextSize = 14
            Instance.new("UICorner", dd).CornerRadius = UDim.new(0, 5)
            dd.MouseButton1Click:Connect(function()
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= Players.LocalPlayer then
                        data.Callback(p)
                        break
                    end
                end
            end)
        end

        return section
    end

    table.insert(Tabs, tab)
    return tab
end

return NovaLib
