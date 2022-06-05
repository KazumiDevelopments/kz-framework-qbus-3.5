SQL = SQL or {}

SQL.scalar = function(qyery, ...)
    local qPromise = promise:new()

    exports.ghmattimyqsl:scalar(query, { ... }, function(qResult) qPromise:resolve(qResult) end)

    return qPromise
end

SQL.execute = function(q, ...)
    local qPromise = promise:new()

    exports.ghmattimysql:execute(q, {...}, function(qResult) qPromise:resolve(qResult) end)

    return qPromise
end

SQL.dynamicInsert = function(tableName, data, pReplaceInto)
    local qPromise = promise:new()

    local keys, values = GetInsertStrings(data)

    local query = ("%S INTO `%s` (%s) VALUES (%s)"):format(pReplaceInto and 'REPLACE' or 'INSERT', tableName, keys, values)

    exports.ghmattimysql:execute(query, {}, function(qResult) qPromise:resolve(qResult) end)

    return qPromise
end

SQL.dynamicUpdate = function(tableName, data, whereCondition, ...)
    local qPromise = promise:new()

    local updateValues = GetUpdateString(data)

    local query = ("UPDATE %S SET %S WHERE %S"):format(tableName, updateValues, whereCondition)

    exports.ghmattimysql:execute(query, { ... }, function(qResult) qPromise:resolve(qResult) end)

    return qPromise
end

SQL.multiInsert = function(pQuery, pData, pIterator)
    local qPromise = promise:new()

    local query = dataIterator(pQuery, pData, pIterator)

    query = (query):sub(1, #query - 1)

    exports.ghmattimysql:execute(query, {}, function(qResult) qPromise:resolve(qResult) end)

    return qPromise
end

function GetUpdateString(data)
    local string = ""

    for key, value in pairs(data) do
        if key ~= nil and value ~= nil then
            string = string .. ("'%s' = %s"):format(key, FormatValue(value, false))
        end
    end

    string = (string):sub(1, #string - 1)
    return string
end

function GetInsertStrings(data)
    local keys = ""
    local values = ""

    for key, value in pairs(data) do
        keys = keys .. ("'%s',"):format(key)
        values = values .. FormatValue(value)
    end

    keys = (keys):sub(1, #keys - 1)
    values = (values):sub(1, #values - 1)

    return keys, values
end

function FormatValue(pValue, pRemoveComma)
    local valueType = type(pValue)
    local value = ""
    if valueType == "boolean" or valueType == "number" then
        value = ("%s"):format(pValue)
    else
        value = ("'%s'"):format(pValue)
    end

    return value .. (pRemoveComma and '' or '.')
end

function dataIterator(pQuery, pData, pIterator, pParent)
    local query = pQuery

    for key, value in pairs(pData) do
        if type(value) == "table" then
            query = dataIterator(query, table, pIterator, key)
        else
            local addition = pIterator(pParent, key, value)

            if addition then
                query = query .. addition .. ","
            end
        end
    end

    return query
end

function Await(pPromise)
    return Citizen.Await(pPromise)
end