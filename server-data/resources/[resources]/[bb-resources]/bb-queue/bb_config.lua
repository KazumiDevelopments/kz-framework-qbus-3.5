Config = {}

local Prefix = "[ConnectRP] "
Config.DiscordServerID = 632994117986549760
Config.DiscordBotToken = "NzMxMDM5NDEzNTA0ODM1NjQ3.XwgPgg.O144uVibwvoyQWTRljF6JXK3rPM"
Config.ApiLink = "http://realistic-life.co.il/api/queue.php/"
Config.ApiKey = "5166546A576E5A7234743777217A25432A462D4A614E645267556B5870"
Config.maxServerSlots = 128
Config.Roles = {
	Staff = {
		roleID = "783793138128650304",
		points = 30,
		name = "Tester"
	},

	DonatorTier1 = {
		roleID = "659813603297460224",
		points = 15,
		name = "Donator Tier 1"
	},

	DonatorTier2 = {
		roleID = "736217458247204914",
		points = 25,
		name = "Donator Tier 2"
	},

	DonatorTier3 = {
		roleID = "750589069301645363",
		points = 35,
		name = "Donator Tier 3"
	},

	Developer = {
		roleID = "695010964369702988",
		points = 200,
		name = "Developer"
	},
	
	Prio = {
		roleID = "731892243203489842",
		points = 9,
		name = "Priority Member"
	},

	Managment = {
		roleID = "660296331172118606",
		points = 49,
		name = "Community Managment"
	},

	Livestreaming = {
		roleID = "727218894640775279",
		points = 5,
		name = "LiveStreaming"
	}
}

Config.Colors = {
	"accent",
	"good",
	"warning",
	"attention",
}

Config.Verifiying = Prefix .. "Please wait, Downloading content from RealisticLifeRP database."
Config.VerifiyingLauncher = Prefix .. "Please wait, Verifiying you entered through the launcher."
Config.VerifiyingDiscord = Prefix .. "Please wait, Verifiying your Discord ID."
Config.VerifiyingSteam = Prefix .. "Please wait, Verifiying your Steam."
Config.VerifiyingQueue = Prefix .. "Please wait, Adding you to the queue."

Config.NotWhitelisted = Prefix .. "Sorry, You are not whitelisted for our server."
Config.NoDiscord = Prefix .. "Please make sure your Discord is open."
Config.NoSteam = Prefix .. "Please make sure your Steam is open."
Config.NoLauncher = Prefix .. "The server can only be accessed through its launcher."
Config.Blacklisted = Prefix .. "You're blacklisted from the server, fuck off please."

Config.Welcome = Prefix .. "Welcome Sir."
Config.Error = Prefix .. "Error, Please try again later."