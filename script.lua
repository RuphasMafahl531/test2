local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Ruphas X Racer | Uma Racing",
   LoadingTitle = "Mengambil Data Server...",
   LoadingSubtitle = "Script Working Version",
   ConfigurationSaving = { Enabled = false }
})

local Tab = Window:CreateTab("Hack", 4483362458)

-- FITUR SPEED DENGAN RENDERSTEPPED (ANTI-RESET)
local racingSpeed = 16
local isSpeeding = false

game:GetService("RunService").RenderStepped:Connect(function()
    if isSpeeding then
        local p = game.Players.LocalPlayer
        if p.Character and p.Character:FindFirstChild("Humanoid") then
            p.Character.Humanoid.WalkSpeed = racingSpeed
        end
    end
end)

Tab:CreateSlider({
   Name = "Kecepatan Kuda",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Flag = "SpeedSlider", 
   Callback = function(Value)
       racingSpeed = Value
       isSpeeding = (Value > 16)
   end,
})

-- FITUR UNLIMITED STAMINA (REMOTE BYPASS)
Tab:CreateToggle({
   Name = "Unlimited Stamina (Force)",
   CurrentValue = false,
   Flag = "StamToggle",
   Callback = function(Value)
       _G.AutoStam = Value
       task.spawn(function()
           while _G.AutoStam do
               local char = game.Players.LocalPlayer.Character
               if char then
                   -- Memaksa sistem internal game
                   char:SetAttribute("Stamina", 9999)
                   char:SetAttribute("Energy", 9999)
               end
               task.wait() -- Tanpa angka di dalam wait agar sangat cepat
           end
       end)
   end,
})

Rayfield:Notify({
   Title = "Success!",
   Content = "Script siap digunakan di Uma Racing.",
   Duration = 5,
})
