RL = {}
RL.Phone = {}
RL.Screen = {}
RL.Phone.Functions = {}
RL.Phone.Animations = {}
RL.Phone.Notifications = {}
RL.Phone.ContactColors = {
    0: "#9b59b6",
    1: "#3498db",
    2: "#e67e22",
    3: "#e74c3c",
    4: "#1abc9c",
    5: "#9c88ff",
}

RL.Phone.Data = {
    currentApplication: null,
    PlayerData: {},
    Applications: {},
    IsOpen: false,
    CallActive: false,
    MetaData: {},
    PlayerJob: {},
    AnonymousCall: false,
}

RL.Phone.Data.MaxSlots = 16;

OpenedChatData = {
    number: null,
}

var CanOpenApp = true;

function IsAppJobBlocked(joblist, myjob) {
    var retval = false;
    if (joblist.length > 0) {
        $.each(joblist, function(i, job){
            if (job == myjob && RL.Phone.Data.PlayerData.job.onduty) {
                retval = true;
            }
        });
    }
    return retval;
}

RL.Phone.Functions.SetupApplications = function(data) {
    RL.Phone.Data.Applications = data.applications;

    var i;
    for (i = 1; i <= RL.Phone.Data.MaxSlots; i++) {
        var applicationSlot = $(".phone-applications").find('[data-appslot="'+i+'"]');
        $(applicationSlot).html("");
        $(applicationSlot).css({
            "background-color":"transparent"
        });
        $(applicationSlot).prop('title', "");
        $(applicationSlot).removeData('app');
        $(applicationSlot).removeData('placement')
    }

    $.each(data.applications, function(i, app){
        var applicationSlot = $(".phone-applications").find('[data-appslot="'+app.slot+'"]');
        var blockedapp = IsAppJobBlocked(app.blockedjobs, RL.Phone.Data.PlayerJob.name)

        if ((!app.job || app.job === RL.Phone.Data.PlayerJob.name) && !blockedapp) {
            $(applicationSlot).css({"background-color":app.color});
            var icon = '<i class="ApplicationIcon '+app.icon+'" style="'+app.style+'"></i>';
            if (app.app == "meos") {
                icon = '<img src="./img/politie.png" class="police-icon">';
            }
            $(applicationSlot).html(icon+'<div class="app-unread-alerts">0</div>');
            $(applicationSlot).prop('title', app.tooltipText);
            $(applicationSlot).data('app', app.app);

            if (app.tooltipPos !== undefined) {
                $(applicationSlot).data('placement', app.tooltipPos)
            }
        }
    });

    $('[data-toggle="tooltip"]').tooltip();
}

RL.Phone.Functions.SetupAppWarnings = function(AppData) {
    $.each(AppData, function(i, app){
        var AppObject = $(".phone-applications").find("[data-appslot='"+app.slot+"']").find('.app-unread-alerts');

        if (app.Alerts > 0) {
            $(AppObject).html(app.Alerts);
            $(AppObject).css({"display":"block"});
        } else {
            $(AppObject).css({"display":"none"});
        }
    });
}

RL.Phone.Functions.IsAppHeaderAllowed = function(app) {
    var retval = true;
    $.each(Config.HeaderDisabledApps, function(i, blocked){
        if (app == blocked) {
            retval = false;
        }
    });
    return retval;
}

$(document).on('click', '.phone-application', function(e){
    e.preventDefault();
    var PressedApplication = $(this).data('app');
    var AppObject = $("."+PressedApplication+"-app");

    if (AppObject.length !== 0) {
        if (CanOpenApp) {
            if (RL.Phone.Data.currentApplication == null) {
                RL.Phone.Animations.TopSlideDown('.phone-application-container', 300, 0);
                RL.Phone.Functions.ToggleApp(PressedApplication, "block");
                
                if (RL.Phone.Functions.IsAppHeaderAllowed(PressedApplication)) {
                    RL.Phone.Functions.HeaderTextColor("black", 300);
                }
    
                RL.Phone.Data.currentApplication = PressedApplication;
    
                if (PressedApplication == "settings") {
                    $("#myPhoneNumber").text(RL.Phone.Data.PlayerData.charinfo.phone);
                } else if (PressedApplication == "twitter") {
                    $.post('http://rl-phone/GetMentionedTweets', JSON.stringify({}), function(MentionedTweets){
                        RL.Phone.Notifications.LoadMentionedTweets(MentionedTweets)
                    })
                    $.post('http://rl-phone/GetHashtags', JSON.stringify({}), function(Hashtags){
                        RL.Phone.Notifications.LoadHashtags(Hashtags)
                    })
                    if (RL.Phone.Data.IsOpen) {
                        $.post('http://rl-phone/GetTweets', JSON.stringify({}), function(Tweets){
                            RL.Phone.Notifications.LoadTweets(Tweets);
                        });
                    }
                } else if (PressedApplication == "bank") {
                    $.post('http://rl-phone/GetBankContacts', JSON.stringify({}), function(contacts){
                        RL.Phone.Functions.LoadContactsWithNumber(contacts);
                    });
                    $.post('http://rl-phone/GetInvoices', JSON.stringify({}), function(invoices){
                        RL.Phone.Functions.LoadBankInvoices(invoices);
                    });

                    RL.Phone.Functions.DoBankOpen();
                } else if (PressedApplication == "whatsapp") {
                    $.post('http://rl-phone/GetWhatsappChats', JSON.stringify({}), function(chats){
                        RL.Phone.Functions.LoadWhatsappChats(chats);
                    });
                } else if (PressedApplication == "phone") {
                    $.post('http://rl-phone/GetMissedCalls', JSON.stringify({}), function(recent){
                        RL.Phone.Functions.SetupRecentCalls(recent);
                    });
                    $.post('http://rl-phone/GetSuggestedContacts', JSON.stringify({}), function(suggested){
                        RL.Phone.Functions.SetupSuggestedContacts(suggested);
                    });
                    $.post('http://rl-phone/ClearGeneralAlerts', JSON.stringify({
                        app: "phone"
                    }));
                } else if (PressedApplication == "mail") {
                    $.post('http://rl-phone/GetMails', JSON.stringify({}), function(mails){
                        RL.Phone.Functions.SetupMails(mails);
                    });
                    $.post('http://rl-phone/ClearGeneralAlerts', JSON.stringify({
                        app: "mail"
                    }));
                } else if (PressedApplication == "advert") {
                    $.post('http://rl-phone/LoadAdverts', JSON.stringify({}), function(Adverts){
                        RL.Phone.Functions.RefreshAdverts(Adverts);
                    })
                } else if (PressedApplication == "garage") {
                    $.post('http://rl-phone/SetupGarageVehicles', JSON.stringify({}), function(Vehicles){
                        SetupGarageVehicles(Vehicles);
                    })
                } else if (PressedApplication == "crypto") {
                    $.post('http://rl-phone/GetCryptoData', JSON.stringify({
                        crypto: "qbit",
                    }), function(CryptoData){
                        SetupCryptoData(CryptoData);
                    })

                    $.post('http://rl-phone/GetCryptoTransactions', JSON.stringify({}), function(data){
                        RefreshCryptoTransactions(data);
                    })
                } else if (PressedApplication == "racing") {
                    $.post('http://rl-phone/GetAvailableRaces', JSON.stringify({}), function(Races){
                        SetupRaces(Races);
                    });
                } else if (PressedApplication == "lsrental") {
                    $.post('http://rl-phone/GetAvailableRaces', JSON.stringify({}), function(Races){
                        SetupRaces(Races);
                    });
                } else if (PressedApplication == "houses") {
                    $.post('http://rl-phone/GetPlayerHouses', JSON.stringify({}), function(Houses){
                        SetupPlayerHouses(Houses);
                    });
                    $.post('http://rl-phone/GetPlayerKeys', JSON.stringify({}), function(Keys){
                        $(".house-app-mykeys-container").html("");
                        if (Keys.length > 0) {
                            $.each(Keys, function(i, key){
                                var elem = '<div class="mykeys-key" id="keyid-'+i+'"> <span class="mykeys-key-label">' + key.HouseData.adress + '</span> <span class="mykeys-key-sub">Click to set GPS</span> </div>';

                                $(".house-app-mykeys-container").append(elem);
                                $("#keyid-"+i).data('KeyData', key);
                            });
                        }
                    });
                } else if (PressedApplication == "meos") {
                    SetupMeosHome();
                } else if (PressedApplication == "lawyers") {
                    $.post('http://rl-phone/GetCurrentLawyers', JSON.stringify({}), function(data){
                        SetupLawyers(data);
                    });
                } else if (PressedApplication == "rentel") {
                    $.post('http://rl-phone/SetupRentel', JSON.stringify({}), function(data){
                        SetupRentel(data); 
                    });
                } else if (PressedApplication == "sellix") {
                    $.post('http://rl-phone/SetupSellix', JSON.stringify({}), function(data){
                        SetupSellixData(data); 
                    });
                /* } else if (PressedApplication == "drivers") {
                    $.post('http://rl-phone/GetCurrentDrivers', JSON.stringify({}), function(data){
                        SetupDrivers(data.drivers, data.isTaxi);
                    }); */
                } else if (PressedApplication == "taxi") {
                    $.post('http://rl-phone/GetCurrentDrivers', JSON.stringify({}), function(data){
                        SetupDrivers(data);
                    });
                } else if (PressedApplication == "store") {
                    $.post('http://rl-phone/SetupStoreApps', JSON.stringify({}), function(data){
                        SetupAppstore(data); 
                    });
                } else if (PressedApplication == "trucker") {
                    $.post('http://rl-phone/GetTruckerData', JSON.stringify({}), function(data){
                        SetupTruckerInfo(data);
                    });
                }
            }
        }
    } else {
        RL.Phone.Notifications.Add("fas fa-exclamation-circle", "System", RL.Phone.Data.Applications[PressedApplication].tooltipText+ " is not available!")
    }
});

$(document).on('click', '.mykeys-key', function(e){
    e.preventDefault();

    var KeyData = $(this).data('KeyData');

    $.post('http://rl-phone/SetHouseLocation', JSON.stringify({
        HouseData: KeyData
    }))
});

$(document).on('click', '.phone-home-container', function(event){
    event.preventDefault();

    if (RL.Phone.Data.currentApplication === null) {
        RL.Phone.Functions.Close();
    } else {
        RL.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
        RL.Phone.Animations.TopSlideUp('.'+RL.Phone.Data.currentApplication+"-app", 400, -160);
        CanOpenApp = false;
        setTimeout(function(){
            RL.Phone.Functions.ToggleApp(RL.Phone.Data.currentApplication, "none");
            CanOpenApp = true;
        }, 400)
        RL.Phone.Functions.HeaderTextColor("white", 300);

        if (RL.Phone.Data.currentApplication == "whatsapp") {
            if (OpenedChatData.number !== null) {
                setTimeout(function(){
                    $(".whatsapp-chats").css({"display":"block"});
                    $(".whatsapp-chats").animate({
                        left: 0+"vh"
                    }, 1);
                    $(".whatsapp-openedchat").animate({
                        left: -30+"vh"
                    }, 1, function(){
                        $(".whatsapp-openedchat").css({"display":"none"});
                    });
                    OpenedChatPicture = null;
                    OpenedChatData.number = null;
                }, 450);
            }
        } else if (RL.Phone.Data.currentApplication == "bank") {
            if (CurrentTab == "invoices") {
                setTimeout(function(){
                    $(".bank-app-invoices").animate({"left": "30vh"});
                    $(".bank-app-invoices").css({"display":"none"})
                    $(".bank-app-accounts").css({"display":"block"})
                    $(".bank-app-accounts").css({"left": "0vh"});
    
                    var InvoicesObjectBank = $(".bank-app-header").find('[data-headertype="invoices"]');
                    var HomeObjectBank = $(".bank-app-header").find('[data-headertype="accounts"]');
    
                    $(InvoicesObjectBank).removeClass('bank-app-header-button-selected');
                    $(HomeObjectBank).addClass('bank-app-header-button-selected');
    
                    CurrentTab = "accounts";
                }, 400)
            }
        } else if (RL.Phone.Data.currentApplication == "meos") {
            $(".meos-alert-new").remove();
            setTimeout(function(){
                $(".meos-recent-alert").removeClass("noodknop");
                $(".meos-recent-alert").css({"background-color":"#004682"}); 
            }, 400)
        }

        RL.Phone.Data.currentApplication = null;
    }
});

RL.Phone.Functions.Open = function(data) {
    RL.Phone.Animations.BottomSlideUp('.container', 300, 0);
    RL.Phone.Notifications.LoadTweets(data.Tweets);
    RL.Phone.Data.IsOpen = true;
}

RL.Phone.Functions.ToggleApp = function(app, show) {
    $("."+app+"-app").css({"display":show});
}

RL.Phone.Functions.Close = function() {

    if (RL.Phone.Data.currentApplication == "whatsapp") {
        setTimeout(function(){
            RL.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
            RL.Phone.Animations.TopSlideUp('.'+RL.Phone.Data.currentApplication+"-app", 400, -160);
            $(".whatsapp-app").css({"display":"none"});
            RL.Phone.Functions.HeaderTextColor("white", 300);
    
            if (OpenedChatData.number !== null) {
                setTimeout(function(){
                    $(".whatsapp-chats").css({"display":"block"});
                    $(".whatsapp-chats").animate({
                        left: 0+"vh"
                    }, 1);
                    $(".whatsapp-openedchat").animate({
                        left: -30+"vh"
                    }, 1, function(){
                        $(".whatsapp-openedchat").css({"display":"none"});
                    });
                    OpenedChatData.number = null;
                }, 450);
            }
            OpenedChatPicture = null;
            RL.Phone.Data.currentApplication = null;
        }, 500)
    } else if (RL.Phone.Data.currentApplication == "meos") {
        $(".meos-alert-new").remove();
        $(".meos-recent-alert").removeClass("noodknop");
        $(".meos-recent-alert").css({"background-color":"#004682"}); 
    }

    RL.Phone.Animations.BottomSlideDown('.container', 300, -70);
    $.post('http://rl-phone/Close');
    RL.Phone.Data.IsOpen = false;
}

RL.Phone.Functions.HeaderTextColor = function(newColor, Timeout) {
    $(".phone-header").animate({color: newColor}, Timeout);
}

RL.Phone.Animations.BottomSlideUp = function(Object, Timeout, Percentage) {
    $(Object).css({'display':'block'}).animate({
        bottom: Percentage+"%",
    }, Timeout);
}

RL.Phone.Animations.BottomSlideDown = function(Object, Timeout, Percentage) {
    $(Object).css({'display':'block'}).animate({
        bottom: Percentage+"%",
    }, Timeout, function(){
        $(Object).css({'display':'none'});
    });
}

RL.Phone.Animations.TopSlideDown = function(Object, Timeout, Percentage) {
    $(Object).css({'display':'block'}).animate({
        top: Percentage+"%",
    }, Timeout);
}

RL.Phone.Animations.TopSlideUp = function(Object, Timeout, Percentage, cb) {
    $(Object).css({'display':'block'}).animate({
        top: Percentage+"%",
    }, Timeout, function(){
        $(Object).css({'display':'none'});
    });
}

RL.Phone.Notifications.Add = function(icon, title, text, color, timeout) {
    $.post('http://rl-phone/HasPhone', JSON.stringify({}), function(HasPhone){
        if (HasPhone) {
            if (timeout == null && timeout == undefined) {
                timeout = 1500;
            }
            if (RL.Phone.Notifications.Timeout == undefined || RL.Phone.Notifications.Timeout == null) {
                if (color != null || color != undefined) {
                    $(".notification-icon").css({"color":color});
                    $(".notification-title").css({"color":color});
                } else if (color == "default" || color == null || color == undefined) {
                    $(".notification-icon").css({"color":"#e74c3c"});
                    $(".notification-title").css({"color":"#e74c3c"});
                }
                RL.Phone.Animations.TopSlideDown(".phone-notification-container", 200, 8);
                if (icon !== "politie") {
                    $(".notification-icon").html('<i class="'+icon+'"></i>');
                } else {
                    $(".notification-icon").html('<img src="./img/politie.png" class="police-icon-notify">');
                }
                $(".notification-title").html(title);
                $(".notification-text").html(text);
                if (RL.Phone.Notifications.Timeout !== undefined || RL.Phone.Notifications.Timeout !== null) {
                    clearTimeout(RL.Phone.Notifications.Timeout);
                }
                RL.Phone.Notifications.Timeout = setTimeout(function(){
                    RL.Phone.Animations.TopSlideUp(".phone-notification-container", 200, -8);
                    RL.Phone.Notifications.Timeout = null;
                }, timeout);
            } else {
                if (color != null || color != undefined) {
                    $(".notification-icon").css({"color":color});
                    $(".notification-title").css({"color":color});
                } else {
                    $(".notification-icon").css({"color":"#e74c3c"});
                    $(".notification-title").css({"color":"#e74c3c"});
                }
                $(".notification-icon").html('<i class="'+icon+'"></i>');
                $(".notification-title").html(title);
                $(".notification-text").html(text);
                if (RL.Phone.Notifications.Timeout !== undefined || RL.Phone.Notifications.Timeout !== null) {
                    clearTimeout(RL.Phone.Notifications.Timeout);
                }
                RL.Phone.Notifications.Timeout = setTimeout(function(){
                    RL.Phone.Animations.TopSlideUp(".phone-notification-container", 200, -8);
                    RL.Phone.Notifications.Timeout = null;
                }, timeout);
            }
        }
    });
}

RL.Phone.Functions.LoadPhoneData = function(data) {
    RL.Phone.Data.PlayerData = data.PlayerData;
    RL.Phone.Data.PlayerJob = data.PlayerJob;
    RL.Phone.Data.MetaData = data.PhoneData.MetaData;
    RL.Phone.Functions.LoadMetaData(data.PhoneData.MetaData);
    RL.Phone.Functions.LoadContacts(data.PhoneData.Contacts);
    RL.Phone.Functions.SetupApplications(data);
    console.log("Phone succesfully loaded!");
}

RL.Phone.Functions.UpdateTime = function(data) {    
    $("#phone-time").html(data.InGameTime.hour + ":" + data.InGameTime.minute);
}

var NotificationTimeout = null;

RL.Screen.Notification = function(title, content, icon, timeout, color) {
    $.post('http://rl-phone/HasPhone', JSON.stringify({}), function(HasPhone){
        if (HasPhone) {
            if (color != null && color != undefined) {
                $(".screen-notifications-container").css({"background-color":color});
            }
            $(".screen-notification-icon").html('<i class="'+icon+'"></i>');
            $(".screen-notification-title").text(title);
            $(".screen-notification-content").text(content);
            $(".screen-notifications-container").css({'display':'block'}).animate({
                right: 5+"vh",
            }, 200);
        
            if (NotificationTimeout != null) {
                clearTimeout(NotificationTimeout);
            }
        
            NotificationTimeout = setTimeout(function(){

                $(".screen-notifications-container").animate({
                    right: -35+"vh",
                }, 200, function(){
                    $(".screen-notifications-container").css({'display':'none'});
                });
                NotificationTimeout = null;
            }, timeout);
        }
    });
}

// RL.Screen.Notification("Nieuwe Tweet", "Dit is een test tweet like #YOLO", "fab fa-twitter", 4000);

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "open":
                RL.Phone.Functions.Open(event.data);
                RL.Phone.Functions.SetupAppWarnings(event.data.AppData);
                RL.Phone.Functions.SetupCurrentCall(event.data.CallData);
                RL.Phone.Data.IsOpen = true;
                RL.Phone.Data.PlayerData = event.data.PlayerData;
                break;
            // case "LoadPhoneApplications":
            //     RL.Phone.Functions.SetupApplications(event.data);
            //     break;
            case "LoadPhoneData":
                RL.Phone.Functions.LoadPhoneData(event.data);
                break;
            case "UpdateTime":
                RL.Phone.Functions.UpdateTime(event.data);
                break;
            case "Notification":
                RL.Screen.Notification(event.data.NotifyData.title, event.data.NotifyData.content, event.data.NotifyData.icon, event.data.NotifyData.timeout, event.data.NotifyData.color);
                break;
            case "PhoneNotification":
                RL.Phone.Notifications.Add(event.data.PhoneNotify.icon, event.data.PhoneNotify.title, event.data.PhoneNotify.text, event.data.PhoneNotify.color, event.data.PhoneNotify.timeout);
                break;
            case "RefreshAppAlerts":
                RL.Phone.Functions.SetupAppWarnings(event.data.AppData);                
                break;
            case "UpdateMentionedTweets":
                RL.Phone.Notifications.LoadMentionedTweets(event.data.Tweets);                
                break;
            case "UpdateBank":
                $(".bank-app-account-balance").html("&dollar; "+event.data.NewBalance);
                $(".bank-app-account-balance").data('balance', event.data.NewBalance);
                break;
            case "UpdateChat":
                if (RL.Phone.Data.currentApplication == "whatsapp") {
                    if (OpenedChatData.number !== null && OpenedChatData.number == event.data.chatNumber) {
                        console.log('Chat reloaded')
                        RL.Phone.Functions.SetupChatMessages(event.data.chatData);
                    } else {
                        console.log('Chats reloaded')
                        RL.Phone.Functions.LoadWhatsappChats(event.data.Chats);
                    }
                }
                break;
            case "UpdateHashtags":
                RL.Phone.Notifications.LoadHashtags(event.data.Hashtags);
                break;
            case "RefreshWhatsappAlerts":
                RL.Phone.Functions.ReloadWhatsappAlerts(event.data.Chats);
                break;
            case "CancelOutgoingCall":
                $.post('http://rl-phone/HasPhone', JSON.stringify({}), function(HasPhone){
                    if (HasPhone) {
                        CancelOutgoingCall();
                    }
                });
                break;
            case "IncomingCallAlert":
                $.post('http://rl-phone/HasPhone', JSON.stringify({}), function(HasPhone){
                    if (HasPhone) {
                        IncomingCallAlert(event.data.CallData, event.data.Canceled, event.data.AnonymousCall);
                    }
                });
                break;
            case "SetupHomeCall":
                RL.Phone.Functions.SetupCurrentCall(event.data.CallData);
                break;
            case "RemoveOngoingMessage":
                $(".phone-currentcall-container").css({"display":"none"});
            case "AnswerCall":
                RL.Phone.Functions.AnswerCall(event.data.CallData);
                break;
            case "UpdateCallTime":
                var CallTime = event.data.Time;
                var date = new Date(null);
                date.setSeconds(CallTime);
                var timeString = date.toISOString().substr(11, 8);

                if (!RL.Phone.Data.IsOpen) {
                    if ($(".call-notifications").css("right") !== "52.1px") {
                        $(".call-notifications").css({"display":"block"});
                        $(".call-notifications").animate({right: 5+"vh"});
                    }
                    $(".call-notifications-title").html("In conversation ("+timeString+")");
                    $(".call-notifications-content").html("Calling with "+event.data.Name);
                    $(".call-notifications").removeClass('call-notifications-shake');
                } else {
                    $(".call-notifications").animate({
                        right: -35+"vh"
                    }, 400, function(){
                        $(".call-notifications").css({"display":"none"});
                    });
                }

                $(".phone-call-ongoing-time").html(timeString);
                $(".phone-currentcall-title").html("In gesprek ("+timeString+")");
                break;
            case "CancelOngoingCall":
                $(".call-notifications").animate({right: -35+"vh"}, function(){
                    $(".call-notifications").css({"display":"none"});
                });
                RL.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                setTimeout(function(){
                    RL.Phone.Functions.ToggleApp("phone-call", "none");
                    $(".phone-application-container").css({"display":"none"});
                }, 400)
                RL.Phone.Functions.HeaderTextColor("white", 300);
    
                RL.Phone.Data.CallActive = false;
                RL.Phone.Data.currentApplication = null;
                break;
            case "RefreshContacts":
                RL.Phone.Functions.LoadContacts(event.data.Contacts);
                break;
            case "UpdateMails":
                RL.Phone.Functions.SetupMails(event.data.Mails);
                break;
            case "RefreshAdverts":
                if (RL.Phone.Data.currentApplication == "advert") {
                    RL.Phone.Functions.RefreshAdverts(event.data.Adverts);
                }
                break;
            case "AddPoliceAlert":
                AddPoliceAlert(event.data)
                break;
            case "UpdateApplications":
                RL.Phone.Data.PlayerJob = event.data.JobData;
                RL.Phone.Functions.SetupApplications(event.data);
                break;
            case "UpdateTransactions":
                RefreshCryptoTransactions(event.data);
                break;
            case "UpdateRacingApp":
                $.post('http://rl-phone/GetAvailableRaces', JSON.stringify({}), function(Races){
                    SetupRaces(Races);
                });
                break;
            case "RefreshAlerts":
                RL.Phone.Functions.SetupAppWarnings(event.data.AppData);
                break;
            case "RemoveTaxiCall":
                RemoveTaxiCall(event.data.id);
                break;
            case "AddTaxiCall":
                AddTaxiCall(event.data.id, event.data.data);
                break;
        }
    })
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESCAPE
            RL.Phone.Functions.Close();
            break;
    }
});

// RL.Phone.Functions.Open();