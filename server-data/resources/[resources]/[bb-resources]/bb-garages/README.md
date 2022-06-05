

 /$$$$$$$  /$$$$$$$         /$$$$$$                                                            
| $$__  $$| $$__  $$       /$$__  $$                                                           
| $$  \ $$| $$  \ $$      | $$  \__/  /$$$$$$   /$$$$$$  /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$$
| $$$$$$$ | $$$$$$$       | $$ /$$$$ |____  $$ /$$__  $$|____  $$ /$$__  $$ /$$__  $$ /$$_____/
| $$__  $$| $$__  $$      | $$|_  $$  /$$$$$$$| $$  \__/ /$$$$$$$| $$  \ $$| $$$$$$$$|  $$$$$$ 
| $$  \ $$| $$  \ $$      | $$  \ $$ /$$__  $$| $$      /$$__  $$| $$  | $$| $$_____/ \____  $$
| $$$$$$$/| $$$$$$$/      |  $$$$$$/|  $$$$$$$| $$     |  $$$$$$$|  $$$$$$$|  $$$$$$$ /$$$$$$$/
|_______/ |_______/        \______/  \_______/|__/      \_______/ \____  $$ \_______/|_______/ 
                                                                  /$$  \ $$                    
                                                                 |  $$$$$$/                    
                                                                  \______/                     
                               Installation Tutorial
                            Developed by barbaronn#9999


# Convert SQL
Insert the sql.sql file into your database,
Run the server with the bb-garages-sql-convert script once

# Add Items
For the plates system to work, you must enter the following items in `RLCore > Shared`
You can also insert the image into your inventory or insert one of your own

["advancedscrewdriver"] = {
    ["name"] = "advancedscrewdriver",
    ["label"] = "Advanced Screwdriver",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "advancedscrewdriver.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "A screwdriver"
},

["licenseplate"] = {
    ["name"] = "licenseplate",
    ["label"] = "License Plate",
    ["weight"] = 30,
    ["type"] = "item",
    ["image"] = "licenseplate.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "A License Plate"
},

======================================================================================================================================================================

# Inventory
app.js > Line 397 - Add:

} else if (itemData.name == "licenseplate") {
    $(".item-info-title").html('<p>'+itemData.label+'</p>')
    $(".item-info-description").html('<p>Plate: ' + itemData.info.plate + '</p>');


======================================================================================================================================================================

# Phone
HTML - 
Replace "garage-app" Div with the following one:

<div class="garage-app">
    <div class="garage-app-header">
        My Garage
    </div>
    <div class="garage-homescreen">
        <div class="garage-vehicles">
        </div>
    </div>
    <div class="garage-detailscreen">
        <div class="garage-cardetails">
            <div class="vehicle-brand"><span class="vehicle-detail">Brand</span><span class="vehicle-answer">BMW M5</span></div>
            <div class="vehicle-model"><span class="vehicle-detail">Model</span><span class="vehicle-answer">BMW M5</span></div>
            <div class="vehicle-plate"><span class="vehicle-detail">License Plate</span><span class="vehicle-answer">BMW M5</span></div>
            <div class="vehicle-garage"><span class="vehicle-detail">Garage</span><span class="vehicle-answer">BMW M5</span></div>
            &nbsp;
            <div class="vehicle-fuel"><span class="vehicle-detail">Fuel</span><span class="vehicle-answer">BMW M5</span></div>
            <div class="vehicle-engine"><span class="vehicle-detail">Damage</span><span class="vehicle-answer">BMW M5</span></div>

            <div class="garage-cardetails-footer">
                BACK
            </div>
        </div>
    </div>
</div>

JS -
Repalce SetupDetails on garages.js line 39 with the following one:

SetupDetails = function(data) {
    $(".vehicle-brand").find(".vehicle-answer").html(data.brand);
    $(".vehicle-model").find(".vehicle-answer").html(data.model);
    $(".vehicle-plate").find(".vehicle-answer").html(data.plate);
    $(".vehicle-garage").find(".vehicle-answer").html(data.garage);
    $(".vehicle-fuel").find(".vehicle-answer").html(Math.ceil(data.fuel)+"%");
    $(".vehicle-engine").find(".vehicle-answer").html(Math.ceil(data.damage)+"%");
}

Server -
Replace qb-phone:server:GetGarageVehicles with the following one:

RLCore.Functions.CreateCallback('qb-phone:server:GetGarageVehicles', function(source, cb)
    local Player = RLCore.Functions.GetPlayer(source)
    local Vehicles = {}

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `bbvehicles` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local VehicleData = RLCore.Shared.Vehicles[v.model]

                local VehicleGarage = "Unknown"
                if v.state ~= 'unknown' then
                    if v.state == 'garage' then
                        local parking = json.decode(v.parking)
                        VehicleGarage = parking[2]
                    elseif v.state == 'impound' then
                        VehicleGarage = 'Impound'
                    end
                end

                local stats = json.decode(v.stats)
                local dmg = (((stats["body_damage"] + stats["engine_damage"]) / 10 / 2))
                local vehdata = {
                    fullname = VehicleData["name"],
                    brand = VehicleData["name"],
                    model = VehicleData["name"],
                    plate = v.plate,
                    garage = VehicleGarage,
                    fuel = stats['fuel'],
                    damage = math.ceil(dmg),
                }

                table.insert(Vehicles, vehdata)
            end
            cb(Vehicles)
        else
            cb(nil)
        end
    end)
end)