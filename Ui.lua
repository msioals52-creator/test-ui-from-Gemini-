--// 1) الخدمات
local TweenService = game:GetService("TweenService")
local isVisible = true 
--// 2) نسوي العناصر
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextButton")

--// 3) إعدادات المربع الأسود
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)     -- خلفية سوداء
Frame.BorderColor3 = Color3.fromRGB(0, 255, 0)       -- إطار أخضر
Frame.Size = UDim2.new(0, 300, 0, 200)               -- الحجم
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)     -- نص الشاشة
Frame.Active = true                                  -- مطلوبة للسحب
Frame.Draggable = true                               -- يتسحب

--// 4) إعدادات العنوان (الزر)
Title.Text = "K7LE"
Title.Size = UDim2.new(1, 0, 0, 40)                  -- عرض كامل، ارتفاع 40
Title.Position = UDim2.new(0, 0, 0, 0)               -- أعلى يسار المربع
Title.TextColor3 = Color3.fromRGB(0, 255, 0)         -- نص أخضر
Title.Font = Enum.Font.SourceSansBold                -- خط سميك
Title.TextSize = 24
Title.BackgroundTransparency = 1                     -- خلفية مخفية
--ازرار
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 0, 40)
button.Position = UDim2.new(0, 0, 0, 50)
button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
button.TextColor3 = Color3.fromRGB(0, 0, 0)
button.Text = "زر جديد"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.Parent = Frame

button.MouseButton1Click:Connect(function()
	print("انضغط الزر!")
end)
--// 5) الحركة
local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local closeTween = TweenService:Create(Frame, info, {BackgroundTransparency = 1})
local openTween = TweenService:Create(Frame, info, {BackgroundTransparency = 0})

--// 6) الحدث: لما ينضغط الزر
Title.MouseButton1Click:Connect(function()
	if isVisible then
		closeTween:Play()
		isVisible = false
	else
		openTween:Play()
		isVisible = true
	end
end)

--// 7) الربط (دائماً آخر شي)
Title.Parent = Frame
Frame.Parent = ScreenGui
ScreenGui.Enabled = true
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
