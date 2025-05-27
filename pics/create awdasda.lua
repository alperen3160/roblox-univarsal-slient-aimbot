--// NovaUI v3 - ChatGPT Edition
-- Şık giriş, hover animasyon, RGB ColorPicker, Başlık özelleştirilebilir

local NovaUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function NovaUI:Init(config)
    config = config or {}
    config.Title = config.Title or "NovaUI"
    config.Intro = config.Intro ~= false

    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "NovaUIv3"
    gui.ResetOnSpawn = false

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 600, 0, 400)
    main.Position = UDim2.new(0.5, -300, 0.5, -200)
    main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    main.BackgroundTransparency = 0
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Visible = false
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = config.Title
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255, 255, 255)

    local tabBar = Instance.new("Frame", main)
    tabBar.Size = UDim2.new(1, 0, 0, 30)
    tabBar.Position = UDim2.new(0, 0, 0, 40)
    tabBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0, 4)
    local layout = Instance.new("UIListLayout", tabBar)
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 4)

    local contentHolder = Instance.new("Frame", main)
    contentHolder.Size = UDim2.new(1, 0, 1, -75)
    contentHolder.Position = UDim2.new(0, 0, 0, 70)
    contentHolder.BackgroundTransparency = 1

    -- Giriş efekti
    if config.Intro then
        main.Size = UDim2.new(0, 0, 0, 0)
        main.Visible = true
        TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 600, 0, 400)
        }):Play()
    else
        main.Visible = true
    end

    function NovaUI:CreateTab(name)
        local tabBtn = Instance.new("TextButton", tabBar)
        tabBtn.Size = UDim2.new(0, 100, 1, 0)
        tabBtn.Text = name
        tabBtn.Font = Enum.Font.GothamBold
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabBtn.TextSize = 14
        tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 4)

        local content = Instance.new("ScrollingFrame", contentHolder)
        content.Size = UDim2.new(1, 0, 1, 0)
        content.Visible = false
        content.CanvasSize = UDim2.new(0, 0, 0, 0)
        content.ScrollBarThickness = 4
        content.BackgroundTransparency = 1
        local list = Instance.new("UIListLayout", content)
        list.Padding = UDim.new(0, 6)
        list.SortOrder = Enum.SortOrder.LayoutOrder

        tabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(contentHolder:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            content.Visible = true
        end)

        local function elementBase()
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, -10, 0, 35)
            frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)
            frame.BorderSizePixel = 0
            frame.Parent = content
            return frame
        end

        local api = {}

        function api:Button(text, callback)
            local f = elementBase()
            local btn = Instance.new("TextButton", f)
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.Text = text
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.BackgroundTransparency = 1
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.MouseEnter:Connect(function()
                TweenService:Create(f, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(f, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            end)
            btn.MouseButton1Click:Connect(callback)
        end

        function api:Toggle(text, default, callback)
            local toggled = default
            local f = elementBase()
            local lbl = Instance.new("TextLabel", f)
            lbl.Text = text .. ": " .. (default and "ON" or "OFF")
            lbl.Font = Enum.Font.Gotham
            lbl.TextSize = 14
            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            lbl.BackgroundTransparency = 1
            lbl.Size = UDim2.new(1, -10, 1, 0)
            lbl.Position = UDim2.new(0, 10, 0, 0)
            f.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    toggled = not toggled
                    lbl.Text = text .. ": " .. (toggled and "ON" or "OFF")
                    callback(toggled)
                end
            end)
        end

        function api:Textbox(placeholder, callback)
            local f = elementBase()
            local box = Instance.new("TextBox", f)
            box.PlaceholderText = placeholder
            box.Size = UDim2.new(1, -20, 1, 0)
            box.Position = UDim2.new(0, 10, 0, 0)
            box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            box.TextColor3 = Color3.fromRGB(255, 255, 255)
            box.Font = Enum.Font.Gotham
            box.TextSize = 14
            Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
            box.FocusLost:Connect(function()
                callback(box.Text)
            end)
        end

        function api:Dropdown(title, options, callback)
            local f = elementBase()
            local selected = options[1]
            local btn = Instance.new("TextButton", f)
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.Text = title .. ": " .. selected
            btn.Font = Enum.Font.Gotham
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.BackgroundTransparency = 1
            btn.TextSize = 14
            btn.MouseButton1Click:Connect(function()
                local new = options[math.random(1, #options)]
                selected = new
                btn.Text = title .. ": " .. new
                callback(new)
            end)
        end

        function api:Bind(text, defaultKey, callback)
            local f = elementBase()
            local current = defaultKey
            local lbl = Instance.new("TextLabel", f)
            lbl.Text = text .. ": [" .. current.Name .. "]"
            lbl.Font = Enum.Font.Gotham
            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            lbl.Size = UDim2.new(1, -10, 1, 0)
            lbl.Position = UDim2.new(0, 10, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.TextSize = 14
            f.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    lbl.Text = text .. ": [ ... ]"
                    local conn
                    conn = UserInputService.InputBegan:Connect(function(key)
                        if key.KeyCode ~= Enum.KeyCode.Unknown then
                            current = key.KeyCode
                            lbl.Text = text .. ": [" .. current.Name .. "]"
                            callback(current)
                            conn:Disconnect()
                        end
                    end)
                end
            end)
        end

        function api:Colorpicker(text, default, callback)
            local f = elementBase()
            local box = Instance.new("TextButton", f)
            box.Size = UDim2.new(1, 0, 1, 0)
            box.Text = text
            box.Font = Enum.Font.Gotham
            box.TextColor3 = Color3.fromRGB(255, 255, 255)
            box.BackgroundColor3 = default
            box.TextSize = 14
            Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
            box.MouseButton1Click:Connect(function()
                local color = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                box.BackgroundColor3 = color
                callback(color)
            end)
        end

        content.Visible = #contentHolder:GetChildren() == 1
        return api
    end
end

return NovaUI
