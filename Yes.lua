-- ============================================================
--  Fluxy | Auto Rebirth + Upgrade Speed + Collect + Auto Speed
-- ============================================================

-- [ CONFIG ]
local UPGRADE_AMOUNT    = 1    -- amount per upgrade
local REBIRTH_INTERVAL  = 60   -- seconds
local UPGRADE_INTERVAL  = 10    -- seconds
local COLLECT_INTERVAL  = 40    -- seconds
local TARGET_SPEED      = 500  -- stop upgrading speed when WalkSpeed >= this, also used for auto speed rejoin

-- ============================================================

local Players = game:GetService("Players")
local lp      = Players.LocalPlayer
local RS      = game:GetService("ReplicatedStorage")

local Networking      = RS:WaitForChild("Shared"):WaitForChild("Remotes"):WaitForChild("Networking")
local RF_PlotAction   = Networking:WaitForChild("RF/PlotAction")
local RF_Rebirth      = RS:WaitForChild("RemoteFunctions"):WaitForChild("Rebirth")
local RF_UpgradeSpeed = RS:WaitForChild("RemoteFunctions"):WaitForChild("UpgradeSpeed")
local RE_SetSetting   = Networking:WaitForChild("RE/Settings/SetSetting")

-- ============================================================
--  AUTO SPEED (fire + rejoin jika belum mencapai target)
-- ============================================================

local char = lp.Character or lp.CharacterAdded:Wait()
local hum  = char:WaitForChild("Humanoid")

print("Fluxy Speed: Current WalkSpeed = " .. hum.WalkSpeed)

if hum.WalkSpeed < TARGET_SPEED then
    print("Fluxy Speed: Setting speed to " .. TARGET_SPEED .. " then rejoining...")
    RE_SetSetting:FireServer("PlayerSpeed", TARGET_SPEED)
    task.wait(1)
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
    return
end

print("Fluxy Speed: Already at target (" .. hum.WalkSpeed .. ") — skip rejoin")

-- ============================================================
--  AUTO DETECT PLOT ID
-- ============================================================

local PlotID = nil
task.spawn(function()
    local elapsed = 0
    while not PlotID and elapsed < 30 do
        local Bases = workspace:FindFirstChild("Bases")
        if Bases then
            for _, plot in ipairs(Bases:GetChildren()) do
                if tostring(plot:GetAttribute("Holder")) == tostring(lp.UserId) then
                    PlotID = plot.Name
                    print("Fluxy: Plot ID = " .. PlotID)
                    break
                end
            end
        end
        task.wait(1)
        elapsed += 1
    end
end)

-- ============================================================
--  AUTO REBIRTH
-- ============================================================

task.spawn(function()
    while task.wait(REBIRTH_INTERVAL) do
        pcall(function()
            local res = RF_Rebirth:InvokeServer()
            print("Rebirth -> " .. tostring(res))
        end)
    end
end)

-- ============================================================
--  AUTO UPGRADE SPEED (berhenti jika sudah mencapai TARGET_SPEED)
-- ============================================================

task.spawn(function()
    while task.wait(UPGRADE_INTERVAL) do
        local currentChar = lp.Character
        local currentHum  = currentChar and currentChar:FindFirstChild("Humanoid")
        if currentHum and currentHum.WalkSpeed >= TARGET_SPEED then
            continue
        end
        pcall(function()
            RF_UpgradeSpeed:InvokeServer(UPGRADE_AMOUNT)
        end)
    end
end)

-- ============================================================
--  AUTO COLLECT MONEY
-- ============================================================

task.spawn(function()
    while task.wait(COLLECT_INTERVAL) do
        if PlotID then
            pcall(function()
                RF_PlotAction:InvokeServer("Collect Money", PlotID, "1")
            end)
        end
    end
end)

print("Fluxy: Auto Rebirth + Upgrade Speed + Collect Money + Auto Speed active")
