RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
 

local callID = nil  

AddEventHandler("onResourceStart", function(resource)
	if (resource ~= GetCurrentResourceName()) then return end;
    TriggerEvent('deleteAllYP')
end);

RegisterNetEvent('deleteAllYP') 
AddEventHandler('deleteAllYP', function()
    exports.ghmattimysql:execute('DELETE FROM phone_yp', {}, function(result) end)
end)

--[[ Twitter Stuff ]]
RegisterNetEvent('GetTweets')
AddEventHandler('GetTweets', function(onePlayer)
    local src = source
    exports.ghmattimysql:execute("SELECT * FROM (SELECT * FROM `phone_tweets` ORDER BY `time` DESC LIMIT 50) sub ORDER BY `time` ASC", {}, function(foundTweets)
        if onePlayer then
            TriggerClientEvent('Client:UpdateTweets', src, foundTweets)
        else
            TriggerClientEvent('Client:UpdateTweets', src, foundTweets)
        end
    end) 
end)

RegisterNetEvent('Tweet')
AddEventHandler('Tweet', function(handle, data)
    local handle = handle
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    exports.ghmattimysql:execute('INSERT INTO phone_tweets (citizenid, handle, message) VALUES (@citizenid, @handle, @message)', {
        ['@citizenid'] = Player.PlayerData.citizenid,
        ['@handle'] = handle,
        ['@message'] = data
    }, function(result)
        TriggerClientEvent('Client:UpdateTweet', -1, data, handle)
        TriggerEvent('GetTweets', true, src)
    end)
end)

RegisterNetEvent('Server:GetHandle')
AddEventHandler('Server:GetHandle', function()
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0)
    end
    
    local name = getIdentity(src)	
    fal = "@" .. name.firstname .. "_" .. name.lastname
    local handle = fal
    TriggerClientEvent('givemethehandle', src, handle)
end)

RegisterNetEvent('phone:addContact')
AddEventHandler('phone:addContact', function(name, number)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0)
    end

    number = "0" .. number -- Cuz QBUS is ass

    exports.ghmattimysql:execute('INSERT INTO phone_contacts (citizenid, name, number) VALUES (@citizenid, @name, @number)', {
        ['@citizenid'] = xPlayer.PlayerData.citizenid,
        ['@name'] = name,
        ['@number'] = number
    }, function(result)
        TriggerEvent('getContacts', true, src)
        TriggerClientEvent('refreshContacts', src)
    end)
end) 

RegisterNetEvent('getContacts')
AddEventHandler('getContacts', function()
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0)
    end
    
    exports.ghmattimysql:execute("SELECT * FROM phone_contacts WHERE citizenid = @citizenid", {["@citizenid"] = xPlayer.PlayerData.citizenid}, function(foundContacts)
        TriggerClientEvent('phone:loadContacts', src, foundContacts)
    end)
end)

RegisterNetEvent('deleteContact') 
AddEventHandler('deleteContact', function(name, number)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0)
    end

    exports.ghmattimysql:execute('DELETE FROM phone_contacts WHERE citizenid = @citizenid AND name = @name AND number = @number LIMIT 1', {
        ['@citizenid'] = xPlayer.PlayerData.citizenid,
        ['@name'] = name,
        ['@number'] = number
    }, function (result)
        TriggerClientEvent("phone:deleteContact", src, name, number)
    end)
end)

--[[ local contacts = {
    {citizenid = "QGQ76826", name = "Bonnie", number = "0533887859"},
    {citizenid = "IYQ85782", name = "JJ", number = "0584511778"},
    {citizenid = "EMD89976", name = "Fuego", number = "0513982114"},
    {citizenid = "JNI61467", name = "Jose Demon", number = "0568538924"},
    {citizenid = "NSA15506", name = "Jayse", number = "059593137"},
    {citizenid = "UZN64104", name = "Jase", number = "0595936137"},
    {citizenid = "TFW20723", name = "Jase", number = "0595936137"},
    {citizenid = "WNB08724", name = "Jase", number = "0595936137"},
    {citizenid = "GPA06957", name = "Jose Demon", number = "0568538924"},
    {citizenid = "YUS27906", name = "Jase Turner", number = "0595936137"},
    {citizenid = "NSA15506", name = "Jase Turner", number = "0595936137"},
    {citizenid = "YUS27906", name = "Logan James", number = "0547213630"},
    {citizenid = "FYI90420", name = "Tony Wyoming", number = "0514953030"},
    {citizenid = "XEV94469", name = "Jose Demon", number = "0568538924"},
    {citizenid = "WZR66725", name = "Noah", number = "0558322943"},
    {citizenid = "WGQ48193", name = "Deputy Hunter", number = "0527141993"},
    {citizenid = "UZN64104", name = "JohnD", number = "0595159626"},
    {citizenid = "GPA06957", name = "John Doe", number = "0595159626"},
    {citizenid = "BNQ33243", name = "Scooter", number = "0581097990"},
    {citizenid = "VLV29191", name = "Jose Demon", number = "0568538924"},
    {citizenid = "VLV29191", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "YUS27906", name = "Gucci Demon", number = "0549727154"},
    {citizenid = "ZYG35649", name = "Jase Turner", number = "0595936137"},
    {citizenid = "JNI61467", name = "Gucci", number = "0549727154"},
    {citizenid = "ZYG35649", name = "Arthur Morgan", number = "0529572750"},
    {citizenid = "IKL19404", name = "JJ Rush", number = "0521126008"},
    {citizenid = "TYU96802", name = "John Doe", number = "0595159626"},
    {citizenid = "YUS27906", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "EMD89976", name = "Jase Turner", number = "0595936137"},
    {citizenid = "GPA06957", name = "Arthur Morgan", number = "0529572750"},
    {citizenid = "GPA06957", name = "JJ Montana", number = "0584511778"},
    {citizenid = "AJA64738", name = "Jase Turner", number = "0595936137"},
    {citizenid = "GPA06957", name = "Jimmy Boombox", number = "0555592697"},
    {citizenid = "UZN64104", name = "Sarz", number = "0561141610"},
    {citizenid = "PPP04513", name = "Yolk", number = "0555195970"},
    {citizenid = "TXF27610", name = "Beshoy", number = "0571825789"},
    {citizenid = "GTH40371", name = "Logan", number = "0571825789"},
    {citizenid = "TXF27610", name = "Beshoy Hanna", number = "0595731527"},
    {citizenid = "NVU72596", name = "Beshoy Hanna", number = "0595731527"},
    {citizenid = "YBF46932", name = "Clarence Lirent", number = "0551256841"},
    {citizenid = "DQJ22077", name = "Beshoy Hanna", number = "0595731527"},
    {citizenid = "HQF66579", name = "Ajax Noire", number = "0571825789"},
    {citizenid = "QZW65600", name = "Anna Sarah", number = "0548604848"},
    {citizenid = "JNI61467", name = "Gun connect", number = "0529572750"},
    {citizenid = "GFR82236", name = "Jose Demon", number = "0568538924"},
    {citizenid = "FYI90420", name = "Johnny Chadson", number = "0563442402"},
    {citizenid = "NJB42345", name = "richard", number = "0521198882"},
    {citizenid = "GGB65955", name = "Joe", number = "0524947122"},
    {citizenid = "EVY33035", name = "Joe Kov", number = "0524947122"},
    {citizenid = "NJB42345", name = "tony", number = "0514953030"},
    {citizenid = "GPA06957", name = "Anna Sarah", number = "0548604848"},
    {citizenid = "TYU96802", name = "Dustin Kowalchuk", number = "0555195970"},
    {citizenid = "NJB42345", name = "Richard Dangle", number = "0568265148"},
    {citizenid = "FFS43297", name = "Sarz", number = "0561141610"},
    {citizenid = "ESL17467", name = "John Doe", number = "0595159626"},
    {citizenid = "LCS60659", name = "Kai Jackson", number = "0511238332"},
    {citizenid = "ESL17467", name = "Arthur Morgan", number = "0529572750"},
    {citizenid = "LCS60659", name = "Arthur Morgan", number = "0529572750"},
    {citizenid = "ZYG35649", name = "Kai Jackson", number = "0511238332"},
    {citizenid = "ESL17467", name = "johnson Chaderick", number = "0563442402"},
    {citizenid = "FYI90420", name = "Keenan Gray", number = "0512421343"},
    {citizenid = "ELT80718", name = "Richard Kiriko", number = "0521198882"},
    {citizenid = "NJB42345", name = "Kai Jackson", number = "0511238332"},
    {citizenid = "ESL17467", name = "Keenan Gray", number = "0512421343"},
    {citizenid = "YUS27906", name = "Beshoy Hanna", number = "0595731527"},
    {citizenid = "FYI90420", name = "John Daniels", number = "0515483983"},
    {citizenid = "FYI90420", name = "Kai Jackson", number = "0511238332"},
    {citizenid = "JNI61467", name = "Jase", number = "0595936137"},
    {citizenid = "ELT80718", name = "Kai Jackson", number = "0511238332"},
    {citizenid = "ELT80718", name = "johnson Chaderick", number = "0563442402"},
    {citizenid = "NJB42345", name = "Keenan Gray", number = "0512421343"},
    {citizenid = "WGQ48193", name = "Beshoy Hanna", number = "0595731527"},
    {citizenid = "WNB08724", name = "Clarance", number = "0551256481"},
    {citizenid = "EVY33035", name = "Frank", number = "0555195970"},
    {citizenid = "WHZ77977", name = "Forrest", number = "0581844878"},
    {citizenid = "EMP27751", name = "Mike Falcone", number = "0538121351"},
    {citizenid = "WHZ77977", name = "Mike Falcone", number = "0538121351"},
    {citizenid = "FEW42477", name = "Alex Hunter", number = "0565267763"},
    {citizenid = "FEW42477", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "DQJ22077", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "EMP27751", name = "Billy Badger", number = "0516156830"},
    {citizenid = "NVU72596", name = "Billy Badger", number = "0516156830"},
    {citizenid = "FEW42477", name = "Jesse Brooks", number = "0565333328"},
    {citizenid = "FEW42477", name = "Alex Hunter", number = "0565267763"},
    {citizenid = "BZW31045", name = "Mike Falcone", number = "0538121351"},
    {citizenid = "OAG13978", name = "Tyler Trumbone", number = "0526307344"},
    {citizenid = "OAG13978", name = "Tyler Trumbone", number = "0526307344"},
    {citizenid = "PPP04513", name = "Chris Ballaz", number = "0546961280"},
    {citizenid = "FEW42477", name = "Billy Badger", number = "0516156830"},
    {citizenid = "DQJ22077", name = "Mike Falcone", number = "0538121351"},
    {citizenid = "NVU72596", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "BZW31045", name = "Sean McG", number = "0515187071"},
    {citizenid = "ZXC31275", name = "Jhon Daniels", number = "0515483983"},
    {citizenid = "HAN40077", name = "Keenan Gray", number = "0512421343"},
    {citizenid = "ELT80718", name = "Rory Walker", number = "0516581436"},
    {citizenid = "ENB94536", name = "Christian Oliver", number = "0546961280"},
    {citizenid = "OAG13978", name = "Frost White", number = "0586097608"},
    {citizenid = "THT58370", name = "Mechanic", number = "0595731527"},
    {citizenid = "BKC23544", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "WGQ48193", name = "Click Click", number = "0513651052"},
    {citizenid = "JNI61467", name = "Beshoy", number = "0595731527"},
    {citizenid = "NJB42345", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "EMP27751", name = "johnson Chaderick", number = "0563442402"},
    {citizenid = "FDO16662", name = "johnson Chaderick", number = "0563442402"},
    {citizenid = "NJB42345", name = "Marty Woo", number = "0599859917"},
    {citizenid = "ENB94536", name = "johnson Chaderick", number = "0563442402"},
    {citizenid = "NJB42345", name = "Frost White", number = "0586097608"},
    {citizenid = "CJU70330", name = "Frost White", number = "0586097608"},
    {citizenid = "NJB42345", name = "Aaron Rezzo", number = "0531377955"},
    {citizenid = "ENB94536", name = "Aaron Rezzo", number = "0531377955"},
    {citizenid = "WNB08724", name = "T Bands", number = "0526307344"},
    {citizenid = "GQH91992", name = "Eliot Kipalog", number = "0581307729"},
    {citizenid = "THT58370", name = "Tobias ", number = "0548039060"},
    {citizenid = "JNI61467", name = "Tony McG", number = "0515187071"},
    {citizenid = "KDW96348", name = "Eliot Kipalog", number = "0581307729"},
    {citizenid = "GFR82236", name = "Sean McG", number = "0515187071"},
    {citizenid = "TWB56018", name = "Beshoy Hanna", number = "0595731527"},
    {citizenid = "BKC23544", name = "Billy Badger", number = "0516156830"},
    {citizenid = "DQJ22077", name = "Anna Sarah", number = "0548604848"},
    {citizenid = "DQJ22077", name = "Anna Sarah", number = "0548604848"},
    {citizenid = "DQJ22077", name = "Click Click", number = "0513651052"},
    {citizenid = "DQJ22077", name = "Anna Sarah", number = "0548604848"},
    {citizenid = "BKC23544", name = "Anna Sarah", number = "0548604848"},
    {citizenid = "AJA64738", name = "Click Click", number = "0513651052"},
    {citizenid = "KDW96348", name = "Click Click", number = "0513651052"},
    {citizenid = "AJA64738", name = "Billy Badger", number = "0516156830"},
    {citizenid = "EVY33035", name = "Jesse Brooks", number = "0565333328"},
    {citizenid = "BZW31045", name = "Clarence Lirent", number = "0551256841"},
    {citizenid = "FFS43297", name = "Clarence Lirent", number = "0551256841"},
    {citizenid = "ODV13271", name = "Beshoy Hanna", number = "0595731527"},
    {citizenid = "THT58370", name = "Clarence {citizenid =  Materials buyer )", number = "0551256841"},
    {citizenid = "THT58370", name = "Krystal {citizenid =  Materials buyer )", number = "0567932199"},
    {citizenid = "ENB94536", name = "Logan James", number = "0547213630"},
    {citizenid = "TXF27610", name = "Frost White", number = "0586097608"},
    {citizenid = "THT58370", name = "Jesse Brooks {citizenid =  Hoss )", number = "0565333328"},
    {citizenid = "FYX30489", name = "Billy Badger", number = "0516156830"},
    {citizenid = "BZW31045", name = "Mech", number = "0595731527"},
    {citizenid = "BZW31045", name = "Krystal", number = "0567932199"},
    {citizenid = "EMP27751", name = "Amberetta Foxglove", number = "0553245546"},
    {citizenid = "UNC58665", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "THT58370", name = "Davis Mechanic", number = "0581611117"},
    {citizenid = "WGQ48193", name = "Anna Sarah", number = "0548604848"},
    {citizenid = "YKM04371", name = "Billy Badger", number = "0516156830"},
    {citizenid = "AJA64738", name = "Clarence Lirent", number = "0551256841"},
    {citizenid = "WGQ48193", name = "Clarence Lirent", number = "0551256841"},
    {citizenid = "EVY33035", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "FEG79563", name = "Dustin Kowalchuk", number = "0555195970"},
    {citizenid = "MTT62081", name = "Gucci Demon", number = "0549727154"},
    {citizenid = "EVY33035", name = "Frost White", number = "0586097608"},
    {citizenid = "EAO93257", name = "johnson Chaderick", number = "0563442402"},
    {citizenid = "WGQ48193", name = "Keenan Gray", number = "0512421343"},
    {citizenid = "WGQ48193", name = "John Doe", number = "0595159626"},
    {citizenid = "ZYG35649", name = "Triston Skonberg", number = "0526545207"},
    {citizenid = "FFS43297", name = "John Doe", number = "0595159626"},
    {citizenid = "FFS43297", name = "Alejandro Coronza", number = "0565407907"},
    {citizenid = "ZYG35649", name = "Alejandro Coronza", number = "0565407907"},
    {citizenid = "PHU97234", name = "John Doe", number = "0595159626"},
    {citizenid = "PHU97234", name = "Triston Skonberg", number = "0526545207"},
    {citizenid = "GPA06957", name = "Dustin Kowalchuk", number = "0555195970"},
    {citizenid = "FEW42477", name = "Alex Hunter", number = "0565267763"},
    {citizenid = "FEW42477", name = "Joe Kov", number = "0524947122"},
    {citizenid = "DQJ22077", name = "Bill McNasty", number = "0545747001"},
    {citizenid = "GPA06957", name = "Robert Stone", number = "0588482244"},
    {citizenid = "WGQ48193", name = "Davis Caribou", number = "0581611117"},
    {citizenid = "FEW42477", name = "Doofy", number = "0571015093"},
    {citizenid = "VLV29191", name = "doofy", number = "0571015093"},
    {citizenid = "GTH40371", name = "Nola", number = "0518615699"},
    {citizenid = "TXF27610", name = "Billy Badger", number = "0516156830"},
    {citizenid = "YAR32430", name = "Nola", number = "0518615699"},
    {citizenid = "EMD89976", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "AXY08657", name = "John Daniels", number = "0515483983"},
    {citizenid = "YAR32430", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "EMP27751", name = "Chuck Tolmero", number = "0545525384"},
    {citizenid = "ENB94536", name = "Joe Kov", number = "0524947122"},
    {citizenid = "WHZ77977", name = "johnson Chaderick", number = "0563442402"},
    {citizenid = "NJB42345", name = "Alex Hunter", number = "0565267763"},
    {citizenid = "TES56794", name = "LostMC", number = "0581844878"},
    {citizenid = "UNC58665", name = "Alex Hunter", number = "0565267763"},
    {citizenid = "WHZ77977", name = "Amberetta Foxglove", number = "0553245546"},
    {citizenid = "WHZ77977", name = "Tony Banks", number = "0583775400"},
    {citizenid = "GFR82236", name = "Jase Turner", number = "0595936137"},
    {citizenid = "GPA06957", name = "Tobias TheFuck", number = "0548039060"},
    {citizenid = "ANV90441", name = "Tobias TheFuck", number = "0548039060"},
    {citizenid = "GLB34392", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "WGQ48193", name = "Joe Kov", number = "0524947122"},
    {citizenid = "WGQ48193", name = "Frost White", number = "0586097608"},
    {citizenid = "ENB94536", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "YAR32430", name = "Anna Sarah", number = "0548604848"},
    {citizenid = "AJA64738", name = "Chuck Tolmero", number = "0545525384"},
    {citizenid = "FDO16662", name = "John Doe", number = "0595159626"},
    {citizenid = "ZYG35649", name = "Marty Woo", number = "0599859917"},
    {citizenid = "WNB08724", name = "Billy Badger", number = "0516156830"},
    {citizenid = "DQJ22077", name = "Dustin Kowalchuk", number = "0555195970"},
    {citizenid = "FYX30489", name = "johnson Chaderick", number = "0563442402"},
    {citizenid = "OGH20166", name = "Billy Badger", number = "0516156830"},
    {citizenid = "DQJ22077", name = "Nola Tarantino", number = "0518615699"},
    {citizenid = "YAR32430", name = "Billy Badger", number = "0516156830"},
    {citizenid = "NJB42345", name = "Jim Flowers", number = "0534341079"},
    {citizenid = "ENB94536", name = "JJ Rush", number = "0521126008"},
    {citizenid = "BNQ33243", name = "Frost White", number = "0586097608"},
    {citizenid = "HPD33052", name = "Beshoy Hanna", number = "0595731527"},
    {citizenid = "NVU72596", name = "Jim Flowers", number = "0534341079"},
    {citizenid = "FYX30489", name = "John Daniels", number = "0515483983"},
    {citizenid = "RSW12899", name = "John Daniels - Midget", number = "0515483983"},
    {citizenid = "JNI61467", name = "Billy Badger", number = "0516156830"},
    {citizenid = "DQJ22077", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "NVU72596", name = "Bellum Smith", number = "0542587867"},
    {citizenid = "WGQ48193", name = "John Daniels", number = "0515483983"},
    {citizenid = "FFS43297", name = "Marty Woo", number = "0599859917"},
    {citizenid = "NJB42345", name = "Gilberto Infante", number = "0573821547"},
    {citizenid = "THF28109", name = "johnson Chaderick", number = "0563442402"},
    {citizenid = "ZYG35649", name = "Jesse Brooks", number = "0565333328"},
    {citizenid = "BZW31045", name = "John Doe", number = "0595159626"},
    {citizenid = "ANV90441", name = "Harvey Litt", number = "0562684278"},
    {citizenid = "WNB08724", name = "Jesse Brooks", number = "0565333328"},
    {citizenid = "BZW31045", name = "Dustin Kowalchuk", number = "0555195970"},
    {citizenid = "FDO16662", name = "Triston Skonberg", number = "0526545207"},
    {citizenid = "KJI93025", name = "Triston Skonberg", number = "0526545207"},
    {citizenid = "KJI93025", name = "John Doe", number = "0595159626"},
    {citizenid = "KJI93025", name = "Marty Woo", number = "0599859917"},
    {citizenid = "ZYG35649", name = "Kenneth Brisendine", number = "0552367130"},
    {citizenid = "LCS60659", name = "Jase Turner", number = "0595936137"},
    {citizenid = "GPA06957", name = "Michael Sarz", number = "0561141610"},
    {citizenid = "GPA06957", name = "Scooter Rush", number = "0581097990"},
    {citizenid = "IKL19404", name = "Jase Turner", number = "0595936137"},
    {citizenid = "ZYG35649", name = "Dustin Kowalchuk", number = "0555195970"},
    {citizenid = "WNB08724", name = "John Doe", number = "0595159626"},
    {citizenid = "TYU96802", name = "Triston Skonberg", number = "0526545207"},
    {citizenid = "FFS43297", name = "Kenneth Brisendine", number = "0552367130"},
    {citizenid = "FFS43297", name = "Arthur Morgan", number = "0529572750"},
    {citizenid = "GPA06957", name = "Zack Costello", number = "0532441730"},
    {citizenid = "FZN85763", name = "Jase Turner", number = "0595936137"},
    {citizenid = "JNI61467", name = "Bobby", number = "0561647581"},
    {citizenid = "GPA06957", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "TFW20723", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "TFW20723", name = "Jase Turner", number = "0595936137"},
    {citizenid = "JNI61467", name = "Zack Costello", number = "0532441730"},
    {citizenid = "FZN85763", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "EVY33035", name = "Nola Tarantino", number = "0518615699"},
    {citizenid = "YBF46932", name = "Nola Tarantino", number = "0518615699"},
    {citizenid = "OGH20166", name = "Habibi Bachem", number = "0535028996"},
    {citizenid = "YBF46932", name = "Vinnie Hunter", number = "0527141993"},
    {citizenid = "WZR66725", name = "Bino Rilla", number = "0541045215"},
    {citizenid = "EAO93257", name = "Jesse Brooks", number = "0565333328"},
    {citizenid = "BZW31045", name = "Tony Wyoming", number = "0514953030"},
    {citizenid = "ZGW81465", name = "Juan Sanchez", number = "0545493328"},
    {citizenid = "PPP04513", name = "Nola Tarantino", number = "0518615699"},
    {citizenid = "PPP04513", name = "Jim Flowers", number = "0534341079"},
    {citizenid = "GPA06957", name = "Jim Flowers", number = "0534341079"},
    {citizenid = "FYX30489", name = "Jase Turner", number = "0595936137"},
    {citizenid = "FYX30489", name = "Tyler Trumbone", number = "0526307344"},
    {citizenid = "OBB95816", name = "Donte Kapri", number = "0546574393"},
    {citizenid = "WNB08724", name = "Donte Kapri", number = "0546574393"},
    {citizenid = "LUT81893", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "JNI61467", name = "Lrchie Bee", number = "0595741223"},
    {citizenid = "XEV94469", name = "Skarletta Foxglove", number = "0538929401"},
    {citizenid = "ITN01724", name = "Bobby Demon", number = "0561647581"},
    {citizenid = "WHZ77977", name = "Lrchie Bee", number = "0595741223"},
    {citizenid = "LUT81893", name = "Jordy King", number = "0521829865"},
    {citizenid = "LUT81893", name = "Alex Hunter", number = "0565267763"},
    {citizenid = "WHZ77977", name = "Andy Johnson", number = "0518303989"},
    {citizenid = "ZGW81465", name = "Alex Hunter", number = "0565267763"},
    {citizenid = "GPA06957", name = "Lrchie Bee", number = "0595741223"},
    {citizenid = "BQL96093", name = "Jase Turner", number = "0595936137"},
    {citizenid = "GPA06957", name = "Maria Rilla", number = "0565736734"},
    {citizenid = "FYI90420", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "GPA06957", name = "Beshoy Hanna", number = "0595731527"},
    {citizenid = "EVY33035", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "EMP27751", name = "Andy Johnson", number = "0518303989"},
    {citizenid = "ZGW81465", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "WGQ48193", name = "Cam Fontaine", number = "0541562739"},
    {citizenid = "ZGW81465", name = "Amberetta Foxglove", number = "0553245546"},
    {citizenid = "OGH20166", name = "Billy Badger", number = "0516156830"},
    {citizenid = "DQJ22077", name = "Nola Tarantino", number = "0518615699"},
    {citizenid = "AJA64738", name = "Joe Kov", number = "0528388574"},
    {citizenid = "GPA06957", name = "Tony Banks", number = "0583775400"},
    {citizenid = "GPA06957", name = "Andy Johnson", number = "0518303989"},
    {citizenid = "ZGW81465", name = "Jase Turner", number = "0595936137"},
    {citizenid = "EMP27751", name = "Tobias TheFuck", number = "0548039060"},
    {citizenid = "VLV29191", name = "jase Turner", number = "0595936137"},
    {citizenid = "UZN64104", name = "Gucci Demon", number = "0549727154"},
    {citizenid = "OQD93021", name = "Billy Badger", number = "0516156830"},
    {citizenid = "ZGW81465", name = "Clarence", number = "0551256841"},
    {citizenid = "JAQ43179", name = "johnson Chaderick", number = "0563442402"},
    {citizenid = "FIZ67595", name = "Billy Badger - Mechanic", number = "0516156830"},
    {citizenid = "FYI90420", name = "Nick Jones", number = "0522343254"},
    {citizenid = "THT58370", name = "Donte Kapri", number = "0546574393"},
    {citizenid = "AXY08657", name = "Andy Johnson", number = "0518303989"},
    {citizenid = "ELT80718", name = "Donte Kapri", number = "0546574393"},
    {citizenid = "AXY08657", name = "Scooter Rush", number = "0581097990"},
    {citizenid = "GQR97247", name = "Anna Sarah", number = "0548604848"},
    {citizenid = "EMD89976", name = "{citizenid = PDM) Jose", number = "0568538924"},
    {citizenid = "IKL19404", name = "Cam Fontaine", number = "0541562739"},
    {citizenid = "FYI90420", name = "Jose Demon", number = "0568538924"},
    {citizenid = "PYC19443", name = "Donte Kapri", number = "0546574393"},
    {citizenid = "GPA06957", name = "Finley Walker", number = "0549528133"},
    {citizenid = "CSZ69061", name = "Jase Turner", number = "0595936137"},
    {citizenid = "WNB08724", name = "Finley Walker", number = "0549528133"},
    {citizenid = "CSZ69061", name = "Dustin Kowalchuk", number = "0555195970"},
    {citizenid = "UNC58665", name = "Donte Kapri", number = "0546574393"},
    {citizenid = "NJB42345", name = "Donte Kapri", number = "0546574393"},
    {citizenid = "YUS27906", name = "Nick Jones", number = "0522343254"},
    {citizenid = "YUS27906", name = "Harvey Litt", number = "0562684278"},
    {citizenid = "ITN01724", name = "Jose Demon", number = "0568538924"},
    {citizenid = "WNB08724", name = "Amberetta Foxglove", number = "0553245546"},
    {citizenid = "UNC58665", name = "Dustin Kowalchuk", number = "0555195970"},
    {citizenid = "HCG31931", name = "Donte Kapri", number = "0546574393"},
    {citizenid = "HCG31931", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "GRN34951", name = "Amberetta Foxglove", number = "0553245546"},
    {citizenid = "HCG31931", name = "Amberetta Foxglove", number = "0553245546"},
    {citizenid = "FYI90420", name = "Andy Johnson", number = "0518303989"},
    {citizenid = "ZGW81465", name = "Richard Kiriko", number = "0521198882"},
    {citizenid = "GTH40371", name = "Donte Kapri", number = "0546574393"},
    {citizenid = "OQD93021", name = "Vito Tarantino", number = "0582684802"},
    {citizenid = "HCG31931", name = "johnson Chaderick", number = "0563442402"},
    {citizenid = "GRN34951", name = "johnson Chaderick", number = "0563442402"},
    {citizenid = "PYC19443", name = "Jose", number = "0568538924"},
    {citizenid = "GRN34951", name = "Nick Jones", number = "0522343254"},
    {citizenid = "PVF85714", name = "Dustin Kowalchuk", number = "0555195970"},
    {citizenid = "XEA44263", name = "Logan James", number = "0547213630"},
    {citizenid = "TXF27610", name = "Zach ", number = "0514612775"},
    {citizenid = "JNI61467", name = "Bobby Demon", number = "0561647581"},
    {citizenid = "ANV90441", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "PVF85714", name = "Jose Demon", number = "0568538924"},
    {citizenid = "UNC58665", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "YUS27906", name = "Bobby Demon", number = "0561647581"},
    {citizenid = "WBN80180", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "JNI61467", name = "Ghost Coleman", number = "0542351798"},
    {citizenid = "WBN80180", name = "Jose Demon", number = "0568538924"},
    {citizenid = "YUS27906", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "YBF46932", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "JNI61467", name = "Andy Johnson", number = "0518303989"},
    {citizenid = "ZGW81465", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "IKL19404", name = "Garrett Johnson", number = "0583705968"},
    {citizenid = "JNI61467", name = "Jerry Applestein", number = "0552282703"},
    {citizenid = "BLW59852", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "GGW83324", name = "Chris Tucker", number = "0516154326"},
    {citizenid = "FIB68062", name = "Doug Douglas", number = "0573937896"},
    {citizenid = "DQJ22077", name = "Jim Flowers", number = "0534341079"},
    {citizenid = "ZEA02333", name = "Krystal Lights", number = "0567932199"},
    {citizenid = "WGQ48193", name = "Michael Sarz", number = "0561141610"},
    {citizenid = "WGQ48193", name = "Tyler Trumbone", number = "0526307344"},
    {citizenid = "WGQ48193", name = "Doug Douglas", number = "0573937896"},
    {citizenid = "PVF85714", name = "Andy Johnson", number = "0518303989"},
    {citizenid = "ZGW81465", name = "Diablo Banderas", number = "0589453407"},
    {citizenid = "PVF85714", name = "Jim Flowers", number = "0534341079"},
    {citizenid = "GRN34951", name = "Diablo Banderas", number = "0589453407"},
    {citizenid = "PVF85714", name = "Frankie Mercer", number = "0582856786"},
    {citizenid = "VXQ16664", name = "Droxx Mercer", number = "0599071708"},
    {citizenid = "YYH06816", name = "PDM", number = "0558322943"},
    {citizenid = "WNB08724", name = "Frost White", number = "0586097608"},
    {citizenid = "ENB94536", name = "Dustin Kowalchuk", number = "0555195970"},
    {citizenid = "DBI95057", name = "Triston Skonberg", number = "0526545207"},
    {citizenid = "WIR01757", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "RHM74831", name = "JJ Rush", number = "0521126008"},
    {citizenid = "BNQ33243", name = "Sexy Man", number = "0581307729"},
    {citizenid = "TWB56018", name = "Scooter Rush", number = "0581097990"},
    {citizenid = "IKL19404", name = "Edgar Foo", number = "0565807480"},
    {citizenid = "ZGW81465", name = "Jose Demon", number = "0568538924"},
    {citizenid = "YUS27906", name = "Andy Johnson", number = "0518303989"},
    {citizenid = "YUS27906", name = "Tony Wyoming", number = "0514953030"},
    {citizenid = "YUS27906", name = "Jerry Applestein", number = "0552282703"},
    {citizenid = "AXY08657", name = "Richard Kiriko", number = "0521198882"},
    {citizenid = "BLW59852", name = "Jose Demon", number = "0568538924"},
    {citizenid = "AXY08657", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "PEP39372", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "WGQ48193", name = "Ajax Noire", number = "0571825789"},
    {citizenid = "WBN80180", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "WGQ48193", name = "Ghost Coleman", number = "0542351798"},
    {citizenid = "UNC58665", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "WGQ48193", name = "Amberetta Foxglove", number = "0553245546"},
    {citizenid = "WGQ48193", name = "Richard Kiriko", number = "0521198882"},
    {citizenid = "PYC19443", name = "Tony Macaroni", number = "0516781030"},
    {citizenid = "AXY08657", name = "Frost White", number = "0586097608"},
    {citizenid = "WGQ48193", name = "Nick Jones", number = "0522343254"},
    {citizenid = "NVU72596", name = "Frost White", number = "0586097608"},
    {citizenid = "ENB94536", name = "John Daniels", number = "0515483983"},
    {citizenid = "WAD88258", name = "Chris Tucker", number = "0516154326"},
    {citizenid = "AKN41215", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "WGQ48193", name = "Harvey Litt", number = "0562684278"},
    {citizenid = "TYM18813", name = "Amberetta Foxglove", number = "0553245546"},
    {citizenid = "UNC58665", name = "Alan Walker", number = "0553951838"},
    {citizenid = "TYM18813", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "NVU72596", name = "Dustin Kowalchuk", number = "0555195970"},
    {citizenid = "WNB08724", name = "John Daniels", number = "0515483983"},
    {citizenid = "WGQ48193", name = "Christopher Johnson", number = "0545402160"},
    {citizenid = "WGQ48193", name = "Alan Walker", number = "0553951838"},
    {citizenid = "WGQ48193", name = "Juan Sanchez", number = "0545493328"},
    {citizenid = "TFW20723", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "IVJ62464", name = "Krystal", number = "0567932199"},
    {citizenid = "IVJ62464", name = "Beshoy", number = "0595731527"},
    {citizenid = "UZN64104", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "EMP27751", name = "Alan Walker", number = "0553951838"},
    {citizenid = "YOI92403", name = "Anatoly Knyazev", number = "0527505908"},
    {citizenid = "ELT80718", name = "Anatoly Knyazev", number = "0527505908"},
    {citizenid = "DXW55695", name = "Keenan Gray", number = "0512421343"},
    {citizenid = "DXW55695", name = "Vladmire Puttin", number = "0537373113"},
    {citizenid = "TYM18813", name = "Forrest Cordle", number = "0581844878"},
    {citizenid = "WGQ48193", name = "Jack Davis", number = "0522462133"},
    {citizenid = "YOI92403", name = "Purchaser", number = "0541562739"},
    {citizenid = "YOI92403", name = "Helisale", number = "0522343254"},
    {citizenid = "RDY35998", name = "NICK", number = "0522343254"},
    {citizenid = "ESL17467", name = "Frost White", number = "0586097608"},
    {citizenid = "ENB94536", name = "Kai Jackson", number = "0511238332"},
    {citizenid = "WNB08724", name = "Billy Badger", number = "0516156830"},
    {citizenid = "ZYG35649", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "WGQ48193", name = "Joe Kov", number = "0528388574"},
    {citizenid = "OQD93021", name = "Frost White", number = "0586097608"},
    {citizenid = "YUS27906", name = "Kai Jackson", number = "0511238332"},
    {citizenid = "ENB94536", name = "Donte Kapri", number = "0546574393"},
    {citizenid = "EXU49662", name = "Amberetta Foxglove", number = "0553245546"},
    {citizenid = "YUS27906", name = "Jax Carter", number = "0598799354"},
    {citizenid = "GPA06957", name = "Amberetta Foxglove", number = "0553245546"},
    {citizenid = "UNC58665", name = "Jase Turner", number = "0595936137"},
    {citizenid = "GPA06957", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "WGQ48193", name = "Jase Turner", number = "0595936137"},
    {citizenid = "MZU45665", name = "cop", name = "911"},
    {citizenid = "WGQ48193", name = "JJ Montana", number = "0584511778"},
    {citizenid = "YUS27906", name = "Scooter Rush", number = "0581097990"},
    {citizenid = "WGQ48193", name = "Edgar Foo", number = "0565807480"},
    {citizenid = "YUS27906", name = "Ajax Noire", number = "0571825789"},
    {citizenid = "YUS27906", name = "Noah Jackson", number = "0558322943"},
    {citizenid = "WGQ48193", name = "Jose Demon", number = "0568538924"},
    {citizenid = "WGQ48193", name = "Hunter Papani", number = "0571699578"},
    {citizenid = "WGQ48193", name = "Colton King", number = "0541878706"},
    {citizenid = "IKL19404", name = "Kai Jackson", number = "0511238332"},
    {citizenid = "ESL17467", name = "Scooter Rush", number = "0581097990"},
    {citizenid = "FYI90420", name = "Clarence L", number = "0551256841"},
    {citizenid = "FYI90420", name = "Frost White", number = "0586097608"},
    {citizenid = "ENB94536", name = "Richard Kiriko", number = "0521198882"},
    {citizenid = "TFW20723", name = "Billy Badger", number = "0516156830"},
    {citizenid = "DQJ22077", name = "Juan Sanchez", number = "0545493328"}
}

local invoices = {
    {citizenid = "TYU96802", amount = 1000, society = "police", title = "SanAndreas State Fine"},
    {citizenid = "HKP78058", amount = 5000, society = "police", title = "Weapon"},
    {citizenid = "FDO16662", amount = 550, society = "police", title = "Robbery"},
    {citizenid = "PHU97234", amount = 69, society = "police", title = "Arrest#001"},
    {citizenid = "KJI93025", amount = 1500, society = "police", title = ""},
    {citizenid = "IAV98865", amount = 6500, society = "police", title = "Gunlicense"},
    {citizenid = "FDO16662", amount = 22500, society = "police", title = "SanAndreas State Fine"},
    {citizenid = "PHU97234", amount = 5000, society = "police", title = "SanAndreas State Fine"},
    {citizenid = "HWN91560", amount = 6500, society = "police", title = "gun"},
    {citizenid = "KJI93025", amount = 2000, society = "police", title = "Fine"},
    {citizenid = "FDO16662", amount = 10000, society = "police", title = "arrest3"},
    {citizenid = "FDO16662", amount = 250, society = "police", title = "SanAndreas State Fine"},
    {citizenid = "FDO16662", amount = 12750, society = "police", title = "Arrest"},
    {citizenid = "FDO16662", amount = 250, society = "police", title = "None"},
    {citizenid = "FDO16662", amount = 250, society = "police", title = "SanAndreas State Fine"},
    {citizenid = "XUB83326", amount = 1000, society = "police", title = "None"},
    {citizenid = "FZN85763", amount = 3500, society = "police", title = "None"},
    {citizenid = "GFR82236", amount = 5500, society = "police", title = "Arrest"},
    {citizenid = "WRY50189", amount = 4000, society = "police", title = "SanAndreas State Fine"},
    {citizenid = "OGH20166", amount = 54000, "mechanic", "moto"},
    {citizenid = "ESL17467", amount = 7000, society = "police", title = "Dirty"},
    {citizenid = "FDO16662", amount = 8500, society = "police", title = "SanAndreas State Fine"},
    {citizenid = "FDO16662", amount = 9750, society = "police", title = "Arrest"},
    {citizenid = "MZU45665", amount = 3000, society = "police", title = "Bank"},
    {citizenid = "ZYG35649", amount = 32250, society = "police", title = "SanAndreas State Fine"},
    {citizenid = "ZYG35649", amount = 34250, society = "police", title = "SanAndreas State Fine"}
}

Citizen.CreateThread(function()
    exports.ghmattimysql:execute("SELECT * FROM phone_contacts", {}, function(foundContacts)
        if #foundContacts <= 0 then
            print("[Phone]: Importing contacts from old phone into DB")
            for i, v in pairs(contacts) do
                exports.ghmattimysql:execute('INSERT INTO phone_contacts (citizenid, name, number) VALUES (@citizenid, @name, @number)', {
                    ['@citizenid'] = v.citizenid,
                    ['@name'] = v.name,
                    ["@number"] = v.number
                }, function(result)
                    -- print(json.encode(result))
                end)
                
                if next(contacts, i) == nil then
                    print("[Phone]: Added all contacts from old phone into DB")
                end
            end
        end
    end)
    
    exports.ghmattimysql:execute("SELECT * FROM phone_invoices", {}, function(foundInvoices)
        if #foundInvoices <= 0 then
            print("[Phone]: Importing invoices from old phone into DB")
            for i, v in pairs(invoices) do
                exports.ghmattimysql:execute('INSERT INTO phone_invoices (citizenid, amount, society, title) VALUES (@citizenid, @amount, @society, @title)', {
                    ['@citizenid'] = v.citizenid,
                    ['@amount'] = v.amount,
                    ["@society"] = v.society,
                    ["@title"] = v.title
                }, function(result)
                    -- print(json.encode(result))
                end)
                
                if next(invoices, i) == nil then
                    print("[Phone]: Added all contacts from old phone into DB")
                end
            end
        end
    end)
end) ]]

--[[ Phone calling stuff ]]

function getNumberPhone(server_id)
    local number = nil
    local finished = false
    local xPlayer = RLCore.Functions.GetPlayer(server_id)
    while not xPlayer do 
        xPlayer = RLCore.Functions.GetPlayer(server_id)
        Wait(0)
    end
    
    exports.ghmattimysql:execute("SELECT charinfo FROM players WHERE citizenid = @citizenid", {["@citizenid"] = xPlayer.PlayerData.citizenid}, function(foundData)
        number = json.decode(foundData[1].charinfo).phone
        finished = true
    end)

    while not finished do
        Wait(0)
    end

    return number
end

function getIdentifierByPhoneNumber(phone_number)
    local identifier = nil
    local finished = false
    
    exports.ghmattimysql:execute("SELECT * FROM players", {}, function(foundData)
        for i, v in pairs(foundData) do
            if phone_number == json.decode(v.charinfo).phone then
                identifier = v.steam
            end

            if next(foundData, i) == nil then
                finished = true
            end
        end
    end)

    while not finished do
        Wait(0)
    end
    
    return identifier
end

RegisterNetEvent('phone:callContact')
AddEventHandler('phone:callContact', function(targetnumber, payphone)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local targetIdentifier = getIdentifierByPhoneNumber(targetnumber)
    local xPlayers = RLCore.Functions.GetPlayers()
    local srcPhone = getNumberPhone(src)
     
    for i=1, #xPlayers, 1 do
        local xPlayer = RLCore.Functions.GetPlayer(xPlayers[i])
        if xPlayer then
            local steam = GetPlayerIdentifiers(xPlayers[i])[1]
            if steam == targetIdentifier then
                playerID = xPlayers[i]
                break
            end
        end
    end

    if playerID ~= nil then
        local player = RLCore.Functions.GetPlayer(playerID)
        if payphone then
            if xPlayer.PlayerData.money['cash'] >= 25 then
                xPlayer.Functions.RemoveMoney('cash', 25)

                TriggerClientEvent('phone:initiateCall', src, src)
                TriggerClientEvent('phone:receiveCall', playerID, targetnumber, src, srcPhone)

                exports['ghmattimysql']:execute("SELECT citizenid FROM players WHERE steam = @identifier", {['@identifier'] = targetIdentifier}, function(result)
                    AddRecentCall(xPlayer.PlayerData.citizenid, 1, targetnumber, GetContactFromNumber(xPlayer.PlayerData.citizenid, targetnumber))
                end)

                AddRecentCall(player.PlayerData.citizenid, 1, srcPhone, GetContactFromNumber(player.PlayerData.citizenid, srcPhone))
                return
            else
                TriggerClientEvent('RLCore:Notify', src, "You need $25 to use the payphone!", "error")
                return
            end
        end
        
        TriggerClientEvent('phone:initiateCall', src, src)
        TriggerClientEvent('phone:receiveCall', playerID, targetnumber, src, srcPhone)

        exports['ghmattimysql']:execute("SELECT citizenid FROM players WHERE steam = @identifier", {['@identifier'] = targetIdentifier}, function(result)
            AddRecentCall(xPlayer.PlayerData.citizenid, 1, targetnumber, GetContactFromNumber(xPlayer.PlayerData.citizenid, targetnumber))
        end)

        AddRecentCall(player.PlayerData.citizenid, 1, srcPhone, GetContactFromNumber(player.PlayerData.citizenid, srcPhone))
    else
        TriggerClientEvent("phone:hangup", src)        
        exports['ghmattimysql']:execute("SELECT citizenid FROM players WHERE steam = @identifier", {['@identifier'] = targetIdentifier}, function(result)
            if #result > 0 then
                TriggerClientEvent('RLCore:Notify', src, "You can't call this number, as this number is offline!", "error")

                exports['ghmattimysql']:execute("SELECT citizenid FROM players WHERE steam = @identifier", {['@identifier'] = targetIdentifier}, function(result2)
                    AddRecentCall(xPlayer.PlayerData.citizenid, 1, targetnumber, GetContactFromNumber(xPlayer.PlayerData.citizenid, targetnumber))
                    AddRecentCall(result2[1].citizenid, 2, srcPhone, GetContactFromNumber(result2[1].citizenid, srcPhone))
                end)
            else
                TriggerClientEvent('RLCore:Notify', src, "You can't call this number, as this number doesn't exist!", "error")
            end
        end)
    end
end)

function GetContactFromNumber(citizenid, number)
    local contact = number
    local finished = false
    exports.ghmattimysql:execute("SELECT * FROM phone_contacts WHERE citizenid = @citizenid AND number = @number", {['@citizenid'] = citizenid, ["@number"] = number}, function(found)
        if #found > 0 then
            contact = found[1].name
        end
        finished = true
    end)

    while not finished do
        Wait(0)
    end
    return contact
end

AddRecentCall = function(citizenid, type, number, name)
    exports.ghmattimysql:execute('INSERT INTO phone_calls (citizenid, type, phoneNumber, name) VALUES (@citizenid, @type, @phoneNumber, @name)', {
        ['@citizenid'] = citizenid,
        ['@type'] = type,
        ["@phoneNumber"] = number,
        ['@name'] = name
    }, function(result)
    end)
end

RegisterNetEvent('phone:getSMS')
AddEventHandler('phone:getSMS', function()
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local mynumber = getNumberPhone(src)
    
    exports.ghmattimysql:execute("SELECT * FROM phone_messages WHERE receiver = @mynumber OR sender = @mynumber ORDER BY id DESC", {['@mynumber'] = mynumber}, function(result)
        local numbers ={}
        local convos = {}
        local valid
        
        for k, v in pairs(result) do
            valid = true
            if v.sender == mynumber then
                for i=1, #numbers, 1 do
                    if v.receiver == numbers[i] then
                        valid = false
                    end
                end
                if valid then
                    table.insert(numbers, v.receiver)
                end
            elseif v.receiver == mynumber then
                for i=1, #numbers, 1 do
                    if v.sender == numbers[i] then
                        valid = false
                    end
                end
                if valid then
                    table.insert(numbers, v.sender)
                end
            end
        end
        
        for i, j in pairs(numbers) do
            for g, f in pairs(result) do
                if j == f.sender or j == f.receiver then
                    table.insert(convos, {
                        id = f.id,
                        sender = f.sender,
                        receiver = f.receiver,
                        message = f.message,
                        date = f.date
                    })
                    break
                end
            end
        end
        
        local data = ReverseTable(convos)
        TriggerClientEvent('phone:loadSMS', src, data, mynumber)
    end)
end)

function ReverseTable(t)
    local reversedTable = {}
    local itemCount = #t
    for k, v in ipairs(t) do
        reversedTable[itemCount + 1 - k] = v
    end
    return reversedTable
end

RegisterNetEvent('phone:sendSMS')
AddEventHandler('phone:sendSMS', function(receiver, message)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    while not xPlayer do 
        xPlayer = RLCore.Functions.GetPlayer(server_id)
        Wait(0)
    end

    local mynumber = getNumberPhone(src)
    local target = getIdentifierByPhoneNumber(receiver)
    exports.ghmattimysql:execute('INSERT INTO phone_messages (citizenid, sender, receiver, message) VALUES (@citizenid, @sender, @receiver, @message)', {
        ["@citizenid"] = xPlayer.PlayerData.citizenid,
        ['@sender'] = mynumber,
        ['@receiver'] = receiver,
        ['@message'] = message
    }, function(result)
        for k, v in pairs(RLCore.Functions.GetPlayers()) do
            v = tonumber(v)
            local otherXPlayer = RLCore.Functions.GetPlayer(v)
            if otherXPlayer then
                if otherXPlayer.PlayerData.steam == target then
                    TriggerClientEvent('phone:newSMS', v, 1, mynumber)
                    -- TriggerClientEvent('refreshSMS', v)
                end
            end
        end
    end)
end)

RegisterNetEvent('phone:serverGetMessagesBetweenParties')
AddEventHandler('phone:serverGetMessagesBetweenParties', function(sender, receiver, displayName)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local mynumber = getNumberPhone(src)
    exports.ghmattimysql:execute("SELECT * FROM phone_messages WHERE (sender = @sender AND receiver = @receiver) OR (sender = @receiver AND receiver = @sender) ORDER BY id ASC", {['@sender'] = sender, ['@receiver'] = receiver}, function(groupMessages)
        TriggerClientEvent('phone:clientGetMessagesBetweenParties', src, groupMessages, displayName, mynumber)
    end)
end)

RegisterNetEvent('phone:StartCallConfirmed')
AddEventHandler('phone:StartCallConfirmed', function(mySourceID)
    local channel = math.random(10000, 99999)
    local src = source

    TriggerClientEvent('phone:callFullyInitiated', mySourceID, mySourceID, src)
    TriggerClientEvent('phone:callFullyInitiated', src, src, mySourceID)

    -- After add them to the same channel or do it from server.
    TriggerClientEvent('phone:addToCall', source, channel)
    TriggerClientEvent('phone:addToCall', mySourceID, channel)

    TriggerClientEvent('phone:id', src, channel)
    TriggerClientEvent('phone:id', mySourceID, channel)
end)

RegisterNetEvent('phone:EndCall')
AddEventHandler('phone:EndCall', function(mySourceID, stupidcallnumberidk, somethingextra)
    local src = source
    TriggerClientEvent('phone:removefromToko', source, stupidcallnumberidk)

    if mySourceID and mySourceID ~= 0 or mySourceID ~= nil then
        TriggerClientEvent('phone:removefromToko', mySourceID, stupidcallnumberidk)
        TriggerClientEvent('phone:otherClientEndCall', mySourceID)
    end

    if somethingextra then
        TriggerClientEvent('phone:otherClientEndCall', src)
    end
end)

RegisterCommand("a", function(source, args, rawCommand)
    local src = source
    TriggerClientEvent('phone:answercall', src)
end, false)

RegisterCommand("h", function(source, args, rawCommand)
    local src = source
    TriggerClientEvent('phone:endCalloncommand', src)
end, false)

RegisterCommand("lawyer", function(source, args, rawCommand)
    local src = source
    TriggerClientEvent('yellowPages:retrieveLawyersOnline', src, true)
end, false)

RegisterCommand("ph", function(source, args, rawCommand)
    local src = source
    local srcPhone = getNumberPhone(src)
    TriggerClientEvent('sendMessagePhoneN', src, srcPhone)
end, false)

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

AddEventHandler('es:playerLoaded',function(source)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    getOrGeneratePhoneNumber(sourcePlayer, identifier, function (myPhoneNumber)
        --[[TriggerClientEvent("gcPhone:myPhoneNumber", sourcePlayer, myPhoneNumber)
        TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
        TriggerClientEvent("gcPhone:allMessage", sourcePlayer, getMessages(identifier))]]
    end)
end)

function getOrGeneratePhoneNumber (sourcePlayer, identifier, cb)
    local sourcePlayer = sourcePlayer
    local identifier = identifier
    local myPhoneNumber = getNumberPhone(src)
    if myPhoneNumber == '0' or myPhoneNumber == nil then
        repeat
            myPhoneNumber = getPhoneRandomNumber()
            local id = getIdentifierByPhoneNumber(myPhoneNumber)
        until id == nil
        exports.ghmattimysql:execute("UPDATE players SET phone_number = @myPhoneNumber WHERE identifier = @identifier", {
            ['myPhoneNumber'] = myPhoneNumber,
            ['identifier'] = identifier
        }, function ()
            cb(myPhoneNumber)
        end)
    else
        cb(myPhoneNumber)
    end
end

function getPhoneRandomNumber()
    local numBase0 = 4
    local numBase1 = math.random(10,99)
    local numBase2 = math.random(100,999)
    local numBase3 = math.random(1000,9999)
    local num = string.format(numBase0 .. "" .. numBase1 .. "" .. numBase2 .. "" .. numBase3)
    return num
end

RegisterNetEvent('message:inDistanceZone')
AddEventHandler('message:inDistanceZone', function(somethingsomething, messagehueifh)
    local src = source		
    local first = messagehueifh:sub(1, 3)
    local second = messagehueifh:sub(4, 6)
    local third = messagehueifh:sub(7, 11)

    local msg = first .. "-" .. second .. "-" .. third
	TriggerClientEvent('chat:addMessage', somethingsomething, {
		template = '<div style = "display: inline-block !important;padding: 0.6vw;padding-top: 0.6vw;padding-bottom: 0.7vw;margin: 0.1vw;margin-left: 0.4vw;border-radius: 10px;background-color: #be6112d9;width: fit-content;max-width: 100%;overflow: hidden;word-break: break-word;"><b>Phone</b>: #{1}</div>',
		args = { fal, msg }
	})
end)

RegisterNetEvent('message:tome')
AddEventHandler('message:tome', function(messagehueifh)
    local src = source		
    local first = messagehueifh:sub(1, 3)
    local second = messagehueifh:sub(4, 6)
    local third = messagehueifh:sub(7, 11)

    local msg = first .. "-" .. second .. "-" .. third
	TriggerClientEvent('chat:addMessage', src, {
		template = '<div style = "display: inline-block !important;padding: 0.6vw;padding-top: 0.6vw;padding-bottom: 0.7vw;margin: 0.1vw;margin-left: 0.4vw;border-radius: 10px;background-color: #be6112d9;width: fit-content;max-width: 100%;overflow: hidden;word-break: break-word;"><b>Phone</b>: #{1}</div>',
		args = { fal, msg }
	})
end)


RegisterNetEvent('phone:getServerTime')
AddEventHandler('phone:getServerTime', function()
    local hours, minutes, seconds = Citizen.InvokeNative(0x50C7A99057A69748, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
    TriggerClientEvent('timeheader', -1, hours, minutes)
end)

function getIdentity(target)
    local data = nil
    local finished = false
    local xPlayer = RLCore.Functions.GetPlayer(target)
    while not xPlayer do 
        xPlayer = RLCore.Functions.GetPlayer(target)
        Wait(0)
    end
    
    exports.ghmattimysql:execute("SELECT * FROM players WHERE citizenid = @citizenid", {["@citizenid"] = xPlayer.PlayerData.citizenid}, function(foundData)
        data = {
            firstname = json.decode(foundData[1].charinfo).firstname,
            lastname = json.decode(foundData[1].charinfo).lastname
        }
        finished = true
    end)

    while not finished do
        Wait(0)
    end

    return data
end

--[[ Others ]]

RegisterNetEvent('getAccountInfo')
AddEventHandler('getAccountInfo', function()
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(source)
    while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0)
    end

    local cash = xPlayer.PlayerData.money['cash']
    local bank = xPlayer.PlayerData.money['bank']
    local licenceTable = {}

    -- TriggerEvent('esx_license:getLicenses', source, function(licenses)
    --     licenceTable = licenses
    -- end)
    licenceTable = {}
    exports['ghmattimysql']:execute("SELECT `driver`, `weapon1`, `weapon2` FROM `user_licenses` WHERE `citizenid` = @CID", {['@CID'] = xPlayer.PlayerData.citizenid}, function(result)
        if #result > 0 then
            local names = {'driver', 'weapon1', 'weapon2'}
            for i = 1, 3 do
                if result[1][names[i]] == 1 then
                    if names[i] == 'driver' then
                        table.insert(licenceTable, {
                            label = 'Drivers License', active = true
                        })
                    elseif names[i] == 'weapon1' then
                        table.insert(licenceTable, {
                            label = 'Concealed Carry License', active = true
                        })
                    elseif names[i] == 'weapon2' then
                        table.insert(licenceTable, {
                            label = 'Military License', active = true
                        })
                    end
                else
                    if names[i] == 'driver' then
                        table.insert(licenceTable, {
                            label = 'Drivers License', active = false
                        })
                    elseif names[i] == 'weapon1' then
                        table.insert(licenceTable, {
                            label = 'Concealed Carry License', active = false
                        })
                    elseif names[i] == 'weapon2' then
                        table.insert(licenceTable, {
                            label = 'Military License', active = false
                        })
                    end
                end
            end
            TriggerClientEvent('getAccountInfo', src, cash, bank, licenceTable)
        else
            TriggerClientEvent('getAccountInfo', src, cash, bank, licenceTable)
        end
    end)
end)


--[[ Yellow Pages ]]

RegisterNetEvent('getYP')
AddEventHandler('getYP', function()
    local source = source
    exports.ghmattimysql:execute("SELECT * FROM phone_yp LIMIT 30", {}, function(foundAds)
        TriggerClientEvent('YellowPageArray', source, foundAds)
    end)
end)

RegisterNetEvent('phone:updatePhoneJob')
AddEventHandler('phone:updatePhoneJob', function(advert)
    --local handle = handle
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local mynumber = getNumberPhone(src)
    local name = getIdentity(src)

    fal = name.firstname .. " " .. name.lastname

    exports.ghmattimysql:execute('INSERT INTO phone_yp (citizenid, name, message, phoneNumber) VALUES (@citizenid, @name, @message, @phoneNumber)', {
        ["@citizenid"] = xPlayer.PlayerData.citizenid,
        ['@name'] = fal,
        ['@message'] = advert,  
        ['@phoneNumber'] = mynumber
    }, function(result)
        TriggerClientEvent('refreshYP', src)
    end)
end)


--[[ RegisterNetEvent('getContacts')
AddEventHandler('getContacts', function()
    local xPlayer =RLCore.Functions.GetPlayer(source) 
	while not xPlayer do xPlayer =RLCore.Functions.GetPlayer(source); Citizen.Wait(0);end
    RLCore.Functions.ExecuteSql(false,"SELECT * FROM phone_contacts WHERE '" .. xPlayer.PlayerData.citizenid .. "'",  function(contacts)
        TriggerClientEvent('phone:loadContacts', source, contacts)
    end)
end) ]]


RegisterNetEvent('phone:foundLawyer')
AddEventHandler('phone:foundLawyer', function(name, phoneNumber)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style = "display: inline-block !important;padding: 0.6vw;padding-top: 0.6vw;padding-bottom: 0.7vw;margin: 0.1vw;margin-left: 0.4vw;border-radius: 10px;background-color: #1e2dff9c;width: fit-content;max-width: 100%;overflow: hidden;word-break: break-word;"><b>YP</b>: ⚖️ {0} ☎️ {1}</div>',
        args = { name, phoneNumber }
    })
end)

RegisterNetEvent('phone:foundLawyerC')
AddEventHandler('phone:foundLawyerC', function(name, phoneNumber)
    local src = source
    TriggerClientEvent('chat:addMessage', src, {
        template = '<div style = "display: inline-block !important;padding: 0.6vw;padding-top: 0.6vw;padding-bottom: 0.7vw;margin: 0.1vw;margin-left: 0.4vw;border-radius: 10px;background-color: #1e2dff9c;width: fit-content;max-width: 100%;overflow: hidden;word-break: break-word;"><b>YP</b>: ⚖️ {0} ☎️ {1}</div>',
        args = { name, phoneNumber }
    })
end)

RegisterNetEvent('phone:deleteYP')
AddEventHandler('phone:deleteYP', function()
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0)
    end

    exports.ghmattimysql:execute('DELETE FROM phone_yp WHERE citizenid = @citizenid', {
        ['@citizenid'] = xPlayer.PlayerData.citizenid,
    }, function ()
        TriggerClientEvent('refreshYP', src)
    end)
end)

--RegisterServerEvent('tp:checkPhoneCount')
--AddEventHandler('tp:checkPhoneCount', function()
--	local _source = source
--	local xPlayer = RLCore.Functions.GetPlayer(_source)
--	if xPlayer.getInventoryItem('phone').count >= 1 then
--		TriggerClientEvent('tp:heHasPhone', _source) 
--	else 
--		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have a phone, Buy one at your local store', length = 7000})
--	end
--end)

RegisterNetEvent("garages:CheckGarageForVeh")
AddEventHandler("garages:CheckGarageForVeh", function()
    local source = source
    local xPlayer = RLCore.Functions.GetPlayer(source)
    while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0)
    end
    
    exports.ghmattimysql:execute("SELECT * FROM bbvehicles WHERE citizenid = @citizenid", {["@citizenid"] = xPlayer.PlayerData.citizenid}, function(foundVehs)
        TriggerClientEvent('phone:Garage', source, foundVehs)
    end)
end)

RegisterNetEvent('phone:financePayment')
AddEventHandler('phone:financePayment', function(vehPlate)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(source)
    while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0)
    end

    if vehPlate ~= nil then
        exports.ghmattimysql:execute("SELECT `buy_price`, `plate`, `finance` FROM bbvehicles WHERE citizenid = @citizenid AND plate = @plate", {["@citizenid"] = xPlayer.PlayerData.citizenid, ["@plate"] = vehPlate}, function(vehData)
            if #vehData > 0 then
                for k, v in pairs(vehData) do
                    if vehPlate == v.plate then
                        local price = (v.buy_price / 10)
                        if price > v.finance then
                            price = v.finance
                        end

                        if xPlayer.PlayerData.money['bank'] >= price then
                            xPlayer.Functions.RemoveMoney('bank', price)
                            fuck = true
                            TriggerClientEvent('RLCore:Notify', src, "You payed $" .. math.ceil(price) .. ", to your financed vehicle (" .. vehPlate .. ")")
                        else
                            fuck = false
                            TriggerClientEvent('RLCore:Notify', src, "You don't have enough money to finance, you need $" .. math.ceil(price) .. "!", "error")
                        end

                        if fuck then
                            exports.ghmattimysql:execute("SELECT finance FROM bbvehicles WHERE citizenid = @citizenid AND plate = @plate", {["@citizenid"] = xPlayer.PlayerData.citizenid, ["@plate"] = vehPlate}, function(newVehData)
                                if #newVehData <= 0 then return end
                                local prevAmount = newVehData[1].finance

                                if prevAmount < price then
                                    exports.ghmattimysql:execute('UPDATE bbvehicles SET `finance` = @finance WHERE plate = @plate', {
                                        ['@finance'] = 0,
                                        ['@plate'] = vehPlate
                                    }, function(result)
                                    end)

                                    exports.ghmattimysql:execute('UPDATE bbvehicles SET `financetimer` = @financetimer WHERE plate = @plate', {
                                        ['@financetimer'] = 1440,
                                        ['@plate'] = vehPlate
                                    }, function(result)
                                    end)
                                else
                                    exports.ghmattimysql:execute('UPDATE bbvehicles SET `finance` = @finance WHERE plate = @plate', {
                                        ['@finance'] = prevAmount - price,
                                        ['@plate'] = vehPlate
                                    }, function(result)
                                    end)

                                    exports.ghmattimysql:execute('UPDATE bbvehicles SET `financetimer` = @financetimer WHERE plate = @plate', {
                                        ['@financetimer'] = 1440,
                                        ['@plate'] = vehPlate
                                    }, function(result)
                                    end)
                                end
                            end)
                        end
                    end
                    return
                end
            end
        end)
    end
end)

RegisterNetEvent("phone:server:getRecentCalls")
AddEventHandler("phone:server:getRecentCalls", function()
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0)
    end

    -- print(xPlayer.PlayerData.citizenid)
    exports.ghmattimysql:execute("SELECT * FROM `phone_calls` WHERE citizenid = @citizenid ORDER BY `date` DESC", {["@citizenid"] = xPlayer.PlayerData.citizenid}, function(foundCalls)
        -- print(json.encode(foundCalls))
        TriggerClientEvent("phone:client:sendRecentCalls", src, foundCalls)
    end)
end)

RegisterNetEvent("phone:server:PostPicture")
AddEventHandler("phone:server:PostPicture", function(description, currTime, url)
    local src = source
    local name = getIdentity(src)
    name = "@" .. name.firstname .. "_" .. name.lastname

    local connect = {
        {
            ["color"] = "32896",
            ["title"] = name .. " posted a picture",
            ["description"] = description,
            ["image"] = {
                ["url"] = url
              },
            ["footer"] = {
                ["text"] = "Posted at ".. currTime.hour .. ":" .. currTime.minute .. "" .. currTime.ampm .. ".",
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/812743158109700106/DNv-YpW0r2NTi61hQnWWLiBeDQb9Rw1vV-qoP9qcVa4F6vRNN2SQdTvF4SXm17GVbOSB", function(err, text, headers) end, 'POST', json.encode({username = "In City Moments", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('phone:server:GiveContactDetails')
AddEventHandler('phone:server:GiveContactDetails', function(PlayerId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    local SuggestionData = {
        name = {
            [1] = Player.PlayerData.charinfo.firstname,
            [2] = Player.PlayerData.charinfo.lastname
        },
        number = Player.PlayerData.charinfo.phone
    }

    TriggerClientEvent('chat:addMessage', PlayerId, {
        template = '<div class="chat-message advert"><div class="chat-message-body"><strong>First Name:</strong> {0} <br><strong>Last name:</strong> {1} <br><strong>Number:</strong> {2}</div></div>',
        args = {SuggestionData.name[1], SuggestionData.name[2], SuggestionData.number}
    })
end)

RegisterNetEvent("phone:server:GetBanking")
AddEventHandler("phone:server:GetBanking", function()
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0)
    end

    exports.ghmattimysql:execute("SELECT * FROM phone_invoices WHERE citizenid = @citizenid", {["@citizenid"] = xPlayer.PlayerData.citizenid}, function(foundInvoices)
        print(json.encode(foundInvoices))
        TriggerClientEvent("phone:client:RecieveBanking", src, xPlayer.PlayerData.money['bank'], foundInvoices)
    end)
end)

local handlingInvoice = {}

RegisterNetEvent("phone:server:PayInvoice")
AddEventHandler("phone:server:PayInvoice", function(invoice_id)
    local src = source
    if not handlingInvoice[src] then
        handlingInvoice[src] = true
        local xPlayer = RLCore.Functions.GetPlayer(src)
        while not xPlayer do
            xPlayer = RLCore.Functions.GetPlayer(src)
            Wait(0)
        end

        exports.ghmattimysql:execute("SELECT `amount`, `title`, `society` FROM phone_invoices WHERE citizenid = @citizenid AND invoiceid = @invoiceid LIMIT 1", {["@citizenid"] = xPlayer.PlayerData.citizenid, ["@invoiceid"] = invoice_id}, function(result)
            if xPlayer.PlayerData.money['bank'] >= result[1].amount then
                xPlayer.Functions.RemoveMoney('bank', result[1].amount)
                TriggerEvent("bb-bossmenu:server:addAccountMoney", result[1].society, result[1].amount)
                exports.ghmattimysql:execute('DELETE FROM phone_invoices WHERE citizenid = @citizenid AND invoiceid = @invoiceid LIMIT 1', {
                    ['@citizenid'] = xPlayer.PlayerData.citizenid,
                    ['@invoiceid'] = tonumber(invoice_id)
                }, function (deletedData)
                    if deletedData.affectedRows > 0 then
                        -- print("DELETED INVOICE")
                        exports.ghmattimysql:execute("SELECT * FROM phone_invoices WHERE citizenid = @citizenid", {["@citizenid"] = xPlayer.PlayerData.citizenid}, function(foundInvoices)
                            -- print(json.encode(foundInvoices))
                            TriggerClientEvent("phone:client:RecieveBanking", src, xPlayer.PlayerData.money['bank'] - result[1].amount, foundInvoices)
                            TriggerClientEvent('RLCore:Notify', src, "You have payed your fine " .. result[1].title .. " to the " .. FirstUppercase(result[1].society) .. ".", "success")
                            Wait(500)
                            handlingInvoice[src] = false
                        end)
                    end
                end)
            else
                TriggerClientEvent('RLCore:Notify', src, "You need $" .. result[1].amount - xPlayer.PlayerData.money['bank'] .. " more to pay this fine!", "error")
                Wait(500)
                handlingInvoice[src] = false
            end
        end)
    -- else
        -- print("FUCKER TRYNA SPAM!")
    end
end)

function FirstUppercase(str)
    return (str:gsub("^%l", string.upper))
end