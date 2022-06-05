ShowroomFunctions = {}


var selectedId = 0
var selectedCat = 0
var formatter = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
});
var current = {}
var zone = null

var canPress = false

var ShowroomFunctions = {
    Load: function () {
        console.log("Showroom: Loading...");
        $(".showroom-wrapper").show();
        $(".showcase").hide();
        $(".main").hide();
        $(".start-container").show();
        $(".lds-spinner").show();
        ShowroomFunctions.GetCars()
        setTimeout(function () {
            $(".showcase").show();
            $(".main").show()
            setTimeout(function () {
                $(".start-container").hide();
                $(".lds-spinner").hide();
                $("#purchase").css("z-index", 99);
                canPress = true
            }, 2850);
        }, 1000);
    },

    ResourceStart: function () {
        $(".start-container").hide();
        $(".lds-spinner").hide();
    },

    GetCars: function () {
        $.post('https://np-showrooms/np-ui:showroomChangeCar', JSON.stringify({ model: cars[selectedId].model }), function (cb) {
            ShowroomFunctions.SelectWaitEnd()
            left = 64
            for (let i = 0; i < cars.length; i++) {
                if (i == 0) {
                    classes = "car-container car-container-selected"
                    selectedId = i
                } else {
                    classes = "car-container"
                }
                if (!cars[i].onStock) {
                    data = `
                <div carid='${i}' class='${classes}' style='left:${left}px; background: url(&quot;https://gta-assets.nopixel.net/images/showroom-vehicles/${cars[i].model}.jpg&quot;) 0% 0% / cover no-repeat rgb(0, 0, 0); user-select: none;'>\
                    <div class="top"><span>${formatter.format(cars[i].price)}</span>
                        <div class="limited"><svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="stop-circle" class="svg-inline--fa fa-stop-circle fa-w-16 fa-fw fa-2x " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                            <path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm96 328c0 8.8-7.2 16-16 16H176c-8.8 0-16-7.2-16-16V176c0-8.8 7.2-16 16-16h160c8.8 0 16 7.2 16 16v160z">
                            </path></svg>
                        </div>
                    </div>
                    <div class="middle"></div>
                    <div class="bottom"><span>&nbsp;</span><span>${cars[i].label}</span></div>
                </div>`
                } else {
                    data = `
                <div carid='${i}' class='${classes}' style='left:${left}px; background: url(&quot;https://gta-assets.nopixel.net/images/showroom-vehicles/${cars[i].model}.jpg&quot;) 0% 0% / cover no-repeat rgb(0, 0, 0); user-select: none;'>\
                    <div class="top"><span>${formatter.format(cars[i].price)}</span>
                    </div>
                    <div class="middle"></div>
                    <div class="bottom"><span>&nbsp;</span><span>${cars[i].label}</span></div>
                </div>`
                }


                $(".showcase").append(data);
                left = left + 284
            };
            ShowroomFunctions.ChangeCars()
        });
    },

    ChangeCars: function (c) {
        $.post('https://np-showrooms/np-ui:showroomChangeCar', JSON.stringify({ model: cars[selectedId].model }), function (cb) {
            ShowroomFunctions.SelectWaitEnd()
        $(".position-container").html((selectedId + 1) + " / " + cars.length);
        cname = cars[selectedId].label;
        cbrand = cars[selectedId].brand;
        cclass = cars[selectedId].class;
        data = `
            <div class="brand-container">
                <div class="veh-class">${cb.data.vehClass}</div>
                <div class="brand">${cb.data.brand}</div>
                <div class="name">${cars[selectedId].label}</div>
            </div>`
        $(".make-model").html(data);

        acceleration = parseFloat(JSON.stringify(cb.data.info[0].value)).toFixed(1)
        if (acceleration > 10){
            acceleration = 10
        }
        $(".value>div[type='acceleration']").html(acceleration)
        $(".bg>div[type='acceleration']").animate({
            width: parseFloat(acceleration).toFixed(1) * 10 + '%',
        });
        speed = parseFloat(JSON.stringify(cb.data.info[1].value)).toFixed(1)
        if (speed > 10){
            speed = 10
        }
        $(".value>div[type='speed']").html(speed)
        $(".bg>div[type='speed']").animate({
            width: parseFloat(speed).toFixed(1) * 10 + '%',
        });
        handling = parseFloat(JSON.stringify(cb.data.info[2].value)).toFixed(1)
        if (handling > 10){
            handling = 10
        }
        $(".value>div[type='handling']").html(handling)
        $(".bg>div[type='handling']").animate({
            width: parseFloat(handling).toFixed(1) * 10 + '%',
        });
        braking = parseFloat(JSON.stringify(cb.data.info[3].value)).toFixed(1)
        if (braking > 10){
            braking = 10
        }
        $(".value>div[type='braking']").html(braking)
        $(".bg>div[type='braking']").animate({
            width: parseFloat(braking).toFixed(1) * 10 + '%',
        });
        $(".price>span").html(formatter.format(cars[selectedId].price))
    });
    },

    SelectWait: function () {
        $(".lds-spinner").show();
        // canPress = false
    },

    SelectWaitEnd: function () {
        $(".lds-spinner").hide();
        canPress = true
    },

    GetFirstInCategory: function (category) {
        for (let i = 0; i < cars.length; i++) {
            if (parseInt(category) == cars[i].category || !cars[i].category == undefined) {
                firstId = i
                return firstId
            }
        }
    },  

    Close: function() {
        $(".showroom-wrapper").hide();
        $(".showcase").hide();
        $(".main").hide();
        $("#purchase").css("z-index", 1);
    },


}

$(document).ready(function () {
    $(".showroom-wrapper").hide()
    ShowroomFunctions.ResourceStart()
    window.addEventListener('message', (event) => {
        let data = event.data
        if (data.shop == 'pdm') {
            zone = "pdm"
            ShowroomFunctions.Load()
            return
        }
        if (data.meta.message = "done") {
            ShowroomFunctions.Close()
            $.post('https://np-showrooms/np-ui:application-closed', JSON.stringify({ name: "showroom" }));
        }
    })
});

$(document).keydown(function(event) {
    if (event.which == "27"){
        ShowroomFunctions.Close()
        $.post('https://np-showrooms/np-ui:application-closed', JSON.stringify({ name: "showroom" }));
    }
});

$(document).on("click", "#purchase", function () {
    canPress = false
    $.post('https://np-showrooms/showroomPurchaseCurrentVehicle', JSON.stringify({ model: cars[selectedId].model, price:cars[selectedId].price, zoneName: zone }), function(cb){
     if( cb.meta.ok) {
        ShowroomFunctions.Close()
        canPress = false
     } else {
        canPress = true
     }
    });
});


$(document).on("click", ".btn", function () {
    control = $(this).attr("value")
    if (!canPress) {
        return
    }
    if (control == "next") {
        if (selectedId + 1 >= cars.length) {
            return
        }
        newId = selectedId + 1
        for (let i = 0; i < cars.length; i++) {
            left = $(".car-container[carid='" + i + "']").css("left")
            newleft = parseInt(left) - 284
            $(".car-container[carid='" + i + "']").css("left", newleft + "px")
        }
        $("div[carid='" + selectedId + "']").removeClass("car-container-selected")
        $("div[carid='" + newId + "']").addClass("car-container-selected")
        selectedId = newId
        $(".mclass").removeClass("mclass-selected")
        $("div[category='"+cars[newId].category+"']").addClass("mclass-selected")
        ShowroomFunctions.SelectWait()
        ShowroomFunctions.ChangeCars()
    } else if(control == "prev") {
        if (selectedId - 1 < 0) {
            return
        }
        newId = selectedId - 1
        for (let i = 0; i < cars.length; i++) {
            left = $(".car-container[carid='" + i + "']").css("left")
            newleft = parseInt(left) + 284
            $(".car-container[carid='" + i + "']").css("left", newleft + "px")
        }
        $("div[carid='" + selectedId + "']").removeClass("car-container-selected")
        $("div[carid='" + newId + "']").addClass("car-container-selected")
        selectedId = newId
        $(".mclass").removeClass("mclass-selected")
        $("div[category='"+cars[newId].category+"']").addClass("mclass-selected")
        ShowroomFunctions.SelectWait()
        ShowroomFunctions.ChangeCars()
    }
});

$(document).on("click", ".car-container", function () {
    if (!canPress) {
        return
    }
    newId = $(this).attr("carid")
    if (newId > cars.length) {
        return
    }
    ShowroomFunctions.SelectWait()
    if (parseInt(newId) > selectedId) {
        for (let i = 0; i < cars.length; i++) {
            diffrence = parseInt(newId) - selectedId
            left = $(".car-container[carid='" + i + "']").css("left")
            newleft = parseInt(left) - 284 * diffrence
            $(".car-container[carid='" + i + "']").css("left", newleft + "px")
            $("div[carid='" + selectedId + "']").removeClass("car-container-selected")
            $("div[carid='" + newId + "']").addClass("car-container-selected")
        }
    } else if (parseInt(newId) < selectedId) {
        for (let i = 0; i < cars.length; i++) {
            diffrence = selectedId - parseInt(newId)
            left = $(".car-container[carid='" + i + "']").css("left")
            newleft = parseInt(left) + 284 * diffrence
            $(".car-container[carid='" + i + "']").css("left", newleft + "px")
            $("div[carid='" + selectedId + "']").removeClass("car-container-selected")
            $("div[carid='" + newId + "']").addClass("car-container-selected")
        }
    }
    selectedId = parseInt(newId)
    newcat = cars[newId].category
    $(".mclass").removeClass("mclass-selected")
    $("div[category='"+newcat+"']").addClass("mclass-selected")
    ShowroomFunctions.ChangeCars()
});

$(document).on("click", ".mclass", function () {
    category = $(this).attr("category")
    $(".mclass").removeClass("mclass-selected")
    $(this).addClass("mclass-selected")
    firstId = ShowroomFunctions.GetFirstInCategory(category)
    if (firstId > selectedId) {
        for (let i = 0; i < cars.length; i++) {
            diffrence = firstId - selectedId
            left = $(".car-container[carid='" + i + "']").css("left")
            newleft = parseInt(left) - 284 * diffrence
            $(".car-container[carid='" + i + "']").css("left", newleft + "px")
            $("div[carid='" + selectedId + "']").removeClass("car-container-selected")
            $("div[carid='" + firstId + "']").addClass("car-container-selected")
        }
    } else if (firstId < selectedId) {
        for (let i = 0; i < cars.length; i++) {
            diffrence = selectedId - firstId
            left = $(".car-container[carid='" + i + "']").css("left")
            newleft = parseInt(left) + 284 * diffrence
            $(".car-container[carid='" + i + "']").css("left", newleft + "px")
            $("div[carid='" + selectedId + "']").removeClass("car-container-selected")
            $("div[carid='" + firstId + "']").addClass("car-container-selected")
        }
    }
    selectedId = firstId
    ShowroomFunctions.ChangeCars()
});

