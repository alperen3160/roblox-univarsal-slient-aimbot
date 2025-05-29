local Nova = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "NovaUI"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 320)
Main.Position = UDim2.new(0.5, -250, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Name = "Main"
Main.ClipsDescendants = true

local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Thickness = 1
UIStroke.Color = Color3.fromRGB(90, 90, 90)

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "🌌 Nova UI Library"
Title.Font = Enum.Font.GothamSemibold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(200, 200, 200)

local TabsHolder = Instance.new("Frame", Main)
TabsHolder.Position = UDim2.new(0, 0, 0, 40)
TabsHolder.Size = UDim2.new(0, 120, 1, -40)
TabsHolder.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", TabsHolder).CornerRadius = UDim.new(0, 4)

local ContentHolder = Instance.new("Frame", Main)
ContentHolder.Position = UDim2.new(0, 125, 0, 45)
ContentHolder.Size = UDim2.new(1, -130, 1, -50)
ContentHolder.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout", TabsHolder)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

function Nova:CreateTab(name, premium)
	local tabBtn = Instance.new("TextButton", TabsHolder)
	tabBtn.Size = UDim2.new(1, -10, 0, 30)
	tabBtn.Position = UDim2.new(0, 5, 0, 0)
	tabBtn.Text = name .. (premium and " ⭐" or "")
	tabBtn.Font = Enum.Font.Gotham
	tabBtn.TextSize = 14
	tabBtn.TextColor3 = premium and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(200, 200, 200)
	tabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	tabBtn.BorderSizePixel = 0
	Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 4)

	local tabFrame = Instance.new("ScrollingFrame", ContentHolder)
	tabFrame.Size = UDim2.new(1, 0, 1, 0)
	tabFrame.Visible = false
	tabFrame.Name = name
	tabFrame.BackgroundTransparency = 1
	tabFrame.ScrollBarThickness = 3
	tabFrame.CanvasSize = UDim2.new(0, 0, 0, 500)

	local list = Instance.new("UIListLayout", tabFrame)
	list.Padding = UDim.new(0, 6)
	list.SortOrder = Enum.SortOrder.LayoutOrder

	tabBtn.MouseButton1Click:Connect(function()
		for _, v in pairs(ContentHolder:GetChildren()) do
			if v:IsA("ScrollingFrame") then v.Visible = false end
		end
		tabFrame.Visible = true
	end)

	local elements = {}

	function elements:Button(text, callback)
		local btn = Instance.new("TextButton", tabFrame)
		btn.Size = UDim2.new(1, -10, 0, 30)
		btn.Text = text
		btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 14
		btn.BorderSizePixel = 0
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
		btn.MouseButton1Click:Connect(callback)
	end

	function elements:Toggle(text, default, callback)
		local toggle = Instance.new("TextButton", tabFrame)
		toggle.Size = UDim2.new(1, -10, 0, 30)
		toggle.Text = text .. ": OFF"
		toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
		toggle.Font = Enum.Font.Gotham
		toggle.TextSize = 14
		toggle.BorderSizePixel = 0
		Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 4)
		local state = default
		toggle.MouseButton1Click:Connect(function()
			state = not state
			toggle.Text = text .. ": " .. (state and "ON" or "OFF")
			callback(state)
		end)
	end

	function elements:Textbox(placeholder, callback)
		local box = Instance.new("TextBox", tabFrame)
		box.Size = UDim2.new(1, -10, 0, 30)
		box.PlaceholderText = placeholder
		box.Text = ""
		box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		box.TextColor3 = Color3.fromRGB(255, 255, 255)
		box.Font = Enum.Font.Gotham
		box.TextSize = 14
		box.BorderSizePixel = 0
		Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
		box.FocusLost:Connect(function()
			callback(box.Text)
		end)
	end

	return elements
end
