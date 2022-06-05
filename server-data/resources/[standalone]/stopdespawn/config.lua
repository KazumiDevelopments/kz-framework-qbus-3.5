intervals = { -- Unit: seconds
	['save'] = 15, -- How often the vehicles' position should be saved. The save schedule is only useful after game crashes, or disconnects while in vehicle.
	['check'] = 15 -- How often should it check for despawned vehicles.
}

-- Make sure to keep a short save interval if you disable any of these two options.
saveOnEnter = true -- Whether the vehicle should be saved right when it's entered. Useful for quick enter and exit.
saveOnExit = true -- Whether the vehicle should be saved once after a player leaves a vehicle.

debugMode = false -- Toggle debug mode (client & server console spam).