$(document).ready(function() {
    $('.police-actives').fadeOut();
    $('.police-settings').fadeOut();
    $('.material-icons').fadeOut();
});

var fontsize = 15
addEventListener("message", function(event){
    let item = event.data;

    if(item.type == 'police-actives') { 
        if (item.data) {
            document.getElementById("police-actives-data").innerHTML = item.data;
            $('.police-actives').fadeIn(750);
        }

        if(item.drag == 0) {
            startTimeout();
        } else if(item.drag == 1) {
            $('.material-icons').fadeIn(750);
            dragElement(document.getElementById("police-actives-div"));
        }
        
        if(item.close != null && item.close != undefined && !item.close) {
            $('.police-actives').fadeOut(750);
        }
        
    } else if(item.type == 'update-title') { 
        document.getElementById("title").innerHTML = item.data;
    } else if(item.type == 'update-officers') { 
        document.getElementById("police-actives-data").innerHTML = item.data;
        document.getElementById("police-actives-data").innerHTML = item.data;
    } else if(item.type == 'close') { 
        $('.police-actives').fadeOut(750);
    }

    
});

function dragElement(elmnt) {
    var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
    document.getElementById("police-actives-div").onmousedown = dragMouseDown;

    function dragMouseDown(e) {
        e = e || window.event;
        e.preventDefault();
        pos3 = e.clientX;
        pos4 = e.clientY;
        document.onmouseup = closeDragElement;
        document.onmousemove = elementDrag;
    }

    function elementDrag(e) {
        e = e || window.event;
        e.preventDefault();
        pos1 = pos3 - e.clientX;
        pos2 = pos4 - e.clientY;
        pos3 = e.clientX;
        pos4 = e.clientY;
        document.getElementById("police-actives-div").style.top = (document.getElementById("police-actives-div").offsetTop - pos2) + "px";
        document.getElementById("police-actives-div").style.left = (document.getElementById("police-actives-div").offsetLeft - pos1) + "px";
    }

    function closeDragElement() {
        document.onmouseup = null;
        document.onmousemove = null;
    }
}

function startTimeout() {
    setTimeout(() => {
        $('.police-actives').fadeOut(750);
    }, 5000);
}

function closeNUI() {
    $('.material-icons').fadeOut(750);
    startTimeout();
    $.post('http://bb-scripts/closeUI');
}

function updateMaxPlayers(id, value) {
    if (id == 'fontsize-range'){
        fontsize = value * 5;
        $('#' + id + '-data').html(fontsize);
    }
}