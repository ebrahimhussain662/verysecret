local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- CONFIG
local ZERO_G_GRAVITY = 0
local NORMAL_GRAVITY = 196.2
local TOGGLE_KEY = Enum.KeyCode.F

-- State
local enabled = false
local humanoid, root
local force, angular

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ZeroGGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.fromOffset(140, 40)
button.Position = UDim2.fromScale(0.02, 0.85)
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "Zero-G: OFF"
button.Parent = gui

-- Helpers
local function cleanupForces()
	if force then force:Destroy() force = nil end
	if angular then angular:Destroy() angular = nil end
end

local function bindCharacter(char)
	humanoid = char:WaitForChild("Humanoid")
	root = char:WaitForChild("HumanoidRootPart")

	-- Always reset on respawn
	enabled = false
	cleanupForces()
	button.Text = "Zero-G: OFF"
	workspace.Gravity = NORMAL_GRAVITY
end

local function enableZeroG()
	if not humanoid or not root then return end
	enabled = true
	button.Text = "Zero-G: ON"

	-- Client-side zero gravity
	workspace.Gravity = ZERO_G_GRAVITY

	-- Stop all motion immediately
	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero

	-- Disable humanoid stabilization
	humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	humanoid.PlatformStand = true

	-- Free rotation only (NO upward force)
	angular = Instance.new("AngularVelocity")
	angular.Attachment0 = root.RootRigAttachment
	angular.AngularVelocity = Vector3.new(2, 3, 1)
	angular.MaxTorque = math.huge
	angular.RelativeTo = Enum.ActuatorRelativeTo.World
	angular.Parent = root
end

llocal function disableZeroG()
	enabled = false
	button.Text = "Zero-G: OFF"

	if angular then angular:Destroy() angular = nil end

	workspace.Gravity = NORMAL_GRAVITY

	if humanoid then
		humanoid.PlatformStand = false
		humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end
end

local function toggle()
	if enabled then
		disableZeroG()
	else
		enableZeroG()
	end
end

-- Input
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == TOGGLE_KEY then
		toggle()
	end
end)

button.MouseButton1Click:Connect(toggle)

-- Character handling (RESPAWN FIX)
player.CharacterAdded:Connect(bindCharacter)
if player.Character then
	bindCharacter(player.Character)
end
