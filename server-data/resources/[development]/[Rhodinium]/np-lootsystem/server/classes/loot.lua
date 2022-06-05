LootTable = {}

function LootTable:new(pName,pData)
    local localdata = pData
    local rTable = {}
    rTable.getLootProbability = function(pItemName)
        local chance = math.random( localdata[pItemName].min , localdata[pItemName].max )
        return chance
    end

    rTable.draw = function()
        local chance = math.random(1,#localdata)
        return localdata[chance].itemid
    end

    rTable.obtain = function(self,pItem,rate, donknow, state)
        local lootkey 
        for k,v in pairs(localdata) do
            if v.itemid == pItem then
                lootkey = k
            end
        end
        local getitem = math.random( localdata[lootkey].min,localdata[lootkey].max )
        return true, getitem
    end

    return rTable
end