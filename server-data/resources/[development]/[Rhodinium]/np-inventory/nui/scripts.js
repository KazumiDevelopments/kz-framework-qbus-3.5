const bindSlots = [1, 2, 3, 4];
let isDragging = false;
let draggingid = 'none';
let mousedown = false;
let personalWeight = 0;
let secondaryWeight = 0;
let personalMaxWeight = 250;
let secondaryMaxWeight = 250;
let movementAmount = 0;
let currentInventory = 0;
let weight = 0;
let amount = 0;
let name = 0;
let itemid = 0;
let slotusing = 0;
let itemusinginfo = '{}';
let inventoryUsedName = 'none';
let curGPSLength = 0;
let cursorX = 0;
let cursorY = 0;
let purchase = false;
let crafting = false;
let clicking = false;
let userCash = 0;
let userWeaponLicense = false;
let itemList = {};
let exluded = {};
let brought = false;
let isCop = false;
let dateNow = Date.now();
let _lastInfo = '';

//Sky's stuff
let isOverAmount = false;
let amountEdit = '';

//User settings
let holdToDrag = false;
let closeOnClick = true;
let ctrlMovesHalf = false;
let showTooltips = true;
let enableBlur = true;

let customImageItems = [
    "musicmerch",
    "customfooditem",
    "customwateritem",
    "customjointitem",
    "customcoffeeitem",
    "vehicle_part",
    "custommerchitem",
    "customciggyitem",
    "custombandageitem",
    "newstape",
    "summonablepet",
    "tcgcard",
    "book",
    "petaccessory",
    "resfooditem",
    "ressideitem",
    "resdessertitem",
    "resdrinkitem",
    "resalcoholitem",
    "bentobox",
    "spraycan",
    "gallerygem",
];
let customNameItems = [
    "customfooditem",
    "customwateritem",
    "customjointitem",
    "customcoffeeitem",
    "vehicle_part",
    "custommerchitem",
    "customciggyitem",
    "custombandageitem",
    "tcgcard",
    "tcgpromobooster",
    "tcgbinder",
    "book",
    "petaccessory",
    "resfooditem",
    "ressideitem",
    "resdessertitem",
    "resdrinkitem",
    "resalcoholitem",
    "gallerygem",
];
let customNameItemsDescriptions = {
    "customfooditem": "(FM) ",
    "customcoffeeitem": "(FM) ",
    "customwateritem": "(FM) ",
    "customjointitem": "(FM) ",
    "custommerchitem": "(FM) ",
    "customciggyitem": "(FM) ",
    "custombandageitem": "(FM) ",
    "book": "(B) ",
    "gallerygem": "(G) ",
};
let customDescriptionItems = [
    "customfooditem",
    "customwateritem",
    "customjointitem",
    "customcoffeeitem",
    "custommerchitem",
    "customciggyitem",
    "custombandageitem",
    "tcgcard",
    "resfooditem",
    "ressideitem",
    "resdessertitem",
    "resdrinkitem",
    "resalcoholitem",
];
let customDescriptionItemsDescriptions = {
    "resfooditem": "Filling, scrumpious, with something special from the restaurant. ",
    "ressideitem": "Makes you feel better. ",
    "resdessertitem": "Sugary boost! ",
    "resdrinkitem": "Thirst quencher. ",
    "resalcoholitem": "Gets you shitfaced. ",
};

const timestampColumns = {
    "animalshotat": "Shot",
    "certExpiry": "Expiry"
}

const foodCatMaps = {
    dairy: 'Dairy helps you feel calmer.',
    grain: 'Grains really fill you up!',
    oil: 'Oils really help with your stress levels.',
    leavening: 'Leavening helps your intellect.',
    protein: 'Protein helps you feel stronger.',
    seasoning: 'Seasoning makes those around you appreciate you more!',
    sugar: 'Sugar helps with your focus.',
    vegetables: 'Vegetables really improve your cardio.',
}

const ignoreMetaKeysInComparison = ["_remove_id", "_hideKeys", "_is_poisoned", "_foodEnhancements", "potency", "interval", "duration", "nonLethal", "quality", "foodEnhancement", "_foodEnhancement"];

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

const isObject = (object) => object != null && typeof object === 'object';
const deepEqual = (object1, object2) => {
    const keys1 = Object.keys(object1);
    const keys2 = Object.keys(object2);
    if (keys1.length !== keys2.length) {
        return false;
    }
    for (const key of keys1) {
        const val1 = object1[key];
        const val2 = object2[key];
        const areObjects = isObject(val1) && isObject(val2);
        if (
            (areObjects && !deepEqual(val1, val2)) ||
            (!areObjects && val1 !== val2)
        ) {
            return false;
        }
    }
    return true;
}

const isMetadataEqual = (obj1, obj2) => {
    const removedKeys = ignoreMetaKeysInComparison.reduce((acc, key) => {
        acc[key] = undefined;
        return acc;
    }, {});

    return deepEqual(
        { ...obj1, ...removedKeys },
        { ...obj2, ...removedKeys }
    );
}

function getInvImage(item, info) {
    let imgSrc = `icons/${item.image}`;
    try {
        if (customImageItems.includes(item._name) && !!info) {
            imgSrc = info._image_url || JSON.parse(info)._image_url || imgSrc;
        }
    } catch (err) { }
    return imgSrc;
}

function fallbackCopyTextToClipboard(text) {
    var textArea = document.createElement('textarea');
    textArea.value = text;

    // Avoid scrolling to bottom
    textArea.style.top = '0';
    textArea.style.left = '0';
    textArea.style.position = 'fixed';

    document.body.appendChild(textArea);
    textArea.focus();
    textArea.select();

    try {
        document.execCommand('copy');
    } catch (err) { }

    document.body.removeChild(textArea);
}

exluded['2578778090'] = true;
exluded['1737195953'] = true;
exluded['1317494643'] = true;
exluded['2508868239'] = true;
exluded['1141786504'] = true;
exluded['2227010557'] = true;
exluded['883325847'] = true;
exluded['4192643659'] = true;
exluded['2460120199'] = true;
exluded['3638508604'] = true;
exluded['4191993645'] = true;
exluded['3713923289'] = true;
exluded['2343591895'] = true;
exluded['2484171525'] = true;
exluded['419712736'] = true;
exluded['-1810795771'] = true;

$(document).ready(function () {
    $('.save-settings').click(() => {
        holdToDrag = $('input[name="enableHoldToDrag"]').prop('checked');
        closeOnClick = $('input[name="enableClickToClose"]').prop('checked');
        ctrlMovesHalf = $('input[name="enableCtrlMovesHalf"]').prop('checked');
        showTooltips = $('input[name="enableShowTooltips"]').prop('checked');
        enableBlur = $('input[name="enableBlur"]').prop('checked');

        //Send post message with new settings
        $.post(
            'https://np-inventory/UpdateSettings',
            JSON.stringify({
                holdToDrag: holdToDrag,
                closeOnClick: closeOnClick,
                ctrlMovesHalf: ctrlMovesHalf,
                showTooltips: showTooltips,
                enableBlur: enableBlur,
            }),
        );
    });

    $(document).keydown((event) => {
        let craft = TargetInventoryName.indexOf('Craft') > -1;

        if (event.keyCode === 67 && (!craft || $('#move-amount').is(':focus'))) {
            try {
                if (_lastInfo) {
                    fallbackCopyTextToClipboard(_lastInfo);
                }
            } catch (err) { }
        }

        //TODO: Get the +generalInventory key?
        if (event.key == 'Escape') {
            closeInv();
        }

        //if (isOverAmount) {
        if (!craft || (craft && isOverAmount) || $('#move-amount').is(':focus')) {
            if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105)) {
                amountEdit += event.key.toString();
                if (parseInt(amountEdit) > 9999) {
                    amountEdit = 9999;
                }
                if (parseInt(amountEdit) < 0) {
                    amountEdit = 0;
                }
                $('#move-amount').val(amountEdit);

                //Update dragged item amount
                if (isDragging && amountEdit) {
                    let actualAmount = Math.min($('#draggedItem > img').data('amount'), amountEdit);
                    $('#draggedItem > .information').html(actualAmount + ' (' + $('#draggedItem > img').data('weight').toFixed(2) + ')');
                }
            } else {
                //Exceptions for shift, ctrl, caps, W/S, and Escape
                if (
                    event.keyCode === 16 ||
                    event.keyCode === 17 ||
                    event.keyCode === 78 ||
                    event.keyCode === 20 ||
                    event.keyCode === 87 ||
                    event.keyCode === 83 ||
                    event.keyCode === 27
                )
                    return;
                amountEdit = '';
                $('#move-amount').val(amountEdit);

                //Reset dragged item amount
                if (isDragging)
                    $('#draggedItem > .information').html(
                        $('#draggedItem > img').data('amount') + ' (' + $('#draggedItem > img').data('weight').toFixed(2) + ')',
                    );
            }
        } else {
            let searchString = $('.craftSearch').val().trim();
            //Input into craft search
            if (!$('.craftSearch').is(':focus')) {
                if (event.keyCode === 8 || event.keyCode === 46) {
                    //Backspace/Delete
                    searchString = searchString.slice(0, -1);
                    $('.craftSearch').val(searchString);
                } else {
                    //Ctrl + Z, Ctrl + Y, Ctrl + A
                    if (event.ctrlKey && event.keyCode === 90) {
                        document.execCommand('undo', false, null);
                    } else if (event.ctrlKey && event.keyCode === 89) {
                        document.execCommand('redo', false, null);
                    } else if (event.ctrlKey && event.keyCode === 65) {
                        $('.craftSearch').focus();
                        $('.craftSearch').select();
                    } else if (event.key.length === 1) {
                        //Add to search string
                        searchString += event.key;
                        $('.craftSearch').val(searchString);
                    }
                }
            }
            $('.craftSearch').trigger('change');
        }
        //}
    });

    $(document).on('change', '.craftSearch', () => {
        let searchString = $('.craftSearch').val().trim().toLowerCase().replace(' ', '');
        $('.craftContainer').each((index, value) => {
            let found = false;
            //Check display name
            if ($(value).find('.itemname').text().trim().toLowerCase().replace(' ', '').includes(searchString)) found = true;

            //Check requirements
            if ($(value).find('.requirementName').text().trim().toLowerCase().replace(' ', '').includes(searchString)) found = true;

            if (found) {
                $(value).show();
            } else {
                $(value).hide();
            }
        });
    });

    $('#move-amount').mouseenter(() => {
        isOverAmount = true;
    });

    $('#move-amount').mouseleave(() => {
        isOverAmount = false;
        amountEdit = '';
    });

    $(document).on('wheel', (event) => {
        if (isOverAmount) {
            let amountValue = $('#move-amount').val();
            if (event.originalEvent.deltaY < 0) {
                amountValue++;
                if (amountValue > 9999) amountValue = 9999;
            } else {
                amountValue--;
                if (amountValue < 0) amountValue = 0;
            }
            amountEdit = amountValue;
            $('#move-amount').val(amountEdit);

            if (isDragging && amountEdit) {
                let actualAmount = Math.min($('#draggedItem > img').data('amount'), amountEdit);
                $('#draggedItem > .information').html(actualAmount + ' (' + $('#draggedItem > img').data('weight').toFixed(2) + ')');
            } else if (!amountEdit) {
                amountEdit = '';
                $('#move-amount').val(amountEdit);

                //Reset dragged item amount
                if (isDragging)
                    $('#draggedItem > .information').html(
                        $('#draggedItem > img').data('amount') + ' (' + $('#draggedItem > img').data('weight').toFixed(2) + ')',
                    );
            }
        }
    });

    $(document).mousemove((event) => {
        if (isDragging) {
            /* Move element with the mouse so it looks like we drag it.. */
            let ele = document.getElementById('draggedItem');
            ele.style.left = event.clientX - (ele.offsetWidth / 2) + 'px';
            ele.style.top = event.clientY - (ele.offsetHeight / 2) + 'px';
        }
    });

    window.addEventListener('message', function (event) {
        let item = event.data;
        // Trigger adding a new message to the log and create its display
        if (item.response == 'openGui') {
            dateNow = Date.now();
            $('#UseBar').fadeOut(100);
            document.getElementById('wrapmain').innerHTML = '';
            document.getElementById('wrapsecondary').innerHTML = '';
            $('#app').fadeIn();
            $('#containers-wrapper').css({ display: "flex" }).slideDown(400).style;
            // $(".wrapsecondary").css({ height: "93%" });
        } else if (item.response == 'closeGui') {
            $('#app').fadeOut(100);
            $('#containers-wrapper').fadeOut(10);
            if (isDragging) EndDrag(draggingid);
        } else if (item.response == 'updateQuality') {
            UpdateQuality(item);
        } else if (item.response == 'Populate') {
            DisplayInventoryMultiple(
                item.playerinventory,
                item.itemCount,
                item.invName,
                item.targetinventory,
                item.targetitemCount,
                item.targetinvName,
                item.cash,
                item.StoreOwner,
                item.targetInvWeight,
                item.targetInvSlots
            );
        } else if (item.response == 'PopulateSingle') {
            personalWeight = 0;
            MyInventory = item.playerinventory;
            MyItemCount = item.itemCount;
            DisplayInventory(item.playerinventory, item.itemCount, item.invName, true);
            UpdateSetWeights(item.invName);
        } else if (item.response == 'cashUpdate') {
            userCash = item.amount;
            userWeaponLicense = item.weaponlicence;
            brought = item.brought;
            isCop = item.cop;
        } else if (item.response == 'DisableMouse') {
            clicking = false;
            EndDrag(slotusing);
            EndDrag(draggingid);
            isDragging = false;
            draggingid = 'none';
            document.getElementById('draggedItem').style.opacity = '0.0';
            document.getElementById('draggedItem').innerHTML = '';
        } else if (item.response == 'EnableMouse') {
            clicking = true;
        } else if (item.response == 'DisplayBar') {
            ToggleBar(item.toggle, item.boundItems, item.boundItemsAmmo);
        } else if (item.response == 'UseBar') {
            UseBar(item.itemid, item.text, item.amount);
        } else if (item.response == 'SendItemList') {
            itemList = item.list;
        } else if (item.response == 'GiveItemChecks') {
            if (itemList[item.id]) {
                $.post(
                    'https://np-inventory/GiveItem',
                    JSON.stringify([
                        item.id,
                        item.amount,
                        item.generateInformation,
                        true,
                        itemList[item.id].nonStack,
                        item.data,
                        item.returnData,
                    ]),
                );
            } else {
                $.post(
                    'https://np-inventory/GiveItem',
                    JSON.stringify([
                        item.id,
                        item.amount,
                        item.generateInformation,
                        false,
                        itemList[item.id].nonStack,
                        item.data,
                        item.returnData,
                    ]),
                );
            }
        } else if (item.response === 'UpdateSettings') {
            holdToDrag = item.holdToDrag;
            closeOnClick = item.closeOnClick;
            ctrlMovesHalf = item.ctrlMovesHalf;
            showTooltips = item.showTooltips;
            enableBlur = item.enableBlur;

            $('input[name="enableHoldToDrag"]').prop('checked', holdToDrag);
            $('input[name="enableClickToClose"]').prop('checked', closeOnClick);
            $('input[name="enableCtrlMovesHalf"]').prop('checked', ctrlMovesHalf);
            $('input[name="enableShowTooltips"]').prop('checked', showTooltips);
            $('input[name="enableBlur"]').prop('checked', enableBlur);
        } else if (item.response === 'playerWeight') {
            personalMaxWeight = parseFloat(item.personalMaxWeight)
        }
    });
});

let usedBar = 0;

function UpdateQuality(data, penis) {
    let inventory = data.inventory;

    let divslot = 'secondaryslot' + data.slot;
    if (inventory.startsWith('ply-')) {
        divslot = 'playerslot' + data.slot;
    }

    if (!document.getElementById(divslot)) return;

    let item = document.getElementById(divslot).getElementsByTagName('img')[0];

    if (!item) return;

    let weight = parseInt(item.dataset.weight);

    let name = item.dataset.name;
    let itemcount = parseInt(item.dataset.amount);
    let itemid = item.dataset.itemid;
    let image = getInvImage(itemList[itemid], item.dataset.info);
    let inventoryNumber = parseInt(item.dataset.inventory);
    let info = JSON.parse(unescape(item.dataset.info));
    let creationDate = parseInt(item.dataset.creationDate);

    let quality = ConvertQuality(itemid, data.creationDate);

    if (quality == undefined) {
        quality = 100;
    }

    if (penis != undefined) {
        quality = penis;
    }

    if (quality < 0) {
        quality = 0;
    }

    let itemMaxed = "class='itemQuality";

    if (quality > 95) {
        itemMaxed += " near-full'";
    } else {
        itemMaxed += "'";
    }

    if (quality == 100) {
        itemMaxed = "class='perfect'";
    }

    let qualityText = quality;
    let qualityHeight = quality;

    if (quality == 0) {
        qualityText = 'Destroyed';
        qualityHeight = 100;
        itemMaxed = "class='destroyed'";
    } else if (quality < 5) {
        qualityText = 'Almost Destroyed';
        qualityHeight = 100;
        itemMaxed = "class='destroyed'";
    } else if (quality < 10) {
        qualityText = 'Falling Apart';
        qualityHeight = 100;
        itemMaxed = "class='destroyed'";
    }

    info = JSON.stringify(info);

    let meta = item.dataset.metainformation;
    let item_cost = item.dataset.fwewef;
    let slot = item.dataset.currentslot;

    let stackable = item.dataset.stackable;
    let inventoryName = inventory;

    try {
        if (meta.indexOf('{}') === 0) {
            meta = meta.substring(2).trim();
        }
    } catch (e) { }

    let htmlstring =
        '<div ' +
        itemMaxed +
        " style='width:" +
        qualityHeight +
        '%; background-size: 1px ' +
        qualityHeight +
        "px;'></div> <div class='itemname'> " +
        name +
        " </div> <div class='information'>  " +
        "<span class='item-qty'>" + itemcount + "x</span> <span class='item-weight'>" + weight.toFixed(2) + "</span> </div>"
        +
        `<img src='${image}` +
        "' data-info='" +
        escape(info) +
        "' data-inventory='" +
        inventoryNumber +
        "' data-quality='" +
        quality +
        "' data-name='" +
        name +
        "' data-metainformation='" +
        meta +
        "' data-itemid='" +
        itemid +
        "' data-fwewef='" +
        item_cost +
        "' data-inventory='" +
        inventoryNumber +
        "' data-currentslot='" +
        slot +
        "' data-stackable='" +
        stackable +
        "' data-amount='" +
        itemcount +
        "' data-weight='" +
        weight +
        "' data-inventoryname='" +
        inventoryName +
        "' class='itemimage' draggable='false'>";

    document.getElementById(divslot).innerHTML = htmlstring;
}

function RandomGen(length) {
    var result = '';
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

let fadeOut = 0;

function UseBar(itemid, text, amount) {
    if (amount == undefined) {
        amount = 1;
    }

    let image = '';
    let name = '';
    let htmlstring = '';
    let id = RandomGen(10);
    fadeOut = id;
    image = getInvImage(itemList[itemid]);
    name = itemList[itemid].displayname;
    htmlstring =
        " <div class='item3' > <div class='UseBarHead'> " +
        text +
        ' ' +
        amount +
        "x  </div> <div class='itemname2'> " +
        name +
        ` </div> <img src='${image}` +
        "' class='itemimage'>  </div>";

    var p = document.getElementById('UseBar');
    var newElement = document.createElement(id);
    newElement.setAttribute('id', id);
    newElement.innerHTML = htmlstring;
    p.prepend(newElement);

    $('#UseBar').css({ display: "flex" }).fadeIn(1000);

    setTimeout(() => {
        $(newElement).fadeOut(500);
    }, 2500);

    setTimeout(() => {
        if (fadeOut == id) {
            $('#UseBar').fadeOut(350);
        }
        var element = document.getElementById(id);
        element.parentNode.removeChild(element);
    }, 3000);
}

function ToggleBar(toggle, boundItems, boundItemsAmmo) {
    if (toggle) {
        document.getElementById('ActionBar').innerHTML = '';

        let image = '';
        let name = '';
        let htmlstring = '';

        if (boundItems[1]) {
            image = itemList[boundItems[1]].image;
            name = itemList[boundItems[1]].displayname;

            if (boundItemsAmmo[1]) {
                name = name + ' - (' + boundItemsAmmo[1] + ')';
            }

            htmlstring =
                "<div class='item3'>" + "<div class='quickbind' id='bind1'>1</div>" + "<div class='itemname3'> " +
                name +
                " </div> <img src='icons/" +
                image +
                "' class='itemimage'>  </div>";
        } else {
            htmlstring =
                "<div class='item3' ><div class='quickbind' id='bind1'> 1 </div><div class='itemname3'> unbound </div> <img src='icons/empty.png' class='itemimage'>  </div>";
        }

        for (let i = 2; i < 5; i++) {
            if (boundItems[i]) {
                image = itemList[boundItems[i]].image;
                name = itemList[boundItems[i]].displayname;

                if (boundItemsAmmo[i]) {
                    name = name + ' - (' + boundItemsAmmo[i] + ')';
                }

                htmlstring =
                    htmlstring +
                    "<div class='item3' >" + "<div class='quickbind' id='bind" + i + "'> " + i + " </div>" + "<div class='itemname3'> " +
                    name +
                    " </div> <img src='icons/" +
                    image +
                    "' class='itemimage'>  </div>";
            } else {
                htmlstring =
                    htmlstring +
                    "<div class='item3' >" + "<div class='quickbind' id='bind" + i + "'>" + i + "</div> " + "<div class='itemname3'> unbound </div> <img src='icons/empty.png' class='itemimage'>  </div>";
            }
        }
        document.getElementById('ActionBar').innerHTML = htmlstring;

        $('#ActionBar').css({ display: "flex" }).fadeIn(500);
    } else {
        $('#ActionBar').fadeOut(2000);
    }
}

document.onkeyup = function (data) {
    if (data.key == 'Escape') {
        closeInv();
    }
};

function invStack(
    targetSlot,
    moveAmount,
    targetInventory,
    originSlot,
    originInventory,
    purchase,
    itemCosts,
    itemidsent,
    metainformation,
    amountmoving,
    crafting,
    weapon,
    amountRemaining,
) {
    let arr = [
        targetSlot,
        moveAmount,
        targetInventory,
        originSlot,
        originInventory,
        purchase,
        itemCosts,
        itemidsent,
        metainformation,
        amountmoving,
        crafting,
        weapon,
        PlayerStore,
        amountRemaining,
    ];
    $.post('https://np-inventory/stack', JSON.stringify(arr));
}

function invMove(
    targetSlot,
    originSlot,
    targetInventory,
    originInventory,
    purchase,
    itemCosts,
    itemidsent,
    metainformation,
    amountmoving,
    crafting,
    weapon,
) {
    let arr = [
        targetSlot,
        originSlot,
        targetInventory,
        originInventory,
        purchase,
        itemCosts,
        itemidsent,
        metainformation,
        amountmoving,
        crafting,
        weapon,
        PlayerStore,
    ];
    $.post('https://np-inventory/move', JSON.stringify(arr));
}

function invSwap(targetSlot, targetInventory, originSlot, originInventory, itemid1, metainformation1, itemid2, metainformation2) {
    let arr = [targetSlot, targetInventory, originSlot, originInventory, itemid1, metainformation1, itemid2, metainformation2];
    $.post('https://np-inventory/swap', JSON.stringify(arr));
}

function removeCraftItems(itemid, moveAmount, CraftArrayID) {
    let arr = itemList[itemid].craft[CraftArrayID];
    let amount = moveAmount;
    $.post('https://np-inventory/removeCraftItems', JSON.stringify([arr, amount]));
}

function CreateEmptyPersonalSlot(slotLimit) {
    //Clear player slots
    $('#wrapmain').html('');
    for (i = 1; i < slotLimit + 1; i++) {
        let htmlstring = "<div id='playerslot" + i + "' class='item'></div>";

        if (bindSlots.includes(i)) {
            htmlstring = "<div id='playerslot" + i + "' class='item'><div id='bind" + i + "'>" + i + "</div></div>";
        }

        document.getElementById('wrapmain').innerHTML += htmlstring;
    }
}

function CreateEmptySecondarySlot(slotLimit) {
    let classColorName = 'default';

    if (TargetInventoryName.indexOf('Craft') > -1) {
        $('#wrapsecondary').addClass('craftGrid');
        return;
    }

    if ($('#wrapsecondary').hasClass('craftGrid')) $('#wrapsecondary').removeClass('craftGrid');

    if (TargetInventoryName.indexOf('Glovebox') > -1) {
        classColorName = 'lblue';
    } else if (TargetInventoryName.indexOf('Trunk') > -1) {
        classColorName = 'lblue';
    } else if (TargetInventoryName.indexOf('hidden') > -1) {
        classColorName = 'green';
    } else if (TargetInventoryName.indexOf('Drop') > -1) {
        classColorName = 'red';
    }
    for (i = 1; i < slotLimit + 1; i++) {
        let htmlstring = "<div id='secondaryslot" + i + "' class='item " + classColorName + "' > </div>";
        document.getElementById('wrapsecondary').innerHTML += htmlstring;
    }
}

function isEmpty(obj) {
    for (let key in obj) {
        if (obj.hasOwnProperty(key)) return false;
    }
    return true;
}

function InventoryLog(string) {
    document.getElementById('Logs').innerHTML = string + '<br>' + document.getElementById('Logs').innerHTML;
}

let PlayerInventoryName = 'none';
let TargetInventoryName = 'none';
let shop = 'Shop';
let craft = 'Craft';
let slotLimitTarget = 500000000000000;
let MyInventory = {};
let MyItemCount = 0;
let StoreOwner = false;
let PlayerStore = false;
// weights are done here, based on the string of the inventory name
function DisplayInventoryMultiple(playerinventory, itemCount, invName, targetinventory, targetitemCount, targetinvName, cash, Owner, targetInvWeight = 0, targetInvSlots = 40) {
    secondaryWeight = 0;
    StoreOwner = Owner;
    PlayerStore = false;
    userCash = parseInt(cash);
    DisplayInventory(playerinventory, itemCount, invName, true);
    MyInventory = playerinventory;
    MyItemCount = itemCount;


    let displayName = 'Storage';

    if (targetinvName.indexOf('Drop') > -1) {
        secondaryMaxWeight = 1000.0;
        slotLimitTarget = 30;
        displayName = 'Ground';
    } else if (targetinvName.indexOf('PlayerStore') > -1) {
        secondaryMaxWeight = 1000.0;
        slotLimitTarget = 2;
        PlayerStore = true;
        displayName = 'Player Store';
    } else if (targetinvName.indexOf('storage') > -1) {
        secondaryMaxWeight = 2000.0;
        slotLimitTarget = 200;
    } else if (targetinvName.indexOf('office') > -1) {
        secondaryMaxWeight = 100.0;
        slotLimitTarget = 5;
    } else if (targetinvName.indexOf('housing') > -1) {
        secondaryMaxWeight = 1200.0;
        slotLimitTarget = 40;
    } else if (targetinvName.indexOf('warehouse') > -1) {
        secondaryMaxWeight = 6500.0;
        slotLimitTarget = 1000;
    } else if (targetinvName.indexOf('motel-1') > -1) {
        secondaryMaxWeight = 300.0;
        slotLimitTarget = 30;
    } else if (targetinvName.indexOf('motel-2') > -1) {
        secondaryMaxWeight = 600.0;
        slotLimitTarget = 50;
    } else if (targetinvName.indexOf('motel-3') > -1) {
        secondaryMaxWeight = 1000.0;
        slotLimitTarget = 90;
    } else if (targetinvName.indexOf('Glovebox') > -1) {
        secondaryMaxWeight = 50.0;
        slotLimitTarget = 5;
        displayName = 'Glovebox';
    } else if (targetinvName.indexOf('Trunk') > -1) {
        secondaryMaxWeight = 650.0;
        slotLimitTarget = 65;
        displayName = 'Trunk';
    } else if (targetinvName.indexOf('Craft') > -1) {
        slotLimitTarget = 100;
        displayName = 'Crafting';
    } else if (targetinvName.indexOf('hidden') > -1) {
        secondaryMaxWeight = 2000.0;
        slotLimitTarget = 200;
        displayName = 'Stash';
        if (targetinvName.indexOf('Apartments') > -1) {
            secondaryMaxWeight = 1000.0;
            slotLimitTarget = 30;
            displayName = 'Apartment Floor';
        }
    } else if (targetinvName.indexOf('evidence') > -1) {
        secondaryMaxWeight = 12000.0;
        slotLimitTarget = 400;
        displayName = 'Evidence';
    } else if (targetinvName.indexOf('Case') > -1) {
        secondaryMaxWeight = 4000.0;
        slotLimitTarget = 400;
        displayName = 'Case: ' + targetinvName;
    } else if (targetinvName.indexOf('docks') > -1) {
        secondaryMaxWeight = 20000.0;
        slotLimitTarget = 2000;
    } else if (targetinvName.indexOf('trash') > -1) {
        secondaryMaxWeight = 12000.0;
        slotLimitTarget = 400;
        displayName = 'Trash';
    } else if (targetinvName.indexOf('personal') > -1) {
        secondaryMaxWeight = 250.0;
        slotLimitTarget = 5;
    } else if (targetinvName.indexOf('Stolen-Goods') > -1) {
        secondaryMaxWeight = 1000.0;
        slotLimitTarget = 5;
    } else if (targetinvName.indexOf('bizlarge') === 0) {
        secondaryMaxWeight = 5000.0;
        slotLimitTarget = 800;
    } else if (targetinvName.indexOf('biz') === 0) {
        secondaryMaxWeight = 2000.0;
        slotLimitTarget = 400;
    } else if (targetinvName.indexOf('Shop') > -1) {
        displayName = 'Shop';
        secondaryMaxWeight = 2000.0;
        slotLimitTarget = 40;
    } else if (targetinvName.startsWith('ply')) {
        secondaryMaxWeight = 250.0;
        slotLimitTarget = 40;
        displayName = 'Other Player';
    } else if (targetinvName.indexOf('rifle-rack') > -1) {
        secondaryMaxWeight = 250.0;
        slotLimitTarget = 10;
        displayName = 'Locked Compartment';
    } else if (targetinvName.indexOf('fisher-bucket-') > -1) {
        secondaryMaxWeight = 99.0;
        slotLimitTarget = 99;
        displayName = 'Fisher Bucket';
    } else if (targetinvName.indexOf('burgerjob_shelf') > -1 || targetinvName.startsWith('restaurants_shelf')) {
        secondaryMaxWeight = 300.0;
        slotLimitTarget = 40;
        displayName = 'Food Shelf'
    } else if (targetinvName.indexOf('trays') > -1 || targetinvName.indexOf('burgerjob_window') > -1) {
        secondaryMaxWeight = 110.0;
        slotLimitTarget = 10;

        // Figure out display name from targetinvName
        const splitName = targetinvName.split("-");
        displayName = splitName[1];

        if (targetinvName.indexOf('burgerjob_window') > -1) {
            displayName = "Window Tray"
        }

    } else if (targetinvName.startsWith('paynless-') || targetinvName.startsWith('rr_hotel-') || targetinvName.startsWith('casino_hotel-')) {
        slotLimitTarget = 40;
        displayName = 'Storage Container'
        const splitName = targetinvName.split("-");
        if (splitName[2] && typeof parseInt(splitName[2]) === "number") {
            secondaryMaxWeight = parseInt(splitName[2]);
        }
    } else if (targetinvName.indexOf('burgerjob_fridge') > -1) {
        secondaryMaxWeight = 1000.0;
        slotLimitTarget = 100;
        displayName = 'Ingredient Storage';
    } else if (targetinvName.indexOf('gallery_gemtrade') > -1) {
        secondaryMaxWeight = 10.0;
        slotLimitTarget = 10;
        displayName = 'Gem Table';
    } else if (targetinvName.indexOf('casino bag') > -1) {
        secondaryMaxWeight = 10.0;
        slotLimitTarget = 10;
        displayName = 'Casino Bag';
    } else if (targetinvName.startsWith('container')) {
        let invname = targetinvName.split("-");
        displayName = invname[2];
    } else if (targetinvName.startsWith('RR_Tavern_Storage')) {
        secondaryMaxWeight = 1000.0;
        slotLimitTarget = 100;
        displayName = 'Ingredient Storage';
    } else if (targetinvName.startsWith('digital_den_counter')) {
        secondaryMaxWeight = 350.0;
        slotLimitTarget = 10;
        displayName = 'Counter';
    } else if (targetinvName.startsWith('business:counter:')) {
        secondaryMaxWeight = 350.0;
        slotLimitTarget = 20;
        displayName = 'Counter';
    } else if (targetinvName.startsWith('farmersmarket_inventory_')) {
        secondaryMaxWeight = 1000.0;
        slotLimitTarget = 50;
        displayName = 'Booth';
    } else if (targetinvName.startsWith('tcg_truck_tailgate_')) {
        secondaryMaxWeight = 500.0;
        slotLimitTarget = 5;
        displayName = 'Tailgate';
    } else if (targetinvName.startsWith('comic_shop_appraisal_')) {
        secondaryMaxWeight = 10.0;
        slotLimitTarget = 50;
        displayName = 'Appraisal Counter';
    } else if (targetinvName.startsWith('mayor_stash')) {
        secondaryMaxWeight = 1000.0;
        slotLimitTarget = 50;
        displayName = 'Mayor Stash';
    } else if (targetinvName.startsWith('display-case-')) {
        secondaryMaxWeight = 10.0;
        slotLimitTarget = 5;
        displayName = 'Display Case';
    } else if (targetinvName.startsWith('mobile-stash-small_')) {
        secondaryMaxWeight = 100.0;
        slotLimitTarget = 5;
        displayName = 'Small Mobile Stash';
    } else if (targetinvName.startsWith('mobile-stash-medium_')) {
        secondaryMaxWeight = 250.0;
        slotLimitTarget = 7;
        displayName = 'Medium Mobile Stash';
    } else if (targetinvName.startsWith('mobile-stash-big_')) {
        secondaryMaxWeight = 500.0;
        slotLimitTarget = 10;
        displayName = 'Big Mobile Stash';
    } else if (targetinvName.startsWith('mobile-stash-canister_')) {
        secondaryMaxWeight = 100.0;
        slotLimitTarget = 1;
        displayName = 'Canister';
    } else if (targetinvName.indexOf('prison:stash') > -1) {
        displayName = 'Stash';
        secondaryMaxWeight = 250.0;
    } else if (targetinvName === 'gooddropoff') {
        displayName = 'Dropoff'
        secondaryMaxWeight = 500.0;
        slotLimitTarget = 100;
    } else if (targetinvName === 'scrapyardscrap') {
        displayName = 'Scrapyard'
        secondaryMaxWeight = 500.0;
        slotLimitTarget = 20;
    } else if (targetinvName.startsWith('mobile-stash-containersmall_')) {
        secondaryMaxWeight = 500.0;
        slotLimitTarget = 50;
        displayName = 'Small Mobile Container';
    } else if (targetinvName.startsWith('mobile-stash-containermedium_')) {
        secondaryMaxWeight = 750.0;
        slotLimitTarget = 50;
        displayName = 'Medium Mobile Container';
    } else if (targetinvName.startsWith('mobile-stash-containerbig_')) {
        secondaryMaxWeight = 1000.0;
        slotLimitTarget = 50;
        displayName = 'Big Mobile Container';
    } else if (targetinvName.startsWith('mobile-stash-bodybag_')) {
        secondaryMaxWeight = 100.0;
        slotLimitTarget = 10;
        displayName = 'Bodybag';
    } else if (targetinvName.startsWith('mobile-stash-fridge_')) {
        secondaryMaxWeight = 10.0;
        slotLimitTarget = 5;
        displayName = 'Fridge';
    } else if (targetinvName.startsWith('mailbox')) {
        secondaryMaxWeight = 300.0;
        slotLimitTarget = 30;
        displayName = 'Mailbox';
    } else if (targetinvName.startsWith('mailtemp')) {
        secondaryMaxWeight = 110.0;
        slotLimitTarget = 5;
        displayName = 'Mailbox';
    } else {
        secondaryMaxWeight = 250.0;
        slotLimitTarget = 40;
    }

    if (targetInvWeight != 0) secondaryMaxWeight = targetInvWeight;
    if (targetInvSlots != 40) slotLimitTarget = targetInvSlots;

    //InventoryLog(targetinvName + " | " + invName)
    DisplayInventory(targetinventory, targetitemCount, targetinvName, false);
    UpdateSetWeights(displayName);
}

function BuildDrop(brokenSlots) {
    $.post(
        'https://np-inventory/dropIncorrectItems',
        JSON.stringify({
            slots: brokenSlots,
        }),
    );
}

// THIS IS A SHIT COPY PASTE JUST TIO UPDATE BECAUSE I COULDNT BE BOTHERED ADDING A VARIABLE TO LIKE 2 EVENTS :)

// NOPIXEL BTW

function produceInfo(data) {
    let string = '';
    let info = JSON.parse(data.replace(/"{/g, `{`).replace(/}"/g, `}`));

    for (let [key, value] of Object.entries(info)) {
        if (typeof value != 'object') {
            string = string + key + ': ' + value + ' | ';
        }
    }

    return string.replace(/[ | ](?=[^|]*$)/, '');
}

function DisplayInventory(sqlInventory, itemCount, invName, main) {
    clicking = false;
    sqlInventory = JSON.parse(sqlInventory);
    let maxWeight = 250;
    let slotLimit = 40;

    let inventory = {};
    itemCount = parseInt(itemCount);
    //document.getElementById('wrapsecondary').innerHTML += sqlInventory[1].name;
    // this shows inventory name

    if (main) {
        personalWeight = 0;
        PlayerInventoryName = invName;
        CreateEmptyPersonalSlot(slotLimit);
    } else {
        TargetInventoryName = invName;
        CreateEmptySecondarySlot(slotLimitTarget);
        slotLimit = slotLimitTarget;
    }
    let slot = 0;

    //InventoryLog(invName + " is Loading.")

    let inventoryNumber = 1;

    if (!main) {
        inventoryNumber = 2;
    }

    let failure = false;
    let fixSlots = {};
    for (let i = 0; i < itemCount; i++) {
        slot = sqlInventory[i].slot;
        if (isEmpty(inventory[slot])) {
            // do something

            inventory[slot] = {};
            inventory[slot].slot = slot;
            inventory[slot].itemid = sqlInventory[i].item_id;
            inventory[slot].itemcount = sqlInventory[i].amount;
            inventory[slot].inventoryName = sqlInventory[i].name;
            inventory[slot].information = sqlInventory[i].information;
            inventory[slot].creationDate = sqlInventory[i].creationDate;
            inventory[slot].quality = sqlInventory[i].quality;
        } else {
            if (sqlInventory[i].item_id != inventory[slot].itemid) {
                if (!fixSlots[invName]) fixSlots[invName] = [];
                failure = true;
                fixSlots[invName].push({
                    faultySlot: slot,
                    faultyItem: sqlInventory[i].item_id,
                });
            } else {
                inventory[slot].itemcount = inventory[slot].itemcount + 1;
            }
        }
    }

    if (failure) {
        BuildDrop(fixSlots);
        closeInv();
    }

    let inventoryName = invName;

    if (itemCount != 0) {
        inventoryName = ' Error grabbing item names.';
    }

    for (i = 0; i < slotLimit + 1; i++) {
        if (isEmpty(inventory[i])) {
        } else {
            let slot = inventory[i].slot;

            let itemid = '' + inventory[i].itemid + '';
            if (itemList[itemid] !== undefined) {
                let itemcount = inventory[i].itemcount;

                inventoryName = inventory[slot].inventoryName;

                let weight = parseFloat(itemList[itemid].weight);
                let item_cost = itemList[itemid].priceWithTax;

                let stackable = !itemList[itemid].nonStack;
                let image = getInvImage(itemList[itemid], inventory[i].information);
                let name = itemList[itemid].displayname;

                let meta = inventory[i].information;
                let creationDate = inventory[i].creationDate;

                let info = meta;

                if (meta == undefined) {
                    meta = '';
                }

                try {
                    const obj = JSON.parse(meta);
                    if (obj.hideInfo) {
                        meta = '';
                    }
                } catch (err) { }

                let keysToFilter = [];
                try {
                    const obj = JSON.parse(meta);
                    if (obj._hideKeys) {
                        keysToFilter = obj._hideKeys;
                    }
                    if (obj._hideAllKeys) {
                        keysToFilter = Object.keys(obj);
                    }
                } catch (err) { }

                try {
                    const obj = JSON.parse(meta);
                    const keys = Object.keys(obj);
                    const newMeta = keys.filter((k) => k !== '_hideKeys' && !keysToFilter.includes(k) && obj[k] !== null && typeof obj[k] !== 'undefined')
                        .map((k) => {
                            if (timestampColumns[k]) {
                                return `${timestampColumns[k]}: ${calculateTimeDiff(obj[k])}`
                            }
                            return `${k}: ${obj[k].toString().replace(/'|"/g, '')}`
                        });
                    meta = newMeta.join(' | ');
                } catch (err) {
                    console.log(err)
                }

                let quality = inventory[i].quality;
                if (itemList[itemid].information) {
                    meta = meta ? meta + '<br><br>' + itemList[itemid].information : itemList[itemid].information;
                }
                if (itemList[itemid].foodCategory) {
                    meta = `${meta}<br><br>Food categories: ${[...itemList[itemid].foodCategory].map(f => capitalizeFirstLetter(f)).join(', ')}`;
                    itemList[itemid].foodCategory.forEach((cat) => {
                        meta = `${meta}<br>${foodCatMaps[cat]}`;
                    });
                }

                let stackString = '(nS)';
                //if (nonStack) {
                //    nonStack = false;
                //} else {
                //    nonStack = true;
                //    stackString = '(S)';
                //}

                if (quality == undefined) {
                    quality = 100;
                }

                let qualityText = quality;
                let qualityWidth = quality;

                let itemMaxed = "class='itemQuality";

                if (quality > 95) {
                    itemMaxed += " near-full'";
                } else {
                    itemMaxed += "'";
                }

                if (quality == 100) {
                    itemMaxed = "class='perfect'";
                }

                if (quality == 0) {
                    qualityText = 'Destroyed';
                    qualityWidth = 100;
                    itemMaxed = "class='destroyed'";
                } else if (quality < 5) {
                    qualityText = 'Almost Destroyed';
                    qualityWidth = 100;
                    itemMaxed = "class='destroyed'";
                } else if (quality < 10) {
                    qualityText = 'Falling Apart';
                    qualityWidth = 100;
                    itemMaxed = "class='destroyed'";
                }
                try {
                    if (meta.indexOf('{}') === 0) {
                        meta = meta.substring(2).trim();
                    }
                } catch (e) { }
                let htmlstring =
                    '<div ' +
                    itemMaxed +
                    " style='width:" +
                    qualityWidth +
                    '%; background-position: 0% ' +
                    (100 - Number(qualityWidth)) +
                    "%;'></div> <div class='itemname'> " +
                    name +
                    " </div> <div class='information'>  " +
                    "<span class='item-qty'>" + itemcount + "x</span> <span class='item-weight'>" + weight.toFixed(2) + "</span></div>"
                    + `<img src='${image}` +
                    "' data-inventory='" +
                    inventoryNumber +
                    "' data-quality='" +
                    quality +
                    "' data-creationDate='" +
                    creationDate +
                    "' data-name='" +
                    name +
                    "' data-info='" +
                    escape(info) +
                    "' data-metainformation='" +
                    meta +
                    "' data-itemid='" +
                    itemid +
                    "' data-fwewef='" +
                    item_cost +
                    "' data-inventory='1' data-currentslot='" +
                    slot +
                    "' data-stackable='" +
                    stackable +
                    "' data-amount='" +
                    itemcount +
                    "' data-weight='" +
                    weight +
                    "' data-inventoryname='" +
                    inventoryName +
                    "' class='itemimage' draggable='false'>";

                if (bindSlots.includes(parseInt(slot)) && inventoryName.includes("ply-")) {
                    htmlstring += "<div id='bind" + slot + "'>" + slot + "</div>";
                }

                if (TargetInventoryName == 'Shop' && !main) {
                    /*if (sqlInventory[i - 1].amount === undefined) {
                        itemcount = 10;
                    } else {
                        itemcount = sqlInventory[i - 1].amount;
                    }*/

                    //Quick fix for joint shop, we lazy
                    if (itemid !== "joint") itemcount = 9999;

                    htmlstring =
                        "<div class='itemname itemnameShop'> " +
                        name +
                        " </div> <div class='information shopInformation'>  " +
                        "<span class='item-qty'>" + (!stackable ? '1' : '') + " </span> <span class='item-weight'>" + weight.toFixed(2) + "</span> </div>"
                        + `</div> <img src='${image}` +
                        "' data-inventory='" +
                        inventoryNumber +
                        "' data-creationDate='" +
                        creationDate +
                        "' data-quality='" +
                        quality +
                        "' data-name='" +
                        name +
                        "' data-info='" +
                        escape(info) +
                        "' data-metainformation='" +
                        meta +
                        "' data-fwewef='" +
                        item_cost +
                        "' data-itemid='" +
                        itemid +
                        "' data-inventory='2' data-currentslot='" +
                        slot +
                        "' data-stackable='" +
                        stackable +
                        "' data-amount='" +
                        itemcount +
                        "' data-weight='" +
                        weight +
                        "' data-inventoryname='" +
                        inventoryName +
                        "' class='itemimage smaller' draggable='false'><div class='itemcost'><span class='money'> $" +
                        Number(item_cost).toLocaleString('en') +
                        '</span></div>';
                }

                if (!StoreOwner && PlayerStore && !main) {
                    htmlstring =
                        "<div class='itemQuality' " +
                        itemMaxed +
                        " style='width:" +
                        qualityWidth +
                        '%; background-position: 0% ' +
                        (100 - Number(qualityWidth)) +
                        "%;'></div> <div class='itemname'> " +
                        name +
                        ' - $' +
                        item_cost +
                        " </div> <div class='information'>  " +
                        itemcount +
                        ' (' +
                        weight.toFixed(2) +
                        `) </div>          <img src='${image}` +
                        "' data-inventory='" +
                        inventoryNumber +
                        "' data-creationDate='" +
                        creationDate +
                        "' data-quality='" +
                        quality +
                        "' data-name='" +
                        name +
                        "' data-info='" +
                        escape(info) +
                        "' data-metainformation='" +
                        meta +
                        "' data-fwewef='" +
                        item_cost +
                        "' data-itemid='" +
                        itemid +
                        "' data-inventory='2' data-currentslot='" +
                        slot +
                        "' data-stackable='" +
                        stackable +
                        "' data-amount='" +
                        itemcount +
                        "' data-weight='" +
                        weight +
                        "' data-inventoryname='" +
                        inventoryName +
                        "' class='itemimage' draggable='false'>";
                }

                if (TargetInventoryName.indexOf('Craft') > -1 && !main) {
                    if (sqlInventory[i - 1] === undefined || sqlInventory[i - 1].amount === undefined) {
                        itemcount = 1;
                    } else {
                        itemcount = sqlInventory[i - 1].amount;
                    }

                    let requirementHtml = '<b>None</b>';
                    if (itemList[itemid].craft !== undefined && invName.indexOf('Craft') > -1) {
                        requirementHtml = '';
                        let requirementsArray = itemList[itemid].craft;
                        let ArrayCount = 0
                        for (let ArrayX = 0; ArrayX < requirementsArray.length; ArrayX++) {
                            ArrayCount++
                            let requirements = requirementsArray[ArrayX]

                            for (let xx = 0; xx < requirements.length; xx++) {
                                let requirementName = itemList[requirements[xx].itemid].displayname;
                                let requiredClasses = 'requirementSmall';

                                requirementHtml +=
                                    "<img id='requirementImage' src='icons/" +
                                    itemList[requirements[xx].itemid].image +
                                    "' /><span class=' " +
                                    requiredClasses +
                                    "'>" +
                                    requirementName +
                                    '</span>: ' +
                                    requirements[xx].amount +
                                    '<br>';
                            }
                            if (ArrayCount < requirementsArray.length) {
                                requirementHtml += ' <hr> ';
                            }

                        }
                    }

                    let fill =
                        "<div class='craftContainer'><div class='item craftItem' id='secondaryslot" +
                        slot +
                        "'><div class='itemname'> " +
                        name +
                        " </div> <div class='information'> " +
                        "<span class='item-qty'>" + itemcount + "x</span> <span class='item-weight'>" + weight.toFixed(2) + "</span>"
                        + `</div> <img src='${image}` +
                        "' data-inventory='" +
                        inventoryNumber +
                        "' data-creationDate='" +
                        creationDate +
                        "' data-quality='" +
                        quality +
                        "' data-name='" +
                        name +
                        "' data-info='" +
                        escape(info) +
                        "' data-metainformation='" +
                        meta +
                        "' data-fwewef='" +
                        item_cost +
                        "' data-itemid='" +
                        itemid +
                        "' data-inventory='2' data-currentslot='" +
                        slot +
                        "' data-stackable='" +
                        stackable +
                        "' data-amount='" +
                        itemcount +
                        "' data-weight='" +
                        weight +
                        "' data-inventoryname='" +
                        inventoryName +
                        "' class='itemimage' draggable='false'></div><div class='requirements'>" +
                        requirementHtml +
                        '</div></div>';
                    $('#wrapsecondary').html($('#wrapsecondary').html() + fill);
                    secondaryWeight = Math.max(secondaryWeight + weight * itemCount, 0);
                    continue;
                }

                if (main) {
                    document.getElementById('playerslot' + slot).innerHTML = htmlstring;

                    personalWeight = personalWeight + weight * itemcount;
                } else {
                    if (slot != 0) {
                        document.getElementById('secondaryslot' + slot).innerHTML = htmlstring;

                        secondaryWeight = Math.max(secondaryWeight + weight * itemcount, 0);
                    }
                }
            }
        }
    }

    //InventoryLog("Loaded " + inventoryName + " without recorded Error.")
    clicking = true;
}

const TimeAllowed = 1000 * 60 * 40320; // 28 days,

function ConvertQuality(itemID, creationDate) {
    let StartDate = new Date(creationDate).getTime();
    let DecayRate = itemList[itemID].decayrate;
    let TimeExtra = TimeAllowed * DecayRate;
    let percentDone = 100 - Math.ceil(((dateNow - StartDate) / TimeExtra) * 100);

    if (DecayRate == 0.0) {
        percentDone = 100;
    }
    if (percentDone < 0) {
        percentDone = 0;
    }
    return percentDone;
}

function UpdateSetWeights(secondaryName) {
    let shop = false;
    if (TargetInventoryName === 'Shop') {
        shop = true;
    }

    let craft = false;
    if (TargetInventoryName.indexOf('Craft') > -1) {
        craft = true;
    }

    if (!$('#mainInvHeading').html() || $('#secondaryInvName').attr('title') !== TargetInventoryName) {
        let mainHeader = `
            <h1 id='mainInvName' class='inventory-name' title='${PlayerInventoryName}'>Player</h1>
            <div class="inventory-weight"><span id='playerWeight'>${personalWeight.toFixed(0)}</span>/${personalMaxWeight.toFixed(0)}</div>
            <div class='weightbar'><div id='playerWeightBar' class='weightfill' style='width:${(personalWeight / personalMaxWeight) * 100}%;'></div></div>
        `;

        $("#mainInvHeading").html(mainHeader)

        if (!secondaryName && $('#secondaryInvName').attr('title') !== TargetInventoryName) secondaryName = 'Ground';

        let secondaryHeader = `<h1 id='secondaryInvName' class='inventory-name' title='${TargetInventoryName}'>${secondaryName}</h1>`;

        if (!shop && !craft) {
            secondaryHeader += `
                <div class="inventory-weight"><span id='secondaryWeight'>${secondaryWeight.toFixed(0)}</span>/${secondaryMaxWeight.toFixed(0)}</div>
                <div class='weightbar'><div id='secondaryWeightBar' class='weightfill' style='width:${(secondaryWeight / secondaryMaxWeight) * 100}%;'></div></div>
            `;
        }

        $(".craftingSearch").css({ display: craft ? "flex" : "none" });
        $(".cashcontainer").css({ display: shop ? "block" : "none" });


        if (shop) {
            document.getElementById('invShopMoney').innerHTML = Number(userCash).toLocaleString('en');
        }

        $("#secondaryInvHeading").html(secondaryHeader)
    } else {
        //Update weights
        $('#playerWeightBar').css('width', (personalWeight / personalMaxWeight) * 100 + '%');
        animateValue('playerWeight', $('#playerWeight').text(), personalWeight.toFixed(0), 1000);

        if (shop) {
            if (document.getElementById('invShopMoney')) {
                document.getElementById('invShopMoney').innerHTML = Number(userCash).toLocaleString('en');
            }
        } else if (craft) {
            //??
        } else {
            $('#secondaryWeightBar').css('width', (secondaryWeight / secondaryMaxWeight) * 100 + '%');
            animateValue('secondaryWeight', $('#secondaryWeight').text(), secondaryWeight.toFixed(0), 1000);
        }
    }

    $.post(
        'https://np-inventory/Weight',
        JSON.stringify({
            weight: personalWeight.toFixed(2),
        }),
    );
}

$(document).on('mousedown mouseup', (event) => {
    //If hold to drag is disabled or if you right click. Stops item from dropping when you let go of mouse1
    if ((!holdToDrag || event.button === 2 || !isDragging) && event.type === 'mouseup' && event.button !== 1) return;

    //Stop middle mouse from opening autoscroll
    if (event.button === 1 && event.type === 'mousedown') return false;

    let element = event.target;

    if (
        element.id === 'CurrentInformation' ||
        element.id === 'Logs' ||
        element.id === 'wrapmain' ||
        element.id === 'wrapsecondary' ||
        element.id === 'inventory-wrapper' ||
        element.id === 'containers-wrapper' ||
        element.id === 'move-amount' ||
        element.id === 'weight-hanger' ||
        element.id === 'playerWeight' ||
        element.id === 'secondaryInvName' ||
        element.id === 'requirementImage' ||
        element.id === 'secondaryInvHeading' ||
        element.id === 'mainInvHeading' ||
        element.id === 'secondaryInv' ||
        element.id === 'mainInv'

    ) {
        if (isDragging) EndDrag(draggingid);
        else if (element.id === 'containers-wrapper' && closeOnClick && event.button === 0) closeInv(); //Close when clicking outside inventory (Left click only)
        return;
    }

    if (element.id === 'CloseInv') {
        if (isDragging) {
            EndDrag(draggingid);
        }
        closeInv();
        return;
    } else if (element.id === 'usearea') {
        if (!isDragging) return;
        useitem();
        return;
    } else if (element.id === 'Drop') {
        if (draggingid != 'none') {
            AttemptDropInEmptySlot(draggingid, true);
        }
    }

    const isImg = element.nodeName.toLowerCase() === 'img';

    const _element = isImg ? element.parentNode : element;

    if (isImg) {
        DisplayInformation(_element.id);
    }

    //Middle mouse click
    if (event.button === 1) {
        DragToggle(_element.id, true, event);
        useitem();
    } else {
        DragToggle(_element.id, false, event);
    }
});

$(document).mouseover((event) => {
    element = event.target;
    let isImg = element.nodeName.toLowerCase() === 'img';

    if (isImg && !isDragging && element.id !== 'weight-hanger' && element.id !== 'usearea' && element.id !== 'requirementImage') {
        element = element.parentNode.id;
        DisplayInformation(element);
        /* HOVER LOOT
        if ((event.ctrlKey || event.shiftKey) && (event.buttons === 1 || event.buttons === 2)) {
            //Simulate click
            DragToggle(element, false, event);
        }*/
    } else {
        if (!isDragging || showTooltips) {
            document.getElementById('CurrentInformation').style.opacity = '0';
            _lastInfo = '';
        }
    }
});

function DragToggle(fromSlot, isUsing, mouseEvent) {
    if (!clicking) {
        return;
    }

    let moveAmount = parseInt(document.getElementById('move-amount').value);
    let shopOrCraft = TargetInventoryName == 'Shop' || TargetInventoryName.indexOf('Craft') > -1 || PlayerStore;

    if (!moveAmount) {
        if (shopOrCraft) {
            document.getElementById('move-amount').value = 1;
            moveAmount = 1;
        } else {
            //document.getElementById("move-amount").value = 0;
            moveAmount = 0;
        }
    }

    if (fromSlot) {
        /* draggingid = Current dragged element(if dragging), slot = what we are attempting to drop in or pick up from */
        /* Here we confirm that the image exists that holds the information for the item(s). */
        let c = document.getElementById(fromSlot).children.length;

        let occupiedslot = false;
        if (c > 1) {
            /* Here we declare if there is already an item in the slot we are dragging too by checking if there is an existing child node. */
            occupiedslot = true;
        }

        if (occupiedslot && !isDragging) {
            /* We are declaring that we just clicked our mouse button and are dragging a new object here. */

            isDragging = true;
            draggingid = fromSlot;

            // $.post('https://np-inventory/SlotInuse', JSON.stringify(parseInt(draggingid.replace(/\D/g, ''))));

            let draggedItemHtml = document.getElementById(draggingid).innerHTML;
            document.getElementById('draggedItem').innerHTML = draggedItemHtml;
            document.getElementById('draggedItem').style.left = mouseEvent.clientX - 50 + 'px';
            document.getElementById('draggedItem').style.top = mouseEvent.clientY - 50 + 'px';
            document.getElementById('draggedItem').style.opacity = '0.5';
            //document.getElementById('draggedItem').fadeIn(200);

            //Set proper amount for dragged item
            if (moveAmount != 0 && $('#draggedItem > img')) {
                let actualAmount = Math.min($('#draggedItem > img').data('amount'), moveAmount);
                $('#draggedItem > .information').html(actualAmount + ' (' + $('#draggedItem > img').data('weight').toFixed(2) + ')');
            }
            //If we're using the item or in crafting, don't shift/ctrl move it.
            if (isUsing || (TargetInventoryName.indexOf('Craft') > -1 && fromSlot.includes('player'))) return;

            //If we're in a shop/craft and ctrl or shift click, just do non-half move b/c a half move would fail
            if ((mouseEvent.shiftKey || mouseEvent.ctrlKey) && shopOrCraft && fromSlot.includes('secondary')) {
                // FindNextSlotAndMove(false);
                return;
            }

            if (mouseEvent.shiftKey) {
                FindNextSlotAndMove(!ctrlMovesHalf);
            } else if (mouseEvent.ctrlKey) {
                FindNextSlotAndMove(ctrlMovesHalf);
            }

            //Prevent running code below
            return;
        }

        if (isUsing) return;

        if (occupiedslot && isDragging) {
            /* Here we are trying to drop an item in an already filled slot, so, we swap the item current. */
            /* We will need to do a check to see if the item is the same, if its stackable and if so, we stack the item on top of the current stack and do not replace.. */
            AttemptDropInFilledSlot(fromSlot);
        }

        if (!occupiedslot && isDragging) {
            // $.post('https://np-inventory/SlotInuse', JSON.stringify(parseInt(draggingid.replace(/\D/g, ''))));
            /* Here we are droping an item to an open slot - I guess we should check waits etc to confirm this is allowed before doing so. */
            AttemptDropInEmptySlot(fromSlot, false);
        }

        if (!occupiedslot && !isDragging) {
            /* I guess we reset here?. */
            isDragging = false;
            draggingid = 'none';
        }
    }
}

function FindNextSlotAndMove(half) {
    let clickedInventory = document.getElementById(draggingid).parentElement.className;
    let moveToSlotName = 'playerslot';
    let slotCounter = 40;
    if (clickedInventory == 'wrapmain') {
        moveToSlotName = 'secondaryslot';
        slotCounter = slotLimitTarget;
    }

    let firstEmpty;
    let stackSlot;
    //Search through for duplicate items first, marking the first empty slot found
    for (let i = 1; i <= slotCounter; i++) {
        let foundSlot = moveToSlotName + i;
        let c = document.getElementById(foundSlot).children.length;
        if (c == 0 || (c == 1 && document.getElementById(foundSlot).children[0].id.startsWith('bind'))) {
            if (!firstEmpty) firstEmpty = foundSlot;
        } else {
            let existingItem = $('#' + foundSlot + ' > img');
            let stackItem = $('#' + draggingid + ' > img');
            const metadata1 = stackItem.data('info');
            const metadata2 = existingItem.data('info');
            if (existingItem.data('stackable') && existingItem.data('itemid') === stackItem.data('itemid') && isMetadataEqual(metadata1, metadata2)) {
                stackSlot = foundSlot;
            }
        }
    }

    //Stack only when SHIFT is pressed
    if (stackSlot && !half) {
        //Stack items
        AttemptDropInFilledSlot(stackSlot);
    } else if (firstEmpty) {
        // $.post('https://np-inventory/SlotInuse', JSON.stringify(parseInt(draggingid.replace(/\D/g, ''))));
        AttemptDropInEmptySlot(firstEmpty, false, half);
    }
}

function searchUpdate() {
    let searchInput = $('#search-text').val();
    $('.wrapmain')
        .find("div[class*='itemname']")
        .each(function (i, el) {
            let parent = el.parentElement.id;

            document.getElementById(parent).style.backgroundColor = 'rgba(40,20,40,0.1)';

            curGPSLength = searchInput.length;
            let dataSearched = el.innerHTML;
            let reg = new RegExp('(.*)' + searchInput + '(.*)', 'ig');

            if (reg.test(dataSearched) && searchInput != '') {
                document.getElementById(parent).style.backgroundColor = 'rgba(40,110,40,0.5)';
            }
        });
    // this will need converting to search proper.
    searchInput = document.getElementById('search-text').value;
    $('.wrapsecondary')
        .find("div[class*='itemname']")
        .each(function (i, el) {
            let parent = el.parentElement.id;
            $('#' + parent).css('background-color', 'rgba(40,20,40,0.1)');
            curGPSLength = searchInput.length;
            let dataSearched = el.innerHTML;
            let reg = new RegExp('(.*)' + searchInput + '(.*)', 'ig');

            if (reg.test(dataSearched) && searchInput != '') {
                $('#' + parent).css('background-color', 'rgba(40,110,40,0.5)');
            }
        });
}

function ErrorCheck(startingInventory, inventoryDropName, movementWeight) {
    let sameInventory = true;
    let ErrorReason = 'Success';

    if (inventoryDropName == 'wrapsecondary' && startingInventory == 1) {
        sameInventory = false;
        //InventoryLog("We are moving an item from Player to Secondary")
    } else if (inventoryDropName == 'wrapmain' && startingInventory == 2) {
        sameInventory = false;
        //InventoryLog("We are moving an item from Secondary to Primary")
    }

    if (sameInventory == true) {
        if (startingInventory == 1) {
            // InventoryLog("We are moving stuff in our personal inventory.")
        } else {
            // InventoryLog("We are moving stuff in our secondary inventory.")
        }
    } else {
        // logging the weight changes.

        if (startingInventory == 1) {
            if (movementWeight + secondaryWeight > secondaryMaxWeight) {
                ErrorReason = 'Your target weight is too much.';
                $('.weightcontainer').eq(1).shake();
            }
        } else {
            if (movementWeight + personalWeight > personalMaxWeight) {
                ErrorReason = 'The personal weight is too much.';
                $('.weightcontainer').eq(0).shake();
            }
        }
    }
    return ErrorReason;
}

function UpdateTextInformation(slot) {
    if (document.getElementById(slot)) {
        let item = document.getElementById(slot).getElementsByTagName('img')[0];
        if (item) {
            let informationDiv = $('#' + slot + " > div[class='information']");
            let weight = parseInt(item.dataset.weight);
            let amount = parseInt(item.dataset.amount);
            if (slot.includes('secondaryslot') && TargetInventoryName === 'Shop') {
                return;
            }
            //console.log('[' + inventory + '] ' + TargetInventoryName + ': setting amount for ' + slot + ' to ' + amount);
            /*let stackable = parseInt(item.dataset.stackable);
            if (parseInt(stackable) == 0) {
                stackable = '(S)';
            } else {
                stackable = '(nS)';
            }*/
            informationDiv.html("<span class='item-qty'>" + amount + "x</span> <span class='item-weight'>" + weight.toFixed(2) + "</span>");
            // "..itemcount.."x ("..weight..") " .. stackString .. "
        }
    }
}

function DropItem(slot, amountDropped) {
    let item = document.getElementById(slot).getElementsByTagName('img')[0];
    currentInventory = item.dataset.inventory;
    weight = item.dataset.weight;
    amount = item.dataset.amount;

    name = item.dataset.name;
    itemid = item.dataset.itemid;
    inventoryUsedName = item.dataset.inventoryname;
    slotusing = item.dataset.currentslot;

    let inventoryUsedNameText = 'Secondary Inventory';
    if (currentInventory == 1) {
        inventoryUsedNameText = 'Player Inventory';
    }

    //InventoryLog("Dropped: " + name + " x(" + amountDropped + ") from slot " + slotusing + " of " + inventoryUsedNameText)

    // $.post('https://np-inventory/dropitem', JSON.stringify({
    //  currentInventory: currentInventory,
    //  weight: weight,
    //  amount: amount,
    //  name: name,
    //  itemid: itemid,
    //  inventoryUsedName: item.dataset.inventoryname,
    //  slotusing: slotusing,
    //  amountDropped: amountDropped,
    // }));
}

function ErrorMove() {
    // $.post('https://np-inventory/move:fail', JSON.stringify({}));
}

function SuccessMove() {
    // $.post('https://np-inventory/move:success', JSON.stringify({}));
}

// we are splitting items from inv2,slot2,amount2 over to inv1,slot1,amount1
// if amount2 is zero, we moved the entire stack.

function CompileStacks(
    targetSlot,
    originSlot,
    inv1,
    inv2,
    originAmount,
    remainingAmount,
    targetAmount,
    purchase,
    itemCosts,
    itemidsent,
    metainformation,
    moveAmount,
    arraySlot
) {
    let originInventory;
    let targetInventory;

    if (inv2 == 'wrapmain') {
        originInventory = PlayerInventoryName;
    } else {
        originInventory = TargetInventoryName;
    }

    if (inv1 == 'wrapmain') {
        targetInventory = PlayerInventoryName;
    } else {
        targetInventory = TargetInventoryName;
    }

    $.post(
        'https://np-inventory/SlotJustUsed',
        JSON.stringify({
            targetslot: targetSlot,
            origin: originSlot,
            itemid: itemidsent,
            move: false,
            MyInvMove: targetInventory === PlayerInventoryName,
        }),
    );

    var isWeapon = false;
    if (itemList[itemidsent].weapon != null && !exluded[itemidsent] && !isCop && targetInventory !== originInventory) {
        brought = true;
        isWeapon = itemList[itemidsent].weapon;
    }

    invStack(
        targetSlot,
        moveAmount,
        targetInventory,
        originSlot,
        originInventory,
        purchase,
        itemCosts,
        itemidsent,
        metainformation,
        moveAmount,
        crafting,
        isWeapon,
        remainingAmount,
    );

    //("Changed Slot: " + targetSlot + "(" + targetAmount + ") of " + inv2 + " to " + originSlot + "(" + originAmount + ") of " + inv1 + " ")
    if (crafting) {
        removeCraftItems(itemidsent, moveAmount, arraySlot);
        //closeInv();
        return;
    }
    UpdateSetWeights('');
}

function MoveStack(targetSlot, originSlot, inv1, inv2, purchase, itemCosts, itemidsent, metainformation, moveAmount, arraySlot) {
    let originInventory;
    let targetInventory;

    if (inv2 == 'wrapmain') {
        originInventory = PlayerInventoryName;
    } else {
        originInventory = TargetInventoryName;
    }

    if (inv1 == 'wrapmain') {
        targetInventory = PlayerInventoryName;
    } else {
        targetInventory = TargetInventoryName;
    }

    $.post(
        'https://np-inventory/SlotJustUsed',
        JSON.stringify({
            targetslot: targetSlot,
            origin: originSlot,
            itemid: itemidsent,
            move: true,
            MyInvMove: targetInventory === PlayerInventoryName,
        }),
    );

    var isWeapon = false;
    if (itemList[itemidsent].weapon != null && !exluded[itemidsent] && !isCop && targetInventory !== originInventory) {
        brought = true;
        isWeapon = itemList[itemidsent].weapon;
    }

    invMove(
        targetSlot,
        originSlot,
        targetInventory,
        originInventory,
        purchase,
        itemCosts,
        itemidsent,
        metainformation,
        moveAmount,
        crafting,
        isWeapon,
    );
    //InventoryLog("Moved Slot " + targetSlot + " of " + targetInventory + " to " + originSlot + " of " + originInventory + " #" + itemidsent + " Information :" + metainformation)
    if (crafting) {
        removeCraftItems(itemidsent, moveAmount, arraySlot);
        //closeInv();
        return;
    }
    UpdateSetWeights('');
}

// slot2 is the object being moved originally, slot 1 is the item it is replacing with.
function SwapStacks(targetSlot, originSlot, inv1, inv2, itemid1, metainformation1, itemid2, metainformation2) {
    // $.post('https://np-inventory/swapstack', JSON.stringify({
    //   slot1: slot1,
    //   slot2: slot2,
    //   inv1: inv1,
    //   inv2: inv2,
    // }));
    let originInventory;
    let targetInventory;

    if (inv2 == 'wrapmain') {
        originInventory = PlayerInventoryName;
    } else {
        originInventory = TargetInventoryName;
    }

    if (inv1 == 'wrapmain') {
        targetInventory = PlayerInventoryName;
    } else {
        targetInventory = TargetInventoryName;
    }

    RequestItemData();
    $.post(
        'https://np-inventory/SlotJustUsed',
        JSON.stringify({
            targetslot: targetSlot,
            origin: originSlot,
            itemid: itemid,
            move: false,
            MyInvMove: targetInventory === PlayerInventoryName,
        }),
    );

    invSwap(targetSlot, targetInventory, originSlot, originInventory, itemid1, metainformation1, itemid2, metainformation2);

    //InventoryLog("Swapped Slot " + targetSlot + " of " + targetInventory + " and " + originSlot + " of " + originInventory + " " + itemid1 + " " + metainformation1 + " " + itemid2 + " " + metainformation2 )
    UpdateSetWeights('');
}

function InsertItem(targetSlot, originSlot, inv1, inv2, itemid1, iteminfo1, itemid2, iteminfo2) {
    let originInventory;
    let targetInventory;

    if (inv2 == 'wrapmain') {
        originInventory = PlayerInventoryName;
    } else {
        originInventory = TargetInventoryName;
    }

    if (inv1 == 'wrapmain') {
        targetInventory = PlayerInventoryName;
    } else {
        targetInventory = TargetInventoryName;
    }

    $.post(
        'https://np-inventory/insert-item',
        JSON.stringify({
            originInventory,
            targetInventory,
            originSlot,
            targetSlot,
            originItemId: itemid1,
            targetItemId: itemid2,
            originItemInfo: iteminfo1,
            targetItemInfo: iteminfo2,
        })
    );
}

function closeInv(pIsItemUsed = false) {
    personalWeight = 0;
    secondaryWeight = 0;

    if (isDragging) EndDrag(draggingid);

    $.post(
        'https://np-inventory/ServerCloseInventory',
        JSON.stringify({
            name: TargetInventoryName,
        }),
    );
    TargetInventoryName = 'none';

    $.post(
        'https://np-inventory/Close',
        JSON.stringify({
            isItemUsed: pIsItemUsed,
        }),
    );
}

function CountItems(ItemIdToCheck) {
    let sqlInventory = JSON.parse(MyInventory);
    let amount = 0;
    for (let i = 0; i < parseInt(MyItemCount); i++) {
        if (sqlInventory[i].item_id == ItemIdToCheck && sqlInventory[i].quality > 0) {
            amount += sqlInventory[i].amount;
        }
    }
    return amount;
}

//itemid, amount, return

function CheckCraftFail(itemid, moveAmount) {
    let requirementsArray = itemList[itemid].craft;

    if (!requirementsArray) return true;

    let itemcheck = false;
    let weightcheck = false;
    let arraySlot = 0

    for (let ArrayX = 0; ArrayX < requirementsArray.length; ArrayX++) {
        itemcheck = false
        weightcheck = false
        let requirements = requirementsArray[ArrayX]
        let ingredientWeight = 0;
        let craftWeight = itemList[itemid].weight * moveAmount;

        let ingredientsJson = {};

        for (let i = 0; i < requirements.length; i++) {
            let requiredAmount = Math.ceil(moveAmount * requirements[i]['amount']);
            let itemNeededId = requirements[i]['itemid'];
            let countedItems = CountItems(itemNeededId);

            if (countedItems < requiredAmount) {
                itemcheck = true;
            } else {
                ingredientsJson[itemNeededId] = requiredAmount;
                ingredientWeight += itemList[itemNeededId].weight * requiredAmount;
            }
        }

        if (personalWeight + craftWeight - ingredientWeight > personalMaxWeight) {
            //Failed
            weightcheck = true;
        }

        if (!itemcheck && !weightcheck) {
            //Remove ingredients from inventory
            let sqlInventory = JSON.parse(MyInventory);
            for (let i = 0; i < parseInt(MyItemCount); i++) {
                let item = sqlInventory[i];
                if (item.item_id in ingredientsJson && item.quality > 0) {
                    let amountDiff = item.amount - ingredientsJson[item.item_id];
                    if (amountDiff > 0) {
                        //Have more than enough, so just change amount
                        sqlInventory[i].amount = amountDiff;
                    } else {
                        //Have exactly enough, remove item
                        delete sqlInventory[i];
                    }
                }
            }
            MyInventory = JSON.stringify(sqlInventory);
            MyItemCount = sqlInventory.length;

            $.post('https://np-inventory/craftProgression', JSON.stringify({
                "inventory": TargetInventoryName,
                "item": itemid,
                "amount": moveAmount,
            }));
            return [itemcheck, weightcheck, arraySlot];
        }
        arraySlot = arraySlot + 1
    }
    return [itemcheck, weightcheck, arraySlot];
    //InventoryLog("We should add " + moveAmount + " of " + itemid)
}

function AttemptDropInFilledSlot(slot) {
    let moveAmount = document.getElementById('move-amount').value;
    if (draggingid == slot) {
        EndDragError(slot);
        return;
    }

    let item = document.getElementById(draggingid).getElementsByTagName('img')[0];
    if (item == undefined) {
        EndDragError(slot);
        return;
    }
    let itemReturnItem = document.getElementById(slot).getElementsByTagName('img')[0];
    let itemidsent = item.dataset.itemid;
    let craftCheck = false;
    let weightCheck = false;
    let arraySlot = 0;
    let currentInventory = parseInt(item.dataset.inventory);
    let weight = parseInt(item.dataset.weight);
    let amount = parseInt(item.dataset.amount);
    let name = item.dataset.name;
    let itemid1 = item.dataset.itemid;
    let itemmetadata1 = unescape(item.dataset.info);
    let metainformation1 = item.dataset.metainformation;
    let stackable = JSON.parse(item.dataset.stackable);

    let itemid2 = itemReturnItem.dataset.itemid;
    let itemmetadata2 = unescape(itemReturnItem.dataset.info);
    let metainformation2 = itemReturnItem.dataset.metainformation;
    let returnItemInventory = itemReturnItem.dataset.inventory;
    let weightReturnItem = parseInt(itemReturnItem.dataset.weight);
    let amountReturnItem = parseInt(itemReturnItem.dataset.amount);
    let nameReturnItem = itemReturnItem.dataset.name;
    let inventoryDropName = document.getElementById(slot).parentElement.className;
    let inventoryReturnItemDropName = document.getElementById(draggingid).parentElement.className;

    let sameinventory = true;
    purchase = false;
    crafting = false;
    let closeOnMove = false;
    let movementWeight = weight * amount;
    let movementReturnItemWeight = weightReturnItem * amountReturnItem;

    let stacking = false;
    let fullstack = false;

    //Prevent people from buying stacks of guns
    if (inventoryReturnItemDropName === 'wrapsecondary' && TargetInventoryName === 'Shop') {
        if ((moveAmount > 1 && !stackable)) moveAmount = 1;
        if (moveAmount > 50) moveAmount = 50;
        if (itemid2 === 'jailfood' || itemid2 === "slushy") {
            moveAmount = 1;
            closeOnMove = true;
        }
    }

    if (itemid1 == itemid2 && stackable) {
        // here we are set to 0, which means the number for movement hasnt been changed so we default to try and move the entire stack over.
        if (moveAmount == 0 || moveAmount > amount) {
            fullstack = true;
            moveAmount = amount;
        }
        movementWeight = weight * moveAmount;
        movementReturnItemWeight = weightReturnItem * moveAmount;

        const metadata1 = JSON.parse(itemmetadata1);
        const metadata2 = JSON.parse(itemmetadata2);
        stacking = isMetadataEqual(metadata1, metadata2);
    }

    let result, result2;

    if (inventoryDropName === 'wrapmain' && inventoryReturnItemDropName === 'craftContainer' && TargetInventoryName.indexOf('Craft') > -1) {
        //InventoryLog('eh: Crafting');
        inventoryReturnItemDropName = 'wrapsecondary';

        [craftCheck, weightCheck, arraySlot] = CheckCraftFail(itemidsent, moveAmount);

        if (!craftCheck && !weightCheck && currentInventory == 2 && inventoryDropName == 'wrapmain') {
            InventoryLog('[1] Attempted to craft item with itemid: ' + itemidsent);
            crafting = true;
            result = 'Success';
            result2 = 'Success';
        } else {
            if (craftCheck) {
                result = 'You dont have the required materials!';
            }
            if (weightCheck) {
                result2 = 'The personal weight is too much.';
                $('.weightcontainer').eq(0).shake();
            }

            EndDragError(slot);
            InventoryLog('Error: ' + result + ' | ' + result2);
            return;
        }
    } else {
        if (stacking == false) {
            // If the item is being stacked, we do not calculate the return weight here as no item will be returned to the starting inventory.
            result2 = ErrorCheck(returnItemInventory, inventoryReturnItemDropName, movementReturnItemWeight);
            //Since we're not stacking, calculate first result with updated weight
            result = ErrorCheck(currentInventory, inventoryDropName, movementWeight - movementReturnItemWeight);
        } else {
            // the item was stacked so its automatically successful for return item weight.
            result2 = 'Success';
            result = ErrorCheck(currentInventory, inventoryDropName, movementWeight);
        }
    }

    /*if (stacking && moveAmount > amount) {
    document.getElementById("move-amount").value = 0;
    result2 = "Warning";
    result = "You do not have that amount!";
  }*/

    if (
        (inventoryDropName === 'wrapsecondary' && TargetInventoryName === 'Shop') ||
        (!StoreOwner && PlayerStore && inventoryDropName === 'wrapsecondary') ||
        (TargetInventoryName === 'Shop' && inventoryReturnItemDropName === 'wrapsecondary' && inventoryDropName === 'wrapmain' && !stacking)
    ) {
        result = 'You can not drop items into the shop!';
    }
    if (
        (inventoryDropName === 'craftContainer' && TargetInventoryName.indexOf('Craft') > -1) ||
        (inventoryDropName == 'wrapmain' && inventoryReturnItemDropName === 'wrapsecondary' && TargetInventoryName.indexOf('Craft') > -1 && !stacking)
    ) {
        result = 'You can not drop items into the craft table!';
    }

    if ((TargetInventoryName.startsWith("container") || TargetInventoryName.startsWith("fisher-bucket")) &&
        (
            ((inventoryReturnItemDropName == 'wrapmain' && inventoryDropName == 'wrapsecondary')) ||
            (inventoryDropName == 'wrapmain' && inventoryReturnItemDropName == 'wrapsecondary')
        )) {
        let sqlInventory = JSON.parse(MyInventory);
        let hasInventoryKey = false;
        for (let i = 0; i < parseInt(MyItemCount); i++) {
            if (sqlInventory[i].item_id !== itemidsent && sqlInventory[i].item_id !== itemid2) continue;
            let meta = JSON.parse(sqlInventory[i].information);
            if (meta.inventoryId !== undefined) {
                hasInventoryKey = true;
            }
        }
        if (hasInventoryKey) {
            result = "Boxception.";
        }

        if (!TargetInventoryName.includes('dodo container') && (itemList[itemid1].weapon || itemList[itemid2].weapon)) {
            result = "Can't fit inside container.";
        }

        if (TargetInventoryName.split("-").length > 3) {
            let hasItem1Key = false;
            let hasItem2Key = false;
            let whitelistItemKey = TargetInventoryName.split("-")[3];
            for (let i = 0; i < parseInt(MyItemCount); i++) {
                if (sqlInventory[i].item_id !== itemidsent && sqlInventory[i].item_id !== itemid2) continue;
                let meta = JSON.parse(sqlInventory[i].information);
                itemList[whitelistItemKey].whitelist.forEach(whitelistKey => {
                    if (itemList[sqlInventory[i].item_id][whitelistKey] || meta[whitelistKey]) {
                        hasItem1Key = sqlInventory[i].item_id === itemidsent || hasItem1Key;
                        hasItem2Key = sqlInventory[i].item_id === itemid2 || hasItem2Key;
                    }
                })
            }
            if (!hasItem1Key || !hasItem2Key) {
                result = "Can't place this here.";
            }
        }
    }

    if (TargetInventoryName.startsWith('mailbox') && ((inventoryDropName == 'wrapsecondary') || (inventoryReturnItemDropName == 'wrapsecondary') && !stacking)) {
        result = 'Cannot place into mailboxes.'
    }

    if (result == 'Success' && result2 == 'Success') {
        // Here we are moving from player inventory to the secondary inventory
        if (currentInventory == 1 && inventoryDropName == 'wrapsecondary') {
            item.dataset.inventory = 2;
            itemReturnItem.dataset.inventory = 1;
            if (stacking) {
                personalWeight = personalWeight - movementWeight;
                secondaryWeight = Math.max(secondaryWeight + movementWeight, 0);
            } else {
                personalWeight = personalWeight + movementReturnItemWeight - movementWeight;
                secondaryWeight = Math.max(secondaryWeight + movementWeight - movementReturnItemWeight, 0);
            }
        }

        // Here we are moving from secondary inventory to the player inventory.
        if (currentInventory == 2 && inventoryDropName == 'wrapmain') {
            item.dataset.inventory = 1;
            itemReturnItem.dataset.inventory = 2;
            if (stacking) {
                personalWeight = personalWeight + movementWeight;
                secondaryWeight = Math.max(secondaryWeight - movementWeight, 0);
            } else {
                personalWeight = personalWeight + movementWeight - movementReturnItemWeight;
                secondaryWeight = Math.max(secondaryWeight + movementReturnItemWeight - movementWeight, 0);
            }
        }

        if (stacking) {
            if (inventoryDropName == 'wrapmain') {
                itemReturnItem.dataset.inventory = 1;
            } else {
                itemReturnItem.dataset.inventory = 2;
            }

            if (currentInventory == 1) {
                item.dataset.inventory = 1;
            } else {
                item.dataset.inventory = 2;
            }

            let purchaseCost = parseInt(item.dataset.fwewef) * parseInt(moveAmount);

            if (TargetInventoryName == 'Shop' || (!StoreOwner && PlayerStore)) {
                // InventoryLog("eh: PURCHASE")
                if (purchaseCost > userCash && purchaseCost !== 0) {
                    result = 'You cant afford this.!';
                    result2 = 'You cant afford this.!';
                    InventoryLog('Error: ' + result);
                    EndDragError(slot);
                    return;
                } else {
                    if (itemList[itemidsent].weapon && inventoryReturnItemDropName !== inventoryDropName) {
                        if (!exluded[itemidsent] && !userWeaponLicense) {
                            result = 'You do not have a license.!';
                            result2 = 'You do not have a license.!';
                            InventoryLog('Error: ' + result);
                            EndDragError(slot);
                            return;
                        }

                        if (!exluded[itemidsent] && brought && !isCop) {
                            result = 'You can only buy one gun a day!';
                            InventoryLog('Error: ' + result);
                            EndDragError(slot);
                            return;
                        }
                    }

                    if (currentInventory == 2 && inventoryDropName == 'wrapmain') {
                        userCash = userCash - purchaseCost;
                        InventoryLog('Purchase Cost: $' + purchaseCost + ' you have $' + userCash + ' left.');
                        purchase = true;
                    }
                }
            }

            //InventoryLog(item.dataset.fwewef + " | " + purchaseCost + " | " + moveAmount);

            let newAmount = parseInt(amountReturnItem) + parseInt(moveAmount);
            itemReturnItem.dataset.amount = newAmount;
            item.dataset.currentslot = parseInt(slot.replace(/\D/g, ''));
            itemReturnItem.dataset.currentslot = parseInt(draggingid.replace(/\D/g, ''));

            if (fullstack == false) {
                let newAmount2 = parseInt(amount) - parseInt(moveAmount);
                item.dataset.amount = newAmount2;

                if (newAmount2 == 0) {
                    document.getElementById(draggingid).innerHTML = '';
                }

                CompileStacks(
                    parseInt(slot.replace(/\D/g, '')),
                    parseInt(draggingid.replace(/\D/g, '')),
                    inventoryDropName,
                    inventoryReturnItemDropName,
                    newAmount,
                    newAmount2,
                    moveAmount,
                    purchase,
                    purchaseCost,
                    itemidsent,
                    itemmetadata1,
                    moveAmount,
                    arraySlot,
                );
            } else {
                document.getElementById(draggingid).innerHTML = '';

                CompileStacks(
                    parseInt(slot.replace(/\D/g, '')),
                    parseInt(draggingid.replace(/\D/g, '')),
                    inventoryDropName,
                    inventoryReturnItemDropName,
                    newAmount,
                    0,
                    moveAmount,
                    purchase,
                    purchaseCost,
                    itemidsent,
                    itemmetadata1,
                    moveAmount,
                    arraySlot,
                );
            }

            let data = {};
            let targetQuality = itemReturnItem.dataset.quality;
            let startQuality = item.dataset.quality;

            if (startQuality < targetQuality && !purchase) {
                data.inventory = item.dataset.inventoryname;
                data.slot = parseInt(slot.replace(/\D/g, ''));
                data.information = unescape(item.dataset.info);
                data.information.quality = startQuality;
                UpdateQuality(data, startQuality);
            }
        } else {
            if (inventoryDropName == 'Shop' || inventoryDropName.indexOf('Craft') > -1 || (!StoreOwner && PlayerStore)) {
                result = 'You can not drop items into the shop!';
                EndDragError(slot);
                InventoryLog('Error: ' + result2 + ' | ' + result);
            } else if (
                (
                    (itemList[itemid1].insertTo && itemList[itemid1].insertTo.includes(itemid2))
                    ||
                    (itemList[itemid2].insertFrom && itemList[itemid2].insertFrom.includes(itemid1))
                )
                && inventoryDropName === 'wrapmain' && inventoryDropName === inventoryReturnItemDropName
            ) {

                InsertItem(
                    parseInt(slot.replace(/\D/g, '')),
                    parseInt(draggingid.replace(/\D/g, '')),
                    inventoryDropName,
                    inventoryReturnItemDropName,
                    itemid1,
                    itemmetadata1,
                    itemid2,
                    itemmetadata2,
                );
            } else {
                SwapStacks(
                    parseInt(slot.replace(/\D/g, '')),
                    parseInt(draggingid.replace(/\D/g, '')),
                    inventoryDropName,
                    inventoryReturnItemDropName,
                    itemid1,
                    metainformation1,
                    itemid2,
                    metainformation2,
                );

                item.dataset.currentslot = parseInt(slot.replace(/\D/g, ''));
                itemReturnItem.dataset.currentslot = parseInt(draggingid.replace(/\D/g, ''));

                let currentdragHTML = document.getElementById(draggingid).innerHTML;
                let currentdropHTML = document.getElementById(slot).innerHTML;

                document.getElementById(draggingid).innerHTML = currentdropHTML;
                document.getElementById(slot).innerHTML = currentdragHTML;

                UpdateSlotBind(draggingid);
                UpdateSlotBind(slot);
            }
        }

        if (!crafting) UpdateSetWeights('');

        EndDrag(slot);
        if (closeOnMove) {
            closeInv();
        }
    } else {
        // errored?
        EndDragError(slot);
        InventoryLog('Error: ' + result2 + ' | ' + result);
    }
}

// Takes a slot id as playerslot1, or playerslot2
function UpdateSlotBind(slot) {
    const newSlotId = slot.split("playerslot")[1];

    // Does this slot already have a slot bind number assigned? if so remove it
    for (const bind of bindSlots) {
        const bindEle = document.getElementById(slot).querySelector(`#bind${bind}`)
        if (bindEle) bindEle.remove();
    }

    if (bindSlots.includes(parseInt(newSlotId)) && slot.includes("playerslot")) {
        document.getElementById(slot).insertAdjacentHTML("beforeend", "<div id='bind" + newSlotId + "'>" + newSlotId + "</div>")
    }
}

function EndDragError(slot) {
    UpdateTextInformation(draggingid);
    UpdateTextInformation(slot);

    document.getElementById('draggedItem').style.opacity = '0.0';
    document.getElementById('draggedItem').innerHTML = '';

    isDragging = false;
    draggingid = 'none';
}

function EndDrag(slot) {
    UpdateTextInformation(draggingid);
    UpdateTextInformation(slot);
    isDragging = false;
    draggingid = 'none';
    document.getElementById('draggedItem').style.opacity = '0.0';
    document.getElementById('draggedItem').innerHTML = '';
}

function DisplayInformation(slot) {
    let item = document.getElementById(slot).getElementsByTagName('img')[0];

    let weight = parseFloat(item.dataset.weight);
    let amount = parseInt(item.dataset.amount);
    let quality = item.dataset.quality;

    let name = item.dataset.name;
    let metainformation = item.dataset.metainformation;

    try {
        if (item.dataset.info) {
            let jsonInfo = JSON.parse(unescape(item.dataset.info));
            if (customNameItems.includes(item.dataset.itemid)) {
                name = `${customNameItemsDescriptions[item.dataset.itemid] || ''}${jsonInfo._name || name}`;
            }
            if (customDescriptionItems.includes(item.dataset.itemid)) {
                metainformation =
                    `${customDescriptionItemsDescriptions[item.dataset.itemid] || ''}${jsonInfo._description || metainformation}`;
            }
        } else {
            name = `${customNameItemsDescriptions[item.dataset.itemid] || ''}${name}`;
        }
    } catch (err) { }

    _lastInfo = metainformation;

    //let stackable = parseInt(item.dataset.stackable);
    let color = 'green';
    if (quality == undefined) {
        quality = 100;
    }
    switch (quality) {
        case quality > 75:
            color = '#5FF03C';
            break;
        case quality > 50:
            color = '#74C242';
            break;
        case quality > 25:
            color = '#DEB837';
            break;
        case quality > 0:
            color = '#CC2727';
            break;
    }

    let element = $('#CurrentInformation');

    if (quality != '' && quality != null && quality != 'undefined') {
        element.html(
            '<h2> ' +
            name +
            "</h2> <div class='DispInfo'>" +
            metainformation +
            '</div> <hr><strong>Weight</strong>: ' +
            weight.toFixed(2) +
            ' | <strong>Amount</strong>: ' +
            amount +
            '' +
            ' | <strong>Quality</strong>: <span style="color:' +
            color +
            '">' +
            quality +
            '</span>' +
            '',
        );
    } else {
        element.html(
            '<h2> ' +
            name +
            "</h2><div class='DispInfo'>" +
            metainformation +
            '</div> <br><hr><strong>Weight</strong>: ' +
            weight.toFixed(2) +
            '| <strong>Amount</strong>: ' +
            amount,
        );
    }

    if (showTooltips) {
        let itemOffset = $(item).offset();

        element.css('top', itemOffset.top - element.height());

        let leftOffset = itemOffset.left + 92;

        //Prevent from going offscreen.
        if (leftOffset + element.width() > $(window).width()) {
            leftOffset = $(window).width() - element.width() - 20;
        }

        element.css('left', leftOffset);

        if (!element.hasClass('tooltip')) element.addClass('tooltip');
    } else {
        //Reset position
        element.attr('style', '');
        element.removeClass('tooltip');
    }
    element.css('opacity', 1);
}

function AttemptDropInEmptySlot(slot, isDropped, half) {
    let item = document.getElementById(draggingid).getElementsByTagName('img')[0];
    100;
    if (item == undefined) {
        EndDragError(slot);
        return;
    }
    let craftCheck = false;
    let weightCheck = false;
    let arraySlot = 0;
    let currentInventory = item.dataset.inventory;
    let weight = parseInt(item.dataset.weight);
    let amount = parseInt(item.dataset.amount);
    let inventoryReturnItemDropName = document.getElementById(draggingid).parentElement.className;
    let inventoryDropName = document.getElementById(slot).parentElement.className;
    let sameinventory = true;
    let movementWeight = weight * amount;
    purchase = false;
    crafting = false;
    let itemidsent = item.dataset.itemid;
    let metainformation = unescape(item.dataset.info);
    let moveAmount = parseInt(document.getElementById('move-amount').value);

    let closeOnMove = false;

    //Prevent people from buying stacks of guns
    if (inventoryReturnItemDropName === 'wrapsecondary' && TargetInventoryName === 'Shop') {
        if (moveAmount > 1 && !JSON.parse(item.dataset.stackable)) moveAmount = 1;
        if (moveAmount > 50) moveAmount = 50;
        if (itemidsent === 'jailfood' || itemidsent === "slushy") {
            moveAmount = 1;
            closeOnMove = true;
        }
    }

    if (!moveAmount) {
        moveAmount = 0;
    }

    if (half && amount > 1) {
        moveAmount = Math.floor(amount / 2);
    }

    if (moveAmount > amount) {
        moveAmount = amount;
        //document.getElementById("move-amount").value = amount;
        //result = "You do not have that amount!";
    }

    let splitMove = false;
    if (moveAmount != 0 && moveAmount != amount) {
        splitMove = true;
        let alteredAmount = moveAmount;
        movementWeight = weight * alteredAmount;
    }

    let result = 'Success';
    if (inventoryDropName === 'wrapmain' && inventoryReturnItemDropName === 'craftContainer' && TargetInventoryName.indexOf('Craft') > -1) {
        // InventoryLog("eh: Crafting")
        inventoryReturnItemDropName = 'wrapsecondary';

        [craftCheck, weightCheck, arraySlot] = CheckCraftFail(itemidsent, moveAmount);

        if (!craftCheck && !weightCheck && Number(currentInventory) === 2 && inventoryDropName === 'wrapmain') {
            InventoryLog('[2] Attempted to craft item with itemid: ' + itemidsent);
            crafting = true;
            result = 'Success';
        } else {
            let result2 = 'Success';
            if (craftCheck) {
                result = 'You dont have the required materials!';
            }
            if (weightCheck) {
                result2 = 'The personal weight is too much.';
                $('.weightcontainer').eq(0).shake();
            }

            EndDragError(slot);
            InventoryLog('Error: ' + result + ' | ' + result2);
            return;
        }
    } else {
        result = ErrorCheck(currentInventory, inventoryDropName, movementWeight);
    }

    if (isDropped && inventoryReturnItemDropName == 'wrapsecondary') {
        result = 'Error: can not drop a dropped item';
    }

    if (
        (inventoryDropName == 'wrapsecondary' && TargetInventoryName == 'Shop') ||
        (inventoryDropName == 'wrapsecondary' && !StoreOwner && PlayerStore)
    ) {
        result = 'You can not drop items into the shop!';
    }
    if (inventoryDropName === 'wrapsecondary' && TargetInventoryName.indexOf('Craft') > -1) {
        result = 'You can not drop items into the craft shop!';
    }

    if (inventoryDropName == 'wrapsecondary' && PlayerStore) {
        let isWeapon = itemList[itemidsent].weapon;
        if (isWeapon != undefined) {
            result = 'You can not move weapons while in player stores!';
        }
    }

    if ((TargetInventoryName.startsWith("container") || TargetInventoryName.startsWith("fisher-bucket")) && (inventoryReturnItemDropName == 'wrapmain' && inventoryDropName == 'wrapsecondary')) {
        let sqlInventory = JSON.parse(MyInventory);
        let hasInventoryKey = false;
        for (let i = 0; i < parseInt(MyItemCount); i++) {
            if (sqlInventory[i].item_id !== itemidsent) continue;
            let meta = JSON.parse(sqlInventory[i].information);
            if (meta.inventoryId !== undefined) {
                hasInventoryKey = true;
            }
        }
        if (hasInventoryKey) {
            result = "Boxception.";
        }

        if (!TargetInventoryName.includes('dodo container') && itemList[itemidsent].weapon) {
            result = "Can't fit inside container.";
        }

        if (TargetInventoryName.split("-").length > 3) {
            let hasWhitelistedKey = false;
            let whitelistItemKey = TargetInventoryName.split("-")[3];
            for (let i = 0; i < parseInt(MyItemCount); i++) {
                if (sqlInventory[i].item_id !== itemidsent) continue;
                let meta = JSON.parse(sqlInventory[i].information);
                itemList[whitelistItemKey].whitelist.forEach(whitelistKey => {
                    if (itemList[sqlInventory[i].item_id][whitelistKey] || meta[whitelistKey]) {
                        hasWhitelistedKey = true;
                    }
                })
            }
            if (!hasWhitelistedKey) {
                result = "Can't place this here.";
            }
        }
    }

    if (TargetInventoryName.startsWith('mailbox') && inventoryDropName == 'wrapsecondary') {
        result = 'Cannot place into mailboxes.'
    }

    if (result == 'Success') {
        let purchaseCost = parseInt(item.dataset.fwewef) * parseInt(moveAmount);
        //InventoryLog(item.dataset.fwewef + " | " + purchaseCost + " | " + moveAmount);
        if (TargetInventoryName == 'Shop' || (!StoreOwner && PlayerStore)) {
            //InventoryLog("eh: PURCHASE")
            if (purchaseCost > userCash && purchaseCost !== 0) {
                result = 'You cant afford that!';
                EndDragError(slot);
                InventoryLog('Error: ' + result);
                //userCash = userCash - purchaseCost; unsure why we are taking money on not enough money taken
                return;
            } else {
                if (itemList[itemidsent].weapon && inventoryReturnItemDropName !== inventoryDropName) {
                    if (!exluded[itemidsent] && !userWeaponLicense) {
                        result = 'You do not have a license!';
                        InventoryLog('Error: ' + result);
                        EndDragError(slot);
                        return;
                    }

                    if (!exluded[itemidsent] && brought && !isCop) {
                        result = 'You can only buy one gun a day!';
                        InventoryLog('Error: ' + result);
                        EndDragError(slot);
                        return;
                    }
                }

                if (currentInventory == 2 && inventoryDropName == 'wrapmain') {
                    userCash = userCash - purchaseCost;
                    InventoryLog('Purchase Cost: $' + purchaseCost + ' you have $' + userCash + ' left.');
                    purchase = true;
                }
            }
        }

        // moving from player to secondat
        if (currentInventory == 1 && (inventoryDropName == 'wrapsecondary' || isDropped)) {
            // tell lua the new location and stuff?
            personalWeight = personalWeight - movementWeight;
            if (!isDropped) {
                item.dataset.inventory = 2;
                secondaryWeight = Math.max(secondaryWeight + movementWeight, 0);
            }
        }

        //moving from secondary to player
        if (currentInventory == 2 && (inventoryDropName == 'wrapmain' || isDropped)) {
            // tell lua the new location and stuff?
            secondaryWeight = Math.max(secondaryWeight - movementWeight, 0);
            if (!isDropped) {
                item.dataset.inventory = 1;
                personalWeight = personalWeight + movementWeight;
            }
        }

        if (!crafting) UpdateSetWeights('');

        if (splitMove || purchase) {
            if (!isDropped) {
                document.getElementById(slot).innerHTML = document.getElementById(draggingid).innerHTML;
            }

            let item = document.getElementById(draggingid).getElementsByTagName('img')[0];
            let itemNewItem = document.getElementById(slot).getElementsByTagName('img')[0];
            let startAmount = parseInt(item.dataset.amount);

            itemNewItem.dataset.amount = parseInt(moveAmount);

            if (inventoryDropName == 'wrapsecondary') {
                itemNewItem.dataset.inventory = 2;
            } else {
                itemNewItem.dataset.inventory = 1;
            }

            item.dataset.amount = startAmount - parseInt(moveAmount);
            itemNewItem.dataset.currentslot = parseInt(slot.replace(/\D/g, ''));

            let oldDragId = draggingid;

            if (!isDropped) {
                CompileStacks(
                    parseInt(slot.replace(/\D/g, '')),
                    parseInt(oldDragId.replace(/\D/g, '')),
                    inventoryDropName,
                    inventoryReturnItemDropName,
                    moveAmount,
                    item.dataset.amount,
                    moveAmount,
                    purchase,
                    purchaseCost,
                    itemidsent,
                    metainformation,
                    moveAmount,
                    arraySlot,
                );

                EndDrag(slot);
            } else {
                DropItem(oldDragId, moveAmount);
            }

            if (parseInt(item.dataset.amount) < 1) {
                document.getElementById(oldDragId).innerHTML = '';
            }

            if (!isDropped) {
                item.dataset.inventory = currentInventory;
            }

            EndDrag(oldDragId);
        } else {
            let oldDragId = draggingid;
            if (!isDropped) {
                MoveStack(
                    parseInt(slot.replace(/\D/g, '')),
                    parseInt(oldDragId.replace(/\D/g, '')),
                    inventoryDropName,
                    inventoryReturnItemDropName,
                    purchase,
                    purchaseCost,
                    itemidsent,
                    metainformation,
                    moveAmount,
                    arraySlot,
                );

                if (inventoryDropName == 'wrapsecondary') {
                    item.dataset.inventory = 2;
                } else {
                    item.dataset.inventory = 1;
                }

                item.dataset.currentslot = parseInt(slot.replace(/\D/g, ''));
                if (document.getElementById(draggingid)) {

                    document.getElementById(slot).innerHTML = document.getElementById(draggingid).innerHTML;

                    UpdateSlotBind(slot)
                    UpdateSlotBind(draggingid)
                }

                EndDrag(slot);
            } else {
                let item = document.getElementById(draggingid).getElementsByTagName('img')[0];
                item.dataset.amount = 0;
                DropItem(draggingid, amount);
                EndDrag(slot);
            }

            document.getElementById(oldDragId).innerHTML = '';
            UpdateSlotBind(oldDragId)
        }
        if (closeOnMove) {
            closeInv();
        }
    } else {
        if (isDropped) {
            CleanEndDrag();
            InventoryLog('Error: ' + result);
        } else {
            EndDragError(slot);
            // errored?
            InventoryLog('Error: ' + result);
        }
    }
}

function CleanEndDrag() {
    $('#draggedItem').css('opacity', 0.0);
    document.getElementById('draggedItem').innerHTML = '';
    isDragging = false;
    draggingid = 'none';
}

function DisplayDataSet(slot) {
    let item = document.getElementById(slot).getElementsByTagName('img')[0];
    //Example of displaying dataset information to the image AKA item we are manipulating so we can do w/e the fuck we want with that slot
}

function RequestItemData() {
    let item = document.getElementById(draggingid).getElementsByTagName('img')[0];
    currentInventory = item.dataset.inventory;
    weight = item.dataset.weight;
    amount = item.dataset.amount;
    name = item.dataset.name;
    itemid = item.dataset.itemid;
    inventoryUsedName = item.dataset.inventoryname;
    slotusing = item.dataset.currentslot;
    itemusinginfo = unescape(item.dataset.info);
}

function EndDragUsage(type) {
    EndDrag(slot);
    let slot = type;

    isDragging = false;
    draggingid = 'none';

    $('#draggedItem').css('opacity', 0.0);
    document.getElementById('draggedItem').innerHTML = '';
}

function useitem() {
    RequestItemData();
    let isWeapon = itemList[itemid].weapon;
    if (isWeapon === undefined) {
        isWeapon = false;
    }
    if (currentInventory == 1) {
        inventoryUsedName = PlayerInventoryName;
        let arr = [inventoryUsedName, itemid, slotusing, isWeapon, itemusinginfo];
        $.post('https://np-inventory/invuse', JSON.stringify(arr));
        //InventoryLog("Using item: " + name + "(" + amount + ") from " + inventoryUsedName + " | slot " + slotusing)
    }
    EndDrag(slotusing);
    closeInv(true);
}

function calculateTimeDiff(time) {
    const now = Date.now()

    const diff = now - time

    if (diff < 0) {
        if (diff > -3600000) {
            const minutes = Math.abs(Math.floor(diff / 60000))
            return `in about ${minutes} ${minutes == 1 ? 'minute' : 'minutes'}`
        }
        const hours = Math.abs(Math.floor(diff / 3600000))
        return `in about ${hours} ${hours == 1 ? 'hour' : 'hours'}`
    }

    if (diff < 3600000) {
        const minutes = Math.floor(diff / 60000)
        return `about ${minutes} ${minutes == 1 ? 'minute' : 'minutes'} ago`
    }
    const hours = Math.floor(diff / 3600000)
    return `about ${hours} ${hours == 1 ? 'hour' : 'hours'} ago`
}

//https://stackoverflow.com/questions/16994662/count-animation-from-number-a-to-b
var timer = {}
function animateValue(id, start, end, duration) {
    if (timer[id]) {
        clearInterval(timer[id])
    }
    start = Number(start);
    end = Number(end);
    duration = Number(duration);
    if (start === end) return;
    var range = end - start;
    var current = start;
    var increment = range / 10;
    var stepTime = Math.abs(Math.floor(duration / 10));
    var obj = document.getElementById(id);
    timer[id] = setInterval(() => {
        current += increment;
        if (current.toFixed(0) === end.toFixed(0)) {
            clearInterval(timer[id]);
            current = end;
        }
        obj.innerHTML = current.toFixed(0);
    }, stepTime);
}

//https://stackoverflow.com/questions/4399005/implementing-jquerys-shake-effect-with-animate
//Not adding jQuery UI :)
jQuery.fn.shake = function (interval, distance, times) {
    interval = typeof interval == 'undefined' ? 100 : interval;
    distance = typeof distance == 'undefined' ? 10 : distance;
    times = typeof times == 'undefined' ? 3 : times;
    var jTarget = $(this);
    jTarget.css('position', 'relative');
    for (var iter = 0; iter < times + 1; iter++) {
        jTarget.animate({ left: iter % 2 == 0 ? distance : distance * -1 }, interval);
    }
    return jTarget.animate({ left: 0 }, interval);
};
