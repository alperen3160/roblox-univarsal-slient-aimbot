local GuiLibrary = {}

-- Renkler
local Colors = {
    Background = Color3.fromRGB(25, 25, 25),
    Accent = Color3.fromRGB(75, 75, 75),
    Text = Color3.fromRGB(255, 255, 255),
    ToggleOn = Color3.fromRGB(0, 170, 255),
    ToggleOff = Color3.fromRGB(100, 100, 100)
}

-- Font
local Font = Enum.Font.Gotham

-- Tab oluşturma
function GuiLibrary:CreateTab(name)
    local tab = Instance.new("Frame")
    tab.Size = UDim2.new(0.2, 0, 0.8, 0)
    tab.Position = UDim2.new(0.4, 0, 0.1, 0)
    tab.BackgroundColor3 = Colors.Background
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Text = name
    title.TextColor3 = Colors.Text
    title.TextSize = 20
    title.Font = Font
    title.Parent = tab
    
    return tab
end

-- Toggle oluşturma
function GuiLibrary:CreateToggle(tab, text, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0.08, 0)
    toggleFrame.BackgroundColor3 = Colors.Accent
    
    local toggleText = Instance.new("TextLabel")
    toggleText.Size = UDim2.new(0.8, 0, 1, 0)
    toggleText.Text = text
    toggleText.TextColor3 = Colors.Text
    toggleText.TextSize = 16
    toggleText.Font = Font
    toggleText.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0.2, 0, 1, 0)
    toggleButton.Position = UDim2.new(0.8, 0, 0, 0)
    toggleButton.Text = ""
    toggleButton.BackgroundColor3 = Colors.ToggleOff
    toggleButton.AutoButtonColor = false
    toggleButton.Parent = toggleFrame
    
    local isToggled = false
    
    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        toggleButton.BackgroundColor3 = isToggled and Colors.ToggleOn or Colors.ToggleOff
        if callback then callback(isToggled) end
    end)
    
    toggleFrame.Parent = tab
    return toggleFrame
end

-- Slider oluşturma
function GuiLibrary:CreateSlider(tab, text, min, max, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0.1, 0)
    sliderFrame.BackgroundColor3 = Colors.Accent
    
    local sliderText = Instance.new("TextLabel")
    sliderText.Size = UDim2.new(0.8, 0, 0.5, 0)
    sliderText.Text = text
    sliderText.TextColor3 = Colors.Text
    sliderText.TextSize = 16
    sliderText.Font = Font
    sliderText.Parent = sliderFrame
    
    local sliderValue = Instance.new("TextLabel")
    sliderValue.Size = UDim2.new(0.8, 0, 0.5, 0)
    sliderValue.Position = UDim2.new(0, 0, 0.5, 0)
    sliderValue.Text = "0"
    sliderValue.TextColor3 = Colors.Text
    sliderValue.TextSize = 16
    sliderValue.Font = Font
    sliderValue.Parent = sliderFrame
    
    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(0.2, 0, 0.9, 0)
    sliderBar.Position = UDim2.new(0.8, 0, 0.05, 0)
    sliderBar.BackgroundColor3 = Colors.Accent
    
    local sliderKnob = Instance.new("Frame")
    sliderKnob.Size = UDim2.new(0.1, 0, 1, 0)
    sliderKnob.BackgroundColor3 = Colors.ToggleOn
    sliderKnob.Parent = sliderBar
    
    local currentValue = min
    
    sliderBar.MouseButton1Down:Connect(function(x, y)
        local relativeX = (x - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X
        currentValue = math.clamp((relativeX * (max - min)) + min, min, max)
        sliderKnob.Position = UDim2.new((currentValue - min) / (max - min), 0, 0, 0)
        sliderValue.Text = tostring(currentValue)
        if callback then callback(currentValue) end
    end)
    
    sliderBar.Parent = sliderFrame
    sliderFrame.Parent = tab
    return sliderFrame
end

-- Button oluşturma
function GuiLibrary:CreateButton(tab, text, callback)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, 0, 0.08, 0)
    buttonFrame.BackgroundColor3 = Colors.Accent
    
    local buttonText = Instance.new("TextButton")
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.Text = text
    buttonText.TextColor3 = Colors.Text
    buttonText.TextSize = 16
    buttonText.Font = Font
    buttonText.BackgroundColor3 = Colors.ToggleOn
    buttonText.AutoButtonColor = false
    
    buttonText.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    buttonFrame.Parent = tab
    return buttonFrame
end

-- Colorpicker oluşturma
function GuiLibrary:CreateColorPicker(tab, callback)
    local pickerFrame = Instance.new("Frame")
    pickerFrame.Size = UDim2.new(1, 0, 0.3, 0)
    pickerFrame.BackgroundColor3 = Colors.Accent
    
    local colorButton = Instance.new("TextButton")
    colorButton.Size = UDim2.new(1, 0, 0.1, 0)
    colorButton.Text = "Renk Seç"
    colorButton.TextColor3 = Colors.Text
    colorButton.TextSize = 16
    colorButton.Font = Font
    colorButton.BackgroundColor3 = Colors.ToggleOn
    colorButton.AutoButtonColor = false
    
    local colorBox = Instance.new("Frame")
    colorBox.Size = UDim2.new(1, 0, 0.2, 0)
    colorBox.Position = UDim2.new(0, 0, 0.1, 0)
    colorBox.BackgroundColor3 = Colors.ToggleOn
    
    local currentColor = Color3.fromRGB(255, 0, 0)
    
    colorButton.MouseButton1Click:Connect(function()
        local picker = Instance.new("ScreenGui")
        local pickerFrame = Instance.new("Frame")
        pickerFrame.Size = UDim2.new(0.2, 0, 0.2, 0)
        pickerFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
        pickerFrame.BackgroundColor3 = Colors.Background
        pickerFrame.Parent = picker
        
        local colorPicker = Instance.new("Frame")
        colorPicker.Size = UDim2.new(1, 0, 1, 0)
        colorPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        colorPicker.Parent = pickerFrame
        
        local colorPickerCursor = Instance.new("Frame")
        colorPickerCursor.Size = UDim2.new(0.02, 0, 0.02, 0)
        colorPickerCursor.BackgroundColor3 = Colors.Background
        colorPickerCursor.Parent = colorPicker
        
        colorPicker.MouseButton1Down:Connect(function(x, y)
            local relativeX = (x - colorPicker.AbsolutePosition.X) / colorPicker.AbsoluteSize.X
            local relativeY = (y - colorPicker.AbsolutePosition.Y) / colorPicker.AbsoluteSize.Y
            
            local r = math.floor(relativeX * 255)
            local g = math.floor(relativeY * 255)
            local b = 255 - (r + g)
            
            currentColor = Color3.fromRGB(r, g, b)
            colorBox.BackgroundColor3 = currentColor
            if callback then callback(currentColor) end
            picker:Destroy()
        end)
        
        picker.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end)
    
    colorButton.Parent = pickerFrame
    colorBox.Parent = pickerFrame
    pickerFrame.Parent = tab
    return pickerFrame
end

return GuiLibrary
