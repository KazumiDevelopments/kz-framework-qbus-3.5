RL.Phone.Settings = {};
RL.Phone.Settings.Background = "default-qbus";
RL.Phone.Settings.OpenedTab = null;
RL.Phone.Settings.Backgrounds = {
    'default-qbus': {
        label: "Default"
    }
};

var PressedBackground = null;
var PressedBackgroundObject = null;
var OldBackground = null;
var IsChecked = null;

$(document).on('click', '.settings-app-tab', function(e){
    e.preventDefault();
    var PressedTab = $(this).data("settingstab");

    if (PressedTab == "background") {
        RL.Phone.Animations.TopSlideDown(".settings-"+PressedTab+"-tab", 200, 0);
        RL.Phone.Settings.OpenedTab = PressedTab;
    } else if (PressedTab == "profilepicture") {
        RL.Phone.Animations.TopSlideDown(".settings-"+PressedTab+"-tab", 200, 0);
        RL.Phone.Settings.OpenedTab = PressedTab;
    } else if (PressedTab == "numberrecognition") {
        var checkBoxes = $(".numberrec-box");
        RL.Phone.Data.AnonymousCall = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", RL.Phone.Data.AnonymousCall);

        if (!RL.Phone.Data.AnonymousCall) {
            $("#numberrecognition > p").html('Disabled');
        } else {
            $("#numberrecognition > p").html('Enabled');
        }
    }
});

$(document).on('click', '#accept-background', function(e){
    e.preventDefault();
    var hasCustomBackground = RL.Phone.Functions.IsBackgroundCustom();

    if (hasCustomBackground === false) {
        RL.Phone.Notifications.Add("fas fa-paint-brush", "Settings", RL.Phone.Settings.Backgrounds[RL.Phone.Settings.Background].label+" is installed!")
        RL.Phone.Animations.TopSlideUp(".settings-"+RL.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $(".phone-background").css({"background-image":"url('/html/img/backgrounds/"+RL.Phone.Settings.Background+".png')"})
    } else {
        RL.Phone.Notifications.Add("fas fa-paint-brush", "Settingsn", "Own background set!")
        RL.Phone.Animations.TopSlideUp(".settings-"+RL.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $(".phone-background").css({"background-image":"url('"+RL.Phone.Settings.Background+"')"});
    }

    $.post('http://rl-phone/SetBackground', JSON.stringify({
        background: RL.Phone.Settings.Background,
    }))
});

RL.Phone.Functions.LoadMetaData = function(MetaData) {
    if (MetaData.background !== null && MetaData.background !== undefined) {
        RL.Phone.Settings.Background = MetaData.background;
    } else {
        RL.Phone.Settings.Background = "default-qbus";
    }

    var hasCustomBackground = RL.Phone.Functions.IsBackgroundCustom();

    if (!hasCustomBackground) {
        $(".phone-background").css({"background-image":"url('/html/img/backgrounds/"+RL.Phone.Settings.Background+".png')"})
    } else {
        $(".phone-background").css({"background-image":"url('"+RL.Phone.Settings.Background+"')"});
    }

    if (MetaData.profilepicture == "default") {
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="./img/default.png">');
    } else {
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="'+MetaData.profilepicture+'">');
    }
}

$(document).on('click', '#cancel-background', function(e){
    e.preventDefault();
    RL.Phone.Animations.TopSlideUp(".settings-"+RL.Phone.Settings.OpenedTab+"-tab", 200, -100);
});

RL.Phone.Functions.IsBackgroundCustom = function() {
    var retval = true;
    $.each(RL.Phone.Settings.Backgrounds, function(i, background){
        if (RL.Phone.Settings.Background == i) {
            retval = false;
        }
    });
    return retval
}

$(document).on('click', '.background-option', function(e){
    e.preventDefault();
    PressedBackground = $(this).data('background');
    PressedBackgroundObject = this;
    OldBackground = $(this).parent().find('.background-option-current');
    IsChecked = $(this).find('.background-option-current');

    if (IsChecked.length === 0) {
        if (PressedBackground != "custom-background") {
            RL.Phone.Settings.Background = PressedBackground;
            $(OldBackground).fadeOut(50, function(){
                $(OldBackground).remove();
            });
            $(PressedBackgroundObject).append('<div class="background-option-current"><i class="fas fa-check-circle"></i></div>');
        } else {
            RL.Phone.Animations.TopSlideDown(".background-custom", 200, 13);
        }
    }
});

$(document).on('click', '#accept-custom-background', function(e){
    e.preventDefault();

    RL.Phone.Settings.Background = $(".custom-background-input").val();
    $(OldBackground).fadeOut(50, function(){
        $(OldBackground).remove();
    });
    $(PressedBackgroundObject).append('<div class="background-option-current"><i class="fas fa-check-circle"></i></div>');
    RL.Phone.Animations.TopSlideUp(".background-custom", 200, -23);
});

$(document).on('click', '#cancel-custom-background', function(e){
    e.preventDefault();

    RL.Phone.Animations.TopSlideUp(".background-custom", 200, -23);
});

// Profile Picture

var PressedProfilePicture = null;
var PressedProfilePictureObject = null;
var OldProfilePicture = null;
var ProfilePictureIsChecked = null;

$(document).on('click', '#accept-profilepicture', function(e){
    e.preventDefault();
    var ProfilePicture = RL.Phone.Data.MetaData.profilepicture;
    if (ProfilePicture === "default") {
        RL.Phone.Notifications.Add("fas fa-paint-brush", "Settings", "Default profile picture installed!")
        RL.Phone.Animations.TopSlideUp(".settings-"+RL.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="./img/default.png">');
    } else {
        RL.Phone.Notifications.Add("fas fa-paint-brush", "Settings", "Custom profile photo installed!")
        RL.Phone.Animations.TopSlideUp(".settings-"+RL.Phone.Settings.OpenedTab+"-tab", 200, -100);
        console.log(ProfilePicture)
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="'+ProfilePicture+'">');
    }
    $.post('http://rl-phone/UpdateProfilePicture', JSON.stringify({
        profilepicture: ProfilePicture,
    }));
});

$(document).on('click', '#accept-custom-profilepicture', function(e){
    e.preventDefault();
    RL.Phone.Data.MetaData.profilepicture = $(".custom-profilepicture-input").val();
    $(OldProfilePicture).fadeOut(50, function(){
        $(OldProfilePicture).remove();
    });
    $(PressedProfilePictureObject).append('<div class="profilepicture-option-current"><i class="fas fa-check-circle"></i></div>');
    RL.Phone.Animations.TopSlideUp(".profilepicture-custom", 200, -23);
});

$(document).on('click', '.profilepicture-option', function(e){
    e.preventDefault();
    PressedProfilePicture = $(this).data('profilepicture');
    PressedProfilePictureObject = this;
    OldProfilePicture = $(this).parent().find('.profilepicture-option-current');
    ProfilePictureIsChecked = $(this).find('.profilepicture-option-current');
    if (ProfilePictureIsChecked.length === 0) {
        if (PressedProfilePicture != "custom-profilepicture") {
            RL.Phone.Data.MetaData.profilepicture = PressedProfilePicture
            $(OldProfilePicture).fadeOut(50, function(){
                $(OldProfilePicture).remove();
            });
            $(PressedProfilePictureObject).append('<div class="profilepicture-option-current"><i class="fas fa-check-circle"></i></div>');
        } else {
            RL.Phone.Animations.TopSlideDown(".profilepicture-custom", 200, 13);
        }
    }
});

$(document).on('click', '#cancel-profilepicture', function(e){
    e.preventDefault();
    RL.Phone.Animations.TopSlideUp(".settings-"+RL.Phone.Settings.OpenedTab+"-tab", 200, -100);
});


$(document).on('click', '#cancel-custom-profilepicture', function(e){
    e.preventDefault();
    RL.Phone.Animations.TopSlideUp(".profilepicture-custom", 200, -23);
});