SetupDrivers = function(data, isTaxi) {
    if (isTaxi == true) {
        $(".drivers-call-full").fadeOut()
        $(".drivers-call-full").fadeIn()
    } else {
        $(".drivers-list").html('<div class="drivers-call-full"><div class="drivers-call">Call Taxi</div></div>');
        $(".drivers-call-full").fadeIn()
    }
}

RemoveTaxiCall = function(id) {
    $("#taxicall-" + id).fadeOut(500)
}

AddTaxiCall = function(id, data) {
    var element = '<div class="driver-list" id="taxicall-'+ id +'"> <div class="driver-list-firstletter">' + (data.name).charAt(0).toUpperCase() + '</div> <div class="driver-list-fullname">' + data.name + '</div> <div class="driver-list-call"><i class="fas fa-user-check"></i></div> </div>'
    $(".drivers-list").append(element);
    $("#taxicall-" + id).data('id', id);
    $("#taxicall-" + id).fadeIn(500);
}

$(document).on('click', '.drivers-call', function(e){
    e.preventDefault();

    $.post('http://rl-phone/CallDriver');
});

$(document).on('click', '.driver-list-call', function(e){
    e.preventDefault();

    var id = $(this).parent().data('id');
    $.post('http://rl-phone/AcceptTaxiCall', JSON.stringify({
        id: id,
    }));
});
