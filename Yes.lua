local Player = game.Players.LocalPlayer
for i, v in Player.PlayerGui:GetDescendants() do
    pcall(function() v.Enabled = false end)
end

local entities = {
    "Stats", 
    "Chat", 
    "Debris",
    "CoreGui",
}
for _, entity in entities do
    pcall(function()
        for i, v in game[entity]:GetDescendants() do
            pcall(function() v:Destroy() end)
        end
    end)
end

-- Variable to enable frame rate optimization features
FrameRateBoost = true

-- Function to lower texture quality and modify properties for performance optimization
function TextureLow()
    if not game:IsLoaded() then repeat wait() until game:IsLoaded() end
    if hookfunction and setreadonly then
        local mt = getrawmetatable(game)
        local old = mt.__newindex
        setreadonly(mt, false)
        local sda
        sda = hookfunction(old, function(t, k, v)
            -- Modify material properties for performance
            if k == "Material" then
                if v ~= Enum.Material.Neon and v ~= Enum.Material.Plastic and v ~= Enum.Material.ForceField then v = Enum.Material.Plastic end
            elseif k == "TopSurface" then v = "Smooth"
            elseif k == "Reflectance" or k == "WaterWaveSize" or k == "WaterWaveSpeed" or k == "WaterReflectance" then v = 0
            elseif k == "WaterTransparency" then v = 1
            elseif k == "GlobalShadows" then v = false end
            return sda(t, k, v)
        end)
        setreadonly(mt, true)
    end

    -- Apply changes to the existing environment
    local g = game
    local w = g.Workspace
    local l = g:GetService"Lighting"
    local t = w:WaitForChild"Terrain"
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 1
    l.GlobalShadows = false

    -- Function to change object properties
    function change(v)
        pcall(function()
            if v.Material ~= Enum.Material.Neon and v.Material ~= Enum.Material.Plastic and v.Material ~= Enum.Material.ForceField then
                pcall(function() v.Reflectance = 0 end)
                pcall(function() v.Material = Enum.Material.Plastic end)
                pcall(function() v.TopSurface = "Smooth" end)
            end
        end)
    end

    -- Apply changes to new objects added to the game
    game.DescendantAdded:Connect(function(v)
        pcall(function()
            if v:IsA"Part" then change(v)
            elseif v:IsA"MeshPart" then change(v)
            elseif v:IsA"TrussPart" then change(v)
            elseif v:IsA"UnionOperation" then change(v)
            elseif v:IsA"CornerWedgePart" then change(v)
            elseif v:IsA"WedgePart" then change(v) end
        end)
    end)

    -- Apply changes to all existing descendants
    for i, v in pairs(game:GetDescendants()) do
        pcall(function()
            if v:IsA"Part" then change(v)
            elseif v:IsA"MeshPart" then change(v)
            elseif v:IsA"TrussPart" then change(v)
            elseif v:IsA"UnionOperation" then change(v)
            elseif v:IsA"CornerWedgePart" then change(v)
            elseif v:IsA"WedgePart" then change(v) end
        end)
    end
end

-- Function to remove water objects from the workspace
function WaterRemove()
    for i,v in pairs(workspace:GetDescendants()) do
        if string.find(v.Name,"Water") then
            v:Destroy()
        end
    end
end

-- Function to remove specific objects like trees and houses
function ObjectRemove()
    for i,v in pairs(workspace:GetDescendants()) do
        if string.find(v.Name,"Tree") or string.find(v.Name,"House") then
            v:Destroy()
        end
    end
end

-- Function to make non-essential objects invisible
function InvisibleObject()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if (v:IsA("Part") or v:IsA("MeshPart") or v:IsA("BasePart")) and v.Transparency then
            v.Transparency = 1
        end
    end
end

-- Disable unnecessary in-game UI to improve performance
function DisableUI()
    -- Disable CoreGui UI elements (e.g., Chat, PlayerList, etc.)
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Templates, false)

    -- Disable in-game menus
    game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)  -- Disables reset button
end

-- Main block that executes the optimizations if FrameRateBoost is true
if FrameRateBoost then
    -- Clear all lighting and apply optimizations
    game:GetService("Lighting"):ClearAllChildren()
    TextureLow()
    WaterRemove()
    ObjectRemove()
    InvisibleObject()
    DisableUI()  -- Disable UI elements for performance boost
end

-- Audio and graphics settings optimization
game:GetService("UserGameSettings").MasterVolume = 0  -- Mute sound for performance
game:GetService("Settings").Rendering.QualityLevel = 3  -- Set rendering quality to the lowest possible setting
