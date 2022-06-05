var itemDataList = {}

$(document).on('click', '.sellix-item', function(e){
    e.preventDefault();

    $(".sellix-homescreen").animate({
        left: 30+"vh"
    }, 200);
    $(".sellix-detailscreen").animate({
        left: 0+"vh"
    }, 200);

    var Id = $(this).attr('id');
    SetupSDetails(itemDataList[Id]);  
});

$(document).on('click', '.sellix-footer-back', function(e){
    e.preventDefault();

    $(".sellix-homescreen").animate({ left: 00+"vh" }, 200);
    $(".sellix-detailscreen").animate({ left: -30+"vh" }, 200);

    $.post('http://rl-phone/SetupSellix', JSON.stringify({}), function(data){
        SetupSellixData(data); 
    });
});

$(document).on('click', '.sellix-footer-take', function(e){
    e.preventDefault();

    $(".sellix-homescreen").animate({ left: 00+"vh" }, 200);
    $(".sellix-detailscreen").animate({ left: -30+"vh" }, 200);
    $.post('http://rl-phone/ActivateBuyer', JSON.stringify({
        id: $(this).attr('id'),
    }), function(succ){
        if (succ == 0) {
            RL.Phone.Notifications.Add("fas fa-check-circle", "SellixShop", "Successfully took this offer.", "#badc58", 1750);
        } else if (succ == 2) {
            RL.Phone.Notifications.Add("fas fa-exclamation-triangle", "SellixShop", "This offer isn't exists anymore.", "#c73434", 1750);
        } else {
            RL.Phone.Notifications.Add("fas fa-exclamation-triangle", "SellixShop", "You can't start another run atm.", "#c73434", 1750);
        }

        $.post('http://rl-phone/SetupSellix', JSON.stringify({}), function(data){
            SetupSellixData(data); 
        });
    })
});

SetupSellixData = function(data) {
    if (data == 'banned') {
        $(".sellix-items").html("<span class='sellix-banned'><center>You are banned.</center></span>");
    } else {
        $(".sellix-items").html("<span class='sellix-title'>Available Offers (" + data.length +")</span>");
        if (data != null) {
            data.reverse();
            $.each(data, function(i, item){
                var Element = '<div class="sellix-item" id="itemKey-' + item.itemKey + '"> <span class="sellix-item-firstletter" style="background-image: url(' + item.buyerData[2] + ')"></span><span class="sellix-item-data"><b style="font-size: 1.4vh;">' + item.buyerData[1] + '</b><br>' + item.quantity + 'x ' + item.name + '<span id="itemdata-price">$' + parseInt(item.quantity * item.price) + '</span></span></div>';
                $(".sellix-items").append(Element);
                itemDataList["itemKey-" + item.itemKey] = item;
            });
        }
    }
}

SetupSDetails = function(data) {
    $(".itemdetail-box-buyer").find(".item-answer").html(data.buyerData[1]);
    $(".itemdetail-box-delivery").find(".item-answer").html(parseInt(data.delivery / 60000) + ' Minutes');
    $(".itemdetail-box-item").find(".item-answer").html(data.name);
    $(".itemdetail-box-quantity").find(".item-answer").html(data.quantity);
    $(".itemdetail-box-price").find(".item-answer").html('$' + parseInt(data.quantity * data.price));
    $(".sellix-footer-take").attr('id', data.itemKey);
}