-- NovaUI v2 by ChatGPT
-- Modern tasarım, üst sekme, farklı GUI ve Orion işlevleri

local NovaUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "NovaUI"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 420)
main.Position = UDim2.new(0.5, -300, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BackgroundTransparency = 0.1
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 6)

local tabBar = Instance.new("Frame", main)
tabBar.Size = UDim2.new(1, 0, 0, 35)
tabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0, 4)
Instance.new("UIListLayout", tabBar).FillDirection = Enum.FillDirection.Horizontal

local contentHolder = Instance.new("Frame", main)
contentHolder.Position = UDim2.new(0, 0, 0, 40)
contentHolder.Size = UDim2.new(1, 0, 1, -40)
contentHolder.BackgroundTransparency = 1

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
	content.CanvasSize = UDim2.new(0, 0, 0, 0)
	content.ScrollBarThickness = 3
	content.BackgroundTransparency = 1
	content.Visible = false
	local layout = Instance.new("UIListLayout", content)
	layout.Padding = UDim.new(0, 6)
	layout.SortOrder = Enum.SortOrder.LayoutOrder

	tabBtn.MouseButton1Click:Connect(function()
		for _, v in pairs(contentHolder:GetChildren()) do
			if v:IsA("ScrollingFrame") then v.Visible = false end
		end
		content.Visible = true
	end)

	local function addBaseElement()
		local base = Instance.new("Frame")
		base.Size = UDim2.new(1, -10, 0, 35)
		base.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		base.BorderSizePixel = 0
		base.Parent = content
		Instance.new("UICorner", base).CornerRadius = UDim.new(0, 4)
		return base
	end

	local api = {}

	function api:Button(text, callback)
		local btn = addBaseElement()
		local b = Instance.new("TextButton", btn)
		b.Size = UDim2.new(1, 0, 1, 0)
		b.Text = text
		b.BackgroundTransparency = 1
		b.TextColor3 = Color3.fromRGB(255, 255, 255)
		b.Font = Enum.Font.Gotham
		b.TextSize = 14
		b.MouseButton1Click:Connect(callback)
	end

	function api:Toggle(text, default, callback)
		local toggled = default
		local box = addBaseElement()

		local label = Instance.new("TextLabel", box)
		label.Text = text .. ": " .. (toggled and "ON" or "OFF")
		label.Size = UDim2.new(1, -10, 1, 0)
		label.Position = UDim2.new(0, 10, 0, 0)
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		label.Font = Enum.Font.Gotham
		label.TextSize = 14
		label.TextXAlignment = Enum.TextXAlignment.Left

		box.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				toggled = not toggled
				label.Text = text .. ": " .. (toggled and "ON" or "OFF")
				callback(toggled)
			end
		end)
	end

	function api:Textbox(placeholder, callback)
		local box = addBaseElement()

		local input = Instance.new("TextBox", box)
		input.PlaceholderText = placeholder
		input.Size = UDim2.new(1, -20, 1, 0)
		input.Position = UDim2.new(0, 10, 0, 0)
		input.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		input.TextColor3 = Color3.fromRGB(255, 255, 255)
		input.Font = Enum.Font.Gotham
		input.TextSize = 14
		input.ClearTextOnFocus = false
		Instance.new("UICorner", input).CornerRadius = UDim.new(0, 3)

		input.FocusLost:Connect(function()
			callback(input.Text)
		end)
	end

	function api:Dropdown(name, options, callback)
		local selected = options[1]
		local box = addBaseElement()

		local dd = Instance.new("TextButton", box)
		dd.Size = UDim2.new(1, 0, 1, 0)
		dd.Text = name .. ": " .. selected
		dd.BackgroundTransparency = 1
		dd.TextColor3 = Color3.fromRGB(255, 255, 255)
		dd.Font = Enum.Font.Gotham
		dd.TextSize = 14

		dd.MouseButton1Click:Connect(function()
			local opt = options[math.random(1, #options)]
			selected = opt
			dd.Text = name .. ": " .. opt
			callback(opt)
		end)
	end

	function api:Bind(text, defaultKey, callback)
		local key = defaultKey
		local box = addBaseElement()

		local label = Instance.new("TextLabel", box)
		label.Size = UDim2.new(1, -10, 1, 0)
		label.Position = UDim2.new(0, 10, 0, 0)
		label.Text = text .. ": [" .. key.Name .. "]"
		label.Font = Enum.Font.Gotham
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		label.BackgroundTransparency = 1
		label.TextSize = 14
		label.TextXAlignment = Enum.TextXAlignment.Left

		box.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				label.Text = text .. ": [ ... ]"
				local conn
				conn = UserInputService.InputBegan:Connect(function(k)
					if k.KeyCode ~= Enum.KeyCode.Unknown then
						key = k.KeyCode
						label.Text = text .. ": [" .. key.Name .. "]"
						callback(key)
						conn:Disconnect()
					end
				end)
			end
		end)
	end

	function api:Colorpicker(text, defaultColor, callback)
		local color = defaultColor
		local box = addBaseElement()

		local button = Instance.new("TextButton", box)
		button.Size = UDim2.new(1, 0, 1, 0)
		button.Text = text
		button.BackgroundColor3 = color
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.Font = Enum.Font.Gotham
		button.TextSize = 14
		Instance.new("UICorner", button).CornerRadius = UDim.new(0, 3)

		button.MouseButton1Click:Connect(function()
			local r = math.random(0,255)
			local g = math.random(0,255)
			local b = math.random(0,255)
			local new = Color3.fromRGB(r,g,b)
			button.BackgroundColor3 = new
			callback(new)
		end)
	end

	return api
end

return NovaUI
