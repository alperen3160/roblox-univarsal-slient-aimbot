-- NovaLib v8.2 – Fonksiyon Paketi Eklendi ✅
-- OrionLib uyumlu: AddButton, AddToggle, AddTextbox, AddDropdown, AddBind, AddColorpicker, AddPlayerDropdown

-- [GUI kodu yukarıda mevcut, burada API fonksiyonları tanımlanıyor]
local NovaLib = {}
local Players = game:GetService("Players")

local Tabs = {}

function NovaLib:MakeWindow(config)
    return NovaLib
end

function NovaLib:MakeTab(tabConfig)
    local tab = {}
    local button = Instance.new("TextButton")
    button.Text = "📁 " .. tabConfig.Name
    button.Size = UDim2.new(1, -10, 0, 35)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.Parent = TabsHolder
    Instance.new("UICorner", button)

    local frame = Instance.new("ScrollingFrame", ContentHolder)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.ScrollBarThickness = 4
    frame.Visible = false
    local layout = Instance.new("UIListLayout", frame)
    layout.Padding = UDim.new(0, 5)

    button.MouseButton1Click:Connect(function()
        for _, child in pairs(ContentHolder:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        frame.Visible = true
    end)

    function tab:AddSection(info)
        local section = {}
        local label = Instance.new("TextLabel", frame)
        label.Text = "🔷 " .. info.Name
        label.Size = UDim2.new(1, -10, 0, 24)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.GothamSemibold
        label.TextSize = 15

        function section:AddButton(data)
            local btn = Instance.new("TextButton", frame)
            btn.Text = data.Name
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(data.Callback)
        end

        function section:AddToggle(data)
            local toggle = Instance.new("TextButton", frame)
            toggle.Text = data.Name .. ": OFF"
            toggle.Size = UDim2.new(1, -10, 0, 30)
            toggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggle.Font = Enum.Font.Gotham
            toggle.TextSize = 14
            Instance.new("UICorner", toggle)
            local state = false
            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.Text = data.Name .. ": " .. (state and "ON" or "OFF")
                data.Callback(state)
            end)
        end

        function section:AddTextbox(data)
            local tb = Instance.new("TextBox", frame)
            tb.PlaceholderText = data.Name
            tb.Size = UDim2.new(1, -10, 0, 30)
            tb.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            tb.TextColor3 = Color3.fromRGB(255, 255, 255)
            tb.Font = Enum.Font.Gotham
            tb.TextSize = 14
            Instance.new("UICorner", tb)
            tb.FocusLost:Connect(function()
                data.Callback(tb.Text)
            end)
        end

        function section:AddDropdown(data)
            local btn = Instance.new("TextButton", frame)
            btn.Text = data.Name .. ": [Seç]"
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                local opt = data.Options[math.random(1, #data.Options)]
                btn.Text = data.Name .. ": " .. opt
                data.Callback(opt)
            end)
        end

        function section:AddBind(data)
            local btn = Instance.new("TextButton", frame)
            btn.Text = data.Name .. ": [" .. data.Default .. "]"
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            Instance.new("UICorner", btn)
            local listening = false
            btn.MouseButton1Click:Connect(function()
                btn.Text = data.Name .. ": [Bekleniyor]"
                local conn; conn = UserInputService.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.Keyboard then
                        data.Callback(i.KeyCode)
                        btn.Text = data.Name .. ": [" .. i.KeyCode.Name .. "]"
                        conn:Disconnect()
                    end
                end)
            end)
        end

        function section:AddColorpicker(data)
            local btn = Instance.new("TextButton", frame)
            btn.Text = data.Name
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.BackgroundColor3 = data.Default or Color3.fromRGB(255, 0, 0)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                local r = math.random(0, 255)
                local g = math.random(0, 255)
                local b = math.random(0, 255)
                local color = Color3.fromRGB(r, g, b)
                btn.BackgroundColor3 = color
                data.Callback(color)
            end)
        end

        function section:AddPlayerDropdown(data)
            local btn = Instance.new("TextButton", frame)
            btn.Text = data.Name .. ": [Seç]"
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                local p = Players:GetPlayers()[math.random(1, #Players:GetPlayers())]
                btn.Text = data.Name .. ": " .. p.Name
                data.Callback(p)
            end)
        end

        return section
    end

    table.insert(Tabs, tab)
    return tab
end

return NovaLib
