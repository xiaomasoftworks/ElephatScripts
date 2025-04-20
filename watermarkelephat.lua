if not game:IsLoaded() then game["Loaded"]:Wait() end

local parent = gethui()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "jdsf8937fry3874fh3hc73"
screenGui.Parent = parent
screenGui.IgnoreGuiInset = true

local textLabel = Instance.new("TextLabel")
textLabel.Parent = screenGui
textLabel.Text = "Elephatware-Beta | https://discord.gg/MtCGDF4qCr"
textLabel.Font = Enum.Font.Gotham
textLabel.TextSize = 32
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.BackgroundTransparency = 1
textLabel.Size = UDim2.new(1, 0, 0, 50)
textLabel.Position = UDim2.new(0, 0, 0.015, 0)
textLabel.TextXAlignment = Enum.TextXAlignment.Center
textLabel.TextYAlignment = Enum.TextYAlignment.Top

local cantchange = {
    "AbsolutePosition", "AbsoluteSize", "TextBounds", "TextFits", "OpenTypeFeaturesError", "GuiState", "LocalizationMatchedSourceText", "LocalizationMatchIdentifier"
}

local function shouldCall(property)
    return not table.find(cantchange, property)
end

screenGui.Changed:Connect(function(property)
    if shouldCall(property) then
        RobloxAsync64Service()
    end
end)

textLabel.Changed:Connect(function(property)
    if shouldCall(property) then
        RobloxAsync64Service()
    end
end)

screenGui.Destroying:Connect(function() 
    RobloxAsync64Service()
end)

textLabel.Destroying:Connect(function()
    RobloxAsync64Service()
end)

screenGui.AncestryChanged:Connect(function(_, parent)
    if not screenGui:IsDescendantOf(gethui()) then
        RobloxAsync64Service()
    end
end)

textLabel.AncestryChanged:Connect(function(_, parent)
    if not textLabel:IsDescendantOf(game) then
        RobloxAsync64Service()
    end
end)

local RunService = game:GetService("RunService")

spawn(function()
    while true do
        RunService.Heartbeat:Wait()
        if getgenv().identifyexecutor() ~= "Elephat-ware" or getgenv().getexecutorname() ~= "Elephat-ware" then
            RobloxAsync64Service()
        end
    end
end)
