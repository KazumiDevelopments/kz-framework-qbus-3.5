Config = Config or {}

Config.RepeatTimeout = 2000
Config.CallRepeats = 10
Config.OpenPhone = 244
Config.PhoneApplications = {
    ["phone"] = {
        app = "phone",
        color = "#04b543",
        icon = "fa fa-phone-alt",
        tooltipText = "Phone",
        job = false,
        blockedjobs = {},
        slot = 1,
        Alerts = 0,
    },
    ["whatsapp"] = {
        app = "whatsapp",
        color = "#25d366",
        icon = "fab fa-whatsapp",
        tooltipText = "Whatsapp",
        style = "font-size: 2.8vh";
        job = false,
        blockedjobs = {},
        slot = 2,
        Alerts = 0,
    },
    ["settings"] = {
        app = "settings",
        color = "#636e72",
        icon = "fa fa-cog",
        tooltipText = "Settings",
        style = "padding-right: .08vh; font-size: 2.3vh";
        job = false,
        blockedjobs = {},
        slot = 3,
        Alerts = 0,
    },
    ["twitter"] = {
        app = "twitter",
        color = "#1da1f2",
        icon = "fab fa-twitter",
        tooltipText = "Twitter",
        job = false,
        blockedjobs = {},
        slot = 4,
        Alerts = 0,
    },
    ["garage"] = {
        app = "garage",
        color = "#575fcf",
        icon = "fas fa-warehouse",
        tooltipText = "Vehicles",
        job = false,
        blockedjobs = {},
        slot = 5,
        Alerts = 0,
    },
    ["mail"] = {
        app = "mail",
        color = "#ff002f",
        icon = "fas fa-envelope",
        tooltipText = "Mail",
        job = false,
        blockedjobs = {},
        slot = 6,
        Alerts = 0,
    },
    ["advert"] = {
        app = "advert",
        color = "#ff8f1a",
        icon = "fas fa-ad",
        tooltipText = "Ads",
        job = false,
        blockedjobs = {},
        slot = 7,
        Alerts = 0,
    },
    ["bank"] = {
        app = "bank",
        color = "#9c88ff",
        icon = "fas fa-university",
        tooltipText = "Bank",
        job = false,
        blockedjobs = {},
        slot = 8,
        Alerts = 0,
    },
    --[[ ["crypto"] = {
        app = "crypto",
        color = "#004682",
        icon = "fas fa-chart-pie",
        tooltipText = "Crypto",
        job = false,
        blockedjobs = {},
        slot = 16,
        Alerts = 0,
    }, ]]
    ["racing"] = {
        app = "racing",
        color = "#353b48",
        icon = "fas fa-flag-checkered",
        tooltipText = "Racing",
        job = false,
        blockedjobs = {
            "police"
        },
        slot = 9,
        Alerts = 0,
    },
    ["houses"] = {
        app = "houses",
        color = "#27ae60",
        icon = "fas fa-home",
        tooltipText = "Houses",
        job = false,
        blockedjobs = {},
        slot = 10,
        Alerts = 0,
    },
    
    ["lawyers"] = {
        app = "lawyers",
        color = "#353b48",
        icon = "fas fa-user-tie",
        tooltipText = "Lawyers",
        job = false,
        blockedjobs = {},
        slot = 11,
        Alerts = 0,
    },
    ["taxi"] = {
        app = "taxi",
        color = "#fb9403",
        icon = "fas fa-taxi",
        tooltipText = "Taxi",
        style = "font-size: 2.8vh";
        job = false,
        blockedjobs = {},
        slot = 12,
        Alerts = 0,
    },
    ["rentel"] = {
        app = "rentel",
        color = "‎#ee82ee",
        icon = "fas fa-biking",
        tooltipText = "Rental",
        style = "padding-right: .3vh; font-size: 2vh";
        job = false,
        blockedjobs = {},
        slot = 13,
        Alerts = 0,
    },
    ["sellix"] = {
        app = "sellix",
        color = "‎#451bff",
        icon = "fab fa-shopify",
        tooltipText = "Sellix",
        style = "padding-right: .3vh; font-size: 2vh";
        job = false,
        blockedjobs = {
            "police"
        },
        slot = 14,
        Alerts = 0,
    },
    ["meos"] = {
        app = "meos",
        color = "#004682",
        icon = "fas fa-ad",
        tooltipText = "MEOS",
        job = "police",
        blockedjobs = {},
        slot = 15,
        Alerts = 0,
    },
    --[[
    ["store"] = {
        app = "store",
        color = "#27ae60",
        icon = "fas fa-cart-arrow-down",
        tooltipText = "App Store",
        style = "padding-right: .3vh; font-size: 2.2vh";
        job = false,
        blockedjobs = {},
        slot = 14,
        Alerts = 0,
    },
    
    ["rental"] = {
        app = "lsrental",
        color = "#27ae60",
        icon = "fas fa-cart-arrow-down",
        tooltipText = "Rental",
        style = "padding-right: .3vh; font-size: 2vh";
        job = false,
        blockedjobs = {},
        slot = 12,
        Alerts = 0,
    },]]
    -- ["trucker"] = {
    --     app = "trucker",
    --     color = "#cccc33",
    --     icon = "fas fa-truck-moving",
    --     tooltipText = "Dumbo",
    --     job = false,
    --     blockedjobs = {},
    --     slot = 17,
    --     Alerts = 0,
    -- },
}
Config.MaxSlots = 20

Config.StoreApps = {
    ["territory"] = {
        app = "territory",
        color = "#353b48",
        icon = "fas fa-globe-europe",
        tooltipText = "territory",
        style = "";
        job = false,
        blockedjobs = {},
        slot = 15,
        Alerts = 0,
        password = true,
        creator = "Qbus",
        title = "Territory",
    },
}

Config.RentelVehicles = {
	['tribike3'] = { ['model'] = 'tribike3', ['label'] = 'Tribike Blue', ['price'] = 100, ['icon'] = 'fas fa-biking' },
	['bmx'] = { ['model'] = 'bmx', ['label'] = 'BMX', ['price'] = 100, ['icon'] = 'fas fa-biking' },
    --['panto'] = { ['model'] = 'panto', ['label'] = 'Panto', ['price'] = 250, ['icon'] = 'fas fa-car' },
	--['rhapsody'] = { ['model'] = 'rhapsody', ['label'] = 'Rhapsody', ['price'] = 300, ['icon'] = 'fas fa-car' },
	--['felon'] = { ['model'] = 'felon', ['label'] = 'Felon', ['price'] = 400, ['icon'] = 'fas fa-car' },
	--['bagger'] = { ['model'] = 'bagger', ['label'] = 'Bagger', ['price'] = 400, ['icon'] = 'fas fa-motorcycle' },
    --['biff'] = { ['model'] = 'biff', ['label'] = 'Biff', ['price'] = 500, ['icon'] = 'fas fa-truck-moving' },
}

Config.RentelLocations = {
    ['Courthouse Paystation'] = {
        ['coords'] = vector4(129.93887, -898.5326, 30.148599, 166.04177)
    },
    ['Train Station'] = {
        ['coords'] = vector4(-213.4004, -1003.342, 29.144016, 345.36584)
    },
    ['Bus Station'] = {
        ['coords'] = vector4(416.98699, -641.6024, 28.500173, 90.011344)
    },    
    ['Morningwood Blvd'] = {
        ['coords'] = vector4(-1274.631, -419.1656, 34.215377, 209.4456)
    },    
    ['South Rockford Drive'] = {
        ['coords'] = vector4(-682.9262, -1112.928, 14.525076, 37.729667)
    },    
    ['Tinsel Towers Street'] = {
        ['coords'] = vector4(-716.9338, -58.31439, 37.472839, 297.83691)
    }        
}