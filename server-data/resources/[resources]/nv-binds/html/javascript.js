var binds = [];
var currentbind = 0;
var currentedit = null;
var currentcomamnds = null;

addEventListener("message", function(event){
    let item = event.data;

    if(item.open == true) {
        if (item.class == "open") {
            $('.main-container').fadeIn();
            $('.binds-container').fadeIn();
        }

        if (item.class == "update") {
            currentedit = null;

            binds = item.binds;
            var html = ""
            if (currentbind && binds[currentbind]) {
                console.log("last location!");
            } else {
                currentbind = 0;
            }

            var html = '<div class="box box-shadow" id="item-' + currentbind + '"><span class="hoster-options" id="options-' + currentbind + '"><span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-' + currentbind + '" class="fas fa-angle-double-up up"></i>  <i id="item-' + currentbind + '" class="fas fa-angle-double-down down"></i></span></span><span class="option-text" id="' + currentbind + '">' + (currentbind + 1) + '. ' + binds[currentbind].label + ' - <span id="bind-' + currentbind + '" class="bind">' + binds[currentbind].bind + '</span></span></div>';
            html = html + SetupCommandBinds([]);

            document.getElementById('binds-list').innerHTML = html;
        }
    } else {
        $('.main-container').fadeOut();
        $('.binds-container').fadeOut();
        
        $.post('http://nv-binds/closeNUI');
    }
});

$(document).on('click', '.goto', function(e) {
    var from = $(this).attr('datafrom');
    var to = $(this).attr('datato');
    if (to == 'quit') {
        $('.main-container').fadeOut();
        $('.binds-container').fadeOut();

        $.post('http://nv-binds/closeNUI');
    } else {
        $('.' + from).fadeOut(0);
        $('.' + to).fadeIn();
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


$(document).on('click', '.up', function(e) {
    if (currentedit) {
        return;
    }
    
    var html = "";
    currentbind = currentbind + 1;
    if (binds[currentbind]) {
        html = '<div class="box box-shadow" id="item-' + currentbind + '"><span class="hoster-options" id="options-' + currentbind + '"><span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-' + currentbind + '" class="fas fa-angle-double-up up"></i>  <i id="item-' + currentbind + '" class="fas fa-angle-double-down down"></i></span></span><span class="option-text" id="' + currentbind + '">' + (currentbind + 1) + '. ' + binds[currentbind].label + ' - <span id="bind-' + currentbind + '" class="bind">' + binds[currentbind].bind + '</span></span></div>';
    } else {
        currentbind = 0;
        html = '<div class="box box-shadow" id="item-' + currentbind + '"><span class="hoster-options" id="options-' + currentbind + '"><span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-' + currentbind + '" class="fas fa-angle-double-up up"></i>  <i id="item-' + currentbind + '" class="fas fa-angle-double-down down"></i></span></span><span class="option-text" id="' + currentbind + '">' + (currentbind + 1) + '. ' + binds[currentbind].label + ' - <span id="bind-' + currentbind + '" class="bind">' + binds[currentbind].bind + '</span></span></div>';
    }

    document.getElementById('binds-list').innerHTML = html;
});


$(document).on('click', '.down', function(e) {
    if (currentedit) {
        return;
    }

    var html = "";
    currentbind = currentbind - 1;
    if (binds[currentbind]) {
        html = '<div class="box box-shadow" id="item-' + currentbind + '"><span class="hoster-options" id="options-' + currentbind + '"><span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-' + currentbind + '" class="fas fa-angle-double-up up"></i>  <i id="item-' + currentbind + '" class="fas fa-angle-double-down down"></i></span></span><span class="option-text" id="' + currentbind + '">' + (currentbind + 1) + '. ' + binds[currentbind].label + ' - <span id="bind-' + currentbind + '" class="bind">' + binds[currentbind].bind + '</span></span></div>';
    } else {
        currentbind = binds.length-1;
        html = '<div class="box box-shadow" id="item-' + currentbind + '"><span class="hoster-options" id="options-' + currentbind + '"><span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-' + currentbind + '" class="fas fa-angle-double-up up"></i>  <i id="item-' + currentbind + '" class="fas fa-angle-double-down down"></i></span></span><span class="option-text" id="' + currentbind + '">' + (currentbind + 1) + '. ' + binds[currentbind].label + ' - <span id="bind-' + currentbind + '" class="bind">' + binds[currentbind].bind + '</span></span></div>';
    }

    document.getElementById('binds-list').innerHTML = html;
});

$(document).on('click', '.option-text', function(e) {
    if (currentedit) {
        return;
    }

    var id = $(this).attr('id');
    currentedit = id;
    document.getElementById('bind-' + id).innerHTML = "<input type='text' class='option-input'>";
    document.getElementById('options-' + id).innerHTML = '<span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-' + currentbind + '" class="fas fa-check-circle edit"></i></span>';
});

$(document).on('click', '.edit', function(e) {
    if (currentedit) {
        var id = $(this).attr('id');
        var key = $(".option-input").val();
        var name = binds[currentbind].name;

        $.post('http://nv-binds/EditBind', JSON.stringify({
            bind: name,
            key: key,
        }));

    }
});

function SetupCommandBinds(commands) {
    var bi = ["F3", "F4", "F5", "F6", "F7"]
    var html = "";

    for (i = 0; i < bi.length; i++) {
        if (commands[i]) {
            html = html + '<div class="box box-shadow" id="item-' + currentbind + '"><span class="hoster-options" id="options-' + currentbind + '"><span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-' + currentbind + '" class="fas fa-angle-double-up up"></i>  <i id="item-' + currentbind + '" class="fas fa-angle-double-down down"></i></span></span><span class="option-text" id="' + currentbind + '">' + (currentbind + 1) + '. ' + binds[currentbind].label + ' - <span id="bind-' + currentbind + '" class="bind">' + binds[currentbind].bind + '</span></span></div>';
        } else {
            html = html + '<div class="box box-shadow" id="item-new-' + i + '"><span class="hoster-options" id="options-new-' + i + '"><span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-new-' + i + '" class="fas fa-plus-circle down"></i></span></span><span class="option-text" id="' + i + '" class="command-input">' + bi[i] + '. No Command</span></div>';
        }
    }

    return html;
}