debugX = true

-- << Supported Game Checks >> --

local SupportedGameIDs = {
	"6331902150", -- Forsaken
	"7344582593", -- Die of Death
	"7676963071" -- Infernity
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
	Name = "Rayfield Example Window",
	Icon = 0,
	LoadingTitle = "Artful's Multi-Purpose Exploit",
	LoadingSubtitle = "by Artful",
	Theme = "Default",

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false,

	ConfigurationSaving = {
		Enabled = false,
		FolderName = nil,
		FileName = "nobody else gonna find dis"
	},

	Discord = {
		Enabled = false,
		Invite = "noinvitelink",
		RememberJoins = true
	},

	KeySystem = false,
	KeySettings = {
		Title = "Untitled",
		Subtitle = "Key System",
		Note = "No method of obtaining the key is provided",
		FileName = "Key",
		SaveKey = true,
		GrabKeyFromSite = false,
		Key = {"Hello"}
	}
})

-- << Info Tab >> --
local InfoTab = Window:CreateTab("Info", 4483362458)

local Info_Message = InfoTab:CreateParagraph({
	Title = "Hello!",
	Content = "Thanks for using this!",
})

local Info_Version = InfoTab:CreateParagraph({
	Title = "ARTFUL'S MULTI-PURPOSE EXPLOIT",
	Content = "Version 1.0.0 (December 22 2025)",
})

local Info_SupportedGames = InfoTab:CreateParagraph({
	Title = "SUPPORTED GAMES",
	Content = "Forsaken\nDie Of Death\nInfernity",
})

local Info_GameID

if isSupported then
	Info_GameID = InfoTab:CreateParagraph({
		Title = "Game ID: " ..game.GameId.. "(Supported)",
		Content = "",
	})
end

-- << Keybinds Tab >> --
local KeybindsTab = Window:CreateTab("Keybinds", 4483362458)

local Keybinds_Divider1 = KeybindsTab:CreateDivider()

local Keybinds_ForsakenLabel = KeybindsTab:CreateParagraph({
	Title = "FORSAKEN",
	Content = "",
})

local Keybinds_Forsaken_Observant = KeybindsTab:CreateKeybind({
	Name = "Toggle Generator Teleport",
	CurrentKeybind = "M",
	HoldToInteract = false,
	Flag = "ObservantKeybind",
	Callback = function(Keybind)
		local Map = workspace:FindFirstChild("Map")
		if not Map then return end
		local Ingame = Map:FindFirstChild("Ingame")
		if not Ingame then return end
		local ActualMap = Ingame:FindFirstChild("Map")
		if not ActualMap then return end
		for _, obj in ipairs(ActualMap:GetDescendants()) do
			if obj:IsA("Model") and obj.Name == "Generator" then
				local generatormain = obj:FindFirstChild("Main") or obj.PrimaryPart

				if generatormain then
					local billboard = Instance.new("BillboardGui")
					billboard.Name = "GenTP"
					billboard.Parent = generatormain
					billboard.Size = UDim2.new(0, 50, 0, 50)
					billboard.AlwaysOnTop = true

					local tpbutton = Instance.new("TextButton")
					tpbutton.Parent = billboard
					tpbutton.Size = UDim2.new(1, 0, 1, 0)
					tpbutton.Text = "Teleport"

					tpbutton.MouseButton1Click:Connect(function()
						local player = game.Players.LocalPlayer
						if player.Character then
							player.Character:PivotTo(obj:GetPivot())
						end
						billboard:Destroy()
					end)
				end
			end
		end
	end
})

local Keybinds_Divider2 = KeybindsTab:CreateDivider()

local Keybinds_DoDLabel = KeybindsTab:CreateParagraph({
	Title = "DIE OF DEATH",
	Content = "",
})

local Keybinds_DoDLabel_Unfinished = KeybindsTab:CreateParagraph({
	Title = "The Rest of this Section is HIGHLY unfinished!",
	Content = "Come back later!",
})

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
	Name = "Generator ESP",
	CurrentValue = false,
	Flag = "GeneratorESP_Flag",
	Callback = function(Value)
		local ActualMap = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")
		if Value then
			if not ActualMap then return end
			local function applyGenESP(obj)
				if obj.Name == "Generator" and obj:IsA("Model") and not obj:FindFirstChild("GenHighlight") then
					local highlight = Instance.new("Highlight", obj)
					highlight.Name = "GenHighlight"
					highlight.FillColor = CurrentGeneratorESPColor
					highlight.OutlineColor = CurrentGeneratorESPOutlineColor
					highlight.FillTransparency = CurrentESPFillTransparency
					highlight.OutlineTransparency = CurrentESPOutlineTransparency
				end
			end
			for _, obj in ipairs(ActualMap:GetChildren()) do applyGenESP(obj) end
			generatorConnection = ActualMap.ChildAdded:Connect(applyGenESP)
		else
			if generatorConnection then generatorConnection:Disconnect() end
			for _, obj in ipairs(workspace:GetDescendants()) do if obj.Name == "GenHighlight" then obj:Destroy() end end
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
				if obj:IsA("Tool") and not obj:FindFirstChild("ItemHighlight") then
					local highlight = Instance.new("Highlight", obj)
					highlight.Name = "ItemHighlight"
					highlight.FillColor = CurrentItemESPColor
					highlight.OutlineColor = CurrentItemESPOutlineColor
					highlight.FillTransparency = CurrentESPFillTransparency
					highlight.OutlineTransparency = CurrentESPOutlineTransparency
				end
			end
			for _, obj in ipairs(ActualMap:GetChildren()) do applyItemESP(obj) end
			itemConnection = ActualMap.ChildAdded:Connect(applyItemESP)
		else
			if itemConnection then itemConnection:Disconnect() end
			for _, obj in ipairs(workspace:GetDescendants()) do if obj.Name == "ItemHighlight" then obj:Destroy() end end
		end
	end,
})

-- Movement/Speed Section
local Forsaken_SpeedExploitsLabel = ForsakenTab:CreateParagraph({Title = "Speed Exploits", Content = ""})
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

-- Generator Fix Section
local Forsaken_GeneratorExploitsLabel = ForsakenTab:CreateParagraph({Title = "Generator Exploits", Content = ""})
local Forsaken_InstantFixGenerator = ForsakenTab:CreateButton({
	Name = "Fire RE (Finishes Puzzle)",
	Callback = function()
		local player = game.Players.LocalPlayer
		local character = player.Character
		local ActualMap = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")
		if character and ActualMap then
			for _, obj in ipairs(ActualMap:GetChildren()) do
				if obj.Name == "Generator" and (character.PrimaryPart.Position - obj:GetPivot().Position).Magnitude <= 10 then
					local re = obj:FindFirstChild("RE", true)
					if re then re:FireServer() end
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

Rayfield:LoadConfiguration()
