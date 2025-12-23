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
	Name = "Artful's Multi-Purpose Exploit",
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
		
		if not ActualMap then return end

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
					tpbutton.Text = "Teleport" -- Fixed from .Title
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
local CurrentKillerESPColor = Color3.fromRGB(255, 52, 52)
local CurrentGeneratorESPColor = Color3.fromRGB(255, 154, 53)
local CurrentItemESPColor = Color3.fromRGB(108, 255, 169)
local CurrentESPFillTransparency = 0.5
local CurrentESPOutlineTransparency = 1

-- Color Pickers
ForsakenTab:CreateColorPicker({Name = "Survivor ESP Color", DefaultColor = CurrentSurvivorESPColor, Callback = function(V) CurrentSurvivorESPColor = V end})
ForsakenTab:CreateColorPicker({Name = "Killer ESP Color", DefaultColor = CurrentKillerESPColor, Callback = function(V) CurrentKillerESPColor = V end})
ForsakenTab:CreateColorPicker({Name = "Generator ESP Color", DefaultColor = CurrentGeneratorESPColor, Callback = function(V) CurrentGeneratorESPColor = V end})
ForsakenTab:CreateColorPicker({Name = "Item ESP Color", DefaultColor = CurrentItemESPColor, Callback = function(V) CurrentItemESPColor = V end})

-- Sliders (Cleaned invisible spaces)
ForsakenTab:CreateSlider({
	Name = "ESP Fill Transparency",
	Range = {0, 1},
	Increment = 0.1,
	CurrentValue = 0.5,
	Callback = function(V) CurrentESPFillTransparency = V end
})

-- << ESP Toggles >> --
local function cleanESP(name)
	for _, v in pairs(workspace:GetDescendants()) do
		if v.Name == name then v:Destroy() end
	end
end

local survivorConn
ForsakenTab:CreateToggle({
	Name = "Survivor ESP",
	CurrentValue = false,
	Callback = function(Value)
		if Value then
			local folder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
			if not folder then return end
			local function apply(m)
				if m:IsA("Model") then
					local h = Instance.new("Highlight", m)
					h.Name = "SurvivorHighlight"
					h.FillColor = CurrentSurvivorESPColor
					h.FillTransparency = CurrentESPFillTransparency
				end
			end
			for _, m in pairs(folder:GetChildren()) do apply(m) end
			survivorConn = folder.ChildAdded:Connect(apply)
		else
			if survivorConn then survivorConn:Disconnect() end
			cleanESP("SurvivorHighlight")
		end
	end
})

local killerConn
ForsakenTab:CreateToggle({
	Name = "Killer ESP",
	CurrentValue = false,
	Callback = function(Value)
		if Value then
			local folder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
			if not folder then return end
			local function apply(m)
				if m:IsA("Model") then
					local h = Instance.new("Highlight", m)
					h.Name = "KillerHighlight"
					h.FillColor = CurrentKillerESPColor
					h.FillTransparency = CurrentESPFillTransparency
				end
			end
			for _, m in pairs(folder:GetChildren()) do apply(m) end
			killerConn = folder.ChildAdded:Connect(apply)
		else
			if killerConn then killerConn:Disconnect() end
			cleanESP("KillerHighlight")
		end
	end
})

local genConn
ForsakenTab:CreateToggle({
	Name = "Generator ESP",
	CurrentValue = false,
	Callback = function(Value)
		local ActualMap = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")
		if Value then
			if not ActualMap then return end
			local function apply(m)
				if m.Name == "Generator" then
					local h = Instance.new("Highlight", m)
					h.Name = "GenHighlight"
					h.FillColor = CurrentGeneratorESPColor
					h.FillTransparency = CurrentESPFillTransparency
				end
			end
			for _, m in pairs(ActualMap:GetChildren()) do apply(m) end
			genConn = ActualMap.ChildAdded:Connect(apply)
		else
			if genConn then genConn:Disconnect() end
			cleanESP("GenHighlight")
		end
	end
})

-- << Movement & Misc >> --
local CurrentSpeedValue = 1.35
ForsakenTab:CreateSlider({
	Name = "Speed Multiplier",
	Range = {1, 2},
	Increment = 0.05,
	CurrentValue = 1.35,
	Callback = function(V) CurrentSpeedValue = V end
})

ForsakenTab:CreateButton({
	Name = "Apply Speed",
	Callback = function()
		local char = game.Players.LocalPlayer.Character
		if char then
			local folder = char:FindFirstChild("SpeedMultipliers") or Instance.new("Folder", char)
			folder.Name = "SpeedMultipliers"
			local val = Instance.new("NumberValue", folder)
			val.Name = "Speedhacks"
			val.Value = CurrentSpeedValue
		end
	end
})

local CurrentJump = 50
ForsakenTab:CreateSlider({
	Name = "Jump Power",
	Range = {0, 150},
	Increment = 1,
	CurrentValue = 50,
	Callback = function(V) CurrentJump = V end
})

ForsakenTab:CreateButton({
	Name = "Set Jump Power",
	Callback = function()
		local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
		if hum then hum.JumpPower = CurrentJump hum.UseJumpPower = true end
	end
})

Rayfield:LoadConfiguration()
