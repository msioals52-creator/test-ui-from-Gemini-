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

--// ازرار
-- 1. إنشاء خلفية السويتش (الزر الرئيسي)
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 80, 0, 40)
toggleButton.Position = UDim2.new(0, 0, 0, 50)
toggleButton.BackgroundColor3 = Color3.fromRGB(180, 180, 180) -- لون الإيقاف (رمادي)
toggleButton.Text = "" -- إزالة النص لتصميم السويتش
toggleButton.Parent = Frame

-- جعل حواف خلفية السويتش دائرية
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggleButton

-- 2. إنشاء الدائرة المتحركة داخل السويتش
local circle = Instance.new("Frame")
circle.Size = UDim2.new(0, 32, 0, 32)
circle.Position = UDim2.new(0, 4, 0.5, -16) -- موقع البدء (يسار)
circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
circle.Parent = toggleButton

-- جعل الدائرة دائرية الشكل بالكامل
local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(1, 0)
circleCorner.Parent = circle

-- 3. برمجة الحركة والتشغيل/الإيقاف
local isOn = false
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

toggleButton.MouseButton1Click:Connect(function()
	isOn = not isOn

	local targetCirclePos
	local targetBgColor

	if isOn then
		targetCirclePos = UDim2.new(1, -36, 0.5, -16) -- تحريك لليمين
		targetBgColor = Color3.fromRGB(0, 200, 255)   -- لون التشغيل (أزرق سماوي)
	else
		targetCirclePos = UDim2.new(0, 4, 0.5, -16)   -- تحريك لليسار
		targetBgColor = Color3.fromRGB(180, 180, 180) -- لون الإيقاف (رمادي)
	end

	-- تطبيق التحريك الناعم للدائرة ولون الخلفية
	TweenService:Create(circle, tweenInfo, {Position = targetCirclePos}):Play()
	TweenService:Create(toggleButton, tweenInfo, {BackgroundColor3 = targetBgColor}):Play()
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
