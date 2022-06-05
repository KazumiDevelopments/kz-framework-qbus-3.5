var qbCityhall = {}
var mouseOver = false;
var selectedIdentity = null;
var selectedIdentityType = null;
var selectedJob = null;
var selectedJobId = null;

/* $(".container2").hide(); */

qbCityhall.Open = function(data) {
    $(".container").fadeIn(150);
    $(".container2").hide();
}

qbCityhall.Close = function() {
    $(".container").fadeOut(150, function(){
        qbCityhall.ResetPages();
    });
    $.post('http://rl-cityhall/close');

    $(selectedJob).removeClass("job-selected");
    $(selectedIdentity).removeClass("job-selected");
}

qbCityhall.OpenTest = function(data) {
    $('.container2').fadeIn(150);
}

qbCityhall.CloseTest = function() {
    $(".container2").fadeOut(150, function(){
        qbCityhall.ResetPages();
    });
    $.post('http://rl-cityhall/close');
}

qbCityhall.ResetPages = function() {
    $(".cityhall-option-blocks").show();
    $(".cityhall-identity-page").hide();
    $(".cityhall-job-page").hide();
    $(".cityhall-weapon-page").hide();
}

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "open":
                qbCityhall.Open(event.data);
                break;
            case "close":
                qbCityhall.Close();
                break;
            }
    })
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            qbCityhall.Close();
            break;
    }
});

$('.cityhall-option-block').click(function(e){
    e.preventDefault();

    var blockPage = $(this).data('page');

    $(".cityhall-option-blocks").fadeOut(100, function(){
        $(".cityhall-" + blockPage + "-page").fadeIn(100);
    });

    if (blockPage == "identity") {
        $(".identity-page-blocks").html("");
        $(".identity-page-blocks").html('<div class="identity-page-block" data-type="id-kaart" onmouseover="' + hoverDescription("id-kaart") + '" onmouseout="' + hoverDescription("id-kaart") + '"><p>ID card</p></div>');
        $.post('http://rl-cityhall/requestLicenses', JSON.stringify({}), function(licenses){-
            $.each(licenses, function(i, license){
                var elem = '<div class="identity-page-block" data-type="' + license.idType + '"><p>' + license.label + '</p></div>';
                $(".identity-page-blocks").append(elem);
            });
        });
    }
});

hoverDescription = function(type) {
    if (!mouseOver) {
        if (type == "id-kaart") {
            $(".hover-description").fadeIn(10);
            $(".hover-description").html('<p>You are required to carry an ID card on you. <br> This is done so that you can identify yourself at any time.</p>');
        } else if (type == "rijbewijs") {
            $(".hover-description").fadeIn(10);
            $(".hover-description").html('<p>When driving a vehicle you are required to show a driving license <br> when it is requested.</p>');
        }
    } else {
        if(selectedIdentity == null) {
            $(".hover-description").fadeOut(10);
            $(".hover-description").html('');
        }
    }

    mouseOver = !mouseOver;
}

$(document).on("click", ".identity-page-block", function(e){
    e.preventDefault();

    var idType = $(this).data('type');

    selectedIdentityType = idType;

    if (selectedIdentity == null) {
        $(this).addClass("identity-selected");
        $(".hover-description").fadeIn(10);
        selectedIdentity = this;
        if (idType== "id-kaart") {
            $(".request-identity-button").fadeIn(100);
            $(".request-identity-button").html("<p>Request A Copy Of Your ID - $50</p>")
        } else if (idType== "drivers") {
            $(".request-identity-button").fadeIn(100);
            $(".request-identity-button").html("<p>Request A Copy Of Your Driver's License - $50</p>")
        } else if (idType== "weapon") {
            $(".request-identity-button").fadeIn(100);
            $(".request-identity-button").html("<p>Request A Copy Of Your Weapon's License - $50</p>")
        } else if (idType== "weaponR") {
            $(".request-identity-button").fadeIn(100);
            $(".request-identity-button").html("<p>Request A Weapon's Saftey Test - $5000</p>")
        }
    } else if (selectedIdentity == this) {
        $(this).removeClass("identity-selected");
        selectedIdentity = null;
        $(".request-identity-button").fadeOut(100);
    } else {
        $(selectedIdentity).removeClass("identity-selected");
        $(this).addClass("identity-selected");
        selectedIdentity = this;
        if($(this).data('type') == "id-kaart") {
            $(".request-identity-button").html("<p>Request A Copy Of Your ID - $50</p>")
        } else if ($(this).data('type') == "drivers"){
            $(".request-identity-button").html("<p>Request A Copy Of Your Driver's License - $50</p>")
        } else if ($(this).data('type') == "weapon"){
            $(".request-identity-button").html("<p>Request A Copy Of Your Weapon's License - $50</p>")
        } else if ($(this).data('type') == "weaponR"){
            $(".request-identity-button").html("<p>Request A Weapon's Saftey Test - $5000</p>")
        }
    }
});

$(".request-identity-button").click(function(e){
    e.preventDefault();
    if (selectedIdentityType == 'weaponR') {
        $(".container").fadeOut(0, function(){
            qbCityhall.ResetPages();
        });
        qbCityhall.OpenTest();
    } else {
        $.post('http://rl-cityhall/requestId', JSON.stringify({
        idType: selectedIdentityType
        }))
    qbCityhall.ResetPages();
    }
});

$(document).on("click", ".job-page-block", function(e){
    e.preventDefault();

    var job = $(this).data('job');

    selectedJobId = job;

    if (selectedJob == null) {
        $(this).addClass("job-selected");
        selectedJob = this;
        $(".apply-job-button").fadeIn(100);
    } else if (selectedJob == this) {
        $(this).removeClass("job-selected");
        selectedJob = null;
        $(".apply-job-button").fadeOut(100);
    } else {
        $(selectedJob).removeClass("job-selected");
        $(this).addClass("job-selected");
        selectedJob = this;
    }
});

$(document).on('click', '.apply-job-button', function(e){
    e.preventDefault();

    $.post('http://rl-cityhall/applyJob', JSON.stringify({
        job: selectedJobId
    }))

    qbCityhall.ResetPages();
});

$(document).on("click", ".weapon-page-block", function(e){
    e.preventDefault();
    $(".apply-weapon-button").show();
});

$(document).on('click', '.apply-weapon-button', function(e){
    e.preventDefault();
    $.post('http://rl-cityhall/Licence', JSON.stringify(true));
});

$(document).on('click', '.remove-weapon-button', function(e){
    e.preventDefault();
    $.post('http://rl-cityhall/Licence', JSON.stringify(false));
});

$(document).on('click', '.check-weapon-button', function(e){
    e.preventDefault();
    $.post('http://rl-cityhall/Check');
});

$(document).on('click', '.back-to-main', function(e){
    e.preventDefault();

    $(selectedJob).removeClass("job-selected");
    $(selectedIdentity).removeClass("job-selected");

    qbCityhall.ResetPages();
});