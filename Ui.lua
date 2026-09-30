--// 1) الخدمات
local TweenService = game:GetService("TweenService")
local isVisible = true

--// 2) نسوي العناصر
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextButton")

--// 3) إعدادات المربع الأسود
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.Active = true
Frame.Draggable = true

--// 4) إعدادات العنوان (الزر)
Title.Text = "K7LE"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24
Title.BackgroundTransparency = 1

--عناوين الازرار 
local NL = Instance.new("TextLabel")
NL.Size = DIim2.new(0,100,0,30)
NL.Position = UDim2.new(1,-200,0,50)
NL.TextColor3 = Color3.fromRGB(0, 255, 0)
NL.Font = Enum.Font.SourceSansBold
NL.TextSize = 24
NL.BackgroundTransparency = 1
NL.Text = "زيادة سرعة الأهيه"

--^زيادة سرعة

--// ازرار
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 50, 0, 20)
toggleButton.Position = UDim2.new(1, -90, 0, 50)
toggleButton.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
toggleButton.Text = ""
toggleButton.Parent = Frame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggleButton

local circle = Instance.new("Frame")
circle.Size = UDim2.new(0, 16, 0, 16)
circle.Position = UDim2.new(0, 2, 0.5, -8)
circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
circle.Parent = toggleButton

local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(1, 0)
circleCorner.Parent = circle

local isOn = false
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

toggleButton.MouseButton1Click:Connect(function()
	isOn = not isOn

	local targetCirclePos
	local targetBgColor

	if isOn then
		targetCirclePos = UDim2.new(1, -18, 0.5, -8)
		targetBgColor = Color3.fromRGB(0, 255, 0)
			game.Players.Local = Player.Character.Humanoid.WalkSpeed = 500
			
	else
		targetCirclePos = UDim2.new(0, 2, 0.5, -8)
		targetBgColor = Color3.fromRGB(180, 180, 180)
			game.Players.Local = Player.Character.Humanoid.WalkSpeed = 16
	end

	TweenService:Create(circle, tweenInfo, {Position = targetCirclePos}):Play()
	TweenService:Create(toggleButton, tweenInfo, {BackgroundColor3 = targetBgColor}):Play()
end)

--// 5) الحركة
local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local closeTween = TweenService:Create(Frame, info, {BackgroundTransparency = 1})
local openTween = TweenService:Create(Frame, info, {BackgroundTransparency = 0})
local closeButton = TweenService:Create(toggleButton, info, {BackgroundTransparency = 1})
local openButton = TweenService:Create(toggleButton, info, {BackgroundTransparency = 0})
local closeCircle = TweenService:Create(circle, info, {BackgroundTransparency = 1})
local openCircle = TweenService:Create(circle, info, {BackgroundTransparency = 0})

--// 6) الحدث: لما ينضغط الزر
Title.MouseButton1Click:Connect(function()
	if isVisible then
		closeTween:Play()
		closeButton:Play()
		closeCircle:Play()
		isVisible = false
	else
		openTween:Play()
		openButton:Play()
		openCircle:Play()
		isVisible = true
	end
end)

--// 7) الربط (دائماً آخر شي)
Title.Parent = Frame
Frame.Parent = ScreenGui
ScreenGui.Enabled = true
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
