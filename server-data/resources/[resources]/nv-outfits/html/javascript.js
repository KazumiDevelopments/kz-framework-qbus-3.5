var choosingGrade = ''

addEventListener("message", function(event){
    let item = event.data;

    if(item.open == true) {
        if (item.class == "open") {
            $('.main-container').fadeIn();
            $('.outfits-container').fadeIn();
        }

        if (item.class == "update") {
            document.getElementById('outfits-list').innerHTML = item.outfits;
        }
    } else {
        $('.main-container').fadeOut();
        $('.outfits-container').fadeOut();
        
        $.post('http://nv-outfits/closeNUI');
    }
});

$(document).on('click', '.goto', function(e) {
    var from = $(this).attr('datafrom');
    var to = $(this).attr('datato');
    if (to == 'quit') {
        $('.main-container').fadeOut();
        $('.outfits-container').fadeOut();
        $('.settings-container').fadeOut();
        $.post('http://nv-outfits/closeNUI');
    } else {
        $('.' + from).fadeOut(0);
        $('.' + to).fadeIn();
    }
});

$(document).on('click', '.deleteoutfit', function(e) {
    var id = $(this).attr('id');
    var outfitID = id.substring(5);

    $.post('http://nv-outfits/DeleteOutfit', JSON.stringify({
        slot: outfitID,
    }));
});

$(document).on('click', '.createoutfit', function(e) {
    var id = $(this).attr('id');
    var outfitID = id.substring(5);

    console.log(outfitID);
    $('.box#item-' + outfitID).html('<span class="hoster-options" id="options-' + outfitID + '"><span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-' + outfitID + '" class="fas fa-check-circle saveoutfit"></i></span></span><span id="option-text">' + outfitID + '. </span><input class="option-input" id="input-' + outfitID + '"></input>');
});

$(document).on('click', '.selectoutfit', function(e) {
    var id = $(this).attr('id');
    var outfitID = id.substring(5);

    $.post('http://nv-outfits/SelectOutfit', JSON.stringify({
        slot: outfitID,
    }));
});

$(document).on('click', '.saveoutfit', function(e) {
    var id = $(this).attr('id');
    var outfitID = id.substring(5);
    var outfitName = $('.option-input#input-' + outfitID).val();
    console.log(outfitID);
    console.log(outfitName);

    if (outfitName.length > 2) {
        $.post('http://nv-outfits/CreateOutfit', JSON.stringify({
            slot: outfitID,
            name: outfitName,
        }));
    }
});


$(document).on('mouseenter', '.box', function (event) {
    var id = $(this).attr('id');
    var playerid = id.substring(5);
    $('.hoster-options#options-' + playerid).fadeIn();
}).on('mouseleave', '.box',  function(){
    var id = $(this).attr('id');
    var playerid = id.substring(5);
    $('.hoster-options#options-' + playerid).fadeOut(0);
});
