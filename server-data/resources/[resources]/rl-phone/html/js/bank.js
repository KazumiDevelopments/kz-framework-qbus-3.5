var FoccusedBank = null;

$(document).on('click', '.bank-app-account', function(e){
    var copyText = document.getElementById("iban-account");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");

    RL.Phone.Notifications.Add("fas fa-university", "TBanking", "Bank account No. copied!", "#badc58", 1750);
});

var CurrentTab = "accounts";

$(document).on('click', '.bank-app-header-button', function(e){
    e.preventDefault();

    var PressedObject = this;
    var PressedTab = $(PressedObject).data('headertype');

    if (CurrentTab != PressedTab) {
        var PreviousObject = $(".bank-app-header").find('[data-headertype="'+CurrentTab+'"]');

        if (PressedTab == "invoices") {
            $(".bank-app-"+CurrentTab).animate({
                left: -30+"vh"
            }, 250, function(){
                $(".bank-app-"+CurrentTab).css({"display":"none"})
            });
            $(".bank-app-"+PressedTab).css({"display":"block"}).animate({
                left: 0+"vh"
            }, 250);
        } else if (PressedTab == "accounts") {
            $(".bank-app-"+CurrentTab).animate({
                left: 30+"vh"
            }, 250, function(){
                $(".bank-app-"+CurrentTab).css({"display":"none"})
            });
            $(".bank-app-"+PressedTab).css({"display":"block"}).animate({
                left: 0+"vh"
            }, 250);
        }

        $(PreviousObject).removeClass('bank-app-header-button-selected');
        $(PressedObject).addClass('bank-app-header-button-selected');
        setTimeout(function(){ CurrentTab = PressedTab; }, 300)
    }
})

RL.Phone.Functions.DoBankOpen = function() {
    RL.Phone.Data.PlayerData.money.bank = (RL.Phone.Data.PlayerData.money.bank).toFixed();
    $(".bank-app-account-number").val(RL.Phone.Data.PlayerData.charinfo.account);
    $(".bank-app-account-balance").html("$ "+RL.Phone.Data.PlayerData.money.bank);
    $(".bank-app-account-balance").data('balance', RL.Phone.Data.PlayerData.money.bank);

    $(".bank-app-loaded").css({"display":"none", "padding-left":"30vh"});
    $(".bank-app-accounts").css({"left":"30vh"});
    $(".qbank-logo").css({"left": "0vh"});
    $("#qbank-text").css({"opacity":"0.0", "left":"9vh"});
    $(".bank-app-loading").css({
        "display":"block",
        "left":"0vh",
    });
    setTimeout(function(){
        CurrentTab = "accounts";
        $(".qbank-logo").animate({
            left: -12+"vh"
        }, 500);
        setTimeout(function(){
            $("#qbank-text").animate({
                opacity: 1.0,
                left: 14+"vh"
            });
        }, 100);
        setTimeout(function(){
            $(".bank-app-loaded").css({"display":"block"}).animate({"padding-left":"0"}, 300);
            $(".bank-app-accounts").animate({left:0+"vh"}, 300);
            $(".bank-app-loading").animate({
                left: -30+"vh"
            },300, function(){
                $(".bank-app-loading").css({"display":"none"});
            });
        }, 1500)
    }, 500)
}

$(document).on('click', '.bank-app-account-actions', function(e){
    RL.Phone.Animations.TopSlideDown(".bank-app-transfer", 400, 0);
});

$(document).on('click', '#cancel-transfer', function(e){
    e.preventDefault();

    RL.Phone.Animations.TopSlideUp(".bank-app-transfer", 400, -100);
});

$(document).on('click', '#accept-transfer', function(e){
    e.preventDefault();

    var iban = $("#bank-transfer-iban").val();
    var amount = $("#bank-transfer-amount").val();

    if (iban != "" && amount != "") {
            $.post('http://rl-phone/CanTransferMoney', JSON.stringify({
                sendTo: iban,
                amountOf: amount,
            }), function(data){
                if (data.TransferedMoney) {
                    $("#bank-transfer-iban").val("");
                    $("#bank-transfer-amount").val("");

                    $(".bank-app-account-balance").html("$ " + (data.NewBalance).toFixed(0));
                    $(".bank-app-account-balance").data('balance', (data.NewBalance).toFixed(0));
                    RL.Phone.Notifications.Add("fas fa-university", "TBanking", "You have $"+amount+" transferred!", "#badc58", 1500);
                } else {
                    RL.Phone.Notifications.Add("fas fa-university", "TBanking", "You do not have enough balance!", "#badc58", 1500);
                }
                RL.Phone.Animations.TopSlideUp(".bank-app-transfer", 400, -100);
            });
    } else {
        RL.Phone.Notifications.Add("fas fa-university", "TBanking", "Fill out all fields!", "#badc58", 1750);
    }
});

GetInvoiceLabel = function(type) {
    retval = null;
    if (type == "request") {
        retval = "Betaalverzoek";
    }

    return retval
}

$(document).on('click', '.pay-invoice', function(event){
    event.preventDefault();

    var InvoiceId = $(this).parent().parent().attr('id');
    var InvoiceData = $("#"+InvoiceId).data('invoicedata');
    var BankBalance = $(".bank-app-account-balance").data('balance');

    if (BankBalance >= InvoiceData.amount) {
        $.post('http://rl-phone/PayInvoice', JSON.stringify({
            society: InvoiceData.society,
            amount: InvoiceData.amount,
            invoiceId: InvoiceData.invoiceid,
        }), function(CanPay){
            if (CanPay) {
                $("#"+InvoiceId).animate({
                    left: 30+"vh",
                }, 300, function(){
                    setTimeout(function(){
                        $("#"+InvoiceId).remove();
                    }, 100);
                });
                RL.Phone.Notifications.Add("fas fa-university", "TBanking", "You have $"+InvoiceData.amount+" paid!", "#badc58", 1500);
                var amountData = $(".bank-app-account-balance").data('balance');
                var NewAmount = (amountData - InvoiceData.amount).toFixed();
                $("#bank-transfer-amount").val(NewAmount);
                $(".bank-app-account-balance").data('balance', NewAmount);
            } else {
                RL.Phone.Notifications.Add("fas fa-university", "TBanking", "You do not have enough balance!", "#badc58", 1500);
            }
        });
    } else {
        RL.Phone.Notifications.Add("fas fa-university", "TBanking", "You do not have enough balance!", "#badc58", 1500);
    }
});

RL.Phone.Functions.LoadBankInvoices = function(invoices) {
    if (invoices !== null) {
        $(".bank-app-invoices-list").html("");

        $.each(invoices, function(i, invoice){
            var Elem = '<div class="bank-app-invoice" id="invoiceid-'+i+'"> <div class="bank-app-invoice-title">$' + invoice.amount + ' <span style="font-size: 1vh; color: gray;">(Society: '+ invoice.society +')</span></div> <div class="bank-app-invoice-amount">' +invoice.title+ '</div> <div class="bank-app-invoice-buttons"> <i class="fas fa-check-circle pay-invoice"></i></div> </div>';

            $(".bank-app-invoices-list").append(Elem);
            $("#invoiceid-"+i).data('invoicedata', invoice);
        });
    }
}

RL.Phone.Functions.LoadContactsWithNumber = function(myContacts) {
    var ContactsObject = $(".bank-app-my-contacts-list");
    $(ContactsObject).html("");
    var TotalContacts = 0;

    $("#bank-app-my-contact-search").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $(".bank-app-my-contacts-list .bank-app-my-contact").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });

    if (myContacts !== null) {
        $.each(myContacts, function(i, contact){
            var RandomNumber = Math.floor(Math.random() * 6);
            var ContactColor = RL.Phone.ContactColors[RandomNumber];
            var ContactElement = '<div class="bank-app-my-contact" data-bankcontactid="'+i+'"> <div class="bank-app-my-contact-firstletter">'+((contact.name).charAt(0)).toUpperCase()+'</div> <div class="bank-app-my-contact-name">'+contact.name+'</div> </div>'
            TotalContacts = TotalContacts + 1
            $(ContactsObject).append(ContactElement);
            $("[data-bankcontactid='"+i+"']").data('contactData', contact);
        });
    }
};

$(document).on('click', '.bank-app-my-contacts-list-back', function(e){
    e.preventDefault();

    RL.Phone.Animations.TopSlideUp(".bank-app-my-contacts", 400, -100);
});

$(document).on('click', '.bank-transfer-mycontacts-icon', function(e){
    e.preventDefault();

    RL.Phone.Animations.TopSlideDown(".bank-app-my-contacts", 400, 0);
});

$(document).on('click', '.bank-app-my-contact', function(e){
    e.preventDefault();
    var PressedContactData = $(this).data('contactData');

    if (PressedContactData.iban !== "" && PressedContactData.iban !== undefined && PressedContactData.iban !== null) {
        $("#bank-transfer-iban").val(PressedContactData.iban);
    } else {
        RL.Phone.Notifications.Add("fas fa-university", "TBanking", "There is no IBAN tied to this contact!", "#badc58", 2500);
    }
    RL.Phone.Animations.TopSlideUp(".bank-app-my-contacts", 400, -100);
});