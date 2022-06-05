let DroppedInventories = [];
let InUseInventories = [];
let DataEntries = 0;
let hasBrought = [];
let CheckedDeginv = [];
const DROPPED_ITEM_KEEP_ALIVE = 1000 * 60 * 15;

function cleanInv() {
    for (let Row in DroppedInventories) {
        if (new Date(DroppedInventories[Row].lastUpdated + DROPPED_ITEM_KEEP_ALIVE).getTime() < Date.now() && DroppedInventories[Row].used && !InUseInventories[DroppedInventories[Row].name]) {
            emitNet("Inventory-Dropped-Remove", -1, [DroppedInventories[Row].name])
            delete DroppedInventories[Row];
        }
    }
}

setInterval(cleanInv, 20000)

RegisterServerEvent("server-request-update")
onNet("server-request-update", async (cid) => {
    let src = source
    let playerInventory = 'ply-' + cid
    let query = `SELECT COUNT(item_id) AS amount, item_id, id, name, information, slot, dropped, quality,  creationDate, MIN(creationDate) AS creationDate FROM player_inventory WHERE name = 'ply-${cid}' GROUP BY item_id, slot`;
    
    exports["ghmattimysql"].execute(query, {}, function(result) {
        emitNet("inventory-update-player", src, [result, 0, playerInventory]);
    });
});

RegisterServerEvent("server-request-update-src")
onNet("server-request-update-src", async (cid, src) => {
    let playerInventory = 'ply-' + cid
    let query = `SELECT COUNT(item_id) AS amount, item_id, id, name, information, slot, dropped, quality, creationDate, MIN(creationDate) AS creationDate FROM player_inventory WHERE name = '${playerInventory}' GROUP BY item_id`;

    exports["ghmattimysql"].execute(query, {}, function(result) {
        emitNet("inventory-update-player", src, [result, 0, playerInventory]);
    });
});

RegisterServerEvent("server-remove-item")
onNet("server-remove-item", async (cid, itemId, amount, openedInv) => {
    let src = source
    let playerInventory = 'ply-' + cid
    let query = `DELETE FROM player_inventory WHERE name = '${playerInventory}' AND item_id = '${itemId}' LIMIT ${amount}`;

    exports["ghmattimysql"].execute(query, {}, function() {
        emit("server-request-update-src", cid, src)
    });
});

RegisterServerEvent("server-remove-item-slot")
onNet("server-remove-item-slot", async (cid, itemId, amount, slotId) => {
    let src = source
    let playerInventory = 'ply-' + cid
    let query = `DELETE FROM player_inventory WHERE name = '${playerInventory}' and item_id = '${itemId}' and slot = '${slotId}' LIMIT ${amount}`

    exports["ghmattimysql"].execute(query, {}, function() {
        emit("server-request-update-src", cid, src)
    })
})

RegisterServerEvent("server-remove-item-kv")
onNet("server-remove-item-kv", async (cid, itemId, amount, metaKey, metaValue) => {
    let src = source
    let playerInventory = 'ply-' + cid
    let query = `DELETE FROM player_inventory WHERE name = '${playerInventory}' and item_id = '${itemId}' AND (information LIKE '${metaKey}' OR information LIKE '${metaValue}') LIMIT ${amount}`;

    exports["ghmattimysql"].execute(query, {}, function() {
        emit("server-request-update-src", cid, src)
    });
});

RegisterServerEvent("server-remove-item-multiple-kv")
onNet("server-remove-item-multiple-kv", async (cid, itemId, amount, kvs, checkQuality) => {
    let src = source
    let playerInventory = 'ply-' + cid
    let query = `DELETE FROM player_inventory WHERE name = '${playerInventory}' AND item_id = '${itemId}' AND (information LIKE '${kvs}') AND quality = '${checkQuality}' LIMIT ${amount}`;

    exports["ghmattimysql"].execute(query, {}, function () {
        emit("server-request-update-src", cid, src)
    });
});

RegisterServerEvent("server-update-item")
onNet("server-update-item", async (cid, itemId, slotId, pData) => {
    let src = source
    let playerInventory = 'ply-' + cid
    let query = `UPDATE player_inventory SET information = '${pData}' WHERE item_id = '${itemId}' AND name = '${playerInventory}' AND slot = '${slotId}'`

    exports["ghmattimysql"].execute(query, {}, function () {
        emit("server-request-update-src", cid, src)
    });
});

RegisterServerEvent("server-inventory-open")
onNet("server-inventory-open", async (playerPos, cid, secondInventory, targetName, itemToDropArray, vehWeightCalc, invWeight, invSlot) => {
    let src = source
    let playerInventory = 'ply-' + cid

    if (InUseInventories[targetName] || InUseInventories[playerInventory]) {

        if (InUseInventories[playerInventory]) {
            if ((InUseInventories[playerInventory] != cid)) {
                return
            } else {

            }
        }
        if (InUseInventories[targetName]) {
            if (InUseInventories[targetName] == cid) {

            } else {
                secondInventory = "69"
            }
        }
    }

    let query = `SELECT COUNT(item_id) AS amount, id, name, item_id, information, slot, dropped, quality, creationDate FROM player_inventory WHERE name = 'ply-${cid}' GROUP BY slot`;

    exports["ghmattimysql"].execute(query, {}, function(result) {
        var invArray = result;
        var arrayCount = 0;

        InUseInventories[playerInventory] = cid;

        if (secondInventory == "1") {
            var targetInventory = targetName
            let query = `SELECT COUNT(item_id) AS amount, id, name, item_id, information, slot, dropped, quality, creationDate FROM player_inventory WHERE name = '${targetInventory}' GROUP BY slot`;

            exports["ghmattimysql"].execute(query, {}, function(inventory) {
                emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, inventory, 0, targetInventory, 500, true, invWeight, invSlot]);

                InUseInventories[targetInventory] = cid
            });
        } else if (secondInventory == "3") {
            let Key = "" + DataEntries + "";
            let NewDroppedName = 'Drop-' + Key;
            DataEntries = DataEntries + 1

            var invArrayTarget = [];

            DroppedInventories[NewDroppedName] = {
                position: {
                    x: playerPos[0],
                    y: playerPos[1],
                    z: playerPos[2]
                },
                name: NewDroppedName,
                used: false,
                lastUpdated: Date.now()
            }

            InUseInventories[NewDroppedName] = cid;

            invArrayTarget = JSON.stringify(invArrayTarget)
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, invArrayTarget, 0, NewDroppedName, 500, false]);

        } else if (secondInventory == "13") {
            let Key = "" + DataEntries + "";
            let NewDroppedName = 'Drop-' + Key;
            DataEntries = DataEntries + 1

            for (let Key in itemToDropArray) {
                for (let i = 0; i < itemToDropArray[Key].length; i++) {
                    let objectToDrop = itemToDropArray[Key][i];
                    exports["ghmattimysql"].execute(`UPDATE player_inventory SET slot = '${i+1}', name = '${NewDroppedName}', dropped = '1' WHERE name = '${Key}' AND slot = '${objectToDrop.faultySlot}' AND item_id = '${objectToDrop.faultyItem}' `);
                }
            }

            DroppedInventories[NewDroppedName] = {
                position: {
                    x: playerPos[0],
                    y: playerPos[1],
                    z: playerPos[2]
                },
                name: NewDroppedName,
                used: false,
                lastUpdated: Date.now()
            }

            emitNet("Inventory-Dropped-Addition", -1, DroppedInventories[NewDroppedName])

        } else if (secondInventory == "2") {
            var targetInventory = targetName;
            var shopArray = ConvenienceStore();
            var shopAmount = 13;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "4") {
            var targetInventory = targetName;
            var shopArray = HardwareStore();
            var shopAmount = 16;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "5") {
            var targetInventory = targetName;
            var shopArray = GunStore();
            var shopAmount = 5;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "10") {
            var targetInventory = targetName; 
            var shopArray = PoliceArmory();
            var shopAmount = 21;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "47") {
            var targetInventory = targetName;
            var shopArray = EMT();
            var shopAmount = 13;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "14") {
            var targetInventory = targetName;
            var shopArray = courthouse();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "18") {
            var targetInventory = targetName;
            var shopArray = TacoTruck();
            var shopAmount = 14;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "22") {
            var targetInventory = targetName;
            var shopArray = JailFood();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "25") {
            var targetInventory = targetName;
            var shopArray = JailMeth();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "12") {
            var targetInventory = targetName;
            var shopArray = burgiestore();
            var shopAmount = 8;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "600") {
            var targetInventory = targetName;
            var shopArray = policeveding();
            var shopAmount = 7;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }

        else if (secondInventory == "27") {
            var targetInventory = targetName;
            var shopArray = Mechanic();
            var shopAmount = 6;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "141") {
            var targetInventory = targetName;
            var shopArray = recycle();
            var shopAmount = 8;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "998") {
            var targetInventory = targetName;
            var shopArray = slushy();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "921") {
            var targetInventory = targetName;
            var shopArray = asslockpick();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }

        else if (secondInventory == "26") {
            var targetInventory = targetName;
            var shopArray = assphone();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "28") {
            var targetInventory = targetName;
            var shopArray = Tuner();
            var shopAmount = 4;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "714") {
            var targetInventory = targetName;
            var shopArray = smelter();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "997") {
            var targetInventory = targetName;
            var shopArray = prison();
            var shopAmount = 7;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "31") {
            var targetInventory = targetName;
            var shopArray = craftDrink();
            var shopAmount = 21;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "42071") {
            var targetInventory = targetName;
            var shopArray = craftRoosters();
            var shopAmount = 6;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else if (secondInventory == "6969") {
            var targetInventory = targetName;
            var shopArray = GunStore2();
            var shopAmount = 2;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }

        

        else if (secondInventory == "7") {
            var targetInventory = targetName;
            var shopArray = DroppedItem(itemToDropArray);

            itemToDropArray = JSON.parse(itemToDropArray)
            var shopAmount = itemToDropArray.length;

            emitNet("inventory-open-target", src, [invArray, arrayCount, playerInventory, shopArray, shopAmount, targetInventory, 500, false]);
        }
        else {
            emitNet("inventory-update-player", src, [invArray, arrayCount, playerInventory]);
        }
    });
});

RegisterServerEvent("server-inventory-close")
onNet("server-inventory-close", async (cid, targetInventory) => {
    let src = source

    emitNet("toggle-animation", src, false);

    InUseInventories = InUseInventories.filter(item => item != cid);

    if (targetInventory.indexOf("Drop") > -1 && DroppedInventories[targetInventory]) {
        if (DroppedInventories[targetInventory].used === false) {
            delete DroppedInventories[targetInventory];
        } else {
            let query = `SELECT COUNT(item_id) AS amount, item_id, name, information, slot, dropped, quality, creationDate FROM player_inventory WHERE name = '${targetInventory}' group by item_id `;

            exports["ghmattimysql"].execute(query, {}, function(result) {
                if (result.length == 0 && DroppedInventories[targetInventory]) {
                    delete DroppedInventories[targetInventory];
                    emitNet("Inventory-Dropped-Remove", -1, [targetInventory])
                }
            });
        }
    }

    emit("server-request-update-src", cid, src)    
});

RegisterServerEvent("server-inventory-stack")
onNet("server-inventory-stack", async (cid, pData, playerPos) => {
    let src = source

    let targetSlot = pData[0]
    let moveAmount = pData[1]
    let targetInventory = pData[2].replace(/"/g, "");
    let originSlot = pData[3]
    let originInventory = pData[4].replace(/"/g, "");
    let isPurchase = pData[5]
    let itemCosts = pData[6]
    let itemId = pData[7]
    let metaInformation = pData[8]

    let amount = pData[9]
    let isCraft = pData[10]
    let isWeapon = pData[11]
    let PlayerStore = pData[12]
    let amountRemaining = pData[13]

    let creationDate = Date.now()

    if ((targetInventory.indexOf("Drop") > -1 || targetInventory.indexOf("hidden") > -1) && DroppedInventories[targetInventory]) {
        if (DroppedInventories[targetInventory].used === false) {
            DroppedInventories[targetInventory] = {
                position: {
                    x: playerPos[0],
                    y: playerPos[1],
                    z: playerPos[2]
                },
                name: targetInventory,
                used: true,
                lastUpdated: Date.now()
            }

            emitNet("Inventory-Dropped-Addition", -1, DroppedInventories[targetInventory])
        }
    }

    let info = "{}"

    if (isPurchase) {
        if (isWeapon) {
            //exports["ghmattimysql"].execute(`INSERT INTO player_inventory (item_id, name, information, slot, creationDate) VALUES ('${itemId}','${targetInventory}','${info}','${targetSlot}','${creationDate}' );`);
        }

        info = await GenerateInformation(cid, itemId)
        removeCash(src, itemCosts)

        if (!PlayerStore) {
            for (let i = 0; i < parseInt(amount); i++) {
                exports["ghmattimysql"].execute(`INSERT INTO player_inventory (item_id, name, information, slot, creationDate) VALUES ('${itemId}','${targetInventory}','${info}','${targetSlot}','${creationDate}' );`);
            }
        }

        if (PlayerStore) {
            exports["ghmattimysql"].execute(`UPDATE player_inventory SET slot = '${targetSlot}', name = '${targetInventory}', dropped = '0' WHERE slot = '${originSlot}' AND name = '${originInventory}'`);
        }

    } else if (isCraft) {
        info = await GenerateInformation(cid, itemId)

        for (let i = 0; i < parseInt(amount); i++) {
            exports["ghmattimysql"].execute(`INSERT INTO player_inventory (item_id, name, information, slot, creationDate) VALUES ('${itemId}','${targetInventory}','${info}','${targetSlot}','${creationDate}' );`);
        }

    } else {
        let query = `SELECT item_id, id FROM player_inventory WHERE slot='${originSlot}' and name='${originInventory}' LIMIT ${moveAmount}`;

        exports["ghmattimysql"].execute(query, {}, function(result) {
            var itemIds = "0"

            for (let i = 0; i < result.length; i++) {
                itemIds = itemIds + "," + result[i].id
            }

            if (targetInventory.indexOf("Drop") > -1 || targetInventory.indexOf("hidden") > -1) {
                exports["ghmattimysql"].execute(`UPDATE player_inventory SET slot='${targetSlot}', name='${targetInventory}', dropped='1' WHERE id IN (${itemIds})`);

            } else {
                exports["ghmattimysql"].execute(`UPDATE player_inventory SET slot='${targetSlot}', name='${targetInventory}', dropped='0' WHERE id IN (${itemIds})`);
            }
        });
    }
});

RegisterServerEvent("server-inventory-move")
onNet("server-inventory-move", async (cid, pData, playerPos) => {
    let src = source

    let targetSlot = pData[0]
    let originSlot = pData[1]
    let targetInventory = pData[2].replace(/"/g, "");
    let originInventory = pData[3].replace(/"/g, "");
    let isPurchase = pData[4]
    let itemCosts = pData[5]
    let itemId = pData[6]
    let metaInformation = pData[7]
    let amount = pData[8]
    let isCraft = pData[9]
    let isWeapon = pData[10]
    let PlayerStore = pData[11]

    let creationDate = Date.now()

    if ((targetInventory.indexOf("Drop") > -1 || targetInventory.indexOf("hidden") > -1) && DroppedInventories[targetInventory]) {
        if (DroppedInventories[targetInventory].used === false) {

            DroppedInventories[targetInventory] = {
                position: {
                    x: playerPos[0],
                    y: playerPos[1],
                    z: playerPos[2]
                },
                name: targetInventory,
                used: true,
                lastUpdated: Date.now()
            }
            emitNet("Inventory-Dropped-Addition", -1, DroppedInventories[targetInventory])
        }
    }

    let info = "{}"

    if (isPurchase) {
        info = await GenerateInformation(cid, itemId);

        if (isWeapon) {
            hadBrought[cid] = true;
            emitNet("Inventory-brought-update", -1, JSON.stringify(Object.assign({}, hadBrought)));
        }

        info = await GenerateInformation(cid, itemId)
        removeCash(src, itemCosts)

        if (!PlayerStore) {
            for (let i = 0; i < parseInt(amount); i++) {
                exports["ghmattimysql"].execute(`INSERT INTO player_inventory (item_id, name, information, slot, creationDate) VALUES ('${itemId}','${targetInventory}','${info}','${targetSlot}','${creationDate}' );`);
            }

        } else if (isCraft) {
            info = await GenerateInformation(cid, itemId)

            for (let i = 0; i < parseInt(amount); i++) {
                exports["ghmattimysql"].execute(`INSERT INTO player_inventory (item_id, name, information, slot, creationDate) VALUES ('${itemId}','${targetInventory}','${info}','${targetSlot}','${creationDate}' );`);
            }

        } else {
            if (targetInventory.indexOf("Drop") > -1 || targetInventory.indexOf("hidden") > -1) {
                exports["ghmattimysql"].execute(`INSERT INTO player_inventory SET slot = '${targetSlot}', name = '${targetInventory}', dropped = '1' WHERE slot = '${originSlot}' AND name = '${originInventory}'`);
            } else {
                exports["ghmattimysql"].execute(`UPDATE player_inventory SET slot = '${targetSlot}', name = '${targetInventory}', dropped = '0' WHERE slot = '${originSlot}' AND name = '${originInventory}'`);
            }
        }
    } else {
        if (isCraft == true) {
            info = await GenerateInformation(cid, itemId)

            for (let i = 0; i < parseInt(amount); i++) {
                exports["ghmattimysql"].execute(`INSERT INTO player_inventory (item_id, name, information, slot, creationDate) VALUES ('${itemId}','${targetInventory}','${info}','${targetSlot}','${creationDate}' );`);
            }
        }

        exports["ghmattimysql"].execute(`UPDATE player_inventory SET slot = '${targetSlot}', name = '${targetInventory}', dropped = '0' WHERE slot = '${originSlot}' AND name = '${originInventory}'`);
    }
});

RegisterServerEvent("server-inventory-swap")
onNet("server-inventory-swap", async (cid, pData, playerPos) => {
    let targetSlot = pData[0]
    let targetInventory = pData[1].replace(/"/g, "");
    let originSlot = pData[2]
    let originInventory = pData[3].replace(/"/g, "");

    let query = `SELECT id FROM player_inventory WHERE slot = '${targetSlot}' AND name = '${targetInventory}'`;

    exports["ghmattimysql"].execute(query, {}, function(result) {
        var itemIds = "0"

        for (let i = 0; i < result.length; i++) {
            itemIds = itemIds + "," + result[i].id
        }

        let query = false;

        if (targetInventory.indexOf("Drop") > -1 || targetInventory.indexOf("hidden") > -1) {
            query = `UPDATE player_inventory SET slot = '${targetSlot}', name = '${targetInventory}', dropped = '1' WHERE slot = '${originSlot}' AND name = '${originInventory}'`;
        } else {
            query = `UPDATE player_inventory SET slot = '${targetSlot}', name = '${targetInventory}', dropped = '0' WHERE slot = '${originSlot}' AND name = '${originInventory}'`;
        }

        exports["ghmattimysql"].execute(query, {}, function(inventory) {
            if (originInventory.indexOf("Drop") > -1 || originInventory.indexOf("hidden") > -1) {
                exports["ghmattimysql"].execute(`UPDATE player_inventory SET slot = '${originSlot}', name = '${originInventory}', dropped = '1' WHERE id IN (${itemIds})`);
            } else {
                exports["ghmattimysql"].execute(`UPDATE player_inventory SET slot = '${originSlot}', name = '${originInventory}', dropped = '0' WHERE id IN (${itemIds})`);
            }
        });
    });
});

//RegisterServerEvent("server-inventory-remove-any")
//onNet("server-inventory-remove-any", async (itemId, amount) => {
    //let src = source
    //let user = exports["np-base"].getModule("Player").GetUser(src)
    //let cid = user.getCurrentCharacter().id
    //let xPlayer = ESX.GetPlayerFromId(src)
    //let cid = xPlayer.getIdentifier()
    //let playerInventory = 'ply-' + cid
    //let query = `DELETE FROM player_inventory WHERE name = '${playerInventory}' AND item_id = '${itemId}' LIMIT ${amount}`

    //exports["ghmattimysql"].execute(query, {}, function() {
        //emit("server-request-update-src", cid, src)
    //})
//})

//RegisterServerEvent("server-inventory-remove-slot")
//onNet("server-inventory-remove-slot", async (itemId, amount, slotId) => {
    //let src = source
    //let user = exports["np-base"].getModule("Player").GetUser(src)
    //let cid = user.getCurrentCharacter().id
    //let playerInventory = 'ply-' + cid
    //let query = `DELETE FROM player_inventory WHERE name = '${playerInventory}' AND item_id = '${itemId}' AND slot = '${slotId}' LIMIT ${amount}`

    //exports["ghmattimysql"].execute(query, {}, function() {
        //emit("server-request-update-src", cid, src)
    //})
//})

RegisterServerEvent("server-inventory-give")
onNet("server-inventory-give", async (cid, itemId, slotId, amount, generateInformation, itemData, openedInv, returnData) => {
    let src = source
    let playerInventory = 'ply-' + cid
    let creationDate = Date.now()

    let info = "{}"

    if (itemId == "idcard") {
        info = await GenerateInformation(cid, itemId, itemData)
    }

    if (itemId == "evidence") {
        info = await GenerateInformation(cid, itemId, itemData)
    }

    if (itemId == "bowlingreceipt") {
        info = await GenerateInformation(cid, itemId, itemData)
    }

    if (itemId == "burgershotbag") {
        info = returnData;
    }

    if (itemId == "murdermeal") {
        info = returnData;
    }

    let values = `('${playerInventory}','${itemId}','${info}','${slotId}','${creationDate}')`

    if (amount > 1) {
        for (let i = 2; i <= amount; i++) {
            values = values + `,('${playerInventory}','${itemId}','${info}','${slotId}','${creationDate}')`
        }
    }

    let query = `INSERT INTO player_inventory (name, item_id, information, slot, creationDate) VALUES ${values};`

    exports["ghmattimysql"].execute(query, {}, function () {
        emit("server-request-update-src", cid, src)
    });
});

RegisterServerEvent("server-inventory-refresh")
onNet("server-inventory-refresh", async (cid) => {
    let src = source
    let query = `SELECT COUNT(item_id) AS amount, id, name, item_id, information, slot, dropped, quality, creationDate FROM player_inventory WHERE name= 'ply-${cid}' GROUP BY slot`;

    exports["ghmattimysql"].execute(query, {}, function(result) {
        if (!result) {} else {
            var invArray = result;
            var arrayCount = 0;
            var playerInventory = cid

            emitNet("inventory-update-player", src, [invArray, arrayCount, playerInventory]);
        }
    })
})

RegisterServerEvent("inventory:degItem")
onNet("inventory:degItem", async (LastUsedItem, percent, LastUsedItemId, cid) => {
    let playerInventory = 'ply-' + cid
    let amount = percent * 100000000 / 2;
    
    exports["ghmattimysql"].execute(`UPDATE player_inventory SET creationDate = creationDate - ${amount} WHERE id = ${LastUsedItem} AND item_id = '${LastUsedItemId}' AND name = '${playerInventory}'`, {}, function() {});
});

function makeId(length) {
    var result = '';
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghikjlmnopqrstuvwxyz'; //abcdef
    var charactersLength = characters.length;

    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }

    return result;
}

function GenerateInformation(cid, itemId, itemData, returnData = '{}') {
    let rData = Object.assign({}, itemData);
    let returnInfo = returnData;

    return new Promise((resolve, reject) => {
        if (itemId == '') return resolve(returninfo);

        let timeout = 0;
        if (!isNaN(itemId)) {
            var serialNumber = cid.toString()
            
            if (itemData && itemData.fakeWeaponData) {
                serialNumber = Math.floor((Math.random() * 99999) + 1)
                serialNumber = serialNumber.toString()
            }

            if (itemList[itemId].weapon == true) {
                let cartridgeCreated = cid + "-" + makeId(3) + "-" + Math.floor(Math.random() * 999 + 1);
                returnInfo = JSON.stringify({
                    Cartridge: cartridgeCreated,
                    Serial: serialNumber,
                    Quality: "Good"
                })
            }

            timeout = 1;
            clearTimeout(timeout)
            return resolve(returnInfo);

        } else if (Object.prototype.toString.call(itemId) === '[object String]') { // Check if itemid is a string
            switch (
                itemId.toLowerCase() 
            ) {
                case "idcard":
                    if (itemData && itemData.fake) {
                        returnInfo = JSON.stringify({
                            Identifier: itemData.charID,
                            Name: itemData.first.replace(/[^\w\s]/gi, ''),
                            Surname: itemData.last.replace(/[^\w\s]/gi, ''),
                            Sex: itemData.sex,
                            DOB: itemData.dob
                        });
                        timeout = 1
                        clearTimeout(timeout);
                        return resolve(returnInfo);
                    } else {
                        let query = `SELECT first_name, last_name, gender, dob FROM characters WHERE id = '${cid}'`;

                        exports["ghmattimysql"].execute(query, {}, function(result) {
                            let dateOfBirth = '';

                            try {
                                dateOfBirth = new Date(result[0].dob).toISOString().split('T')[0];
                            } catch (err) {
                                dateOfBirth = 'N/A';
                            }

                            returnInfo = JSON.stringify({
                                Identifier: cid.toString(),
                                Name: result[0].first_name.replace(/[^\w\s]/gi, ''),
                                Surname: result[0].last_name.replace(/[^\w\s]/gi, ''),
                                Sex: result[0].gender === 0 ? "M" : "F",
                                DOB: dateOfBirth
                            });

                            timeout = 1
                            clearTimeout(timeout);
                            return resolve(returnInfo);
                        });
                    }
                    break;
                case 'huntingcarcass1':
                case 'huntingcarcass2':
                case 'huntingcarcass3':
                case 'huntingcarcass4':
                    returnInfo = JSON.stringify({
                        Identifier: itemData.identifier
                    });

                    timeout = 1;
                    clearTimeout(timeout);
                    return resolve(returnInfo);

                case "casing":
                    returnInfo = JSON.stringify({
                        Identifier: itemData.identifier,
                        Type: itemData.eType,
                        Other: itemData.other
                    })

                    timeout = 1
                    clearTimeout(timeout);
                    return resolve(returnInfo);

                case "np_evidence_marker_yellow":
                case "np_evidence_marker_red":
                case "np_evidence_marker_white":
                case "np_marker_evidence_marker_orange":
                case "np_marker_evidence_marker_light_blue":
                case "np_marker_evidence_marker_light_purple":
                case "evidence":
                    returnInfo = JSON.stringify({
                        Identifier: itemData.identifier,
                        Type: itemData.eType,
                        Other: itemData.other
                    })

                    timeout = 1;
                    clearTimeout(timeout);
                    return resolve(returnInfo);
                    
                case 'burnerphone':
                    burnerNumber = GenerateBurnerPhoneNumber();
                    returnInfo = JSON.stringify({
                        Number: burnerNumber
                    });

                    timeout = 1;
                    clearTimeout(timeout);
                    return resolve(returnInfo);

                case "heistlaptop1":
                case "heistlaptop2":
                case "heistlaptop3":
                case "heistlaptop4":
                    const randomId = Math.floor(Math.random() * 9999999) + 100000;

                    returnInfo = JSON.stringify({
                        id: randomId,
                        _hideKeys: ['id'],
                    });

                    timeout = 1;
                    clearTimeout(timeout);
                    return resolve(returnInfo);

                case "bowlingreceipt":
                    returnInfo = JSON.stringify({ 
                        Lane: itemData.lane 
                    })

                    timeout = 1;
                    clearTimeout(timeout)
                    return resolve(returnInfo);       

                case "murdermeal":
                case "burgershotbag":
                    returnInfo = JSON.stringify({ 
                        inventoryId: itemData.inventoryId, 
                        slots: itemData.slots, 
                        weight: itemData.weight 
                    })

                    timeout = 1;
                    clearTimeout(timeout);
                    return resolve(returnInfo);        
 
                case "drivingtest":
                    if (rData.id) {
                        let query = `SELECT * FROM driving_tests WHERE id = '${rData.id}'`;

                        exports["ghmattimysql"].execute(query, {}, function(result) {
                            if (result[0]) {
                                let timeStamp = new Date(parseInt(result[0].timestamp) * 1000);
                                let testDate = timeStamp.getFullYear() + "-" + ("0" + (timeStamp.getMonth() + 1)).slice(-2) + "-" + ("0" + timeStamp.getDate()).slice(-2);

                                returninfo = JSON.stringify({
                                    ID: result[0].id,
                                    CID: result[0].cid,
                                    Instructor: result[0].instructor,
                                    Date: testDate,
                                });

                                timeout = 1;
                                clearTimeout(timeout)
                            }
                            return resolve(returninfo);
                        });
                    } else {
                        timeout = 1;
                        clearTimeout(timeout)
                        return resolve(returnInfo);
                    }
                    break;    
                default:
                    timeout = 1
                    clearTimeout(timeout)
                    return resolve(returnInfo);
            }
        } else {
            return resolve(returnInfo);
        }

        setTimeout(() => {
            if (timeout == 0) {
                return resolve(returnInfo);
            }
        }, 500)
    });
}

function removeCash(src, itemCosts) {
    emit('cash:remove', src, itemCosts)
}

function DroppedItem(itemArray) {
    itemArray = JSON.parse(itemArray)
    var shopItems = [];

    shopItems[0] = {
        item_id: itemArray[0].itemid,
        id: 0,
        name: "shop",
        information: "{}",
        slot: 1,
        amount: itemArray[0].amount
    };

    return JSON.stringify(shopItems);
}

function deleteHidden() {
    exports["ghmattimysql"].execute(`DELETE FROM player_inventory WHERE name like '%Hidden%' OR name like '%trash%'`)
}

function deleteHiddenHandler() {
    setTimeout(250000, deleteHidden())
}

onNet('onResourceStart', (resource) => {
    if (resource == GetCurrentResourceName()){
        exports["ghmattimysql"].execute(`DELETE FROM player_inventory WHERE name like '%Drop%'`)
    }
})

/////////////////////////////// Old Code ///////////////////////////////

RegisterServerEvent('server-jail-item')
onNet("server-jail-item", async (player, isSentToJail) => {
    let currInventoryName = `${player}`
    let newInventoryName = `${player}`

    if (isSentToJail) {
        currInventoryName = `jail-${player}`
        newInventoryName = `${player}`
    } else {
        currInventoryName = `${player}`
        newInventoryName = `jail-${player}`
    }

    exports["ghmattimysql"].execute(`UPDATE player_inventory SET name='${currInventoryName}', WHERE name='${newInventoryName}' and dropped=0`);
});