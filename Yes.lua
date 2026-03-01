-- ============================================================
--  Fluxy | Auto Rebirth + Upgrade Speed
-- ============================================================

-- [ CONFIG ]
local UPGRADE_AMOUNT    = 1   -- amount per upgrade
local REBIRTH_INTERVAL  = 10   -- seconds
local UPGRADE_INTERVAL  = 1  -- seconds
local COLLECT_INTERVAL  = 5    -- seconds

-- ============================================================

local Players = game:GetService("Players")
local lp      = Players.LocalPlayer
local RS      = game:GetService("ReplicatedStorage")

local Networking      = RS:WaitForChild("Shared"):WaitForChild("Remotes"):WaitForChild("Networking")
local RF_PlotAction   = Networking:WaitForChild("RF/PlotAction")
local RF_Rebirth      = RS:WaitForChild("RemoteFunctions"):WaitForChild("Rebirth")
local RF_UpgradeSpeed = RS:WaitForChild("RemoteFunctions"):WaitForChild("UpgradeSpeed")

-- Auto detect Plot ID
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

-- Auto Rebirth
task.spawn(function()
    while task.wait(REBIRTH_INTERVAL) do
        pcall(function()
            local res = RF_Rebirth:InvokeServer()
            print("Rebirth -> " .. tostring(res))
        end)
    end
end)

-- Auto Upgrade Speed
task.spawn(function()
    while task.wait(UPGRADE_INTERVAL) do
        pcall(function()
            RF_UpgradeSpeed:InvokeServer(UPGRADE_AMOUNT)
        end)
    end
end)

-- Auto Collect Money
task.spawn(function()
    while task.wait(COLLECT_INTERVAL) do
        if PlotID then
            pcall(function()
                RF_PlotAction:InvokeServer("Collect Money", PlotID, "1")
            end)
        end
    end
end)

print("Fluxy: Auto Rebirth + Upgrade Speed + Collect Money active")
