let savelist = [
    "huntingammo",
    "subammo",
    "heavyammo",
    "lmgammo",
    "shotgunammo",
    "pistolammo",
    "tuner",
    "1gcocaine",
    "1gcrack",
    "coke50g",
    "coke5g",
    "joint",
    "joint2",
    "maleseed",
    "femaleseed",
    "oxy",
    "weed12oz",
    "weed5oz",
    "weedoz",
    "weedg",
    "aluminium",
    "plastic",
    "copper",
    "electronics",
    "rubber",
    "scrapmetal",
    "steel",
    "advlockpick",
    "armor",
    "bandage",
    "coffee",
    "cola",
    "burrito",
    "eggsbacon",
    "donut",
    "applepie",
    "foodgoods",
    "foodingredient",
    "freis",
    "greencow",
    "churro",
    "bakingsoda",
    "bleederburger",
    "water",
    "hotdog",
    "icecream",
    "jailfood",
    "sandwich",
    "torpedo",
    "treat",
    "hamburger",
    "weedtaco",
    "wheelchair",
    "glass",
    "moneyshot",
    "mobilephone",
    "questionablemeatburger",
    "repairkit",
    "fishingbass",
    "fishingbluefish",
    "fishingflounder",
    "fishingmackerel",
    "fishingcod",
    "fishingwhale",
    "fishingdolphin",
    "fishingshark",
    "softdrink",
    "bscoffee",
    "heartstopper",
    "mshake",
    "hamburgerbuns",
    "lettuce",
    "hamburgerpatty",
    "cheese",
    "potatoingred",
    "milk",
    "icecreamngred",
    "coffeebeans",
    "hfcs",
    "ciggypack",
    "ciggy",
    "chips",
    "maccheese",
    "ramen",
    "roostertea",
    "foodbag",
    "burgershotbag",
    "roostertakeout",
    "casinovip",
    "casinomember",
    "rentalpapers"
]

// we add items to the above list and delete them once decayed, this is run once on restarts.
const TimeAllowed = 1000 * 60 * 40320; // 28 days

function DeleteOld() {
    let dateNow = Date.now()

    for (let i = savelist.lengh - 1; i > 0; i--) {
        let ItemID = savelist[i]
        let TimeExtra = (TimeAllowed * ItemList[ItemID].decayrate)
        let DeleteTime = dateNow - TimeExtra
        
        if (itemList[ItemID].fullyDegrades) {
            exports["ghmattimysql"].execute(`DELETE FROM player_inventory WHERE item_id = '${ItemID}' AND ${DeleteTime} > creationDate`);
        } else {
            console.log("Tried to delete: " + ItemID + " but it should not fully decay, why is it in the list?")
        }
    }

    console.log("Inventory: Delete old items")
}

function CleanDroppedInventories() {
    exports["ghmattimysql"].execute(`DELETE FROM player_inventory WHERE dropped = '1'`)
    exports["ghmattimysql"].execute(`DELETE FROM player_inventory WHERE name LIKE '%_trash'`)
    DeleteOld()
}

function GetDecayDate(pItemID) {
    const item = itemList[pItemID]

    if (item.decayrate === undefined || item.decayrate === 0.0) return;

    const dateNow = Date.now()
    const decayTime = TimeAllowed + item.decayrate

    return dateNow - decayTime
}

exports('GetDecayDate', GetDecayDate)

setTimeout(CleanDroppedInventories, 30000)
