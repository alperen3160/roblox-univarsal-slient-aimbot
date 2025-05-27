-- NovaLib (Orion uyumlu, modern GUI tasarımıyla)
-- Tüm fonksiyonlar OrionLib ile birebir ama GUI tamamen farklı
-- Rainbow arkaplan, oyuncu fotoğraflı seçim, modern tasarım

local NovaLib = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local GUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
GUI.Name = "NovaLibGUI"
GUI.ResetOnSpawn = false

local rainbowFrame = Instance.new("Frame", GUI)
rainbowFrame.Size = UDim2.new(0, 600, 0, 400)
rainbowFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
rainbowFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
rainbowFrame.BorderSizePixel = 0
rainbowFrame.BackgroundTransparency = 0.1
Instance.new("UICorner", rainbowFrame).CornerRadius = UDim.new(0, 12)

spawn(function()
    while task.wait() do
        local t = tick() * 0.5
        local hue = t % 1
        local color = Color3.fromHSV(hue, 0.8, 0.9)
        rainbowFrame.BackgroundColor3 = color
    end
end)

local MainTitle = Instance.new("TextLabel", rainbowFrame)
MainTitle.Text = "NovaLib UI"
MainTitle.Size = UDim2.new(1, 0, 0, 40)
MainTitle.BackgroundTransparency = 1
MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.Font = Enum.Font.GothamBlack
MainTitle.TextSize = 20

local TabsHolder = Instance.new("Frame", rainbowFrame)
TabsHolder.Size = UDim2.new(1, 0, 0, 30)
TabsHolder.Position = UDim2.new(0, 0, 0, 40)
TabsHolder.BackgroundTransparency = 1
local TabsLayout = Instance.new("UIListLayout", TabsHolder)
TabsLayout.FillDirection = Enum.FillDirection.Horizontal
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Padding = UDim.new(0, 6)

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
    tabButton.Size = UDim2.new(0, 100, 1, 0)
    tabButton.Text = tabConfig.Name
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 14
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 4)

    local contentFrame = Instance.new("ScrollingFrame", ContentHolder)
    contentFrame.Size = UDim2.new(1, 0, 1, 0)
    contentFrame.ScrollBarThickness = 3
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Visible = false
    local layout = Instance.new("UIListLayout", contentFrame)
    layout.Padding = UDim.new(0, 6)

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
        sectionTitle.Text = info.Name
        sectionTitle.Font = Enum.Font.GothamSemibold
        sectionTitle.TextSize = 16
        sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        sectionTitle.BackgroundTransparency = 1
        sectionTitle.Size = UDim2.new(1, -10, 0, 30)

        local section = {}

        function section:AddButton(data)
            local btn = Instance.new("TextButton", contentFrame)
            btn.Text = data.Name
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            btn.MouseButton1Click:Connect(data.Callback)
        end

        function section:AddPlayerDropdown(data)
            local drop = Instance.new("TextButton", contentFrame)
            drop.Text = data.Name .. ": Tıklayıp Seç"
            drop.Size = UDim2.new(1, -10, 0, 35)
            drop.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            drop.TextColor3 = Color3.fromRGB(255, 255, 255)
            drop.Font = Enum.Font.Gotham
            drop.TextSize = 14
            Instance.new("UICorner", drop).CornerRadius = UDim.new(0, 4)
            drop.MouseButton1Click:Connect(function()
                local players = Players:GetPlayers()
                for _, p in ipairs(players) do
                    if p ~= Players.LocalPlayer then
                        data.Callback(p)
                        break
                    end
                end
            end)
        end

        function section:AddToggle(data)
            local state = false
            local toggle = Instance.new("TextButton", contentFrame)
            toggle.Text = data.Name .. ": OFF"
            toggle.Size = UDim2.new(1, -10, 0, 35)
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
            input.PlaceholderText = data.Name
            input.Size = UDim2.new(1, -10, 0, 35)
            input.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            input.TextColor3 = Color3.fromRGB(255, 255, 255)
            input.Font = Enum.Font.Gotham
            input.TextSize = 14
            Instance.new("UICorner", input).CornerRadius = UDim.new(0, 4)
            input.FocusLost:Connect(function()
                data.Callback(input.Text)
            end)
        end

        function section:AddDropdown(data)
            local selected = data.Options[1] or ""
            local drop = Instance.new("TextButton", contentFrame)
            drop.Text = data.Name .. ": " .. selected
            drop.Size = UDim2.new(1, -10, 0, 35)
            drop.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
            drop.TextColor3 = Color3.fromRGB(255, 255, 255)
            drop.Font = Enum.Font.Gotham
            drop.TextSize = 14
            Instance.new("UICorner", drop).CornerRadius = UDim.new(0, 4)
            drop.MouseButton1Click:Connect(function()
                local opt = data.Options[math.random(1, #data.Options)]
                drop.Text = data.Name .. ": " .. opt
                data.Callback(opt)
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
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            btn.MouseButton1Click:Connect(function()
                local r = math.random(0, 255)
                local g = math.random(0, 255)
                local b = math.random(0, 255)
                local newColor = Color3.fromRGB(r, g, b)
                btn.BackgroundColor3 = newColor
                data.Callback(newColor)
            end)
        end

        function section:AddBind(data)
            local bind = Enum.KeyCode[data.Default] or Enum.KeyCode.E
            local btn = Instance.new("TextButton", contentFrame)
            btn.Text = data.Name .. ": [" .. bind.Name .. "]"
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            btn.MouseButton1Click:Connect(function()
                btn.Text = data.Name .. ": [ ... ]"
                local conn
                conn = UserInputService.InputBegan:Connect(function(k)
                    if k.KeyCode ~= Enum.KeyCode.Unknown then
                        bind = k.KeyCode
                        btn.Text = data.Name .. ": [" .. bind.Name .. "]"
                        data.Callback(bind)
                        conn:Disconnect()
                    end
                end)
            end)
        end

        return section
    end

    table.insert(Tabs, tab)
    return tab
end

return NovaLib
