--==================================================
-- CYBER // 2077
-- Version 1.1.0
-- Roblox Studio UI Framework
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local Config = {
	Version = "1.1.0",

	Accent = Color3.fromRGB(0, 255, 220),

	Background = Color3.fromRGB(7, 9, 14),
	Panel = Color3.fromRGB(14, 17, 25),
	PanelDark = Color3.fromRGB(10, 12, 18),

	Text = Color3.fromRGB(235, 240, 245),
	Muted = Color3.fromRGB(125, 135, 150),

	Animations = true,
	Notifications = true,
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
-- NOTIFICATION SYSTEM
--==================================================

local NotificationHolder = Instance.new("Frame")
NotificationHolder.Name = "Notifications"
NotificationHolder.AnchorPoint = Vector2.new(1, 1)
NotificationHolder.Position = UDim2.new(1, -20, 1, -20)
NotificationHolder.Size = UDim2.fromOffset(320, 400)
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
	frame.Size = UDim2.fromOffset(300, 70)
	frame.BackgroundColor3 = Config.Panel
	frame.BorderSizePixel = 0
	frame.Parent = NotificationHolder

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Color = Config.Accent
	stroke.Thickness = 1
	stroke.Parent = frame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.BackgroundTransparency = 1
	titleLabel.Position = UDim2.fromOffset(14, 8)
	titleLabel.Size = UDim2.new(1, -28, 0, 20)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Text = title
	titleLabel.TextSize = 13
	titleLabel.TextColor3 = Config.Accent
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = frame

	local messageLabel = Instance.new("TextLabel")
	messageLabel.BackgroundTransparency = 1
	messageLabel.Position = UDim2.fromOffset(14, 31)
	messageLabel.Size = UDim2.new(1, -28, 0, 30)
	messageLabel.Font = Enum.Font.Gotham
	messageLabel.Text = message
	messageLabel.TextSize = 11
	messageLabel.TextColor3 = Config.Text
	messageLabel.TextWrapped = true
	messageLabel.TextXAlignment = Enum.TextXAlignment.Left
	messageLabel.Parent = frame

	frame.Position = UDim2.new(1, 330, 0, 0)

	TweenService:Create(
		frame,
		TweenInfo.new(0.3, Enum.EasingStyle.Quint),
		{Position = UDim2.new(0, 0, 0, 0)}
	):Play()

	task.delay(duration, function()

		if frame and frame.Parent then

			local tween = TweenService:Create(
				frame,
				TweenInfo.new(0.3),
				{
					Position = UDim2.new(1, 330, 0, 0),
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
LoadingTitle.TextSize = 38
LoadingTitle.TextColor3 = Config.Accent
LoadingTitle.ZIndex = 101
LoadingTitle.Parent = Loading

local LoadingSub = Instance.new("TextLabel")
LoadingSub.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingSub.Position = UDim2.fromScale(0.5, 0.51)
LoadingSub.Size = UDim2.fromOffset(500, 30)
LoadingSub.BackgroundTransparency = 1
LoadingSub.Font = Enum.Font.Code
LoadingSub.Text = "INITIALIZING NEURAL INTERFACE..."
LoadingSub.TextSize = 12
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

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1, 0)
BarCorner.Parent = BarBackground

local Bar = Instance.new("Frame")
Bar.Size = UDim2.new(0, 0, 1, 0)
Bar.BackgroundColor3 = Config.Accent
Bar.BorderSizePixel = 0
Bar.ZIndex = 102
Bar.Parent = BarBackground

local BarCorner2 = Instance.new("UICorner")
BarCorner2.CornerRadius = UDim.new(1, 0)
BarCorner2.Parent = Bar

local LoadingPercent = Instance.new("TextLabel")
LoadingPercent.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingPercent.Position = UDim2.fromScale(0.5, 0.63)
LoadingPercent.Size = UDim2.fromOffset(100, 25)
LoadingPercent.BackgroundTransparency = 1
LoadingPercent.Font = Enum.Font.Code
LoadingPercent.Text = "0%"
LoadingPercent.TextSize = 11
LoadingPercent.TextColor3 = Config.Text
LoadingPercent.ZIndex = 101
LoadingPercent.Parent = Loading

task.spawn(function()

	for i = 0, 100 do

		Bar.Size = UDim2.new(i / 100, 0, 1, 0)
		LoadingPercent.Text = tostring(i) .. "%"

		if i < 25 then
			LoadingSub.Text = "INITIALIZING NEURAL INTERFACE..."
		elseif i < 50 then
			LoadingSub.Text = "LOADING CYBER MODULES..."
		elseif i < 75 then
			LoadingSub.Text = "CONNECTING SYSTEMS..."
		else
			LoadingSub.Text = "SYSTEM READY..."
		end

		task.wait(0.015)
	end

	task.wait(0.3)

	TweenService:Create(
		Loading,
		TweenInfo.new(0.5),
		{BackgroundTransparency = 1}
	):Play()

	TweenService:Create(
		LoadingTitle,
		TweenInfo.new(0.4),
		{TextTransparency = 1}
	):Play()

	TweenService:Create(
		LoadingSub,
		TweenInfo.new(0.4),
		{TextTransparency = 1}
	):Play()

	TweenService:Create(
		BarBackground,
		TweenInfo.new(0.4),
		{BackgroundTransparency = 1}
	):Play()

	TweenService:Create(
		LoadingPercent,
		TweenInfo.new(0.4),
		{TextTransparency = 1}
	):Play()

	task.wait(0.5)

	Loading:Destroy()

	Notify(
		"CYBER // 2077",
		"Neural interface online.",
		3
	)
end)

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.fromOffset(680, 430)
Main.BackgroundColor3 = Config.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Visible = true
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Config.Accent
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.15
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

--==================================================
-- CLOSE
--==================================================

local Close = Instance.new("TextButton")
Close.BackgroundTransparency = 1
Close.Position = UDim2.new(1, -50, 0, 13)
Close.Size = UDim2.fromOffset(35, 35)
Close.Font = Enum.Font.GothamBold
Close.Text = "×"
Close.TextSize = 26
Close.TextColor3 = Config.Text
Close.AutoButtonColor = false
Close.Parent = TopBar

Close.MouseEnter:Connect(function()
	Close.TextColor3 = Config.Accent
end)

Close.MouseLeave:Connect(function()
	Close.TextColor3 = Config.Text
end)

Close.MouseButton1Click:Connect(function()
	Main.Visible = false

	Notify(
		"INTERFACE",
		"Interface hidden. Press RightShift to reopen.",
		3
	)
end)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.fromOffset(160, 370)
Sidebar.Position = UDim2.fromOffset(0, 60)
Sidebar.BackgroundColor3 = Config.PanelDark
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 15)
SidebarPadding.PaddingLeft = UDim.new(0, 12)
SidebarPadding.PaddingRight = UDim.new(0, 12)
SidebarPadding.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 7)
SidebarLayout.Parent = Sidebar

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

--==================================================
-- HEADER
--==================================================

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

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(40, 45, 55)
	stroke.Transparency = 0.3
	stroke.Parent = button

	local enabled = false

	button.MouseEnter:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = Color3.fromRGB(20, 24, 33)
			}
		):Play()
	end)

	button.MouseLeave:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = Config.Panel
			}
		):Play()
	end)

	button.MouseButton1Click:Connect(function()

		enabled = not enabled

		if enabled then

			button.Text =
				"  " .. text .. "                         ON"

			button.TextColor3 = Config.Accent
			stroke.Color = Config.Accent

		else

			button.Text =
				"  " .. text .. "                         OFF"

			button.TextColor3 = Config.Muted
			stroke.Color = Color3.fromRGB(40, 45, 55)
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
	valueLabel.Text = tostring(default)
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

	local barCorner = Instance.new("UICorner")
	barCorner.CornerRadius = UDim.new(1, 0)
	barCorner.Parent = barBackground

	local bar = Instance.new("Frame")
	bar.BackgroundColor3 = Config.Accent
	bar.BorderSizePixel = 0
	bar.Parent = barBackground

	local barCorner2 = Instance.new("UICorner")
	barCorner2.CornerRadius = UDim.new(1, 0)
	barCorner2.Parent = bar

	local dragging = false

	local function SetValue(value)

		value = math.clamp(value, min, max)

		local percent =
			(value - min) / (max - min)

		bar.Size =
			UDim2.new(percent, 0, 1, 0)

		valueLabel.Text =
			tostring(math.floor(value))

		if callback then
			callback(value)
		end
	end

	local function Update(input)

		local x =
			math.clamp(
				input.Position.X -
				barBackground.AbsolutePosition.X,
				0,
				barBackground.AbsoluteSize.X
			)

		local percent =
			x / barBackground.AbsoluteSize.X

		local value =
			min + ((max - min) * percent)

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

		if not dragging then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then

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

	return holder
end

--==================================================
-- RGB COLOR PICKER
--==================================================

local function ColorPicker(y, callback)

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
	title.Position = UDim2.fromOffset(12, 8)
	title.Size = UDim2.new(1, -24, 0, 20)
	title.Font = Enum.Font.GothamBold
	title.Text = "RGB ACCENT"
	title.TextSize = 12
	title.TextColor3 = Config.Text
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = holder

	local values = {
		R = 0,
		G = 255,
		B = 220
	}

	local function Update()

		local color = Color3.fromRGB(
			values.R,
			values.G,
			values.B
		)

		Config.Accent = color

		MainStroke.Color = color
		Title.TextColor3 = color

		if callback then
			callback(color)
		end
	end

	local function RGBSlider(name, y2, key)

		local slider = Instance.new("TextButton")
		slider.Position = UDim2.fromOffset(12, y2)
		slider.Size = UDim2.new(1, -24, 0, 25)
		slider.BackgroundColor3 = Color3.fromRGB(30, 34, 42)
		slider.BorderSizePixel = 0
		slider.Text = ""
		slider.AutoButtonColor = false
		slider.Parent = holder

		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.Position = UDim2.fromOffset(8, 0)
		label.Size = UDim2.fromOffset(25, 25)
		label.Font = Enum.Font.Code
		label.Text = name
		label.TextSize = 11
		label.TextColor3 = Config.Text
		label.Parent = slider

		local value = Instance.new("TextLabel")
		value.BackgroundTransparency = 1
		value.Position = UDim2.new(1, -50, 0, 0)
		value.Size = UDim2.fromOffset(40, 25)
		value.Font = Enum.Font.Code
		value.Text = tostring(values[key])
		value.TextSize = 10
		value.TextColor3 = Config.Accent
		value.Parent = slider

		local dragging = false

		local function update(input)

			local percent =
				math.clamp(
					(input.Position.X - slider.AbsolutePosition.X)
					/ slider.AbsoluteSize.X,
					0,
					1
				)

			values[key] = math.floor(percent * 255)

			value.Text = tostring(values[key])

			Update()
		end

		slider.InputBegan:Connect(function(input)

			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then

				dragging = true
				update(input)
			end
		end)

		UserInputService.InputChanged:Connect(function(input)

			if dragging then

				if input.UserInputType == Enum.UserInputType.MouseMovement
					or input.UserInputType == Enum.UserInputType.Touch then

					update(input)
				end
			end
		end)

		UserInputService.InputEnded:Connect(function(input)

			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then

				dragging = false
			end
		end)
	end

	RGBSlider("R", 32, "R")
	RGBSlider("G", 62, "G")
	RGBSlider("B", 92, "B")
end

--==================================================
-- TAB SYSTEM
--==================================================

local CurrentTab

local function Tab(name)

	local button = Instance.new("TextButton")
	button.Name = name
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

	button.MouseEnter:Connect(function()

		if CurrentTab ~= button then
			button.TextColor3 = Config.Text
		end
	end)

	button.MouseLeave:Connect(function()

		if CurrentTab ~= button then
			button.TextColor3 = Config.Muted
		end
	end)

	return button
end

local PlayerTab = Tab("PLAYER")
local VisualTab = Tab("VISUAL")
local MiscTab = Tab("MISC")
local SettingsTab = Tab("SETTINGS")

local function SelectTab(button)

	if CurrentTab then
		CurrentTab.TextColor3 = Config.Muted
	end

	CurrentTab = button
	button.TextColor3 = Config.Accent
end

--==================================================
-- PLAYER
--==================================================

PlayerTab.MouseButton1Click:Connect(function()

	SelectTab(PlayerTab)
	ClearContent()

	Header("PLAYER SYSTEM")

	Toggle("Sprint", 55, function(state)

		-- Add your own experience's sprint logic here.
		print("Sprint:", state)
	end)

	Toggle("Jump Boost", 110, function(state)

		-- Add your own experience's jump logic here.
		print("Jump Boost:", state)
	end)

	Slider(
		"Movement Speed",
		175,
		1,
		100,
		50,
		function(value)

			print("Movement Speed:", value)
		end
	)
end)

--==================================================
-- VISUAL
--==================================================

VisualTab.MouseButton1Click:Connect(function()

	SelectTab(VisualTab)
	ClearContent()

	Header("VISUAL SYSTEM")

	Toggle("Neon Glow", 55, function(state)

		Config.Glow = state

		print("Neon Glow:", state)
	end)

	Toggle("Glitch FX", 110, function(state)

		Config.Glitch = state

		print("Glitch FX:", state)
	end)

	ColorPicker(175, function(color)

		print(
			"Accent:",
			math.floor(color.R * 255),
			math.floor(color.G * 255),
			math.floor(color.B * 255)
		)
	end)
end)

--==================================================
-- MISC
--==================================================

MiscTab.MouseButton1Click:Connect(function()

	SelectTab(MiscTab)
	ClearContent()

	Header("SYSTEM")

	Toggle("Notifications", 55, function(state)

		Config.Notifications = state

		if state then
			Notify(
				"SYSTEM",
				"Notifications enabled.",
				2
			)
		end
	end)

	Toggle("Debug Mode", 110, function(state)

		Config.Debug = state

		print("Debug:", state)
	end)

	Toggle("UI Animations", 165, function(state)

		Config.Animations = state

		print("Animations:", state)
	end)
end)

--==================================================
-- SETTINGS
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

	Toggle("Interface Sound", 130, function(state)

		print("Interface Sound:", state)
	end)
end)

--==================================================
-- DEFAULT TAB
--==================================================

PlayerTab:Activate()

SelectTab(PlayerTab)

ClearContent()

Header("PLAYER SYSTEM")

Toggle("Sprint", 55, function(state)
	print("Sprint:", state)
end)

Toggle("Jump Boost", 110, function(state)
	print("Jump Boost:", state)
end)

Slider(
	"Movement Speed",
	175,
	1,
	100,
	50,
	function(value)

		print("Movement Speed:", value)
	end
)

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
-- RIGHT SHIFT
--==================================================

UserInputService.InputBegan:Connect(function(input, processed)

	if processed then
		return
	end

	if input.KeyCode == Enum.KeyCode.RightShift then

		Main.Visible = not Main.Visible

		if Main.Visible then
			Notify("INTERFACE", "Cyber interface opened.", 2)
		end
	end
end)

--==================================================
-- GLITCH EFFECT
--==================================================

task.spawn(function()

	while task.wait(2.5) do

		if Config.Glitch and Main.Visible then

			local originalPosition = Main.Position

			Main.Position = UDim2.new(
				originalPosition.X.Scale,
				originalPosition.X.Offset + math.random(-2, 2),
				originalPosition.Y.Scale,
				originalPosition.Y.Offset + math.random(-1, 1)
			)

			task.wait(0.04)

			Main.Position = originalPosition
		end
	end
end)

print("================================")
print(" CYBER // 2077")
print(" Version:", Config.Version)
print(" Status: ONLINE")
print("================================")