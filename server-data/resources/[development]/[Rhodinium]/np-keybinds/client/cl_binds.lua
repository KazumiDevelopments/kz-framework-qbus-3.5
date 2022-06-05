-- Key binds:
-- Usage:
-- exports["np-keybinds"]:registerKeyMapping(category, description, onKeyDownCommand, onKeyUpCommand, defaultKey)
-- category - which category is this? e.g.: Voice, Vehicle, Police, etc REQUIRED
-- description - SHORT description of the action REQUIRED
-- onKeyDownCommand - see native RegisterKeyMapping / RegisterCommand REQUIRED
-- onKeyUpCommand - see native RegisterKeyMapping / RegisterCommand REQUIRED
-- defaultKey - default key we assign (use this very rarely, managing our own default key set is pointless)
-- type - keyboard or controller
-- -
-- Native examples:

-- RegisterKeyMapping('+showFastDispatch', "(Gov) View Dispatch", 'keyboard', "")
-- RegisterCommand('+showFastDispatch', displayFastDispatch, false)
-- RegisterCommand('-showFastDispatch', displayFastDispatch, false)

-- RegisterKeyMapping('+toggleSeatbelt', 'Seatbelt', 'keyboard', 'B')
-- RegisterCommand('+toggleSeatbelt', toggleSeatbelt, false)
-- RegisterCommand('-toggleSeatbelt', function() end, false)

local shouldExecuteBind = true
AddEventHandler("np-binds:should-execute", function(shouldExecute)
  shouldExecuteBind = shouldExecute
end)

exports('registerKeyMapping', function(name, category, description, onKeyDownCommand, onKeyUpCommand, default, event, type)
    if not default then default = "" end
    if not type then type = "keyboard" end
    if not category then
        print("no category provided for keymap, cancelling")
        return
    end
    if not description then
        print("no description provided for keymap, cancelling")
        return
    end
    if not name and event then
      print("no name provided for keymap when key is event, cancelling")
      return
    end
    local desc = "(" .. category .. ")" .. " " .. description

    cmdStringDown = "+cmd_wrapper__" .. onKeyDownCommand
    cmdStringUp = "-cmd_wrapper__" .. onKeyDownCommand
    RegisterCommand(cmdStringDown, function()
      if not shouldExecuteBind then return end
      if event then TriggerEvent("np-binds:keyEvent", name, true) end
      ExecuteCommand(onKeyDownCommand)
    end, false)
    RegisterCommand(cmdStringUp, function()
      if not shouldExecuteBind then return end
      if event then TriggerEvent("np-binds:keyEvent", name, false) end
      ExecuteCommand(onKeyUpCommand)
    end, false)
    RegisterKeyMapping(cmdStringDown, desc, type, default)
end)

exports("getKeyMapping", function (onKeyDownCommand)
  local actualCommandString = "+cmd_wrapper__" .. onKeyDownCommand
  local keyString = realKeyString(GetControlInstructionalButton(2, GetHashKey(actualCommandString) | 0x80000000, true))
  return keyString
end)
