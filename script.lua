local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Uma Racing ULTRA | Ruphas Hub",
   LoadingTitle = "Bypassing Internal Systems...",
   LoadingSubtitle = "V4 Extreme Edition",
   ConfigurationSaving = { Enabled = false }
})

local Tab = Window:CreateTab("Main Cheats", 4483362458)

-- VARIABEL GLOBAL
_G.RunSpeed = 16
_G.AutoRun = false
_G.InfStam = false
_G.AntiHit = false

-- 1. EXTREME INF STAMINA (Memaksa Stamina tetap Full setiap saat)
Tab:CreateToggle({
   Name = "Inf Stamina (Force Lock)",
   CurrentValue = false,
   Flag = "StamToggle",
   Callback = function(Value)
       _G.InfStam = Value
       if Value then
           task.spawn(function()
               while _G.InfStam do
                   local p = game.Players.LocalPlayer
                   local char = p.Character
                   if char then
                       -- Memaksa Attributes & Values secara instan
                       char:SetAttribute("Stamina", 1000)
                       char:SetAttribute("Energy", 1000)
                       
                       local stats = p:FindFirstChild("leaderstats") or p:FindFirstChild("Stats")
                       if stats and stats:FindFirstChild("Stamina") then
                           stats.Stamina.Value = 1000
                       end
                   end
                   task.wait() -- Tanpa delay agar sistem game kalah cepat
               end
           end)
       end
   end,
})

-- 2. MAX SPEED CHANGER (Anti-Reset Method)
Tab:CreateSlider({
   Name = "Max Speed Changer",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Flag = "SpeedSlider", 
   Callback = function(Value)
       _G.RunSpeed = Value
   end,
})

-- Loop Penstabil Speed (Dijalankan setiap frame)
game:GetService("RunService").RenderStepped:Connect(function()
    local char = game.Players.LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        if _G.AutoRun or hum.MoveDirection.Magnitude > 0 then
            hum.WalkSpeed = _G.RunSpeed
        end
        if _G.AutoRun then
            hum:Move(Vector3.new(0, 0, -1), true)
        end
    end
end)

-- 3. AUTO RUN
Tab:CreateToggle({
   Name = "Auto Run (Otomatis)",
   CurrentValue = false,
   Flag = "AutoRun",
   Callback = function(Value)
       _G.AutoRun = Value
   end,
})

-- 4. ANTI HIT WALL (Noclip)
Tab:CreateToggle({
   Name = "Anti Hit Wall",
   CurrentValue = false,
   Flag = "AntiHit",
   Callback = function(Value)
       _G.AntiHit = Value
       task.spawn(function()
           while _G.AntiHit do
               local char = game.Players.LocalPlayer.Character
               if char then
                   for _, v in pairs(char:GetDescendants()) do
                       if v:IsA("BasePart") and v.CanCollide then
                           v.CanCollide = false
                       end
                   end
               end
               task.wait(0.1)
           end
       end)
   end,
})

-- 5. TAMBAHAN FITUR LAINNYA
Tab:CreateButton({
   Name = "ESP & Instant Camera",
   Callback = function()
       -- ESP
       for _, v in pairs(game.Players:GetPlayers()) do
           if v ~= game.Players.LocalPlayer and v.Character then
               local h = Instance.new("Highlight", v.Character)
               h.FillColor = Color3.fromRGB(255, 0, 0)
           end
       end
       -- Camera
       workspace.CurrentCamera.FieldOfView = 100
   end,
})

Rayfield:Notify({
   Title = "V4 Loaded!",
   Content = "Aktifkan 'Inf Stamina' dan naikkan 'Max Speed'!",
   Duration = 5,
})
