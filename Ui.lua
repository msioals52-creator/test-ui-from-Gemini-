local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")

Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100) -- يضع المربع في منتصف الشاشة
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

ScreenGui.Enabled = true
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
