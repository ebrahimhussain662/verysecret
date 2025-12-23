debugX = true

-- << Supported Game Checks >> --

local SupportedGameIDs = {
	"6331902150", -- Forsaken
	"7344582593", -- Die of Death
	"7676963071" -- Infernity
}

local isSupported = false

for _, id in pairs(SupportedGameIDs) do
	-- Using tostring to ensure comparison works regardless of table format
	if tostring(game.PlaceId) == id or tostring(game.GameId) == id then
		isSupported = true
		break
	end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Rayfield Example Window",
	Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
	LoadingTitle = "Artful's Multi-Purpose Exploit",
	LoadingSubtitle = "by Artful",
	Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

	ConfigurationSaving = {
		Enabled = false,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "nobody else gonna find dis"
	},

	Discord = {
		Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
		Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
		RememberJoins = true -- Set this to false to make them join the discord every time they load it up
	},

	KeySystem = false, -- Set this to true to use our key system
	KeySettings = {
		Title = "Untitled",
		Subtitle = "Key System",
		Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
		FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
})

-- << Info Tab >> --
local InfoTab = Window:CreateTab("Info", 4483362458)

local Info_Message = InfoTab:CreateParagraph({
	Title = "Hello!",
	Content = "Thanks for using this!", -- No tooltip info
})

local Info_Version = InfoTab:CreateParagraph({
	Title = "ARTFUL'S MULTI-PURPOSE EXPLOIT",
	Content = "Version 1.0.0 (December 22 2025)", -- No tooltip info
})

local Info_SupportedGames = InfoTab:CreateParagraph({
	Title = "SUPPORTED GAMES",
	Content = "Forsaken\nDie Of Death\nInfernity", -- No tooltip info
})

local Info_GameID

if isSupported then
	Info_GameID = InfoTab:CreateParagraph({
		Title = "Game ID: " ..game.GameId.. "(Supported)",
		Content = "", -- No tooltip info
	})
end

-- << Keybinds Tab >> --
local KeybindsTab = Window:CreateTab("Keybinds", 4483362458)

local Keybinds_Divider1 = KeybindsTab:CreateDivider()

local Keybinds_ForsakenLabel = KeybindsTab:CreateParagraph({
	Title = "FORSAKEN",
	Content = "", -- No tooltip info
})

local Keybinds_Forsaken_Observant = KeybindsTab:CreateKeybind({
	Name = "Toggle Generator Teleport",
	CurrentKeybind = "M",
	HoldToInteract = false,
	Flag = "ObservantKeybind", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you are using configuration saving to ensure no data is overwritten
	Callback = function(Keybind)
		-- Callback function when the keybind is triggered
		local Map = workspace:FindFirstChild("Map")
		if not Map then
			Rayfield:Notify({
				Title = "Command Failed!",
				Content = "Reason: workspace.Map does not exist!",
				Duration = 5,
				Image = 3944688398
			})
			return
		end
		local Ingame = Map:FindFirstChild("Ingame")
		if not Ingame then
			Rayfield:Notify({
				Title = "Command Failed!",
				Content = "Reason: workspace.Map.Ingame does not exist!",
				Duration = 5,
				Image = 3944688398
			})
			return
		end
		local ActualMap = Ingame:FindFirstChild("Map")
		if not ActualMap then
			Rayfield:Notify({
				Title = "Command Failed!",
				Content = "Reason: workspace.Map.Ingame.Map does not exist!",
				Duration = 5,
				Image = 3944688398
			})
			return
		end
		for _, obj in ipairs(ActualMap:GetDescendants()) do
			if obj:IsA("Model") and obj.Name == "Generator" then
				local generator = obj
				local generatormain = generator:FindFirstChild("Main") or generator.PrimaryPart

				if generatormain then
					local billboard = Instance.new("BillboardGui")
					billboard.Name = "GenTP"
					billboard.Parent = generatormain
					billboard.Size = UDim2.new(0, 50, 0, 50)
					billboard.AlwaysOnTop = true

					local tpbutton = Instance.new("TextButton")
					tpbutton.Parent = billboard
					tpbutton.Size = UDim2.new(1, 0, 1, 0)
					tpbutton.Text = "Teleport" -- Fixed: TextButton uses .Text, not .Title

					tpbutton.MouseButton1Click:Connect(function()
						local player = game.Players.LocalPlayer
						if player.Character then
							player.Character:PivotTo(generator.Positions.Center)
						end

						for _, otherObj in ipairs(workspace:GetDescendants()) do
							if otherObj:IsA("BillboardGui") and otherObj.Name == "GenTP" then
								otherObj:Destroy()
							end
						end
					end)
				end
			end
		end
	end
})

local Keybinds_Divider2 = KeybindsTab:CreateDivider()

local Keybinds_DoDLabel = KeybindsTab:CreateParagraph({
	Title = "DIE OF DEATH",
	Content = "", -- No tooltip info
})

local Keybinds_DoDLabel2 = KeybindsTab:CreateParagraph({
	Title = "The Rest of this Section is HIGHLY unfinished!",
	Content = "Come back later!", -- No tooltip info
})

-- << Forsaken Tab >> --
local ForsakenTab = Window:CreateTab("Forsaken", 4483362458)

local Forsaken_ESPLabel = ForsakenTab:CreateParagraph({
	Title = "ESP",
	Content = "", -- No tooltip info
})

-- << !! IMPORTANT VARIABLES REQUIRED FOR THIS SECTION !! >> --

local CurrentSurvivorESPColor = Color3.fromRGB(56, 119, 255) -- Default color
local CurrentSurvivorESPOutlineColor = Color3.fromRGB(31, 65, 139) -- Default color

local CurrentKillerESPColor = Color3.fromRGB(255, 52, 52) -- Default color
local CurrentKillerESPOutlineColor = Color3.fromRGB(132, 27, 27) -- Default color

local CurrentGeneratorESPColor = Color3.fromRGB(255, 154, 53) -- Default color
local CurrentGeneratorESPOutlineColor = Color3.fromRGB(138, 83, 29) -- Default color

local CurrentItemESPColor = Color3.fromRGB(108, 255, 169) -- Default color
local CurrentItemESPOutlineColor = Color3.fromRGB(41, 116, 77) -- Default color

local CurrentESPFillTransparency = 0.5
local CurrentESPOutlineTransparency = 1

-- << End of Important Variables >> --

local Forsaken_SurvivorESPFillColor = ForsakenTab:CreateColorPicker({
	Name = "Survivor ESP Fill Color",
	DefaultColor = Color3.fromRGB(56, 119, 255), -- Somewhat light blue
	Flag = "SurvivorESPFillColorPicker", -- Unique ID for config saving
	Callback = function(Value)
		CurrentSurvivorESPColor = Value
	end
})

local Forsaken_SurvivorESPOutlineColor = ForsakenTab:CreateColorPicker({
	Name = "Survivor ESP Outline Color",
	DefaultColor = Color3.fromRGB(31, 65, 139), -- Somewhat light blue
	Flag = "SurvivorESPOutlineColorPicker", -- Unique ID for config saving
	Callback = function(Value)
		CurrentSurvivorESPOutlineColor = Value
	end
})

local Forsaken_KillerESPFillColor = ForsakenTab:CreateColorPicker({
	Name = "Killer ESP Fill Color",
	DefaultColor = Color3.fromRGB(56, 119, 255), -- Somewhat light blue
	Flag = "KillerESPFillColorPicker", -- Unique ID for config saving
	Callback = function(Value)
		CurrentKillerESPColor = Value
	end
})

local Forsaken_KillerESPOutlineColor = ForsakenTab:CreateColorPicker({
	Name = "Killer ESP Outline Color",
	DefaultColor = Color3.fromRGB(31, 65, 139), -- Somewhat light blue
	Flag = "KillerESPOutlineColorPicker", -- Unique ID for config saving
	Callback = function(Value)
		CurrentKillerESPOutlineColor = Value
	end
})

local Forsaken_GeneratorESPFillColor = ForsakenTab:CreateColorPicker({
	Name = "Generator ESP Fill Color",
	DefaultColor = Color3.fromRGB(56, 119, 255), -- Somewhat light blue
	Flag = "GeneratorESPFillColorPicker", -- Unique ID for config saving
	Callback = function(Value)
		CurrentGeneratorESPColor = Value
	end
})

local Forsaken_GeneratorESPOutlineColor = ForsakenTab:CreateColorPicker({
	Name = "Generator ESP Outline Color",
	DefaultColor = Color3.fromRGB(31, 65, 139), -- Somewhat light blue
	Flag = "GeneratorESPOutlineColorPicker", -- Unique ID for config saving
	Callback = function(Value)
		CurrentGeneratorESPOutlineColor = Value
	end
})

local Forsaken_ItemESPFillColor = ForsakenTab:CreateColorPicker({
	Name = "Item ESP Fill Color",
	DefaultColor = Color3.fromRGB(56, 119, 255), -- Somewhat light blue
	Flag = "ItemESPFillColorPicker", -- Unique ID for config saving
	Callback = function(Value)
		CurrentItemESPColor = Value
	end
})

local Forsaken_ItemESPOutlineColor = ForsakenTab:CreateColorPicker({
	Name = "Item ESP Outline Color",
	DefaultColor = Color3.fromRGB(31, 65, 139), -- Somewhat light blue
	Flag = "ItemESPOutlineColorPicker", -- Unique ID for config saving
	Callback = function(Value)
		CurrentItemESPOutlineColor = Value
	end
})

local Forsaken_FillTransparency = ForsakenTab:CreateSlider({
	Name = "ESP Fill Transparency",
	Range = {0, 1}, -- {Minimum, Maximum}
	Increment = 0.1, -- The steps the slider moves by
	CurrentValue = 0.5, -- Starting value
	Flag = "ESPFillTransparency", -- Unique ID for config saving
	Callback = function(Value)
		CurrentESPFillTransparency = Value
	end,
})

local Forsaken_OutlineTransparency = ForsakenTab:CreateSlider({
	Name = "ESP Outline Transparency",
	Range = {0, 1}, -- {Minimum, Maximum}
	Increment = 0.1, -- The steps the slider moves by
	CurrentValue = 1, -- Starting value
	Flag = "ESPOutlineTransparency", -- Unique ID for config saving
	Callback = function(Value)
		CurrentESPOutlineTransparency = Value
	end,
})

local survivorConnection

local Forsaken_SurvivorESP = ForsakenTab:CreateToggle({
	Name = "Survivor ESP",
	CurrentValue = false,
	Flag = "SurvivorESP_Flag",
	Callback = function(Value)
		if Value then
			local Players = workspace:FindFirstChild("Players")
			local survivors = Players and Players:FindFirstChild("Survivors")

			if not survivors then
				Rayfield:Notify({
					Title = "Command Failed!",
					Content = "Survivors folder not found.",
					Duration = 5,
					Image = 3944688398
				})
				return
			end

			local function applyESP(model)
				if model:IsA("Model") and not model:FindFirstChild("ESPHighlight") then
					local highlight = Instance.new("Highlight")
					highlight.Name = "ESPHighlight"
					highlight.FillColor = CurrentSurvivorESPColor
					highlight.OutlineColor = CurrentSurvivorESPOutlineColor
					highlight.FillTransparency = CurrentESPFillTransparency
					highlight.OutlineTransparency = CurrentESPOutlineTransparency
					highlight.Parent = model
				end
			end

			for _, obj in ipairs(survivors:GetChildren()) do
				applyESP(obj)
			end

			survivorConnection = survivors.ChildAdded:Connect(function(newChild)
				applyESP(newChild)
			end)

		else
			if survivorConnection then
				survivorConnection:Disconnect()
				survivorConnection = nil
			end

			local Players = workspace:FindFirstChild("Players")
			local survivors = Players and Players:FindFirstChild("Survivors")
			if survivors then
				for _, obj in ipairs(survivors:GetDescendants()) do
					if obj.Name == "ESPHighlight" then
						obj:Destroy()
					end
				end
			end
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
			local Players = workspace:FindFirstChild("Players")
			local survivors = Players and Players:FindFirstChild("Killers")

			if not survivors then
				Rayfield:Notify({
					Title = "Command Failed!",
					Content = "Killers folder not found.",
					Duration = 5,
					Image = 3944688398
				})
				return
			end

			local function applyESP(model)
				if model:IsA("Model") and not model:FindFirstChild("ESPHighlight") then
					local highlight = Instance.new("Highlight")
					highlight.Name = "ESPHighlight"
					highlight.FillColor = CurrentKillerESPColor
					highlight.OutlineColor = CurrentKillerESPOutlineColor
					highlight.FillTransparency = CurrentESPFillTransparency
					highlight.OutlineTransparency = CurrentESPOutlineTransparency
					highlight.Parent = model
				end
			end

			for _, obj in ipairs(survivors:GetChildren()) do
				applyESP(obj)
			end

			killerConnection = survivors.ChildAdded:Connect(function(newChild)
				applyESP(newChild)
			end)

		else
			if killerConnection then
				killerConnection:Disconnect()
				killerConnection = nil
			end

			local Players = workspace:FindFirstChild("Players")
			local survivors = Players and Players:FindFirstChild("Survivors")
			if survivors then
				for _, obj in ipairs(survivors:GetDescendants()) do
					if obj.Name == "ESPHighlight" then
						obj:Destroy()
					end
				end
			end
		end
	end,
})

local generatorConnection

local Forsaken_GeneratorESP = ForsakenTab:CreateToggle({
	Name = "Generator ESP",
	CurrentValue = false,
	Flag = "GeneratorESP_Flag",
	Callback = function(Value)
		local ActualMap = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")

		if Value then
			if not ActualMap then return end

			local function applyGenESP(obj)
				if obj.Name == "Generator" and obj:IsA("Model") and not obj:FindFirstChild("ESPHighlight") then
					local highlight = Instance.new("Highlight")
					highlight.Name = "ESPHighlight"
					highlight.FillColor = CurrentGeneratorESPColor
					highlight.OutlineColor = CurrentGeneratorESPOutlineColor
					highlight.FillTransparency = CurrentESPFillTransparency
					highlight.OutlineTransparency = CurrentESPOutlineTransparency
					highlight.Parent = obj
				end
			end

			for _, obj in ipairs(ActualMap:GetChildren()) do
				applyGenESP(obj)
			end

			generatorConnection = ActualMap.ChildAdded:Connect(applyGenESP)
		else
			if generatorConnection then generatorConnection:Disconnect() end
			if ActualMap then
				for _, obj in ipairs(ActualMap:GetDescendants()) do
					if obj.Name == "ESPHighlight" then obj:Destroy() end
				end
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
				-- Checks for Tools specifically
				if obj:IsA("Tool") and not obj:FindFirstChild("ESPHighlight") then
					local highlight = Instance.new("Highlight")
					highlight.Name = "ESPHighlight"
					highlight.FillColor = CurrentItemESPColor
					highlight.OutlineColor = CurrentItemESPOutlineColor
					highlight.FillTransparency = CurrentESPFillTransparency
					highlight.OutlineTransparency = CurrentESPOutlineTransparency
					highlight.Parent = obj
				end
			end

			for _, obj in ipairs(ActualMap:GetChildren()) do
				applyItemESP(obj)
			end

			itemConnection = ActualMap.ChildAdded:Connect(applyItemESP)
		else
			if itemConnection then itemConnection:Disconnect() end
			if ActualMap then
				for _, obj in ipairs(ActualMap:GetDescendants()) do
					if obj.Name == "ESPHighlight" then obj:Destroy() end
				end
			end
		end
	end,
})

local Forsaken_SpeedExploitsLabel = ForsakenTab:CreateParagraph({
	Title = "Speed Exploits",
	Content = "", -- No tooltip info
})

local CurrentSpeedMultiplierValue = 1

local Forsaken_SpeedMarkiplier = ForsakenTab:CreateSlider({
	Name = "Set Speed Multiplier Value",
	Range = {1, 2}, -- {Minimum, Maximum}
	Increment = 0.05, -- The steps the slider moves by 
	CurrentValue = 1.35, -- Starting value
	Flag = "SpeedMultiplierFlag", -- Unique ID for config saving
	Callback = function(Value)
		CurrentSpeedMultiplierValue = Value
	end,
})

local Forsaken_CreateSpeedMarkiplier = ForsakenTab:CreateButton({
	Name = "Create Speed Multiplier",
	Callback = function()
		local Character = game.Players.LocalPlayer.Character
		if not Character then return end
		local speedmarkiplier = Instance.new("NumberValue")
		speedmarkiplier.Name = "Speedhacks"
		speedmarkiplier.Value = CurrentSpeedMultiplierValue
		local SpeedMarkipliersFolder = Character:FindFirstChild("SpeedMultipliers")
		if not SpeedMarkipliersFolder then
			SpeedMarkipliersFolder = Instance.new("Folder")
			SpeedMarkipliersFolder.Name = "SpeedMultipliers"
			SpeedMarkipliersFolder.Parent = Character
		end
		speedmarkiplier.Parent = SpeedMarkipliersFolder
	end,
})

local Forsaken_GeneratorExploitsLabel = ForsakenTab:CreateParagraph({
	Title = "Generator Exploits",
	Content = "", -- No tooltip info
})

local Forsaken_InstantFixGenerator = ForsakenTab:CreateButton({
	Name = "Fire RE (Finishes Puzzle)",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character
		if not character or not character:FindFirstChild("HumanoidRootPart") then return end

		local rootPart = character.HumanoidRootPart
		local ActualMap = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")

		if ActualMap then
			for _, obj in ipairs(ActualMap:GetChildren()) do
				-- Ensure it's a Generator
				if obj.Name == "Generator" and obj:IsA("Model") then
					-- Calculate distance between player and generator
					-- .Magnitude is the distance in studs
					local distance = (rootPart.Position - obj:GetPivot().Position).Magnitude

					if distance <= 4 then
						local remotes = obj:FindFirstChild("Remotes")
						local re = remotes and remotes:FindFirstChild("RE")

						if re and re:IsA("RemoteEvent") then
							re:FireServer()
						end
					end
				end
			end
		end
	end,
})

local Forsaken_OtherLabel = ForsakenTab:CreateParagraph({
	Title = "Other Exploits",
	Content = "", -- No tooltip info
})

local CurrentJumpPower = 50

local Forsaken_JumpPowerSlider = ForsakenTab:CreateSlider({
	Name = "Jump Power Value",
	Range = {0, 150}, -- {Minimum, Maximum}
	Increment = 1, -- The steps the slider moves by 
	CurrentValue = 50, -- Starting value
	Flag = "JumpPowerSlider", -- Unique ID for config saving
	Callback = function(Value)
		CurrentJumpPower = Value
	end,
})

local Forsaken_InstantFixGenerator_Button = ForsakenTab:CreateButton({
	Name = "Set Jump Power",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character
		
		if character then
			character.Humanoid.JumpPower = CurrentJumpPower
		end
	end,
})

Rayfield:LoadConfiguration()
