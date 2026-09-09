--==================================================
-- CYBER // 2077
-- Cyberpunk-inspired Roblox UI
-- For Roblox Studio projects you own/have permission to modify
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local ACCENT = Color3.fromRGB(0, 255, 220)
local BACKGROUND = Color3.fromRGB(7, 9, 14)
local PANEL = Color3.fromRGB(14, 17, 25)
local PANEL_DARK = Color3.fromRGB(10, 12, 18)
local TEXT = Color3.fromRGB(235, 240, 245)
local MUTED = Color3.fromRGB(125, 135, 150)

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "Cyber2077"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.fromOffset(650, 400)
Main.BackgroundColor3 = BACKGROUND
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = ACCENT
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.2
MainStroke.Parent = Main

--==================================================
-- TOP BAR
--==================================================

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 58)
TopBar.BackgroundColor3 = PANEL
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(20, 7)
Title.Size = UDim2.fromOffset(400, 26)
Title.Font = Enum.Font.GothamBold
Title.Text = "CYBER // 2077"
Title.TextSize = 20
Title.TextColor3 = ACCENT
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.fromOffset(21, 33)
Subtitle.Size = UDim2.fromOffset(400, 17)
Subtitle.Font = Enum.Font.Code
Subtitle.Text = "NEURAL INTERFACE // ONLINE"
Subtitle.TextSize = 10
Subtitle.TextColor3 = MUTED
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TopBar

--==================================================
-- CLOSE BUTTON
--==================================================

local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.BackgroundTransparency = 1
Close.Position = UDim2.new(1, -48, 0, 12)
Close.Size = UDim2.fromOffset(32, 32)
Close.Font = Enum.Font.GothamBold
Close.Text = "×"
Close.TextSize = 25
Close.TextColor3 = TEXT
Close.Parent = TopBar

Close.MouseEnter:Connect(function()
	Close.TextColor3 = ACCENT
end)

Close.MouseLeave:Connect(function()
	Close.TextColor3 = TEXT
end)

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Position = UDim2.fromOffset(0, 58)
Sidebar.Size = UDim2.fromOffset(155, 342)
Sidebar.BackgroundColor3 = PANEL_DARK
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 15)
SidebarPadding.PaddingLeft = UDim.new(0, 12)
SidebarPadding.PaddingRight = UDim.new(0, 12)
Sidebar.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 7)
SidebarLayout.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Position = UDim2.fromOffset(170, 73)
Content.Size = UDim2.new(1, -185, 1, -88)
Content.BackgroundTransparency = 1
Content.Parent = Main

--==================================================
-- HELPERS
--==================================================

local function clearContent()
	for _, child in ipairs(Content:GetChildren()) do
		child:Destroy()
	end
end

local function createHeader(text)
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Position = UDim2.fromOffset(10, 5)
	label.Size = UDim2.new(1, -20, 0, 32)
	label.Font = Enum.Font.GothamBold
	label.Text = text
	label.TextSize = 17
	label.TextColor3 = TEXT
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = Content

	return label
end

local function createToggle(text, y, callback)
	local button = Instance.new("TextButton")

	button.Name = text
	button.Position = UDim2.fromOffset(10, y)
	button.Size = UDim2.new(1, -20, 0, 45)
	button.BackgroundColor3 = PANEL
	button.BorderSizePixel = 0
	button.Font = Enum.Font.GothamMedium
	button.Text = "  " .. text .. "                         OFF"
	button.TextSize = 12
	button.TextColor3 = MUTED
	button.TextXAlignment = Enum.TextXAlignment.Left
	button.AutoButtonColor = false
	button.Parent = Content

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(40, 45, 55)
	stroke.Transparency = 0.3
	stroke.Parent = button

	local enabled = false

	button.MouseEnter:Connect(function()
		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{BackgroundColor3 = Color3.fromRGB(20, 25, 34)}
		):Play()
	end)

	button.MouseLeave:Connect(function()
		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{BackgroundColor3 = PANEL}
		):Play()
	end)

	button.MouseButton1Click:Connect(function()
		enabled = not enabled

		if enabled then
			button.Text = "  " .. text .. "                         ON"
			button.TextColor3 = ACCENT
			stroke.Color = ACCENT
		else
			button.Text = "  " .. text .. "                         OFF"
			button.TextColor3 = MUTED
			stroke.Color = Color3.fromRGB(40, 45, 55)
		end

		if callback then
			callback(enabled)
		end
	end)

	return button
end

--==================================================
-- TAB SYSTEM
--==================================================

local currentTab

local function createTab(name)
	local button = Instance.new("TextButton")

	button.Name = name
	button.Size = UDim2.new(1, 0, 0, 42)
	button.BackgroundColor3 = PANEL
	button.BorderSizePixel = 0
	button.Font = Enum.Font.GothamBold
	button.Text = name
	button.TextSize = 11
	button.TextColor3 = MUTED
	button.AutoButtonColor = false
	button.Parent = Sidebar

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = button

	button.MouseEnter:Connect(function()
		if currentTab ~= button then
			button.TextColor3 = TEXT
		end
	end)

	button.MouseLeave:Connect(function()
		if currentTab ~= button then
			button.TextColor3 = MUTED
		end
	end)

	button.MouseButton1Click:Connect(function()

		if currentTab then
			currentTab.TextColor3 = MUTED
		end

		currentTab = button
		button.TextColor3 = ACCENT

		clearContent()

		-- PLAYER
		if name == "PLAYER" then

			createHeader("PLAYER SYSTEM")

			createToggle("Sprint", 55, function(state)
				print("Sprint:", state)
			end)

			createToggle("Jump Boost", 110, function(state)
				print("Jump Boost:", state)
			end)

			createToggle("Movement FX", 165, function(state)
				print("Movement FX:", state)
			end)

		-- VISUAL
		elseif name == "VISUAL" then

			createHeader("VISUAL SYSTEM")

			createToggle("UI Effects", 55, function(state)
				print("UI Effects:", state)
			end)

			createToggle("Scanline", 110, function(state)
				print("Scanline:", state)
			end)

			createToggle("Neon Glow", 165, function(state)
				print("Neon Glow:", state)
			end)

		-- MISC
		elseif name == "MISC" then

			createHeader("SYSTEM")

			createToggle("Notifications", 55, function(state)
				print("Notifications:", state)
			end)

			createToggle("Debug Mode", 110, function(state)
				print("Debug Mode:", state)
			end)

		-- SETTINGS
		elseif name == "SETTINGS" then

			createHeader("SETTINGS")

			createToggle("Interface Sound", 55, function(state)
				print("Interface Sound:", state)
			end)

			createToggle("Animations", 110, function(state)
				print("Animations:", state)
			end)
		end
	end)

	return button
end

local PlayerTab = createTab("PLAYER")
createTab("VISUAL")
createTab("MISC")
createTab("SETTINGS")

--==================================================
-- DEFAULT TAB
--==================================================

PlayerTab.TextColor3 = ACCENT
currentTab = PlayerTab

createHeader("PLAYER SYSTEM")

createToggle("Sprint", 55, function(state)
	print("Sprint:", state)
end)

createToggle("Jump Boost", 110, function(state)
	print("Jump Boost:", state)
end)

createToggle("Movement FX", 165, function(state)
	print("Movement FX:", state)
end)

--==================================================
-- DRAG SYSTEM
--==================================================

local dragging = false
local dragStart
local startPosition

TopBar.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = Main.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

		local delta = input.Position - dragStart

		Main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = false
	end
end)

--==================================================
-- KEYBOARD TOGGLE
--==================================================

UserInputService.InputBegan:Connect(function(input, processed)

	if processed then
		return
	end

	if input.KeyCode == Enum.KeyCode.RightShift then
		Main.Visible = not Main.Visible
	end
end)

--==================================================
-- OPEN ANIMATION
--==================================================

local originalSize = Main.Size

Main.Size = UDim2.fromOffset(0, 0)

TweenService:Create(
	Main,
	TweenInfo.new(
		0.5,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out
	),
	{
		Size = originalSize
	}
):Play()

print("CYBER // 2077 UI ONLINE")