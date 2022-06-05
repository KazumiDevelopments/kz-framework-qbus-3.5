# fivem-tgiann-skillbar

**exports**
```
exports["tgiann-skillbar"]:taskBar(time)
```
**Example Usage**
```
local finished = exports["tgiann-skillbar"]:taskBar(30000)
if not finished then
    isActive = false
else
    local finished2 = exports["tgiann-skillbar"]:taskBar(2000)
    if not finished2 then
        isActive = false
    else
        local finished3 = exports["tgiann-skillbar"]:taskBar(1000)
        if not finished3 then
            isActive = false
        else
            local finished4 = exports["tgiann-skillbar"]:taskBar(4200)
            if not finished4 then
                isActive = false
            else
                local finished5 = exports["tgiann-skillbar"]:taskBar(1400)
                if not finished5 then
                    isActive = false
                else
                    ClearPedSecondaryTask(playerPed)
                    isActive = false
                end
            end
        end
    end
end
```
