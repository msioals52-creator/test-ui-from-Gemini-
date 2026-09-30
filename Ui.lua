local ScreenGui = Instance.new("ScreenGui")
-- نسوي شاشة UI جديدة، هذي الحاوية الكبيرة اللي تحمل كل شي

local Frame = Instance.new("Frame")
-- نسوي مربع (Frame)، هذا الصندوق الأسود اللي يبين بالشاشة

local Title = Instance.new("TextLabel")
-- نسوي نص (TextLabel) نكتب بي العنوان

Title.Text = "K7LE"
-- الكلمة اللي تنكتب بالنص

Title.Size = UDim2.new(1, 0, 0, 40)
-- الحجم: العرض كامل المربع (1 = 100%)، والارتفاع 40 بكسل

Title.Position = UDim2.new(0, 0, 0, 0)
-- المكان: أعلى يسار المربع

Title.TextColor3 = Color3.fromRGB(0, 255, 0)
-- لون النص أخضر (أحمر 0، أخضر 255، أزرق 0)

Title.Font = Enum.Font.SourceSansBold
-- نوع الخط: سميك (Bold)

Title.TextSize = 24
-- حجم الخط

Title.BackgroundTransparency = 1
-- الخلفية شفافة تماماً (1 = مخفية، 0 = ظاهرة)

Title.Parent = Frame
-- نحط النص داخل المربع، بدون هذا السطر ما راح يبين

Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
-- لون خلفية المربع أسود

Frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
-- لون الإطار أخضر

Frame.Size = UDim2.new(0, 300, 0, 200)
-- الحجم: عرض 300 بكسل وارتفاع 200 بكسل

Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
-- المكان: نص الشاشة، ونرجع نص حجم المربع (150 و100) حتى يتوسّط

Frame.Active = true
-- لازم تكون true حتى يشتغل السحب

Frame.Draggable = true
-- نقدر نسحب المربع بالماوس أو الاصبع

Frame.Parent = ScreenGui
-- نحط المربع داخل الشاشة (ScreenGui)

ScreenGui.Enabled = true
-- نفعّل الشاشة حتى تظهر

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
-- نحط الشاشة عند اللاعب، و WaitForChild ينتظر لين تنوجد PlayerGui
