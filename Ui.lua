local ScreenGui = Instance.new("ScreenGui")
-- نسوي شاشة UI جديدة

local Frame = Instance.new("Frame")
-- نسوي المربع الأسود

local Title = Instance.new("TextButton")
-- نسوي زر نصي، لازم زر حتى نقدر ننقر عليه

local TweenService = game:GetService("TweenService")
-- نستدعي خدمة الحركة، الاسم لازم يكون مضبوط بالحرف

local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
-- إعدادات الحركة: نص ثانية، بأسلوب Quad، وتبطأ بالنهاية

local closeTween = TweenService:Create(Frame, info, {BackgroundTransparency = 1})
-- نجهّز حركة تخلي خلفية المربع تختفي تدريجياً

Title.MouseButton1Click:Connect(function()
-- لما ينضغط الزر، ينفذ الكود اللي جوّا
    closeTween:Play()
    -- يشغّل الحركة، الأقواس مهمة
end)
-- نهاية الدالة

Title.Text = "K7LE"
-- الكلمة اللي تنكتب

Title.Size = UDim2.new(1, 0, 0, 40)
-- عرض المربع كامل وارتفاع 40 بكسل

Title.Position = UDim2.new(0, 0, 0, 0)
-- أعلى يسار المربع

Title.TextColor3 = Color3.fromRGB(0, 255, 0)
-- لون النص أخضر

Title.Font = Enum.Font.SourceSansBold
-- خط سميك

Title.TextSize = 24
-- حجم الخط

Title.BackgroundTransparency = 1
-- خلفية الزر شفافة

Title.Parent = Frame
-- نحط الزر داخل المربع

Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
-- خلفية سوداء

Frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
-- إطار أخضر

Frame.Size = UDim2.new(0, 300, 0, 200)
-- 300 عرض و200 ارتفاع

Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
-- نص الشاشة

Frame.Active = true
-- مطلوبة حتى يشتغل السحب

Frame.Draggable = true
-- نقدر نسحب المربع

Frame.Parent = ScreenGui
-- نحط المربع داخل الشاشة

ScreenGui.Enabled = true
-- تفعيل الشاشة

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
-- نحط الشاشة عند اللاعب
