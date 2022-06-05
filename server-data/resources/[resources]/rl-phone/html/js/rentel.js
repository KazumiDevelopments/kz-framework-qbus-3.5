
SetupRentel = function(data) {
    $(".rentel-items").html("");
    $.each(data, function(i, vehicle){
        console.log(vehicle.stored);
        var elem = '<div class="rentelapp" id="app-'+i+'" data-app="'+i+'"><div class="rentelapp-icon"><i class="'+vehicle.icon+'"></i></div><div class="rentelapp-title">'+vehicle.label+' - ' + (vehicle.stored ? vehicle.stored : ('$' + vehicle.price)) + '</div><div class="rentelapp-purchase"><i class="' + (vehicle.stored ? "fas fa-trash-restore-alt": "fas fa-dollar-sign" ) + '"></i></div></div>'
        $(".rentel-items").append(elem);
        $("#app-"+i).data('VehicleData', vehicle);
    });
}

$(document).on('click', '.rentelapp-purchase', function(e){
    e.preventDefault();

    var AppId = $(this).parent().attr('id');
    var VehicleData = $("#" + AppId).data('VehicleData');
    $.post('http://rl-phone/' + (VehicleData.stored ? 'RestoreVehicle' : 'RentVehicle'), JSON.stringify({
        vehicle: VehicleData
    }));

    setTimeout(function(){
        $.post('http://rl-phone/SetupRentel', JSON.stringify({}), function(data){
            SetupRentel(data); 
        });
    }, 400)
});
