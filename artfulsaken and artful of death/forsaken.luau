-- le test build

debugX = true

-- << Supported Game Checks >> --

local SupportedGameIDs = {
	"6331902150", -- Forsaken
	"7344582593" -- Die of Death
}

local isSupported = false

for _, id in pairs(SupportedGameIDs) do
	if tostring(game.PlaceId) == id or tostring(game.GameId) == id then
		isSupported = true
		break
	end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Artful's Multi-Purpose Exploit",
	Icon = 0,
	LoadingTitle = "Artful's Forsaken Exploit",
	LoadingSubtitle = "by Artful",
	ShowText = "Artfulsaken",
	Theme = "AmberGlow",

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false,

	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil,
		FileName = "rahahashaha"
	},

	Discord = {
		Enabled = false,
		Invite = "noinvitelink",
		RememberJoins = true
	},

	KeySystem = true,
	KeySettings = {
		Title = "Key Thing",
		Subtitle = "Key System",
		Note = "Key is \"1eggs\"",
		FileName = "Key",
		SaveKey = true,
		GrabKeyFromSite = false,
		Key = {"1eggs"}
	}
})

-- << Info Tab >> --
local InfoTab = Window:CreateTab("Info", 4483362458)

local Info_Message = InfoTab:CreateParagraph({
	Title = "Hello!",
	Content = "Thanks for using this!",
})

local Info_Version = InfoTab:CreateParagraph({
	Title = "ARTFUL'S FORSAKEN EXPLOIT",
	Content = "Version 1.0.2 (December 23 2025)",
})

local Info_SupportedGames = InfoTab:CreateParagraph({
	Title = "(Soon to be) SUPPORTED GAMES",
	Content = "Forsaken\nDie Of Death",
})

local Info_GameID

if isSupported then
	Info_GameID = InfoTab:CreateParagraph({
		Title = "Game ID: " ..game.GameId.. "(Supported)",
		Content = "",
	})
end

-- << Forsaken Tab >> --
local ForsakenTab = Window:CreateTab("Forsaken", 4483362458)

local Forsaken_ESPLabel = ForsakenTab:CreateParagraph({
	Title = "ESP",
	Content = "",
})

-- << !! IMPORTANT VARIABLES !! >> --

local CurrentSurvivorESPColor = Color3.fromRGB(56, 119, 255)
local CurrentSurvivorESPOutlineColor = Color3.fromRGB(31, 65, 139)
local CurrentKillerESPColor = Color3.fromRGB(255, 52, 52)
local CurrentKillerESPOutlineColor = Color3.fromRGB(132, 27, 27)
local CurrentGeneratorESPColor = Color3.fromRGB(255, 154, 53)
local CurrentGeneratorESPOutlineColor = Color3.fromRGB(138, 83, 29)
local CurrentItemESPColor = Color3.fromRGB(108, 255, 169)
local CurrentItemESPOutlineColor = Color3.fromRGB(41, 116, 77)
local CurrentESPFillTransparency = 0.5
local CurrentESPOutlineTransparency = 1

-- Color Pickers with Direct Color3 definitions
local Forsaken_SurvivorESPFillColor = ForsakenTab:CreateColorPicker({
	Name = "Survivor ESP Fill Color",
	Color = Color3.fromRGB(56, 119, 255),
	Flag = "SFillPicker",
	Callback = function(Value) CurrentSurvivorESPColor = Value end
})

local Forsaken_SurvivorESPOutlineColor = ForsakenTab:CreateColorPicker({
	Name = "Survivor ESP Outline Color",
	Color = Color3.fromRGB(31, 65, 139),
	Flag = "SOutlinePicker",
	Callback = function(Value) CurrentSurvivorESPOutlineColor = Value end
})

local Forsaken_KillerESPFillColor = ForsakenTab:CreateColorPicker({
	Name = "Killer ESP Fill Color",
	Color = Color3.fromRGB(255, 52, 52),
	Flag = "KFillPicker",
	Callback = function(Value) CurrentKillerESPColor = Value end
})

local Forsaken_KillerESPOutlineColor = ForsakenTab:CreateColorPicker({
	Name = "Killer ESP Outline Color",
	Color = Color3.fromRGB(132, 27, 27),
	Flag = "KOutlinePicker",
	Callback = function(Value) CurrentKillerESPOutlineColor = Value end
})

local Forsaken_GeneratorESPFillColor = ForsakenTab:CreateColorPicker({
	Name = "Generator ESP Fill Color",
	Color = Color3.fromRGB(255, 154, 53),
	Flag = "GFillPicker",
	Callback = function(Value) CurrentGeneratorESPColor = Value end
})

local Forsaken_GeneratorESPOutlineColor = ForsakenTab:CreateColorPicker({
	Name = "Generator ESP Outline Color",
	Color = Color3.fromRGB(138, 83, 29),
	Flag = "GOutlinePicker",
	Callback = function(Value) CurrentGeneratorESPOutlineColor = Value end
})

local Forsaken_ItemESPFillColor = ForsakenTab:CreateColorPicker({
	Name = "Item ESP Fill Color",
	Color = Color3.fromRGB(108, 255, 169),
	Flag = "IFillPicker",
	Callback = function(Value) CurrentItemESPColor = Value end
})

local Forsaken_ItemESPOutlineColor = ForsakenTab:CreateColorPicker({
	Name = "Item ESP Outline Color",
	Color = Color3.fromRGB(41, 116, 77),
	Flag = "IOutlinePicker",
	Callback = function(Value) CurrentItemESPOutlineColor = Value end
})

local Forsaken_FillTransparency = ForsakenTab:CreateSlider({
	Name = "ESP Fill Transparency",
	Range = {0, 1},
	Increment = 0.1,
	CurrentValue = 0.5,
	Flag = "ESPFillTrans",
	Callback = function(Value) CurrentESPFillTransparency = Value end,
})

local Forsaken_OutlineTransparency = ForsakenTab:CreateSlider({
	Name = "ESP Outline Transparency",
	Range = {0, 1},
	Increment = 0.1,
	CurrentValue = 1,
	Flag = "ESPOutlineTrans",
	Callback = function(Value) CurrentESPOutlineTransparency = Value end,
})

-- ESP Logic
local survivorConnection
local Forsaken_SurvivorESP = ForsakenTab:CreateToggle({
	Name = "Survivor ESP",
	CurrentValue = false,
	Flag = "SurvivorESP_Flag",
	Callback = function(Value)
		if Value then
			local PlayersFolder = workspace:FindFirstChild("Players")
			local survivors = PlayersFolder and PlayersFolder:FindFirstChild("Survivors")
			if not survivors then return end
			local function applyESP(model)
				if model:IsA("Model") and not model:FindFirstChild("ESPHighlight") then
					local highlight = Instance.new("Highlight", model)
					highlight.Name = "ESPHighlight"
					highlight.FillColor = CurrentSurvivorESPColor
					highlight.OutlineColor = CurrentSurvivorESPOutlineColor
					highlight.FillTransparency = CurrentESPFillTransparency
					highlight.OutlineTransparency = CurrentESPOutlineTransparency
				end
			end
			for _, obj in ipairs(survivors:GetChildren()) do applyESP(obj) end
			survivorConnection = survivors.ChildAdded:Connect(applyESP)
		else
			if survivorConnection then survivorConnection:Disconnect() survivorConnection = nil end
			for _, obj in ipairs(workspace:GetDescendants()) do if obj.Name == "ESPHighlight" then obj:Destroy() end end
		end
	end,
})

local killerConnection
local Forsaken_KillerESP = ForsakenTab:CreateToggle({
	Name = "Killer ESP",
	CurrentValue = false,
	Flag = "KillerESP_Flag",
	Callback = function(Value)
		if Value then
			local PlayersFolder = workspace:FindFirstChild("Players")
			local killers = PlayersFolder and PlayersFolder:FindFirstChild("Killers")
			if not killers then return end
			local function applyESP(model)
				if model:IsA("Model") and not model:FindFirstChild("KillerHighlight") then
					local highlight = Instance.new("Highlight", model)
					highlight.Name = "KillerHighlight"
					highlight.FillColor = CurrentKillerESPColor
					highlight.OutlineColor = CurrentKillerESPOutlineColor
					highlight.FillTransparency = CurrentESPFillTransparency
					highlight.OutlineTransparency = CurrentESPOutlineTransparency
				end
			end
			for _, obj in ipairs(killers:GetChildren()) do applyESP(obj) end
			killerConnection = killers.ChildAdded:Connect(applyESP)
		else
			if killerConnection then killerConnection:Disconnect() killerConnection = nil end
			for _, obj in ipairs(workspace:GetDescendants()) do if obj.Name == "KillerHighlight" then obj:Destroy() end end
		end
	end,
})

local generatorConnection
local Forsaken_GeneratorESP = ForsakenTab:CreateToggle({
	Name = "Generator ESP (Unfinished Generators)",
	CurrentValue = false,
	Flag = "GenESP_Flag",
	Callback = function(Value)
		local ActualMap = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")

		if Value then
			if not ActualMap then return end

			local function applyGenESP(obj)
				if obj.Name == "Generator" and obj:IsA("Model") then
					local progress = obj:FindFirstChild("Progress")

					-- Only apply if not finished
					if progress and progress.Value < 100 then
						if not obj:FindFirstChild("GenHighlight") then
							local highlight = Instance.new("Highlight", obj)
							highlight.Name = "GenHighlight"
							highlight.FillColor = CurrentGeneratorESPColor
							highlight.OutlineColor = CurrentGeneratorESPOutlineColor
							highlight.FillTransparency = CurrentESPFillTransparency
						end
					end

					-- Listen for the generator finishing to remove the highlight
					if progress then
						progress:GetPropertyChangedSignal("Value"):Connect(function()
							if progress.Value >= 100 then
								local h = obj:FindFirstChild("GenHighlight")
								if h then h:Destroy() end
							end
						end)
					end
				end
			end

			for _, obj in ipairs(ActualMap:GetChildren()) do applyGenESP(obj) end
			generatorConnection = ActualMap.ChildAdded:Connect(applyGenESP)
		else
			if generatorConnection then generatorConnection:Disconnect() end
			for _, obj in ipairs(workspace:GetDescendants()) do 
				if obj.Name == "GenHighlight" then obj:Destroy() end 
			end
		end
	end,
})

local itemConnection
local Forsaken_ItemESP = ForsakenTab:CreateToggle({
	Name = "Item ESP",
	CurrentValue = false,
	Flag = "ItemESP_Flag",
	Callback = function(Value)
		local ActualMap = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")

		if Value then
			if not ActualMap then return end

			local function applyItemESP(obj)
				-- Checking for Tools or specific Item names in the map
				if obj:IsA("Tool") and not obj:FindFirstChild("ItemHighlight") then
					-- Optional: Filter for specific items if needed
					local highlight = Instance.new("Highlight", obj)
					highlight.Name = "ItemHighlight"
					highlight.FillColor = CurrentItemESPColor
					highlight.OutlineColor = CurrentItemESPOutlineColor
					highlight.FillTransparency = CurrentESPFillTransparency
				end
			end

			for _, obj in ipairs(ActualMap:GetChildren()) do applyItemESP(obj) end
			itemConnection = ActualMap.ChildAdded:Connect(applyItemESP)
		else
			if itemConnection then itemConnection:Disconnect() end
			for _, obj in ipairs(workspace:GetDescendants()) do 
				if obj.Name == "ItemHighlight" then obj:Destroy() end 
			end
		end
	end,
})

-- Movement/Speed Section
local Forsaken_SpeedExploitsLabel = ForsakenTab:CreateParagraph({Title = "Movement Exploits", Content = ""})
local CurrentSpeedMultiplierValue = 1.35
local Forsaken_SpeedMarkiplier = ForsakenTab:CreateSlider({
	Name = "Set Speed Multiplier Value",
	Range = {1, 2},
	Increment = 0.05,
	CurrentValue = 1.35,
	Flag = "SpeedSlider",
	Callback = function(Value) CurrentSpeedMultiplierValue = Value end,
})

local Forsaken_CreateSpeedMarkiplier = ForsakenTab:CreateButton({
	Name = "Create Speed Multiplier",
	Callback = function()
		local Character = game.Players.LocalPlayer.Character
		if not Character then return end
		local Folder = Character:FindFirstChild("SpeedMultipliers") or Instance.new("Folder", Character)
		Folder.Name = "SpeedMultipliers"
		local val = Instance.new("NumberValue", Folder)
		val.Name = "Speedhacks"
		val.Value = CurrentSpeedMultiplierValue
	end,
})

local antiSlowdownConnection
local antiSlowdownLoop

local Forsaken_AntislowDown = ForsakenTab:CreateToggle({
	Name = "Anti-Slowdown",
	CurrentValue = false,
	Flag = "AntiSlowdown_Flag",
	Callback = function(Value)
		if Value then
			local function fixSpeeds(character)
				local folder = character:FindFirstChild("SpeedMultipliers")
				if folder then
					for _, val in ipairs(folder:GetChildren()) do
						if val:IsA("NumberValue") and val.Value < 1 then
							val.Value = 1
						end
					end

					-- Listen for new multipliers being added (e.g., getting hit or traps)
					antiSlowdownConnection = folder.ChildAdded:Connect(function(child)
						if child:IsA("NumberValue") then
							-- Small delay to ensure the game has set the initial low value
							task.wait()
							if child.Value < 1 then
								child.Value = 1
							end
							-- Also watch if the value changes later
							child:GetPropertyChangedSignal("Value"):Connect(function()
								if child.Value < 1 then child.Value = 1 end
							end)
						end
					end)
				end
			end

			-- Run immediately and start a loop as a fallback
			local char = game.Players.LocalPlayer.Character
			if char then fixSpeeds(char) end

			antiSlowdownLoop = task.spawn(function()
				while true do
					local character = game.Players.LocalPlayer.Character
					if character then
						local folder = character:FindFirstChild("SpeedMultipliers")
						if folder then
							for _, v in ipairs(folder:GetChildren()) do
								if v:IsA("NumberValue") and v.Value < 1 then
									v.Value = 1
								end
							end
						end
					end
					task.wait(0.5) -- Check every half second
				end
			end)
		else
			-- Cleanup
			if antiSlowdownConnection then antiSlowdownConnection:Disconnect() end
			if antiSlowdownLoop then task.cancel(antiSlowdownLoop) end
		end
	end,
})

local Forsaken_InfStamina = ForsakenTab:CreateToggle({
	Name = "Infinite Stamina",
	CurrentValue = false,
	Flag = "AntiSlowdown_Flag",
	Callback = function(Value)
		local RS = game:GetService("ReplicatedStorage")
		local SYS = RS:FindFirstChild("Systems")
		local CHR = SYS:FindFirstChild("Character")
		local GME = CHR:FindFirstChild("Game")
		local SPR = require(GME:FindFirstChild("Sprinting"))
		
		if Value then
			SPR.StaminaLossDisabled = true
		else
			SPR.StaminaLossDisabled = false
		end
	end,
})

-- Generator Fix Section
local Forsaken_GeneratorExploitsLabel = ForsakenTab:CreateParagraph({Title = "Generator Exploits", Content = ""})
local Forsaken_TPUnfinished = ForsakenTab:CreateButton({
	Name = "TP to Unfinished Generator",
	Callback = function()
		local char = game.Players.LocalPlayer.Character
		local map = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")

		if char and map then
			for _, obj in ipairs(map:GetChildren()) do
				if obj.Name == "Generator" then
					local progress = obj:FindFirstChild("Progress")
					if progress and progress.Value < 100 then
						char:PivotTo(obj.Positions.Center.CFrame) -- TPs slightly above to avoid stuck
						return -- Stop at the first unfinished one found
					end
				end
			end
			Rayfield:Notify({Title = "Notice", Content = "All generators are finished!", Duration = 3})
		end
	end,
})

local instantfixdb = false
local instantfixcd = 2.5

Forsaken_InstantFixGenerator = ForsakenTab:CreateButton({
	Name = "Fire RE (Finishes Puzzle)",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character
		local ActualMap = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")
		if character and ActualMap and not instantfixdb then
			instantfixdb = true
			for _, obj in ipairs(ActualMap:GetChildren()) do
				if obj.Name == "Generator" and (character.PrimaryPart.Position - obj:GetPivot().Position).Magnitude <= 10 then
					local re = obj:FindFirstChild("RE", true)
					if re then re:FireServer() end
					Forsaken_InstantFixGenerator:Set("Cooldown (2s)")
					task.delay(1, function()
						Forsaken_InstantFixGenerator:Set("Cooldown (1s)")
					end)
					task.delay(instantfixcd + 0.1, function()
						Forsaken_InstantFixGenerator:Set("Fire RE (Finishes Puzzle)")
						instantfixdb = false
					end)
				end
			end
		end
	end,
})

-- Jump Power Section
local Forsaken_OtherLabel = ForsakenTab:CreateParagraph({Title = "Other Exploits", Content = ""})
local CurrentJumpPower = 50
local Forsaken_JumpPowerSlider = ForsakenTab:CreateSlider({
	Name = "Jump Power Value",
	Range = {0, 150},
	Increment = 1,
	CurrentValue = 50,
	Flag = "JumpPowerSlider",
	Callback = function(Value) CurrentJumpPower = Value end,
})

local Forsaken_SetJumpPower = ForsakenTab:CreateButton({
	Name = "Set Jump Power",
	Callback = function()
		local character = game.Players.LocalPlayer.Character
		if character and character:FindFirstChild("Humanoid") then
			character.Humanoid.JumpPower = CurrentJumpPower
			character.Humanoid.UseJumpPower = true
		end
	end,
})


-- Animation Section
local Forsaken_OtherLabel = ForsakenTab:CreateParagraph({Title = "Animation Exploits", Content = ""})
local animHeartbeat
local animInput
local activeTracks = {}

local StalkerAnimations = ForsakenTab:CreateToggle({
	Name = "Stalker Animations",
	CurrentValue = false,
	Flag = "StalkerAnims",
	Callback = function(Value)
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")

		if Value then
			-- << SETUP ANIMATIONS >> --
			local ANIM_IDS = {
				Idle = "rbxassetid://135419935358802",
				Walk = "rbxassetid://95469909855529",
				Run = "rbxassetid://109671225388655",
				M1_1 = "rbxassetid://79710880505841",
				M1_2 = "rbxassetid://70589254357640",
				Blocked = "rbxassetid://80277760801310"
			}

			for name, id in pairs(ANIM_IDS) do
				local anim = Instance.new("Animation")
				anim.AnimationId = id
				activeTracks[name] = humanoid:LoadAnimation(anim)
			end

			local canAttack = true
			local nextIsAltAttack = false

			-- << MOVEMENT LOGIC >> --
			animHeartbeat = game:GetService("RunService").Heartbeat:Connect(function()
				local isMoving = humanoid.MoveDirection.Magnitude > 0
				local isRunning = humanoid.WalkSpeed > 20

				if isMoving then
					if isRunning then
						if not activeTracks.Run.IsPlaying then
							activeTracks.Idle:Stop(); activeTracks.Walk:Stop(); activeTracks.Run:Play()
						end
					else
						if not activeTracks.Walk.IsPlaying then
							activeTracks.Idle:Stop(); activeTracks.Run:Stop(); activeTracks.Walk:Play()
						end
					end
				else
					if not activeTracks.Idle.IsPlaying then
						activeTracks.Walk:Stop(); activeTracks.Run:Stop(); activeTracks.Idle:Play()
					end
				end
			end)

			-- << ATTACK LOGIC >> --
			animInput = game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
				if not gp and input.UserInputType == Enum.UserInputType.MouseButton1 and canAttack then
					canAttack = false
					local track = nextIsAltAttack and activeTracks.M1_2 or activeTracks.M1_1
					track:Play()
					nextIsAltAttack = not nextIsAltAttack
					task.wait(2) -- Cooldown
					canAttack = true
				end
			end)
		else
			-- << CLEANUP >> --
			if animHeartbeat then animHeartbeat:Disconnect() end
			if animInput then animInput:Disconnect() end

			-- Stop all tracks and clear table
			for _, track in pairs(activeTracks) do
				track:Stop()
			end
			activeTracks = {}
		end
	end,
})

local SlasherAnimations = ForsakenTab:CreateToggle({
	Name = "Slasher Animations",
	CurrentValue = false,
	Flag = "SlasherAnims",
	Callback = function(Value)
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")

		if Value then
			-- << SETUP ANIMATIONS >> --
			local ANIM_IDS = {
				Idle = "rbxassetid://116050994905421",
				Walk = "rbxassetid://93622022596108",
				Run = "rbxassetid://93054787145505",
				M1_1 = "rbxassetid://126830014841198",
				M1_2 = "rbxassetid://126830014841198",
				Blocked = "rbxassetid://80277760801310"
			}

			for name, id in pairs(ANIM_IDS) do
				local anim = Instance.new("Animation")
				anim.AnimationId = id
				activeTracks[name] = humanoid:LoadAnimation(anim)
			end

			local canAttack = true
			local nextIsAltAttack = false

			-- << MOVEMENT LOGIC >> --
			animHeartbeat = game:GetService("RunService").Heartbeat:Connect(function()
				local isMoving = humanoid.MoveDirection.Magnitude > 0
				local isRunning = humanoid.WalkSpeed > 20

				if isMoving then
					if isRunning then
						if not activeTracks.Run.IsPlaying then
							activeTracks.Idle:Stop(); activeTracks.Walk:Stop(); activeTracks.Run:Play()
						end
					else
						if not activeTracks.Walk.IsPlaying then
							activeTracks.Idle:Stop(); activeTracks.Run:Stop(); activeTracks.Walk:Play()
						end
					end
				else
					if not activeTracks.Idle.IsPlaying then
						activeTracks.Walk:Stop(); activeTracks.Run:Stop(); activeTracks.Idle:Play()
					end
				end
			end)

			-- << ATTACK LOGIC >> --
			animInput = game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
				if not gp and input.UserInputType == Enum.UserInputType.MouseButton1 and canAttack then
					canAttack = false
					local track = nextIsAltAttack and activeTracks.M1_2 or activeTracks.M1_1
					track:Play()
					nextIsAltAttack = not nextIsAltAttack
					task.wait(2) -- Cooldown
					canAttack = true
				end
			end)
		else
			-- << CLEANUP >> --
			if animHeartbeat then animHeartbeat:Disconnect() end
			if animInput then animInput:Disconnect() end

			-- Stop all tracks and clear table
			for _, track in pairs(activeTracks) do
				track:Stop()
			end
			activeTracks = {}
		end
	end,
})

local CoolkiddAnimations = ForsakenTab:CreateToggle({
	Name = "c00lkidd Animations",
	CurrentValue = false,
	Flag = "CoolkiddAnims",
	Callback = function(Value)
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")

		if Value then
			-- << SETUP ANIMATIONS >> --
			local ANIM_IDS = {
				Idle = "rbxassetid://18885903667",
				Walk = "rbxassetid://18885906143",
				Run = "rbxassetid://96571077893813",
				M1_1 = "rbxassetid://18885909645",
				M1_2 = "rbxassetid://18885909645",
				Blocked = "rbxassetid://80277760801310"
			}

			for name, id in pairs(ANIM_IDS) do
				local anim = Instance.new("Animation")
				anim.AnimationId = id
				activeTracks[name] = humanoid:LoadAnimation(anim)
			end

			local canAttack = true
			local nextIsAltAttack = false

			-- << MOVEMENT LOGIC >> --
			animHeartbeat = game:GetService("RunService").Heartbeat:Connect(function()
				local isMoving = humanoid.MoveDirection.Magnitude > 0
				local isRunning = humanoid.WalkSpeed > 20

				if isMoving then
					if isRunning then
						if not activeTracks.Run.IsPlaying then
							activeTracks.Idle:Stop(); activeTracks.Walk:Stop(); activeTracks.Run:Play()
						end
					else
						if not activeTracks.Walk.IsPlaying then
							activeTracks.Idle:Stop(); activeTracks.Run:Stop(); activeTracks.Walk:Play()
						end
					end
				else
					if not activeTracks.Idle.IsPlaying then
						activeTracks.Walk:Stop(); activeTracks.Run:Stop(); activeTracks.Idle:Play()
					end
				end
			end)

			-- << ATTACK LOGIC >> --
			animInput = game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
				if not gp and input.UserInputType == Enum.UserInputType.MouseButton1 and canAttack then
					canAttack = false
					local track = nextIsAltAttack and activeTracks.M1_2 or activeTracks.M1_1
					track:Play()
					nextIsAltAttack = not nextIsAltAttack
					task.wait(2) -- Cooldown
					canAttack = true
				end
			end)
		else
			-- << CLEANUP >> --
			if animHeartbeat then animHeartbeat:Disconnect() end
			if animInput then animInput:Disconnect() end

			-- Stop all tracks and clear table
			for _, track in pairs(activeTracks) do
				track:Stop()
			end
			activeTracks = {}
		end
	end,
})

local JohnDoeAnimations = ForsakenTab:CreateToggle({
	Name = "John Doe Animations",
	CurrentValue = false,
	Flag = "JohnToeAnims",
	Callback = function(Value)
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")

		if Value then
			-- << SETUP ANIMATIONS >> --
			local ANIM_IDS = {
				Idle = "rbxassetid://105880087711722",
				Walk = "rbxassetid://81193817424328",
				Run = "rbxassetid://132653655520682",
				M1_1 = "rbxassetid://105458270463374",
				M1_2 = "rbxassetid://105458270463374",
				Blocked = "rbxassetid://80277760801310"
			}

			for name, id in pairs(ANIM_IDS) do
				local anim = Instance.new("Animation")
				anim.AnimationId = id
				activeTracks[name] = humanoid:LoadAnimation(anim)
			end

			local canAttack = true
			local nextIsAltAttack = false

			-- << MOVEMENT LOGIC >> --
			animHeartbeat = game:GetService("RunService").Heartbeat:Connect(function()
				local isMoving = humanoid.MoveDirection.Magnitude > 0
				local isRunning = humanoid.WalkSpeed > 20

				if isMoving then
					if isRunning then
						if not activeTracks.Run.IsPlaying then
							activeTracks.Idle:Stop(); activeTracks.Walk:Stop(); activeTracks.Run:Play()
						end
					else
						if not activeTracks.Walk.IsPlaying then
							activeTracks.Idle:Stop(); activeTracks.Run:Stop(); activeTracks.Walk:Play()
						end
					end
				else
					if not activeTracks.Idle.IsPlaying then
						activeTracks.Walk:Stop(); activeTracks.Run:Stop(); activeTracks.Idle:Play()
					end
				end
			end)

			-- << ATTACK LOGIC >> --
			animInput = game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
				if not gp and input.UserInputType == Enum.UserInputType.MouseButton1 and canAttack then
					canAttack = false
					local track = nextIsAltAttack and activeTracks.M1_2 or activeTracks.M1_1
					track:Play()
					nextIsAltAttack = not nextIsAltAttack
					task.wait(2) -- Cooldown
					canAttack = true
				end
			end)
		else
			-- << CLEANUP >> --
			if animHeartbeat then animHeartbeat:Disconnect() end
			if animInput then animInput:Disconnect() end

			-- Stop all tracks and clear table
			for _, track in pairs(activeTracks) do
				track:Stop()
			end
			activeTracks = {}
		end
	end,
})

local NoliAnimations = ForsakenTab:CreateToggle({
	Name = "Noli Animations",
	CurrentValue = false,
	Flag = "NolaAnims",
	Callback = function(Value)
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")

		if Value then
			-- << SETUP ANIMATIONS >> --
			local ANIM_IDS = {
				Idle = "rbxassetid://83465205704188",
				Walk = "rbxassetid://109700476007435",
				Run = "rbxassetid://117451341682452",
				M1_1 = "rbxassetid://106538427162796",
				M1_2 = "rbxassetid://106538427162796",
				Blocked = "rbxassetid://80277760801310"
			}

			for name, id in pairs(ANIM_IDS) do
				local anim = Instance.new("Animation")
				anim.AnimationId = id
				activeTracks[name] = humanoid:LoadAnimation(anim)
			end

			local canAttack = true
			local nextIsAltAttack = false

			-- << MOVEMENT LOGIC >> --
			animHeartbeat = game:GetService("RunService").Heartbeat:Connect(function()
				local isMoving = humanoid.MoveDirection.Magnitude > 0
				local isRunning = humanoid.WalkSpeed > 20

				if isMoving then
					if isRunning then
						if not activeTracks.Run.IsPlaying then
							activeTracks.Idle:Stop(); activeTracks.Walk:Stop(); activeTracks.Run:Play()
						end
					else
						if not activeTracks.Walk.IsPlaying then
							activeTracks.Idle:Stop(); activeTracks.Run:Stop(); activeTracks.Walk:Play()
						end
					end
				else
					if not activeTracks.Idle.IsPlaying then
						activeTracks.Walk:Stop(); activeTracks.Run:Stop(); activeTracks.Idle:Play()
					end
				end
			end)

			-- << ATTACK LOGIC >> --
			animInput = game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
				if not gp and input.UserInputType == Enum.UserInputType.MouseButton1 and canAttack then
					canAttack = false
					local track = nextIsAltAttack and activeTracks.M1_2 or activeTracks.M1_1
					track:Play()
					nextIsAltAttack = not nextIsAltAttack
					task.wait(2) -- Cooldown
					canAttack = true
				end
			end)
		else
			-- << CLEANUP >> --
			if animHeartbeat then animHeartbeat:Disconnect() end
			if animInput then animInput:Disconnect() end

			-- Stop all tracks and clear table
			for _, track in pairs(activeTracks) do
				track:Stop()
			end
			activeTracks = {}
		end
	end,
})

local OneEXAnimations = ForsakenTab:CreateToggle({
	Name = "1x1x1x1 Animations",
	CurrentValue = false,
	Flag = "1eggsAnims",
	Callback = function(Value)
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")

		if Value then
			-- << SETUP ANIMATIONS >> --
			local ANIM_IDS = {
				Idle = "rbxassetid://138754221537146",
				Walk = "rbxassetid://109130982296927",
				Run = "rbxassetid://106485518413331",
				M1_1 = "rbxassetid://83829782357897",
				M1_2 = "rbxassetid://83829782357897",
				Blocked = "rbxassetid://80277760801310"
			}

			for name, id in pairs(ANIM_IDS) do
				local anim = Instance.new("Animation")
				anim.AnimationId = id
				activeTracks[name] = humanoid:LoadAnimation(anim)
			end

			local canAttack = true
			local nextIsAltAttack = false

			-- << MOVEMENT LOGIC >> --
			animHeartbeat = game:GetService("RunService").Heartbeat:Connect(function()
				local isMoving = humanoid.MoveDirection.Magnitude > 0
				local isRunning = humanoid.WalkSpeed > 20

				if isMoving then
					if isRunning then
						if not activeTracks.Run.IsPlaying then
							activeTracks.Idle:Stop(); activeTracks.Walk:Stop(); activeTracks.Run:Play()
						end
					else
						if not activeTracks.Walk.IsPlaying then
							activeTracks.Idle:Stop(); activeTracks.Run:Stop(); activeTracks.Walk:Play()
						end
					end
				else
					if not activeTracks.Idle.IsPlaying then
						activeTracks.Walk:Stop(); activeTracks.Run:Stop(); activeTracks.Idle:Play()
					end
				end
			end)

			-- << ATTACK LOGIC >> --
			animInput = game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
				if not gp and input.UserInputType == Enum.UserInputType.MouseButton1 and canAttack then
					canAttack = false
					local track = nextIsAltAttack and activeTracks.M1_2 or activeTracks.M1_1
					track:Play()
					nextIsAltAttack = not nextIsAltAttack
					task.wait(2) -- Cooldown
					canAttack = true
				end
			end)
		else
			-- << CLEANUP >> --
			if animHeartbeat then animHeartbeat:Disconnect() end
			if animInput then animInput:Disconnect() end

			-- Stop all tracks and clear table
			for _, track in pairs(activeTracks) do
				track:Stop()
			end
			activeTracks = {}
		end
	end,
})

Rayfield:LoadConfiguration()
