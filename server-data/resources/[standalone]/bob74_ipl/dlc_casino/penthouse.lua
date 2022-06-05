--[[ Citizen.CreateThread(function()


    RequestIpl("vw_casino_penthouse")
    
        interiorID = GetInteriorAtCoords(976.63, 70.29, 115.16)
            
        
        if IsValidInterior(interiorID) then      
                ActivateInteriorEntitySet(interiorID, "set_pent_tint_shell")
                SetInteriorEntitySetColor(interiorID, "set_pent_tint_shell", 1)
                ActivateInteriorEntitySet(interiorID, "set_pent_media_bar_open")
                SetInteriorEntitySetColor(interiorID, "set_pent_media_bar_open", 1)
                ActivateInteriorEntitySet(interiorID, "set_pent_spa_bar_open")
                SetInteriorEntitySetColor(interiorID, "set_pent_spa_bar_open", 1)
                ActivateInteriorEntitySet(interiorID, "set_pent_dealer")
                SetInteriorEntitySetColor(interiorID, "set_pent_dealer", 1)
                --ActivateInteriorEntitySet(interiorID, "set_pent_nodealer")
                --ActivateInteriorEntitySet(interiorID, "set_pent_media_bar_closed")
                --ActivateInteriorEntitySet(interiorID, "set_pent_spa_bar_closed")
                --ActivateInteriorEntitySet(interiorID, "set_pent_pattern_01")
                --ActivateInteriorEntitySet(interiorID, "set_pent_pattern_02")
                --ActivateInteriorEntitySet(interiorID, "set_pent_pattern_03")
                ActivateInteriorEntitySet(interiorID, "set_pent_pattern_04")
                SetInteriorEntitySetColor(interiorID, "set_pent_pattern_04", 1)
                --ActivateInteriorEntitySet(interiorID, "set_pent_pattern_05")
                --ActivateInteriorEntitySet(interiorID, "set_pent_pattern_06")
                --ActivateInteriorEntitySet(interiorID, "set_pent_pattern_07")
                --ActivateInteriorEntitySet(interiorID, "set_pent_pattern_08")
                --ActivateInteriorEntitySet(interiorID, "set_pent_pattern_09")
                --ActivateInteriorEntitySet(interiorID, "set_pent_arcade_modern")
                ActivateInteriorEntitySet(interiorID, "set_pent_arcade_retro")
                ActivateInteriorEntitySet(interiorID, "set_pent_clutter_03")
                --ActivateInteriorEntitySet(interiorID, "set_pent_clutter_02")
                ActivateInteriorEntitySet(interiorID, "set_pent_clutter_01")
                --ActivateInteriorEntitySet(interiorID, "set_pent_lounge_blocker")
                --ActivateInteriorEntitySet(interiorID, "set_pent_guest_blocker")
                --ActivateInteriorEntitySet(interiorID, "set_pent_office_blocker")
                --ActivateInteriorEntitySet(interiorID, "set_pent_cine_blocker")
                --ActivateInteriorEntitySet(interiorID, "set_pent_spa_blocker")
                --ActivateInteriorEntitySet(interiorID, "set_pent_bar_blocker")
                --ActivateInteriorEntitySet(interiorID, "set_pent_bar_party_after")
                ActivateInteriorEntitySet(interiorID, "set_pent_bar_clutter")
                --ActivateInteriorEntitySet(interiorID, "set_pent_bar_party_2")
                ActivateInteriorEntitySet(interiorID, "set_pent_bar_light_01")
                --ActivateInteriorEntitySet(interiorID, "set_pent_bar_light_0")
                --ActivateInteriorEntitySet(interiorID, "set_pent_bar_light_02")
                --ActivateInteriorEntitySet(interiorID, "set_pent_bar_party_0")
                ActivateInteriorEntitySet(interiorID, "set_pent_bar_party_1")
                
        RefreshInterior(interiorID)
    
        end
    
    end) ]]