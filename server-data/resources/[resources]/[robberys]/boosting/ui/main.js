let amountoftasks = 0

const idsvin = []

function AddNotify(data) {
    var $notification = $(document.createElement('div'));
    $notification.addClass('slideinanim').html(` <div class="police-alert">
    <h1 style="font-size: 1.2vmin;position: relative;top: 0.8vmin;left: 3%;font-weight: 600;">Car Theft In Progress</h1>
    <div class="police-info" style="position: relative;left: 3%;top: -2%;">
        <i class="fas fa-car-alt"></i> <p class="plate" style="margin-right: 0.3vmin;">${data.plate}</p> ${data.model}
        <br>
        <i class="fas fa-palette"></i> ${data.color}
        <br>
        <i class="fas fa-location-arrow"></i> ${data.place}
    </div>  
</div> `)
    $(".police-dispatch").prepend($notification)


    setTimeout(() => {
        $notification.removeClass('slideinanim').addClass('slideoutanim')
        setTimeout(() => {
            $notification.remove()
        }, 700);
    }, data.length);
}


function AddTask(data) {
    amountoftasks = amountoftasks + 10
    if (data.vin == true) {
        idsvin.push(data.id)
    }
    // }
    let text = 'START CONTRACT'
    let disabled = ''
    let color = '#4ebb29'
    if (data.started === true) {
        text = 'CONTRACT IN PROGRESS'
        disabled = 'disabled'
        color = "#5c5c5c"
    }
    $(".vehicles-bar").append(` 
    <div class="vehicle-boosting" data-id=${data.id}>

    <div class="vehicle-info" style="position: relative;top:15%;left: 2%;">
    <div class="circle-shit">
        <p>${data.type}</p>
    </div>


    <p style="font-weight: bold;font-size: 17px;margin-top: -6%;" >${data.vehicle}</p>
    <div class="vehicle-info">
        <p style="color:#bdbec9;margin-top: 1.4vh;">Buy In: <span style="color: green">${data.price} BNE</span></p>
    </div>
    <div class="vehicle-price">
        <p style="color: #bdbec9;margin-top: 1.4vh;">Expires: <span style="color: green">${data.expires}</span> </p>
    </div>
   <div style="display: grid;grid-row-gap: 8px;position: absolute;top: 120%;left: 45%;transform: translate(-50% );width: 80%;">
        <button class="btn-startboosting" data-task="start" data-pshit=${data.id} ${disabled} data-id=${data.id} data-price=${data.price} style="width: 100%;">${text}</button>
        <button class="btn-transferbutton" data-task="transfer" data-id=${data.id} style="width: 100%" >TRANSFER CONTRACT</button> 
        <button class="btn-stopboosting" data-task="decline" data-id=${data.id} style="width: 100%">DECLINE CONTRACT</button> 

    </div>

</div>

</div>
    </div>`)
}

$(document).ready(function() {
    $(".btn-leaveboostingQ").hide();
	$('input[type=number]').on('mousewheel', function(e) {
       $(e.target).blur();
    });

    let id = 0
    var bne = 0
    let dddurl = ''

    window.addEventListener('message', function(e) {
        if (e.data.show === 'true') {
            bne = e.data.BNE
            timeString12hr = new Date('1970-01-01T' + e.data.time + 'Z').toLocaleTimeString('en-US', { hour12: true, hour: '2-digit', minute: '2-digit' });
            $("#bnestatus").html(`Wallet: <span style="color:green">${bne} BNE</span>`)
            $("#clock").text(timeString12hr)
            $("#logoicon").attr("src", e.data.logo);
            $(".tablet-container").show()
            $(".tablet-container").css('background-image', "url(" + e.data.background + ")")
            dddurl = e.data.defaultback
        }

        if (e.data.add === 'true') {
            AddTask(e.data.data)
        }
        if (e.data.addNotify === 'true') {
            AddNotify(e.data)
        }
    })

    $(document).on('click', ".btn-dialog", function() {
        $("#StartContract").fadeOut()
        if ($(this).data('idk') == 'normal') {
            close()
            $.post(`https://${GetParentResourceName()}/dick`, JSON.stringify({
                id: id,
                price: price,
            }));

        } else {

            close()
            $.post(`https://${GetParentResourceName()}/vin`, JSON.stringify({
                id: id,
                price: price,
            }));

        }
    })
	
	$(document).on('click', ".btn-transferdialog", function() {
        $("#TransferContract").fadeOut()
        if ($(this).data('transfer') == 'Send') {
            close()
            $.post(`https://${GetParentResourceName()}/transfercontract`, JSON.stringify({
                contract: contract,
				target: $("#ContractReceiver").val(),
            }));
			$.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));

        }
    })


    function close() {
        amountoftasks = 0

        $(".tablet-container").hide()
        $(".vehicles-bar").empty()
        $(".boosting-container").hide()

    }

    $("#background-apply").click(function() {
        $.post(`https://${GetParentResourceName()}/updateurl`, JSON.stringify({ url: $("#bacgkroundurl").val() }));

        $(".tablet-container").css('background-image', "url(" + $("#bacgkroundurl").val() + ")")
    })

    $("#background-reset").click(function() {
        $.post(`https://${GetParentResourceName()}/updateurl`, JSON.stringify({ url: dddurl }));

        $(".tablet-container").css('background-image', "url(" + dddurl + ")")
    })
	
    $(document).on('click', ".btn-startboosting", function() {
        id = $(this).data('id')
        price = $(this).data('price')
        if (id === null) {
            return
        }
        $(document).on('click', "#closevin", function() {
            $("#StartContract").fadeOut()
        })
        if (idsvin.indexOf(id) >= 0) {
            $("#StartContract").fadeIn()
        } else {
            close()
            $.post(`https://${GetParentResourceName()}/dick'`, JSON.stringify({
                id: id,
                price: price,
            }));
        }
    });
	
	 $(document).on('click', ".btn-transferbutton", function() {
        contract = $(this).data()
        if (contract === null) {
            return
        }
		$(document).on('click', "#closetransfer", function() {
            $("#TransferContract").fadeOut()
        })
		$("#TransferContract").fadeIn()
        // $.post(`https://${GetParentResourceName()}/transfercontract`, JSON.stringify({
            // contract: contract,
			// target: $("#ContractReceiver").val(),
        // }));
    });

    $(document).on('click', ".btn-stopboosting", function() {
        id = $(this).data('id')
        price = $(this).data('price')
        if (id === null) {
            return
        }
        $(`div.vehicle-boosting[data-id="${id}"]`).remove()
        $.post(`https://${GetParentResourceName()}/decline`, JSON.stringify({
            id: id,
            price: price,
        }));
    });


    $(document).on('input', ".colorpicker", function() {
        $(".tablet-taskbar").css('background-color', $(".colorpicker").val());
    });

    $(document).on('click', ".btn-JoinboostingQ", function() {
        $.post(`https://${GetParentResourceName()}/joinBoostQueue`, JSON.stringify({}));
        $(".btn-JoinboostingQ").hide();
        $(".btn-leaveboostingQ").show();
    });

    $(document).on('click', ".btn-leaveboostingQ", function() {
        $.post(`https://${GetParentResourceName()}/leaveBoostQueue`, JSON.stringify({}));
        $(".btn-leaveboostingQ").hide();
        $(".btn-JoinboostingQ").show();
    });


    $(document).on('click', ".btn-closeboosting", function() {
        $(".boosting-container").fadeToggle('slow')
    });

    $(document).on('click', ".btn-closesettings", function() {
        $(".boosting-settings").fadeToggle('slow')
    });

    $(".settings").click(function() {
        $(".boosting-container").fadeOut('fast')
        $(".boosting-settings").fadeToggle('slow')
    })

    $(document).keyup(function(e) {

        if (e.key === "Escape") {
            close()
            $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
        }
    });


    $(".boosting").click(function(e) {
        $(".boosting-settings").fadeOut('fast')
        $(".prog-bar").css('width', amountoftasks + "%")
        $(".tablet-taskbar").append(`
        <div style="position: absolute;width:2vh;height: 2vh;border-radius: 5px;margin-left: 8vh;background-color: #353d49;font-size:6px;display: flex;justify-content: center;align-items: center;margin*">
            <h1 style="color: white;font-family: 'Segoe UI', Arial , sans-serif;">B</h1>
        </div>`)
        $(".boosting-container").fadeToggle('slow')


    });

    Coloris({
        wrap: true,

        // Available themes: default, large, polaroid.
        // More themes might be added in the future.
        theme: 'default',

        // Set the theme to light or dark mode:
        // * light: light mode (default).
        // * dark: dark mode.
        // * auto: automatically enables dark mode when the user prefers a dark color scheme.
        themeMode: 'dark',

        // The margin in pixels between the input fields and the color picker's dialog.
        margin: 2,

        // Set the preferred color string format:
        // * hex: outputs #RRGGBB or #RRGGBBAA (default).
        // * rgb: outputs rgb(R, G, B) or rgba(R, G, B, A).
        // * hsl: outputs hsl(H, S, L) or hsla(H, S, L, A).
        // * auto: guesses the format from the active input field. Defaults to hex if it fails.
        // * mixed: outputs #RRGGBB when alpha is 1; otherwise rgba(R, G, B, A).
        format: 'hex',

        // Set to true to enable format toggle buttons in the color picker dialog.
        // This will also force the format (above) to auto.
        formatToggle: false,

        // Enable or disable alpha support.
        // When disabled, it will strip the alpha value from the existing color value in all formats.
        alpha: true,

        // Focus the color value input when the color picker dialog is opened.
        focusInput: true,

        // Show an optional clear button and set its label
        clearButton: {
            show: true,
            label: 'Clear'
        },

        // An array of the desired color swatches to display. If omitted or the array is empty,
        // the color swatches will be disabled.
        swatches: [
            '#264653',
            '#2a9d8f',
            '#e9c46a',
            'rgb(244,162,97)',
            '#e76f51',
            '#d62828',
            'navy',
            '#07b',
            '#0096c7',
            '#00b4d880',
            'rgba(0,119,182,0.8)'
        ]
    });


});