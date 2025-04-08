local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ElephantIntro"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 9999999
screenGui.Parent = gethui()

-- Create the labels
local elephantLabel = Instance.new("TextLabel")
elephantLabel.Parent = screenGui
elephantLabel.AnchorPoint = Vector2.new(0.5, 0.5)
elephantLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
elephantLabel.Size = UDim2.new(0, 100, 0, 100)
elephantLabel.BackgroundTransparency = 1
elephantLabel.Text = "🐘"
elephantLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
elephantLabel.TextScaled = true
elephantLabel.Font = Enum.Font.GothamBlack
elephantLabel.TextTransparency = 1

local pipeLabel = Instance.new("TextLabel")
pipeLabel.Parent = screenGui
pipeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
pipeLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
pipeLabel.Size = UDim2.new(0, 50, 0, 100)
pipeLabel.BackgroundTransparency = 1
pipeLabel.Text = "|"
pipeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
pipeLabel.TextScaled = true
pipeLabel.Font = Enum.Font.GothamBlack
pipeLabel.TextTransparency = 1

local loadedLabel = Instance.new("TextLabel")
loadedLabel.Parent = screenGui
loadedLabel.AnchorPoint = Vector2.new(0.5, 0.5)
loadedLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
loadedLabel.Size = UDim2.new(0, 200, 0, 100)
loadedLabel.BackgroundTransparency = 1
loadedLabel.Text = "Elephant Loaded!"
loadedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
loadedLabel.TextScaled = true
loadedLabel.Font = Enum.Font.GothamBlack
loadedLabel.TextTransparency = 1

-- Tween Definitions for Sliding In from Different Directions
local function slideInTween(label, startPos, endPos, delay)
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, delay)
	local tween = TweenService:Create(label, tweenInfo, {Position = endPos, TextTransparency = 0})
	tween:Play()
end

-- Smooth Camera Shake Function (0.1s quick shake)
local function cameraShake(intensity)
	local shakeStart = tick()
	local shakeConn
	shakeConn = RunService.RenderStepped:Connect(function()
		local t = tick() - shakeStart
		if t >= 0.1 then
			shakeConn:Disconnect()
			return
		end
		local shakePower = intensity * (1 - (t / 0.1)) -- Quick strong shake
		local offsetX = math.random(-shakePower, shakePower)
		local offsetY = math.random(-shakePower, shakePower)
		camera.CFrame = camera.CFrame * CFrame.new(offsetX, offsetY, 0)
	end)
end

-- Sequence to slide in each label and trigger camera shake after all labels appear

-- Slide in Elephant Emoji from Left
slideInTween(elephantLabel, UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0.4, 0, 0.5, 0), 0)

-- Slide in Pipe Symbol from Top
task.wait(0.3) -- Shorten wait before second label
slideInTween(pipeLabel, UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0.5, 0, 0.45, 0), 0.3)

-- Slide in Loaded Text from Right
task.wait(0.3) -- Shorten wait before third label
slideInTween(loadedLabel, UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0.6, 0, 0.5, 0), 0.6)

-- Shake All Labels After They Appear
task.wait(1) -- Wait for a bit before starting the shake
local shakeStart = tick()
local shakeDuration = 2
local shakeIntensity = 20
local shakeConn

shakeConn = RunService.RenderStepped:Connect(function()
	local t = tick() - shakeStart
	if t >= shakeDuration then
		shakeConn:Disconnect()
		-- Finalize with a tween to fly off the screen
		local flyTween = TweenService:Create(elephantLabel, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
			Position = UDim2.new(2, 0, 2, 0),
			Rotation = 1080,
			TextTransparency = 1
		})
		flyTween:Play()
		local flyTween2 = TweenService:Create(pipeLabel, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
			Position = UDim2.new(2, 0, 2, 0),
			Rotation = 1080,
			TextTransparency = 1
		})
		flyTween2:Play()
		local flyTween3 = TweenService:Create(loadedLabel, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
			Position = UDim2.new(2, 0, 2, 0),
			Rotation = 1080,
			TextTransparency = 1
		})
		flyTween3:Play()
		return
	end

	-- Intense shaking logic
	local shakePower = shakeIntensity * (t / shakeDuration) * 2
	local offsetX = math.random(-shakePower, shakePower)
	local offsetY = math.random(-shakePower, shakePower)
	elephantLabel.Position = UDim2.new(0.4, offsetX, 0.5, offsetY)
	pipeLabel.Position = UDim2.new(0.5, offsetX, 0.45, offsetY)
	loadedLabel.Position = UDim2.new(0.6, offsetX, 0.5, offsetY)
end)
