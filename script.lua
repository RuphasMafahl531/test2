local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Uma Racing | Sprint Injector V9",
   LoadingTitle = "Menyuntikkan Kode ke Tombol Sprint...",
   LoadingSubtitle = "Oleh Ruphas PRO",
   ConfigurationSaving = { Enabled = false }
})

local Tab = Window:CreateTab("Main Hack", 4483362458)

-- Global Settings
_G.MaxSpeed = 16
_G.InfStamina = false
_G.AutoRun = false
_G.AntiHit = false

-- 1. ULTIMATE INF STAMINA (Mencegat pengurangan nilai)
Tab:CreateToggle({
   Name = "Infinite Stamina",
   CurrentValue = false,
   Flag = "StamToggle",
   Callback = function(Value)
       _G.InfStamina = Value
       if Value then
           task.spawn(function()
               while _G.InfStamina do
                   local p = game.Players.LocalPlayer
                   if p.Character then
                       -- Memaksa atribut stamina tetap 100% setiap milidetik
                       p.Character:SetAttribute("Stamina", 100)
                       p.Character:SetAttribute("Energy", 100)
                       p.Character:SetAttribute("SprintDrain", 0) -- Mencoba mematikan drain
                   end
                   task.wait()
               end
           end)
       end
   end,
})

-- 2. MAX SPEED CHANGER (Fokus ke Tombol Sprint)
Tab:CreateSlider({
   Name = "Max Speed (Saat Sprint)",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Flag = "SpeedSlider", 
   Callback = function(Value)
       _G.MaxSpeed = Value
   end,
})

-- LOOP UTAMA: Mendeteksi aktivitas sprint dan memaksa Speed
game:GetService("RunService").RenderStepped:Connect(function()
    local p = game.Players.LocalPlayer
    local char = p.Character
    local hum = char and char:FindFirstChild("Humanoid")
    
    if hum then
        -- Jika pemain bergerak DAN menekan tombol (Magnitude > 0)
        -- Kita paksa WalkSpeed tepat saat game mencoba mengontrolnya
        if hum.MoveDirection.Magnitude > 0 then
            hum.WalkSpeed = _G.MaxSpeed
        end
        
        -- Fitur Auto Run
        if _G.AutoRun then
            hum:Move(Vector3.new(0, 0, -1), true)
        end
    end
end)

-- 3. ANTI HIT WALL (Noclip)
Tab:CreateToggle({
   Name = "Anti Hit Wall",
   CurrentValue = false,
   Flag = "AntiHit",
   Callback = function(Value)
       _G.AntiHit = Value
       game:GetService("RunService").Stepped:Connect(function()
           if _G.AntiHit and game.Players.LocalPlayer.Character then
               for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                   if v:IsA("BasePart") then v.CanCollide = false end
               end
           end
       end)
   end,
})

-- 4. AUTO RUN TOGGLE
Tab:CreateToggle({
   Name = "Auto Run",
   CurrentValue = false,
   Flag = "AutoRun",
   Callback = function(Value)
       _G.AutoRun = Value
   end,
})

-- 5. PLAYER ESP & CAMERA
Tab:CreateButton({
   Name = "Player ESP & Instant Camera",
   Callback = function()
       -- ESP
       for _, v in pairs(game.Players:GetPlayers()) do
           if v ~= game.Players.LocalPlayer and v.Character then
               if not v.Character:FindFirstChild("Highlight") then
                   local h = Instance.new("Highlight", v.Character)
                   h.FillColor = Color3.fromRGB(255, 0, 0)
               end
           end
       end
       -- Camera Turn
       workspace.CurrentCamera.FieldOfView = 120
   end,
})

-- FITUR "NO STAMINA SPEED" (Bypass Lambat saat Lelah)
task.spawn(function()
    while true do
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum and _G.InfStamina then
            -- Mencegah status 'Tired' atau melambat
            hum.PlatformStand = false
        end
        task.wait(0.1)
    end
end)

Rayfield:Notify({
   Title = "V9 Sprint Injected!",
   Content = "Nyalakan Inf Stamina, lalu tekan tombol sprint asli game!",
   Duration = 5,
})
