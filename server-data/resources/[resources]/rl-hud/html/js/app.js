window.addEventListener('message', function (event) {

    // VEHICLE UPDATES
    if(event.data.showhud == true){
        // $('.huds').fadeIn();
        setProgressSpeed(event.data.speed,'.progress-speed');
    }
    if(event.data.showcompass == true){
        $(".direction").find(".image").attr('style', 'transform: translate3d(' + event.data.direction + 'px, 0px, 0px)');
    }
    if(event.data.showlocation == true){
        $('#showlocation').text(event.data.location);
    }
    if(event.data.clock == true){
        $('#clock').text(event.data.showclock);
    } else if (event.data.action == "toggleCar") {
        if (event.data.show){
            $('.carStats').fadeIn();
            $('.time').fadeIn();
            $('.location2').fadeIn();
            $('.direction').fadeIn();
            $("#time").removeClass("time-watch");
            $("#time").addClass("time");
        } else{
            $('.carStats').fadeOut();
            $('.time').fadeOut();
            $('.location2').fadeOut();
            $('.direction').fadeOut();
            $("#time").removeClass("time");
            $("#time").addClass("time-watch");
        }
    } else if (event.data.action == "seatbelt"){
        if(event.data.status){
            $('#seatbelt').css('stroke','#98D4E0');
        }else{
            $('#seatbelt').css('stroke','#ce2d2d00');
        }
    } else if (event.data.action == "lights"){
        if(event.data.status == "off") {
            $('#lights').css('background-image','url(img/vehicle/lowbeam.png)');
            $('#lights2').css('stroke','#98D4E000');
        }else if(event.data.status == "normal") {
            $('#lights').css('background-image','url(img/vehicle/lowbeam.png)');
            $('#lights2').css('stroke','#98D4E0');
        }else if(event.data.status == "high") {
            $('#lights2').css('stroke','#98D4E0');
            $('#lights').css('background-image','url(img/vehicle/highbeam.png)');
        }
    }else if (event.data.action == "updateGas"){
        setProgressFuel(event.data.value,'.progress-fuel');
        if (event.data.value < 15) {
            $('#fuel').css('stroke', '#f03232');
        } else if (event.data.value > 15) {
            $('#fuel').css('stroke', '#98D4E0');
        }
    }else if (event.data.action == "updateNitro"){
        setProgressNitro(event.data.value,'.progress-nitro');
        if (event.data.value < 15) {
            $('#nitro').css('stroke', '#f03232');
        } else if (event.data.value > 15) {
            $('#nitro').css('stroke', '#98D4E0');
        }
    }else if (event.data.action == "toggleWatch"){
        if (event.data.show) {
            $("#time").fadeIn();
            $("#direction").fadeIn();
            $("#location2").fadeIn();
            $("#time").removeClass("time");
            $("#time").addClass("time-watch");
        } else {
            $("#time").fadeOut();
            $("#direction").fadeOut();
            $("#location2").hide();
            $("#time").removeClass("time-watch");
            $("#time").addClass("time");
        }
    }else if (event.data.action == "updateWatchInfo"){
        if ($('#direction').is(':hidden')) $('#direction').show();
        if ($('#location2').is(':hidden')) $('#location2').show();
        if ($('#clock').is(':hidden')) $('#clock').show();
        $('#clock').text(event.data.time);
        $('#location2').text(event.data.location);
        $(".direction").find(".image").attr('style', 'transform: translate3d(' + event.data.direction + 'px, 0px, 0px)');
    }

     // PLAYER UPDATES

     switch (event.data.action) {
        case 'updateStatusHud':
            $("body").css("display", event.data.show ? "block" : "none");

            $("#boxSetHealth").css("width", event.data.health + "%");
            if (event.data.health < 20) {
                $('#boxSetHealth').css('background','#f03232');
            } else if (event.data.health > 20) {
                $('#boxSetHealth').css('background','#3bb174');
            }

            $("#boxSetArmour").css("width", event.data.armour + "%");
            if (event.data.armour < 20) {
                $('#boxSetArmour').css('background','#f03232');
            } else if (event.data.armour > 20) {
                $('#boxSetArmour').css('background','#4289ff');
            }

            widthHeightSplit(event.data.hunger, $("#boxSetHunger"));
            if (event.data.hunger < 20) {
                $('#boxSetHunger').css('background','#f03232');
            } else if (event.data.hunger > 20) {
                $('#boxSetHunger').css('background','#d29b43');
            }

            widthHeightSplit(event.data.thirst, $("#boxSetThirst"));
            if (event.data.thirst < 20) {
                $('#boxSetThirst').css('background','#f03232');
            } else if (event.data.thirst > 20) {
                $('#boxSetThirst').css('background','#507db5');
            }

            widthHeightSplit(event.data.oxygen, $("#boxSetOxygen"));
            if (event.data.oxygen < 25) {
                $('#boxSetOxygen').css('background','#f03232');
            } else if (event.data.oxygen >= 25 ) {
                $('#boxSetOxygen').css('background','#4c5b75');
            }

            widthHeightSplit(event.data.stress, $("#boxSetStress"));

            if (event.data.talking == 'normal') {
                $('#rect1').css('fill', '#ff70f8')
                $('#rect2').css('fill', '#ff70f8')
                $('#rect3').css('fill', '#ff70f8')
            } else if (event.data.talking == 'radio') {
                $('#rect1').css('fill', '#5e8eb5')
                $('#rect2').css('fill', '#5e8eb5')
                $('#rect3').css('fill', '#5e8eb5')
            } else if (event.data.talking == false) {
                $('#rect1').css('fill', '#FFFFFF')
                $('#rect2').css('fill', '#FFFFFF')
                $('#rect3').css('fill', '#FFFFFF')
            }

            if (event.data.proximity == 0) {
                $('#rect1').css('visibility', 'hidden')
                $('#rect2').css('visibility', 'hidden')
                $('#rect3').css('visibility', 'hidden')
            } else if (event.data.proximity == 1){
                $('#rect1').css('visibility', 'hidden')
                $('#rect2').css('visibility', 'visible')
                $('#rect3').css('visibility', 'visible')
            } else if (event.data.proximity == 2){
                $('#rect1').css('visibility', 'hidden')
                $('#rect2').css('visibility', 'hidden')
                $('#rect3').css('visibility', 'visible')
            } else if (event.data.proximity == 3){
                $('#rect1').css('visibility', 'visible')
                $('#rect2').css('visibility', 'visible')
                $('#rect3').css('visibility', 'visible')
            }
    }
});

function widthHeightSplit(value, ele) {
    let height = 25.5;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("height", eleHeight + "px");
    ele.css("top", leftOverHeight + "px");
};

function formatCurrency(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function setProgressSpeed(value, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var percent = value*100/220;

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    var predkosc = Math.floor(value * 1.8)
    if (predkosc == 81 || predkosc == 131) {
      predkosc = predkosc - 1
    }

    html.text(predkosc);
  }

  function setProgressFuel(percent, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }

  function setProgressNitro(percent, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }