-- here we go

debugX = true

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Artful's Multi-Purpose Exploit",
	Icon = 0,
	LoadingTitle = "Artful's Multi-Purpose Exploit",
	LoadingSubtitle = "by Artful",
	ShowText = "Artful???",
	Theme = "AmberGlow",

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false,

	ConfigurationSaving = {
		Enabled = false,
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
		Note = "Key is \"artful\"",
		FileName = "ARTFUL-S-MULTI-PURPOSE-EXPLOIT-KEY",
		SaveKey = true,
		GrabKeyFromSite = false,
		Key = {"artful"}
	}
})

-- << Select game >>
-- << Tabs >>
local GameUsing = Window:CreateTab("???", "square-m") -- Title, Image
-- << Tab Functions >>
local function AddGameButton(Title, GameName)
	local Button = GameUsing:CreateButton({
		Name = tostring("Title"),
		Callback = function()
			if GameName == "Forsaken" then
				loadstring(game:HTTPGet("https://raw.githubusercontent.com/ebrahimhussain662/verysecret/refs/heads/main/artfulsaken%20and%20artful%20of%20death/forsaken.luau"))()
				Rayfield:Destroy()
			elseif GameName == "DoD" then
				loadstring(game:HTTPGet("https://raw.githubusercontent.com/ebrahimhussain662/verysecret/refs/heads/main/artfulsaken%20and%20artful%20of%20death/die%20of%20death.luau"))()
				Rayfield:Destroy()
			end
		end,
	})
end
-- << GameUsing Tab >>
local MainSection = GameUsing:CreateSection("Select your game")
AddGameButton("Forsaken", "Forsaken")
AddGameButton("Die of Death", "DoD")
