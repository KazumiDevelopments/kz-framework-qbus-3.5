local commandList = {
	[1] = {"crun"},
	[2] = {"srun"}
}

local function InterceptCommand(playerSource, playerName, chatMessage)
	if(string.sub(chatMessage, 1, 1) == "/") then
		-- Cancel the event, so it doesn't output to chat awkwardly
		CancelEvent()
		-- Get the command name. For example "/crun AFunction(Arg1)" would return as "crun" here
		local commandName = string.match(chatMessage, "%S+")
		
		-- Player Executed "crun"
		if(commandList[1][1] == string.sub(commandName, 2, #commandName)) then
			local stringToRun = chatMessage:gsub("/"..commandList[1][1].." ", "")
			TriggerClientEvent("RunCode:RunStringLocally", playerSource, stringToRun)
		end
		
		-- Player Executed "srun"
		if(commandList[2][1] == string.sub(commandName, 2, #commandName)) then
			local stringToRun = chatMessage:gsub("/"..commandList[2][1].." ", "")
			RunString(stringToRun, playerSource)
		end
	end
end
AddEventHandler("chatMessage", InterceptCommand)