debugX = true

-- << Supported Game Checks >> --
local SupportedGameIDs = {
	"6331902150", -- Forsaken
	"7344582593", -- Die of Death
	"7676963071"  -- Infernity
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
	Name = "Artful's Multi-Purpose Hub",
	Icon = 0,
	LoadingTitle = "Artful's Multi-Purpose Exploit",
	LoadingSubtitle = "by Artful",
	Theme = "Default",
	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false,
	ConfigurationSaving = {
		Enabled = false,
		FolderName = nil,
		FileName = "artful_config"
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

InfoTab:CreateParagraph({Title = "Hello!", Content = "Thanks for using this!"})
InfoTab:CreateParagraph({Title = "VERSION", Content = "1.0.0 (December 22 2025)"})
InfoTab:CreateParagraph({Title = "SUPPORTED GAMES", Content = "Forsaken\nDie Of Death\nInfernity"})

if isSupported then
	InfoTab:CreateParagraph({Title = "Game ID: " ..game.GameId.. " (Supported)", Content = ""})
end

-- << Keybinds Tab >> --
local KeybindsTab = Window:CreateTab("Keybinds", 4483362458)
KeybindsTab:CreateDivider()
KeybindsTab:CreateParagraph({Title = "FORSAKEN", Content = ""})

KeybindsTab:CreateKeybind({
	Name = "Toggle Generator Teleport",
	CurrentKeybind = "M",
	HoldToInteract = false,
	Flag = "ObservantKeybind",
	Callback = function()
		local Map = workspace:FindFirstChild("Map")
		local Ingame = Map and Map:FindFirstChild("Ingame")
		local ActualMap = Ingame and Ingame:FindFirstChild("Map")
		
		if not ActualMap then
			Rayfield:Notify({Title = "Error", Content = "Map not loaded!", Duration = 5})
			return
		end

		for _, obj in ipairs(ActualMap:GetDescendants()) do
			if obj:IsA("Model") and obj.Name == "Generator" then
				local generatormain = obj:FindFirstChild("Main") or obj.PrimaryPart
				if generatormain and not generatormain:FindFirstChild("GenTP") then
					local billboard = Instance.new("BillboardGui", generatormain)
					billboard.Name = "GenTP"
					billboard.Size = UDim2.new(0, 50, 0, 50)
					billboard.AlwaysOnTop = true

					local tpbutton = Instance.new("TextButton", billboard)
					tpbutton.Size = UDim2.new(1, 0, 1, 0)
					tpbutton.Text = "TP"
					tpbutton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

					tpbutton.MouseButton1Click:Connect(function()
						if game.Players.LocalPlayer.Character then
							game.Players.LocalPlayer.Character:PivotTo(obj:GetPivot())
						end
						billboard:Destroy()
					end)
				end
			end
		end
	end
})

-- << Forsaken Tab >> --
local ForsakenTab = Window:CreateTab("Forsaken", 4483362458)

local CurrentSurvivorESPColor = Color3.fromRGB(56, 119, 255)
local CurrentESPFillTransparency = 0.5

ForsakenTab:CreateSlider({
	Name = "ESP Fill Transparency",
	Range = {0, 1},
	Increment = 0.1,
	CurrentValue = 0.5,
	Flag = "ESPFillTrans",
	Callback = function(Value) CurrentESPFillTransparency = Value end
})

local CurrentSpeedMultiplierValue = 1.35
ForsakenTab:CreateSlider({
	Name = "Speed Multiplier Value",
	Range = {1, 2},
	Increment = 0.05,
	CurrentValue = 1.35,
	Flag = "SpeedVal",
	Callback = function(Value) CurrentSpeedMultiplierValue = Value end
})

ForsakenTab:CreateButton({
	Name = "Apply Speed Multiplier",
	Callback = function()
		local Char = game.Players.LocalPlayer.Character
		if Char then
			local Folder = Char:FindFirstChild("SpeedMultipliers") or Instance.new("Folder", Char)
			Folder.Name = "SpeedMultipliers"
			local val = Instance.new("NumberValue", Folder)
			val.Name = "Speedhacks"
			val.Value = CurrentSpeedMultiplierValue
		end
	end
})

local CurrentJumpPower = 50
ForsakenTab:CreateSlider({
	Name = "Jump Power",
	Range = {0, 150},
	Increment = 1,
	CurrentValue = 50,
	Flag = "JumpSlider",
	Callback = function(Value) CurrentJumpPower = Value end
})

ForsakenTab:CreateButton({
	Name = "Set Jump Power",
	Callback = function()
		local char = game.Players.LocalPlayer.Character
		if char and char:FindFirstChild("Humanoid") then
			char.Humanoid.JumpPower = CurrentJumpPower
			char.Humanoid.UseJumpPower = true
		end
	end
})

Rayfield:LoadConfiguration()
