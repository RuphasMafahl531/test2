local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Uma Racing Hub | RuphasMafahl531",
   LoadingTitle = "Bypassing Game Systems...",
   LoadingSubtitle = "Anti-Energy & Infinite Stamina",
   ConfigurationSaving = { Enabled = false }
})

local Tab = Window:CreateTab("Racing Cheats", 4483362458)

-- 1. UNLIMITED STAMINA & NO ENERGY LIMIT
-- Script ini akan memaksa nilai stamina dan energi ke angka maksimal setiap detik
local staminaEnabled = false
Tab:CreateToggle({
   Name = "Unlimited Stamina & No Energy",
   CurrentValue = false,
   Flag = "StaminaToggle",
   Callback = function(Value)
       staminaEnabled = Value
       task.spawn(function()
           while staminaEnabled do
               local p = game.Players.LocalPlayer
               local char = p.Character
               if char then
                   -- Paksa Attributes (Tempat paling umum menyimpan stamina di game racing)
                   char:SetAttribute("Stamina", 9999)
                   char:SetAttribute("Energy", 9999)
                   char:SetAttribute("SprintEnergy", 9999)
               end
               -- Mencari nilai di folder stats
               local stats = p:FindFirstChild("leaderstats") or p:FindFirstChild("Stats")
               if stats then
                   if stats:FindFirstChild("Stamina") then stats.Stamina.Value = 9999 end
                   if stats:FindFirstChild("Energy") then stats.Energy.Value = 9999 end
               end
               task.wait(0.5)
           end
       end)
   end,
})

-- 2. SPEED HACK (WALKSPEED + BYPASS)
-- Menggunakan loop agar kecepatan tidak direset oleh game saat energi habis
local currentSpeed = 16
local speedHackEnabled = false

Tab:CreateSlider({
   Name = "Speed Lari / Kuda",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Flag = "SpeedSlider", 
   Callback = function(Value)
       currentSpeed = Value
       speedHackEnabled = (Value > 16)
   end,
})

-- Loop penstabil kecepatan
task.spawn(function()
    while true do
        if speedHackEnabled then
            local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then
                hum.WalkSpeed = currentSpeed
            end
        end
        task.wait(0.1)
    end
end)

-- 3. JUMP POWER
Tab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 1,
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
       local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
       if hum then
           hum.JumpPower = Value
           hum.UseJumpPower = true
       end
   end,
})

Rayfield:Notify({
   Title = "Script Aktif!",
   Content = "Jangan gunakan speed terlalu tinggi agar tidak terkena kick otomatis.",
   Duration = 5,
})
