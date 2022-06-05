  local blips = {
  {title="Clothing", colour=3, id=73, x = 425.236, y = -806.008, z = 29.491}, -- Clothing 1
  {title="Clothing", colour=3, id=73, x = -162.658, y = -303.397, z = 39.733}, -- Clothing 2
  {title="Clothing", colour=3, id=73, x = 75.950, y = -1392.891, z = 29.376}, -- Clothing 3
  {title="Clothing", colour=3, id=73, x = -822.194, y = -1074.134, z = 11.328}, -- Clothing 4
  {title="Clothing", colour=3, id=73, x = -1450.711, y = -236.83, z = 49.809}, -- Clothing 5
  {title="Clothing", colour=3, id=73, x = 4.254, y = 6512.813, z = 31.877}, -- Clothing 6
  {title="Clothing", colour=3, id=73, x = 615.180, y = 2762.933, z = 44.088}, -- Clothing 7
  {title="Clothing", colour=3, id=73, x = 1196.785, y = 2709.558, z = 38.222}, -- Clothing 8
  {title="Clothing", colour=3, id=73, x = -3171.453, y = 1043.857, z = 20.863}, -- Clothing 9
  {title="Clothing", colour=3, id=73, x = -1100.959, y = 2710.211, z = 19.107}, -- Clothing 10
  {title="Clothing", colour=3, id=73, x = -1192.9453125, y = -772.62481689453, z = 17.3254737854}, -- Clothing 11
  {title="Clothing", colour=3, id=73, x = 1683.45667, y = 4823.17725, z = 42.1631294}, -- Clothing 12
  {title="Clothing", colour=3, id=73, x = -712.215881, y = -155.352982, z = 37.4151268}, -- Clothing 13
  {title="Clothing", colour=3, id=73, x = 121.76, y = -224.6, z = 54.56}, -- Clothing 14
  {title="Clothing", colour=3, id=73, x = -1207.5267333984, y = -1456.9530029297, z = 4.3763856887817}, -- Clothing 15
  {title="Barber", colour=9, id=71, x = -814.3, y = -183.8, z = 36.6}, -- Barber Shop 1
  {title="Barber", colour=9, id=71, x = 136.8, y = -1708.4, z = 28.3}, -- Barber Shop 2
  {title="Barber", colour=9, id=71, x = -1282.6, y = -1116.8, z = 6.0}, -- Barber Shop 3
  {title="Barber", colour=9, id=71, x = 1931.5, y = 3729.7, z = 31.8}, -- Barber Shop 4
  {title="Barber", colour=9, id=71, x = 1212.8, y = -472.9, z = 65.2}, -- Barber Shop 5
  {title="Barber", colour=9, id=71, x = -32.9, y = -152.3, z = 56.1}, -- Barber Shop 6
  {title="Barber", colour=9, id=71, x = -278.1, y = 6228.5, z = 30.7}, -- Barber Shop 7
}

Citizen.CreateThread(function()
      for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	    BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)