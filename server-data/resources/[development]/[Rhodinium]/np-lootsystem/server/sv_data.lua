LootData = {}

function GetLootTables(pLootData)
    local tables = {}

    for tableName,data in pairs(pLootData) do
        if data then
            tables[tableName] = LootTable:new(tableName,data)
        end
    end

    return tables
end

function GetLootTableProbability(pTableName)
    local loot = LootTables[pTableName]

    local probability = {}

    if loot then
        for itemName,_ in pairs(LootData[pTableName]) do
            local result = loot:getLootProbability(itemName)
            probability[itemName] = result
        end
    end

    return probability
end