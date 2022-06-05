var documentWidth = document.documentElement.clientWidth;
var documentHeight = document.documentElement.clientHeight;

var cursor = document.getElementById("cursor");
var cursorX = documentWidth / 2;
var cursorY = documentHeight / 2;

var volume = 100

function UpdateCursorPos() {
    cursor.style.left = cursorX;
    cursor.style.top = cursorY;
}

function Click(x, y) {
    var element = $(document.elementFromPoint(x, y));
    element.focus().click();
}

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "enableui") {
            cursor.style.display = event.data.enable ? "block" : "none";
            document.body.style.display = event.data.enable ? "block" : "none";
        } else if (event.data.type == "click") {
            // Avoid clicking the cursor itself, click 1px to the top/left;
            Click(cursorX - 1, cursorY - 1);
        } else if (event.data.type == "volume") {
            volume = event.data.volume
            $("#volume").text("Volume: " + volume + "%");
        }
    });

    $(document).mousemove(function(event) {
        cursorX = event.pageX;
        cursorY = event.pageY;
        UpdateCursorPos();
    });

    $("#volumeUp").hover(function(e) {
        $("#tooltip").text("Volume Up");
    }, function() {
        $("#tooltip").text("");
    });

    $("#volumeDown").hover(function(e) {
        $("#tooltip").text("Volume Down");

    }, function() {
        $("#tooltip").text("");
    });

    $("#onoff").hover(function(e) {
        $("#tooltip").text("Power");
    }, function() {
        $("#tooltip").text("");
    });





    document.onkeyup = function(data) {
        if (data.which == 27) { // Escape key
            $.post('https://radio/escape', JSON.stringify({}));
        }
    };

    $("#login-form").submit(function(e) {
        e.preventDefault(); // Prevent form from submitting

        $.post('https://radio/joinRadio', JSON.stringify({
            channel: $("#channel").val()
        }));
    });

    $("#onoff").click(function(e) {
        e.preventDefault(); // Prevent form from submitting

        $.post('https://radio/leaveRadio', JSON.stringify({

        }));
    });

    $("#volumeUp").click(function() {
        $.post('https://radio/click', JSON.stringify({}));
        $.post('https://radio/volumeUp', JSON.stringify({}));
    });

    $("#volumeDown").click(function() {
        $.post('https://radio/click', JSON.stringify({}));
        $.post('https://radio/volumeDown', JSON.stringify({}));
    });

});