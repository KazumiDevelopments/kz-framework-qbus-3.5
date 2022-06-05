var open = false;
$(function () {
    window.addEventListener('message', function (event) {
        if (event.data.type == "enabletestdrive") {
            open = event.data.enable;
            if (open) {
                document.body.style.display = "block";
                $("#testdrive").attr("style", "display: block;position: relative;left: 500px;");
            } else {
                document.body.style.display = "none";
                $("#testdrive").attr("style", "display: none");
            }
        }
    })

    function closeMenu() {
        document.body.style.display = "none";
        $("#testdrive").attr("display", "none");
    }

    $('.secondary-content').on('click', function() {
        closeMenu();
        $.post('http://rl-driftschool/spawntestdrive', JSON.stringify({model: $(this).parents('li').attr('value')}));
    })

    $('#close').on('click', function() {
        closeMenu();
        $.post('http://rl-driftschool/closemenu', JSON.stringify({}));
    })
})