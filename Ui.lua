--// LocalScript
--// 1) الخدمات
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local isVisible = true

--// 2) الإعدادات (غيّرها إذا احتجت)
local BOSS_KEYWORD = "scramble" -- جزء من اسم البوس بالإنجليزي، بحروف صغيرة
local WEAPON_KEYWORD = "sword"  -- جزء من اسم سلاحك بالإنجليزي، بحروف صغيرة

--// 3) الحالة
local speedOn = false
local eggEscapeOn = false
local lagOn = false
local bossOn = false

--// ==================== [ منع الطرد بسبب AFK ] ====================
player.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

--// ==================== [ تقليل اللاق ] ====================
local backup = setmetatable({}, {__mode = "k"})
local lagConnection, savedQuality, savedShadows

local function simplify(obj)
	if obj:IsA("BasePart") then
		if not backup[obj] then
			backup[obj] = {Material = obj.Material, CastShadow = obj.CastShadow}
		end
		obj.Material = Enum.Material.SmoothPlastic
		obj.CastShadow = false
	elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke")
		or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("BlurEffect")
		or obj:IsA("BloomEffect") or obj:IsA("SunRaysEffect") or obj:IsA("DepthOfFieldEffect") then
		if not backup[obj] then
			backup[obj] = {Enabled = obj.Enabled}
		end
		obj.Enabled = false
	end
end

local function setLowGraphics(on)
	lagOn = on
	if on then
		pcall(function()
			savedQuality = settings().Rendering.QualityLevel
			settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		end)
		savedShadows = Lighting.GlobalShadows
		Lighting.GlobalShadows = false
		for _, obj in ipairs(Lighting:GetChildren()) do simplify(obj) end

		task.spawn(function()
			local count = 0
			for _, obj in ipairs(workspace:GetDescendants()) do
				if not lagOn then break end
				simplify(obj)
				count += 1
				if count % 500 == 0 then task.wait() end -- حتى ما تتجمد اللعبة
			end
		end)
		lagConnection = workspace.DescendantAdded:Connect(simplify)
	else
		if lagConnection then lagConnection:Disconnect() lagConnection = nil end
		pcall(function()
			if savedQuality then settings().Rendering.QualityLevel = savedQuality end
		end)
		if savedShadows ~= nil then Lighting.GlobalShadows = savedShadows end
		for obj, data in pairs(backup) do
			if obj.Parent then
				if data.Material then
					obj.Material = data.Material
					obj.CastShadow = data.CastShadow
				else
					obj.Enabled = data.Enabled
				end
			end
		end
		table.clear(backup)
	end
end

--// ==================== [ فارم البوس ] ====================
local currentBoss, bossPart

local function isAlive(model)
	if not model or not model.Parent then return false end
	local hum = model:FindFirstChildOfClass("Humanoid")
	return hum ~= nil and hum.Health > 0
end

local function findBoss()
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj.Name:lower():find(BOSS_KEYWORD, 1, true) and isAlive(obj) then
			local part = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
			if part then return obj, part end
		end
	end
end

task.spawn(function()
	local lastSearch = 0
	while true do
		task.wait(0.2)
		if not bossOn then continue end

		local char = player.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if not (root and hum and hum.Health > 0) then continue end

		-- يدور على البوس كل ثانيتين بس (حتى ما يسبب لاق)
		if not isAlive(currentBoss) and os.clock() - lastSearch > 2 then
			lastSearch = os.clock()
			currentBoss, bossPart = findBoss()
		end

		if isAlive(currentBoss) and bossPart and bossPart.Parent then
			-- تجهيز السلاح
			local tool = char:FindFirstChildOfClass("Tool")
			if tool and not tool.Name:lower():find(WEAPON_KEYWORD, 1, true) then tool = nil end
			if not tool then
				local backpack = player:FindFirstChildOfClass("Backpack")
				if backpack then
					for _, t in ipairs(backpack:GetChildren()) do
						if t:IsA("Tool") and t.Name:lower():find(WEAPON_KEYWORD, 1, true) then
							hum:EquipTool(t)
							tool = t
							break
						end
					end
				end
			end

			root.CFrame = bossPart.CFrame * CFrame.new(0, 0, 5) -- يوقف قريب من البوس
			if tool then tool:Activate() end
		end
	end
end)

--// ==================== [ الواجهة: Liquid Glass ] ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false -- حتى ما تختفي الواجهة إذا متت

local Container = Instance.new("Frame")
Container.Size = UDim2.new(0, 300, 0, 240)
Container.Position = UDim2.new(0.5, -150, 0.5, -120)
Container.BackgroundTransparency = 1
Container.Active = true
Container.Draggable = true
Container.Parent = ScreenGui

local Glass = Instance.new("CanvasGroup")
Glass.Size = UDim2.new(1, 0, 1, 0)
Glass.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Glass.BackgroundTransparency = 0
Glass.Parent = Container

local glassCorner = Instance.new("UICorner")
glassCorner.CornerRadius = UDim.new(0, 26)
glassCorner.Parent = Glass

local glassStroke = Instance.new("UIStroke")
glassStroke.Color = Color3.fromRGB(255, 255, 255)
glassStroke.Transparency = 0.45
glassStroke.Thickness = 1.5
glassStroke.Parent = Glass

local glassGradient = Instance.new("UIGradient")
glassGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(170, 200, 255))
glassGradient.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0.55),
	NumberSequenceKeypoint.new(1, 0.85),
})
glassGradient.Rotation = 45
glassGradient.Parent = Glass

local Title = Instance.new("TextButton")
Title.Text = "K7LE"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = Container

local List = Instance.new("Frame")
List.Size = UDim2.new(1, -24, 1, -52)
List.Position = UDim2.new(0, 12, 0, 44)
List.BackgroundTransparency = 1
List.Parent = Glass

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = List

--// دالة تسوي سويتش كامل (بدل ما نكرر الكود لكل زر)
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local ON_COLOR = Color3.fromRGB(52, 199, 89)
local OFF_COLOR = Color3.fromRGB(120, 120, 128)

local function createToggle(text, order, onChange)
	local state = false

	local Row = Instance.new("Frame")
	Row.Size = UDim2.new(1, 0, 0, 40)
	Row.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Row.BackgroundTransparency = 0.88
	Row.LayoutOrder = order
	Row.Parent = List

	local rowCorner = Instance.new("UICorner")
	rowCorner.CornerRadius = UDim.new(0, 14)
	rowCorner.Parent = Row

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, -72, 1, 0)
	Label.Position = UDim2.new(0, 62, 0, 0)
	Label.BackgroundTransparency = 1
	Label.Text = text
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.Font = Enum.Font.SourceSansSemibold
	Label.TextSize = 18
	Label.TextXAlignment = Enum.TextXAlignment.Right
	Label.Parent = Row

	local Switch = Instance.new("TextButton")
	Switch.Size = UDim2.new(0, 46, 0, 26)
	Switch.Position = UDim2.new(0, 10, 0.5, -13)
	Switch.BackgroundColor3 = OFF_COLOR
	Switch.Text = ""
	Switch.AutoButtonColor = false
	Switch.Parent = Row

	local swCorner = Instance.new("UICorner")
	swCorner.CornerRadius = UDim.new(1, 0)
	swCorner.Parent = Switch

	local Knob = Instance.new("Frame")
	Knob.Size = UDim2.new(0, 22, 0, 22)
	Knob.Position = UDim2.new(0, 2, 0.5, -11)
	Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Knob.Parent = Switch

	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = Knob

	Switch.MouseButton1Click:Connect(function()
		state = not state
		TweenService:Create(Knob, tweenInfo, {
			Position = state and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11)
		}):Play()
		TweenService:Create(Switch, tweenInfo, {
			BackgroundColor3 = state and ON_COLOR or OFF_COLOR
		}):Play()
		onChange(state)
	end)
end

--// ==================== [ الأزرار ] ====================
createToggle("زيادة السرعة", 1, function(on)
	speedOn = on
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = on and 500 or 16 end
end)

createToggle("هروب البيضة", 2, function(on)
	eggEscapeOn = on
end)

createToggle("تقليل اللاق", 3, function(on)
	setLowGraphics(on)
end)

createToggle("فارم البوس", 4, function(on)
	bossOn = on
end)

--// إعادة تعيين السرعة عند الموت
player.CharacterAdded:Connect(function(newCharacter)
	local newHumanoid = newCharacter:WaitForChild("Humanoid")
	newHumanoid.WalkSpeed = speedOn and 500 or 16
end)

--// هروب البيضة (يتوقف أثناء فارم البوس حتى ما يتعارض مع السلاح)
RunService.RenderStepped:Connect(function()
	if not eggEscapeOn or bossOn then return end

	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		local root = char:FindFirstChild("HumanoidRootPart")
		local tool = char:FindFirstChildOfClass("Tool")

		if tool and root and hum then
			if hum:GetState() ~= Enum.HumanoidStateType.Jumping then
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end
			root.CFrame = root.CFrame * CFrame.new(0, 0, -50)
		end
	end
end)

--// انيميشن إخفاء/إظهار الواجهة عند الضغط على العنوان
local fadeInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

Title.MouseButton1Click:Connect(function()
	isVisible = not isVisible
	if isVisible then Glass.Visible = true end

	local tween = TweenService:Create(Glass, fadeInfo, {GroupTransparency = isVisible and 0 or 1})
	tween:Play()

	if not isVisible then
		tween.Completed:Connect(function()
			if not isVisible then Glass.Visible = false end
		end)
	end
end)

--// الربط النهائي
ScreenGui.Parent = player:WaitForChild("PlayerGui")
