--// LocalScript
--// 1) الخدمات
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local isVisible = true

--// 2) إنشاء العناصر الأساسية
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextButton")

--// 3) إعدادات المربع الأسود (زدنا الارتفاع لتتسع للزر الثاني)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.Active = true
Frame.Draggable = true

--// 4) إعدادات العنوان (الزر العلوى للتصغير)
Title.Text = "K7LE"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.BackgroundTransparency = 1

--// ==================== [ الزر الأول: زيادة السرعة ] ====================
local NL1 = Instance.new("TextLabel")
NL1.Size = UDim2.new(0, 110, 0, 20)
NL1.Position = UDim2.new(1, -220, 0, 45)
NL1.TextColor3 = Color3.fromRGB(0, 255, 0)
NL1.Font = Enum.Font.SourceSansBold
NL1.TextSize = 16
NL1.BackgroundTransparency = 1
NL1.Text = "زيادة السرعة"
NL1.Parent = Frame

local speedToggle = Instance.new("TextButton")
speedToggle.Size = UDim2.new(0, 50, 0, 20)
speedToggle.Position = UDim2.new(1, -80, 0, 45)
speedToggle.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
speedToggle.Text = ""
speedToggle.Parent = Frame

local corner1 = Instance.new("UICorner")
corner1.CornerRadius = UDim.new(1, 0)
corner1.Parent = speedToggle

local circle1 = Instance.new("Frame")
circle1.Size = UDim2.new(0, 16, 0, 16)
circle1.Position = UDim2.new(0, 2, 0.5, -8)
circle1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
circle1.Parent = speedToggle

local cCorner1 = Instance.new("UICorner")
cCorner1.CornerRadius = UDim.new(1, 0)
cCorner1.Parent = circle1

--// ==================== [ الزر الثاني: هروب البيضة تلقائيًا ] ====================
local NL2 = Instance.new("TextLabel")
NL2.Size = UDim2.new(0, 130, 0, 20)
NL2.Position = UDim2.new(1, -240, 0, 85)
NL2.TextColor3 = Color3.fromRGB(0, 255, 0)
NL2.Font = Enum.Font.SourceSansBold
NL2.TextSize = 16
NL2.BackgroundTransparency = 1
NL2.Text = "هروب البيضة"
NL2.Parent = Frame

local eggToggle = Instance.new("TextButton")
eggToggle.Size = UDim2.new(0, 50, 0, 20)
eggToggle.Position = UDim2.new(1, -80, 0, 85)
eggToggle.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
eggToggle.Text = ""
eggToggle.Parent = Frame

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(1, 0)
corner2.Parent = eggToggle

local circle2 = Instance.new("Frame")
circle2.Size = UDim2.new(0, 16, 0, 16)
circle2.Position = UDim2.new(0, 2, 0.5, -8)
circle2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
circle2.Parent = eggToggle

local cCorner2 = Instance.new("UICorner")
cCorner2.CornerRadius = UDim.new(1, 0)
cCorner2.Parent = circle2

--// المتغيرات والـ Tweens
local speedOn = false
local eggEscapeOn = false
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

--// أحداث زر السرعة
speedToggle.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	local targetCirclePos = speedOn and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
	local targetBgColor = speedOn and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(180, 180, 180)

	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = speedOn and 500 or 16 end
	end

	TweenService:Create(circle1, tweenInfo, {Position = targetCirclePos}):Play()
	TweenService:Create(speedToggle, tweenInfo, {BackgroundColor3 = targetBgColor}):Play()
end)

--// أحداث زر هروب البيضة
eggToggle.MouseButton1Click:Connect(function()
	eggEscapeOn = not eggEscapeOn
	local targetCirclePos = eggEscapeOn and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
	local targetBgColor = eggEscapeOn and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(180, 180, 180)

	TweenService:Create(circle2, tweenInfo, {Position = targetCirclePos}):Play()
	TweenService:Create(eggToggle, tweenInfo, {BackgroundColor3 = targetBgColor}):Play()
end)

--// إعادة تعيين السرعة عند الموت
player.CharacterAdded:Connect(function(newCharacter)
	local newHumanoid = newCharacter:WaitForChild("Humanoid")
	newHumanoid.WalkSpeed = speedOn and 500 or 16
end)

--// منطق القفز والتخطي عند حمل البيضة (ينفذ بكل إطار سريع)
RunService.RenderStepped:Connect(function()
	if not eggEscapeOn then return end

	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		local root = char:FindFirstChild("HumanoidRootPart")
		local tool = char:FindFirstChildOfClass("Tool")

		-- يفحص إذا كان اللاعب يحمل أداة تحوي اسم البيضة أو أي أداة مسكها
		if tool and root and hum then
			-- القفز المستمر
			if hum:GetState() ~= Enum.HumanoidStateType.Jumping then
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end
			-- النقل الفوري للأمام 50 خطوة بأجزاء من الثانية
			root.CFrame = root.CFrame * CFrame.new(0, 0, -50)
		end
	end
end)

--// انيميشن إخفاء/إظهار النافذة عند الضغط على العنوان
local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

Title.MouseButton1Click:Connect(function()
	local targetTrans = isVisible and 1 or 0
	isVisible = not isVisible

	TweenService:Create(Frame, info, {BackgroundTransparency = targetTrans}):Play()
	TweenService:Create(speedToggle, info, {BackgroundTransparency = targetTrans}):Play()
	TweenService:Create(circle1, info, {BackgroundTransparency = targetTrans}):Play()
	TweenService:Create(NL1, info, {TextTransparency = targetTrans}):Play()
	TweenService:Create(eggToggle, info, {BackgroundTransparency = targetTrans}):Play()
	TweenService:Create(circle2, info, {BackgroundTransparency = targetTrans}):Play()
	TweenService:Create(NL2, info, {TextTransparency = targetTrans}):Play()
end)

--// الربط النهائي
Title.Parent = Frame
Frame.Parent = ScreenGui
ScreenGui.Enabled = true
ScreenGui.Parent = player:WaitForChild("PlayerGui")
