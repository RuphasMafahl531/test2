local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Uma Racing | Natural Hub",
   LoadingTitle = "Menyesuaikan Sistem Sprint...",
   LoadingSubtitle = "V7 Stealth Edition",
   ConfigurationSaving = { Enabled = false }
})

local Tab = Window:CreateTab("Stealth Hack", 4483362458)

_G.CustomSpeed = 16
_G.StealthActive = false

-- 1. STEALTH INFINITE STAMINA
Tab:CreateToggle({
   Name = "Stealth Inf Stamina (Gunakan saat Sprint)",
   CurrentValue = false,
   Flag = "StealthStam",
   Callback = function(Value)
       _G.StealthActive = Value
       task.spawn(function()
           while _G.StealthActive do
               local p = game.Players.LocalPlayer
               local char = p.Character
               if char then
                   -- Mengunci stamina secara halus agar tidak terlihat aneh di UI
                   char:SetAttribute("Stamina", 100)
                   char:SetAttribute("Energy", 100)
               end
               task.wait(0.01) -- Sangat cepat untuk melawan sistem drain
           end
       end)
   end,
})

-- 2. SPEED CHANGER (Hanya aktif saat kamu bergerak)
Tab:CreateSlider({
   Name = "Kecepatan Sprint (Natural)",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Flag = "SpeedSlider", 
   Callback = function(Value)
       _G.CustomSpeed = Value
   end,
})

-- 3. SPRINT DETECTOR (Menimpa sistem lari bawaan game)
game:GetService("RunService").RenderStepped:Connect(function()
    local p = game.Players.LocalPlayer
    local hum = p.Character and p.Character:FindFirstChild("Humanoid")
    
    if hum and _G.StealthActive then
        -- Jika kamu sedang menekan tombol jalan/sprint
        if hum.MoveDirection.Magnitude > 0 then
            hum.WalkSpeed = _G.CustomSpeed
        end
    end
end)

-- 4. ANTI-KICK BYPASS (Mencegah terdeteksi server)
task.spawn(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldindex = mt.__index
    mt.__index = newcclosure(function(t, k)
        if k == "WalkSpeed" and not checkcaller() then
            return 16 -- Server akan selalu mengira speed kamu cuma 16
        end
        return oldindex(t, k)
    end)
    setreadonly(mt, true)
end)

Rayfield:Notify({
   Title = "Stealth V7 Aktif",
   Content = "Silakan tekan tombol sprint seperti biasa!",
   Duration = 5,
})

