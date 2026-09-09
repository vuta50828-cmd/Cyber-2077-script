--==================================================
-- CYBER // 2077
-- Version 1.2.0
-- Roblox Studio UI
-- NO SAVE / NO DATASTORE
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

--==================================================
-- DEFAULT SETTINGS
--==================================================

local Config = {
	Version = "1.2.0",

	Accent = Color3.fromRGB(0, 255, 220),

	Background = Color3.fromRGB(7, 9, 14),
	Panel = Color3.fromRGB(14, 17, 25),
	PanelDark = Color3.fromRGB(10, 12, 18),

	Text = Color3.fromRGB(235, 240, 245),
	Muted = Color3.fromRGB(125, 135, 150),

	Notifications = true,
	Animations = true,
	Glitch = true,
}

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "Cyber2077"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = player:WaitForChild("PlayerGui")

--==================================================
-- NOTIFICATION HOLDER
--==================================================

local NotificationHolder = Instance.new("Frame")
NotificationHolder.Name = "Notifications"
NotificationHolder.AnchorPoint = Vector2.new(1, 1)
NotificationHolder.Position = UDim2.new(1, -18, 1, -18)
NotificationHolder.Size = UDim2.fromOffset(310, 350)
NotificationHolder.BackgroundTransparency = 1
NotificationHolder.Parent = Gui

local NotificationLayout = Instance.new("UIListLayout")
NotificationLayout.Padding = UDim.new(0, 8)
NotificationLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
NotificationLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotificationLayout.Parent = NotificationHolder

local function Notify(title, message, duration)

	if not Config.Notifications then
		return
	end

	duration = duration or 3

	local frame = Instance.new("Frame")
	frame.Size = UDim2.fromOffset(295, 68)
	frame.BackgroundColor3 = Config.Panel
	frame.BorderSizePixel = 0
	frame.Parent = NotificationHolder

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Color = Config.Accent
	stroke.Thickness = 1.5
	stroke.Parent = frame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.BackgroundTransparency = 1
	titleLabel.Position = UDim2.fromOffset(12, 7)
	titleLabel.Size = UDim2.new(1, -24, 0, 20)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Text = title
	titleLabel.TextSize = 12
	titleLabel.TextColor3 = Config.Accent
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = frame

	local messageLabel = Instance.new("TextLabel")
	messageLabel.BackgroundTransparency = 1
	messageLabel.Position = UDim2.fromOffset(12, 30)
	messageLabel.Size = UDim2.new(1, -24, 0, 28)
	messageLabel.Font = Enum.Font.Gotham
	messageLabel.Text = message
	messageLabel.TextSize = 10
	messageLabel.TextColor3 = Config.Text
	messageLabel.TextWrapped = true
	messageLabel.TextXAlignment = Enum.TextXAlignment.Left
	messageLabel.Parent = frame

	frame.Position = UDim2.new(1, 320, 0, 0)

	TweenService:Create(
		frame,
		TweenInfo.new(0.3, Enum.EasingStyle.Quint),
		{Position = UDim2.new(0, 0, 0, 0)}
	):Play()

	task.delay(duration, function()

		if frame.Parent then

			local tween = TweenService:Create(
				frame,
				TweenInfo.new(0.3),
				{
					Position = UDim2.new(1, 320, 0, 0),
					BackgroundTransparency = 1
				}
			)

			tween:Play()
			tween.Completed:Wait()

			frame:Destroy()
		end
	end)
end

--==================================================
-- LOADING SCREEN
--==================================================

local Loading = Instance.new("Frame")
Loading.Name = "Loading"
Loading.Size = UDim2.fromScale(1, 1)
Loading.BackgroundColor3 = Color3.fromRGB(3, 5, 9)
Loading.BorderSizePixel = 0
Loading.ZIndex = 100
Loading.Parent = Gui

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingTitle.Position = UDim2.fromScale(0.5, 0.43)
LoadingTitle.Size = UDim2.fromOffset(500, 60)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Font = Enum.Font.GothamBlack
LoadingTitle.Text = "CYBER // 2077"
LoadingTitle.TextSize = 36
LoadingTitle.TextColor3 = Config.Accent
LoadingTitle.ZIndex = 101
LoadingTitle.Parent = Loading

local LoadingSub = Instance.new("TextLabel")
LoadingSub.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingSub.Position = UDim2.fromScale(0.5, 0.51)
LoadingSub.Size = UDim2.fromOffset(500, 30)
LoadingSub.BackgroundTransparency = 1
LoadingSub.Font = Enum.Font.Code
LoadingSub.Text = "INITIALIZING..."
LoadingSub.TextSize = 11
LoadingSub.TextColor3 = Config.Muted
LoadingSub.ZIndex = 101
LoadingSub.Parent = Loading

local BarBackground = Instance.new("Frame")
BarBackground.AnchorPoint = Vector2.new(0.5, 0.5)
BarBackground.Position = UDim2.fromScale(0.5, 0.58)
BarBackground.Size = UDim2.fromOffset(360, 6)
BarBackground.BackgroundColor3 = Config.Panel
BarBackground.BorderSizePixel = 0
BarBackground.ZIndex = 101
BarBackground.Parent = Loading

local Bar = Instance.new("Frame")
Bar.Size = UDim2.new(0, 0, 1, 0)
Bar.BackgroundColor3 = Config.Accent
Bar.BorderSizePixel = 0
Bar.ZIndex = 102
Bar.Parent = BarBackground

local Percent = Instance.new("TextLabel")
Percent.AnchorPoint = Vector2.new(0.5, 0.5)
Percent.Position = UDim2.fromScale(0.5, 0.63)
Percent.Size = UDim2.fromOffset(100, 25)
Percent.BackgroundTransparency = 1
Percent.Font = Enum.Font.Code
Percent.Text = "0%"
Percent.TextSize = 11
Percent.TextColor3 = Config.Text
Percent.ZIndex = 101
Percent.Parent = Loading

task.spawn(function()

	for i = 0, 100 do

		Bar.Size = UDim2.new(i / 100, 0, 1, 0)
		Percent.Text = i .. "%"

		if i < 30 then
			LoadingSub.Text = "INITIALIZING..."
		elseif i < 60 then
			LoadingSub.Text = "LOADING MODULES..."
		elseif i < 90 then
			LoadingSub.Text = "CONNECTING..."
		else
			LoadingSub.Text = "SYSTEM READY..."
		end

		task.wait(0.012)
	end

	task.wait(0.25)

	TweenService:Create(
		Loading,
		TweenInfo.new(0.45),
		{BackgroundTransparency = 1}
	):Play()

	TweenService:Create(
		LoadingTitle,
		TweenInfo.new(0.35),
		{TextTransparency = 1}
	):Play()

	TweenService:Create(
		LoadingSub,
		TweenInfo.new(0.35),
		{TextTransparency = 1}
	):Play()

	TweenService:Create(
		BarBackground,
		TweenInfo.new(0.35),
		{BackgroundTransparency = 1}
	):Play()

	TweenService:Create(
		Percent,
		TweenInfo.new(0.35),
		{TextTransparency = 1}
	):Play()

	task.wait(0.5)

	Loading:Destroy()

	Notify(
		"CYBER // 2077",
		"Interface online.",
		3
	)
end)

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.fromOffset(680, 430)
Main.BackgroundColor3 = Config.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Config.Accent
MainStroke.Thickness = 1.5
MainStroke.Parent = Main

--==================================================
-- TOP BAR
--==================================================

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 60)
TopBar.BackgroundColor3 = Config.Panel
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(20, 8)
Title.Size = UDim2.fromOffset(450, 27)
Title.Font = Enum.Font.GothamBlack
Title.Text = "CYBER // 2077"
Title.TextSize = 21
Title.TextColor3 = Config.Accent
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.fromOffset(21, 35)
Subtitle.Size = UDim2.fromOffset(450, 18)
Subtitle.Font = Enum.Font.Code
Subtitle.Text = "NEURAL INTERFACE // ONLINE"
Subtitle.TextSize = 10
Subtitle.TextColor3 = Config.Muted
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TopBar

local Minimize = Instance.new("TextButton")
Minimize.Name = "Minimize"
Minimize.BackgroundTransparency = 1
Minimize.Position = UDim2.new(1, -92, 0, 13)
Minimize.Size = UDim2.fromOffset(35, 35)
Minimize.Font = Enum.Font.GothamBold
Minimize.Text = "Ã¢ÂÂ"
Minimize.TextSize = 26
Minimize.TextColor3 = Config.Text
Minimize.AutoButtonColor = false
Minimize.Parent = TopBar

local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.BackgroundTransparency = 1
Close.Position = UDim2.new(1, -50, 0, 13)
Close.Size = UDim2.fromOffset(35, 35)
Close.Font = Enum.Font.GothamBold
Close.Text = "ÃÂ"
Close.TextSize = 26
Close.TextColor3 = Config.Text
Close.AutoButtonColor = false
Close.Parent = TopBar

--==================================================
-- WINDOW BUTTON HOVER
--==================================================

local function AddWindowButtonHover(Button, NormalColor, HoverColor)

	Button.MouseEnter:Connect(function()
		TweenService:Create(
			Button,
			TweenInfo.new(0.12),
			{TextColor3 = HoverColor}
		):Play()
	end)

	Button.MouseLeave:Connect(function()
		TweenService:Create(
			Button,
			TweenInfo.new(0.12),
			{TextColor3 = NormalColor}
		):Play()
	end)
end

AddWindowButtonHover(Minimize, Config.Text, Config.Accent)
AddWindowButtonHover(Close, Config.Text, Color3.fromRGB(255, 90, 100))

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.fromOffset(160, 370)
Sidebar.Position = UDim2.fromOffset(0, 60)
Sidebar.BackgroundColor3 = Config.PanelDark
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 15)
Padding.PaddingLeft = UDim.new(0, 12)
Padding.PaddingRight = UDim.new(0, 12)
Padding.Parent = Sidebar

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 7)
Layout.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Position = UDim2.fromOffset(175, 75)
Content.Size = UDim2.new(1, -190, 1, -90)
Content.BackgroundTransparency = 1
Content.Parent = Main

local function ClearContent()

	for _, child in ipairs(Content:GetChildren()) do
		child:Destroy()
	end
end

local function Header(text)

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Position = UDim2.fromOffset(10, 5)
	label.Size = UDim2.new(1, -20, 0, 32)
	label.Font = Enum.Font.GothamBold
	label.Text = text
	label.TextSize = 17
	label.TextColor3 = Config.Text
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = Content

	return label
end

--==================================================
-- TOGGLE
--==================================================

local function Toggle(text, y, callback)

	local button = Instance.new("TextButton")
	button.Position = UDim2.fromOffset(10, y)
	button.Size = UDim2.new(1, -20, 0, 45)
	button.BackgroundColor3 = Config.Panel
	button.BorderSizePixel = 0
	button.Font = Enum.Font.GothamMedium
	button.Text = "  " .. text .. "                         OFF"
	button.TextSize = 12
	button.TextColor3 = Config.Muted
	button.TextXAlignment = Enum.TextXAlignment.Left
	button.AutoButtonColor = false
	button.Parent = Content

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = button

	local enabled = false

	button.MouseButton1Click:Connect(function()

		enabled = not enabled

		if enabled then
			button.Text = "  " .. text .. "                         ON"
			button.TextColor3 = Config.Accent
		else
			button.Text = "  " .. text .. "                         OFF"
			button.TextColor3 = Config.Muted
		end

		if callback then
			callback(enabled)
		end
	end)

	return button
end

--==================================================
-- SLIDER
--==================================================

local function Slider(text, y, min, max, default, callback)

	local holder = Instance.new("Frame")
	holder.Position = UDim2.fromOffset(10, y)
	holder.Size = UDim2.new(1, -20, 0, 65)
	holder.BackgroundColor3 = Config.Panel
	holder.BorderSizePixel = 0
	holder.Parent = Content

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = holder

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Position = UDim2.fromOffset(12, 7)
	label.Size = UDim2.new(0.7, 0, 0, 20)
	label.Font = Enum.Font.GothamMedium
	label.Text = text
	label.TextSize = 11
	label.TextColor3 = Config.Text
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = holder

	local valueLabel = Instance.new("TextLabel")
	valueLabel.BackgroundTransparency = 1
	valueLabel.Position = UDim2.new(0.7, 0, 0, 7)
	valueLabel.Size = UDim2.new(0.25, 0, 0, 20)
	valueLabel.Font = Enum.Font.Code
	valueLabel.TextSize = 11
	valueLabel.TextColor3 = Config.Accent
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Parent = holder

	local barBackground = Instance.new("Frame")
	barBackground.Position = UDim2.fromOffset(12, 38)
	barBackground.Size = UDim2.new(1, -24, 0, 6)
	barBackground.BackgroundColor3 = Color3.fromRGB(35, 40, 48)
	barBackground.BorderSizePixel = 0
	barBackground.Parent = holder

	local bar = Instance.new("Frame")
	bar.BackgroundColor3 = Config.Accent
	bar.BorderSizePixel = 0
	bar.Parent = barBackground

	local dragging = false

	local function SetValue(value)

		value = math.clamp(value, min, max)

		local percent = (value - min) / (max - min)

		bar.Size = UDim2.new(percent, 0, 1, 0)
		valueLabel.Text = tostring(math.floor(value))

		if callback then
			callback(value)
		end
	end

	local function Update(input)

		local percent = math.clamp(
			(input.Position.X - barBackground.AbsolutePosition.X)
			/ barBackground.AbsoluteSize.X,
			0,
			1
		)

		local value = min + ((max - min) * percent)

		SetValue(value)
	end

	barBackground.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			Update(input)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)

		if dragging and (
			input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch
		) then

			Update(input)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = false
		end
	end)

	SetValue(default)
end

--==================================================
-- RGB PICKER
--==================================================

local function RGBSlider(parent, name, y, value, callback)

	local slider = Instance.new("Frame")
	slider.Position = UDim2.fromOffset(12, y)
	slider.Size = UDim2.new(1, -24, 0, 22)
	slider.BackgroundColor3 = Color3.fromRGB(30, 34, 42)
	slider.BorderSizePixel = 0
	slider.Parent = parent

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Position = UDim2.fromOffset(8, 0)
	label.Size = UDim2.fromOffset(30, 22)
	label.Font = Enum.Font.Code
	label.Text = name
	label.TextSize = 11
	label.TextColor3 = Config.Text
	label.Parent = slider

	local valueText = Instance.new("TextLabel")
	valueText.BackgroundTransparency = 1
	valueText.Position = UDim2.new(1, -50, 0, 0)
	valueText.Size = UDim2.fromOffset(42, 22)
	valueText.Font = Enum.Font.Code
	valueText.Text = tostring(value)
	valueText.TextSize = 10
	valueText.TextColor3 = Config.Accent
	valueText.Parent = slider

	local dragging = false

	local function Update(input)

		local percent = math.clamp(
			(input.Position.X - slider.AbsolutePosition.X)
			/ slider.AbsoluteSize.X,
			0,
			1
		)

		local newValue = math.floor(percent * 255)

		valueText.Text = tostring(newValue)

		callback(newValue)
	end

	slider.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			Update(input)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)

		if dragging and (
			input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch
		) then

			Update(input)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = false
		end
	end)
end

local function ColorPicker(y)

	local holder = Instance.new("Frame")
	holder.Position = UDim2.fromOffset(10, y)
	holder.Size = UDim2.new(1, -20, 0, 120)
	holder.BackgroundColor3 = Config.Panel
	holder.BorderSizePixel = 0
	holder.Parent = Content

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = holder

	local title = Instance.new("TextLabel")
	title.BackgroundTransparency = 1
	title.Position = UDim2.fromOffset(12, 6)
	title.Size = UDim2.new(1, -24, 0, 20)
	title.Font = Enum.Font.GothamBold
	title.Text = "RGB ACCENT"
	title.TextSize = 12
	title.TextColor3 = Config.Text
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = holder

	local R, G, B = 0, 255, 220

	local function Update()

		Config.Accent = Color3.fromRGB(R, G, B)

		MainStroke.Color = Config.Accent
		Title.TextColor3 = Config.Accent

		for _, obj in ipairs(Content:GetDescendants()) do

			if obj:IsA("TextLabel") and obj.Text == "RGB ACCENT" then
				obj.TextColor3 = Config.Accent
			end
		end
	end

	RGBSlider(holder, "R", 32, R, function(v)
		R = v
		Update()
	end)

	RGBSlider(holder, "G", 62, G, function(v)
		G = v
		Update()
	end)

	RGBSlider(holder, "B", 92, B, function(v)
		B = v
		Update()
	end)
end


--==================================================
-- REAL PLAYER / VISUAL FEATURES
-- Roblox Studio
--==================================================

local SpeedEnabled = false
local JumpEnabled = false
local ESPEnabled = false

local SpeedValue = 50
local JumpValue = 100

local DEFAULT_WALK_SPEED = 16
local DEFAULT_JUMP_POWER = 50

local function GetHumanoid()
	local character = player.Character
	if not character then
		return nil
	end

	return character:FindFirstChildOfClass("Humanoid")
end

local function SetSpeed(enabled)
	SpeedEnabled = enabled

	local humanoid = GetHumanoid()
	if not humanoid then
		return
	end

	humanoid.WalkSpeed = enabled and SpeedValue or DEFAULT_WALK_SPEED
end

local function SetJump(enabled)
	JumpEnabled = enabled

	local humanoid = GetHumanoid()
	if not humanoid then
		return
	end

	humanoid.UseJumpPower = true
	humanoid.JumpPower = enabled and JumpValue or DEFAULT_JUMP_POWER
end

local function RemoveESP()
	for _, targetPlayer in ipairs(Players:GetPlayers()) do
		local character = targetPlayer.Character
		if character then
			local highlight = character:FindFirstChild("CyberESP")
			if highlight then
				highlight:Destroy()
			end
		end
	end
end

local function AddESP(targetPlayer)
	if targetPlayer == player then
		return
	end

	local character = targetPlayer.Character
	if not character then
		return
	end

	local highlight = character:FindFirstChild("CyberESP")

	if not highlight then
		highlight = Instance.new("Highlight")
		highlight.Name = "CyberESP"
		highlight.Adornee = character
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = character
	end

	highlight.FillColor = Config.Accent
	highlight.OutlineColor = Config.Accent
	highlight.FillTransparency = 0.75
	highlight.OutlineTransparency = 0
end

local function SetESP(enabled)
	ESPEnabled = enabled

	if not enabled then
		RemoveESP()
		return
	end

	for _, targetPlayer in ipairs(Players:GetPlayers()) do
		AddESP(targetPlayer)
	end
end

local function RefreshESP()
	if not ESPEnabled then
		return
	end

	for _, targetPlayer in ipairs(Players:GetPlayers()) do
		AddESP(targetPlayer)
	end
end

Players.PlayerAdded:Connect(function(targetPlayer)
	targetPlayer.CharacterAdded:Connect(function()
		task.wait(0.25)
		RefreshESP()
	end)
end)

for _, targetPlayer in ipairs(Players:GetPlayers()) do
	if targetPlayer ~= player then
		targetPlayer.CharacterAdded:Connect(function()
			task.wait(0.25)
			RefreshESP()
		end)
	end
end

player.CharacterAdded:Connect(function()
	task.wait(0.25)

	if SpeedEnabled then
		SetSpeed(true)
	end

	if JumpEnabled then
		SetJump(true)
	end
end)

--==================================================
-- TABS
--==================================================

local CurrentTab

local function CreateTab(name)

	local button = Instance.new("TextButton")

	button.Size = UDim2.new(1, 0, 0, 43)
	button.BackgroundColor3 = Config.Panel
	button.BorderSizePixel = 0
	button.Font = Enum.Font.GothamBold
	button.Text = name
	button.TextSize = 11
	button.TextColor3 = Config.Muted
	button.AutoButtonColor = false
	button.Parent = Sidebar

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = button

	return button
end

local PlayerTab = CreateTab("PLAYER")
local VisualTab = CreateTab("VISUAL")
local MiscTab = CreateTab("MISC")
local SettingsTab = CreateTab("SETTINGS")

local function SelectTab(tab)

	if CurrentTab then
		CurrentTab.TextColor3 = Config.Muted
	end

	CurrentTab = tab
	tab.TextColor3 = Config.Accent
end

--==================================================
-- PLAYER TAB
--==================================================

PlayerTab.MouseButton1Click:Connect(function()

	SelectTab(PlayerTab)
	ClearContent()

	Header("PLAYER SYSTEM")

	Toggle("Sprint", 55, function(state)
		SetSpeed(state)
	end)

	Toggle("Jump Boost", 110, function(state)
		SetJump(state)
	end)

	Slider(
		"Movement Speed",
		175,
		16,
		100,
		SpeedValue,
		function(value)
			SpeedValue = value

			if SpeedEnabled then
				SetSpeed(true)
			end
		end
	)
end)

--==================================================
-- VISUAL TAB
--==================================================

VisualTab.MouseButton1Click:Connect(function()

	SelectTab(VisualTab)
	ClearContent()

	Header("VISUAL SYSTEM")

	Toggle("ESP", 55, function(state)
		SetESP(state)
	end)

	Toggle("Glitch FX", 110, function(state)
		Config.Glitch = state
	end)

	ColorPicker(175)
end)

--==================================================
-- MISC TAB
--==================================================

MiscTab.MouseButton1Click:Connect(function()

	SelectTab(MiscTab)
	ClearContent()

	Header("SYSTEM")

	Toggle("Notifications", 55, function(state)
		Config.Notifications = state
	end)

	Toggle("UI Animations", 110, function(state)
		Config.Animations = state
	end)

	Toggle("Debug Mode", 165, function(state)
		print("Debug Mode:", state)
	end)
end)

--==================================================
-- SETTINGS TAB
--==================================================

SettingsTab.MouseButton1Click:Connect(function()

	SelectTab(SettingsTab)
	ClearContent()

	Header("SETTINGS")

	local version = Instance.new("TextLabel")
	version.BackgroundTransparency = 1
	version.Position = UDim2.fromOffset(10, 55)
	version.Size = UDim2.new(1, -20, 0, 30)
	version.Font = Enum.Font.Code
	version.Text = "VERSION  " .. Config.Version
	version.TextSize = 12
	version.TextColor3 = Config.Accent
	version.TextXAlignment = Enum.TextXAlignment.Left
	version.Parent = Content

	local status = Instance.new("TextLabel")
	status.BackgroundTransparency = 1
	status.Position = UDim2.fromOffset(10, 85)
	status.Size = UDim2.new(1, -20, 0, 30)
	status.Font = Enum.Font.Code
	status.Text = "STATUS   ONLINE"
	status.TextSize = 12
	status.TextColor3 = Config.Text
	status.TextXAlignment = Enum.TextXAlignment.Left
	status.Parent = Content
end)

--==================================================
-- DEFAULT TAB
--==================================================

SelectTab(PlayerTab)

-- Load the default PLAYER tab without trying to fire the signal manually.
-- MouseButton1Click is an event and cannot be called with :Fire().

-- Populate the default PLAYER tab on startup.
ClearContent()
Header("PLAYER SYSTEM")

Toggle("Sprint", 55, function(state)
	SetSpeed(state)
end)

Toggle("Jump Boost", 110, function(state)
	SetJump(state)
end)

Slider(
	"Movement Speed",
	175,
	16,
	100,
	SpeedValue,
	function(value)
		SpeedValue = value

		if SpeedEnabled then
			SetSpeed(true)
		end
	end
)

--==================================================
-- MOBILE CYBER ICON
--==================================================

local OpenButton = Instance.new("TextButton")

OpenButton.Name = "CyberIcon"
OpenButton.AnchorPoint = Vector2.new(1, 1)
OpenButton.Position = UDim2.new(1, -18, 1, -18)
OpenButton.Size = UDim2.fromOffset(58, 58)

OpenButton.BackgroundColor3 = Color3.fromRGB(8, 12, 18)
OpenButton.BorderSizePixel = 0

OpenButton.Text = "Ã¢ÂÂ"
OpenButton.Font = Enum.Font.GothamBlack
OpenButton.TextSize = 24
OpenButton.TextColor3 = Config.Accent

OpenButton.AutoButtonColor = false
OpenButton.Visible = false
OpenButton.ZIndex = 50

OpenButton.Parent = Gui

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = OpenButton

local IconStroke = Instance.new("UIStroke")
IconStroke.Color = Config.Accent
IconStroke.Thickness = 2
IconStroke.Parent = OpenButton

OpenButton.MouseButton1Click:Connect(function()

	Main.Visible = true
	OpenButton.Visible = false

	Notify(
		"CYBER // 2077",
		"Interface opened.",
		2
	)
end)

-- Ã¢ÂÂ = Ã¡ÂºÂ¨N MENU, vÃ¡ÂºÂ«n giÃ¡Â»Â¯ icon Cyber ÃÂÃ¡Â»Â mÃ¡Â»Â lÃ¡ÂºÂ¡i
Minimize.MouseButton1Click:Connect(function()

	Main.Visible = false
	OpenButton.Visible = true
end)

-- ÃÂ = THOÃÂT HÃ¡ÂºÂ²N GUI
Close.MouseButton1Click:Connect(function()

	Main.Visible = false
	OpenButton.Visible = false
	Gui.Enabled = false
end)

--==================================================
-- MOBILE ICON PULSE
--==================================================

task.spawn(function()

	while task.wait(1) do

		if OpenButton.Visible then

			TweenService:Create(
				IconStroke,
				TweenInfo.new(0.5),
				{
					Transparency = 0.55,
					Thickness = 3
				}
			):Play()

			task.wait(0.5)

			TweenService:Create(
				IconStroke,
				TweenInfo.new(0.5),
				{
					Transparency = 0,
					Thickness = 2
				}
			):Play()
		end
	end
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

	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then

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
-- RIGHT SHIFT
--==================================================

UserInputService.InputBegan:Connect(function(input, processed)

	if processed then
		return
	end

	if input.KeyCode == Enum.KeyCode.RightShift then

		Main.Visible = not Main.Visible
		OpenButton.Visible = not Main.Visible
	end
end)

--==================================================
-- GLITCH
--==================================================

task.spawn(function()

	while task.wait(2.5) do

		if Config.Glitch and Main.Visible then

			local old = Main.Position

			Main.Position = UDim2.new(
				old.X.Scale,
				old.X.Offset + math.random(-2, 2),
				old.Y.Scale,
				old.Y.Offset + math.random(-1, 1)
			)

			task.wait(0.04)

			Main.Position = old
		end
	end
end)