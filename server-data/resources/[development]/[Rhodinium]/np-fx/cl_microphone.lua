CreateThread(function()
  exports["np-polyzone"]:AddBoxZone("np-fx:audio:stage", vector3(-551.12, 284.66, 82.98), 7.4, 3.0, {
    heading=355,
    minZ=81.78,
    maxZ=84.78,
    data = {
      id = "tequilala:stage",
      ranges = {
        {
          mode = 3,
          range = 30.0,
          priority = 3
        }
      }
    }
  })
  exports["np-polyzone"]:AddBoxZone("np-fx:audio:stage", vector3(-439.78, 277.39, 83.41), 1.8, 1.4, {
    heading=355,
    minZ=82.06,
    maxZ=85.26,
    data = {
      id = "comedyclub:stage",
      ranges = {
        {
          mode = 3,
          range = 30.0,
          priority = 3
        }
      }
    }
  })
  exports["np-polyzone"]:AddBoxZone("np-fx:audio:stage", vector3(-1381.94, -615.02, 31.5), 2.0, 4.0, {
    heading=303,
    minZ=29.9,
    maxZ=33.9,
    data = {
      id = "bahamamamas:stage",
      ranges = {
        {
          mode = 3,
          range = 30.0,
          priority = 3
        }
      }
    }
  })
  exports["np-polyzone"]:AddBoxZone("np-fx:audio:stage", vector3(440.84, -985.84, 34.97), 1.0, 1.4, {
    heading=0,
    minZ=33.97,
    maxZ=36.77,
    data = {
      id = "pd:classroom:podium",
      ranges = {
        {
          mode = 2,
          range = 5.0,
          priority = 3
        },
        {
          mode = 3,
          range = 10.0,
          priority = 3
        }
      },
      filter = "podium"
    }
  })
  exports["np-polyzone"]:AddBoxZone("np-fx:audio:stage", vector3(-570.29, -929.6, 23.97), 3.4, 2.0, {
    heading=0,
    minZ=22.97,
    maxZ=25.77,
    data = {
      id = "lsnews:anchor:stage",
      ranges = {
        {
          mode = 3,
          range = 10.0,
          priority = 3
        }
      }
    }
  })
  exports["np-polyzone"]:AddPolyZone("np-fx:audio:stage", {
    vector2(667.98602294922, 576.31848144531),
    vector2(679.03790283203, 590.67059326172),
    vector2(700.68853759766, 582.84783935547),
    vector2(699.16333007812, 564.87322998047),
    vector2(689.61529541016, 568.25823974609),
    vector2(687.34429931641, 566.87066650391),
    vector2(683.13262939453, 566.18231201172),
    vector2(679.07061767578, 569.24786376953),
    vector2(677.82830810547, 572.54663085938),
    vector2(676.77917480469, 572.95831298828)
  }, {
    minZ = 129.54597473145,
    maxZ = 137.46141052246,
    data = {
      id = "vinewood:bowl:stage",
      ranges = {
        {
          mode = 3,
          range = 100.0,
          priority = 3
        }
      }
    }
  })
  exports["np-polyzone"]:AddBoxZone("np-fx:audio:stage", vector3(485.62, -988.78, 26.27), 4.5, 5.6, {
    heading=0,
    minZ=25.27,
    maxZ=28.077,
    data = {
      id = "pd:interrogation:1",
      ranges = {
        {
          mode = 1,
          range = 4.0,
          priority = 2
        },
        {
          mode = 2,
          range = 4.0,
          priority = 2
        }
      }
    }
  })
  exports["np-polyzone"]:AddBoxZone("np-fx:audio:stage", vector3(485.65, -996.87, 26.27), 4.4, 5.6, {
    heading=0,
    minZ=25.27,
    maxZ=28.07,
    data = {
      id = "pd:interrogation:2",
      ranges = {
        {
          mode = 1,
          range = 4.0,
          priority = 2
        },
        {
          mode = 2,
          range = 4.0,
          priority = 2
        }
      }
    }
  })
  exports["np-polyzone"]:AddBoxZone("np-fx:audio:stage", vector3(-839.96, -718.49, 28.06), 6.2, 4.6, {
    heading=140,
    minZ=26.91,
    maxZ=30.51,
    data = {
      id = "wuchang:stage",
      ranges = {
        {
          mode = 3,
          range = 30.0,
          priority = 3
        }
      }
    }
  })
  exports["np-polyzone"]:AddBoxZone("np-fx:audio:stage", vector3(-1714.29, -1120.51, 13.96), 6.4, 9.4, {
    heading=47.0,
    minZ=12.16,
    maxZ=17.36,
    data = {
      id = "deanworld:stage",
      ranges = {
        {
          mode = 3,
          range = 30.0,
          priority = 3
        }
      }
    }
  })
  exports["np-polyzone"]:AddBoxZone("np-fx:audio:stage", vector3(-490.08, 30.27, 52.41), 3.6, 4.2, {
    heading=356,
    minZ=51.61,
    maxZ=54.21,
    data = {
      id = "gallery:stage",
      ranges = {
        {
          mode = 3,
          range = 15.0,
          priority = 3,
        },
      },
    },
  })

  exports["np-polyzone"]:AddBoxZone("np-fx:audio:stage", vector3(1770.26, 2492.41, 50.43), 2.0, 1.0, {
    heading=30,
    minZ=49.43,
    maxZ=51.43,
    data = {
      id = "prison:doc:megaphone:1",
      ranges = {
        {
          mode = 3,
          range = 20.0,
          priority = 3,
        },
      },
    },
  })

  exports["np-polyzone"]:AddBoxZone("np-fx:audio:stage", vector3(1691.0, 2529.05, 54.88), 2.0, 10.6, {
    heading=0,
    minZ=53.88,
    maxZ=56.48,
    data = {
      id = "prison:doc:megaphone:2",
      ranges = {
        {
          mode = 3,
          range = 100.0,
          priority = 3,
        },
      },
    },
  })
end)

AddEventHandler("np-polyzone:enter", function(zone, data)
  if zone == "np-fx:audio:stage" then
    MumbleSetAudioInputIntent(`music`)
    if data.filter then
      TriggerServerEvent("np:voice:transmission:state", -1, data.filter, true, data.filter)
    end
    TriggerEvent('np:voice:proximity:override', data.id, data.ranges)
  end
end)

AddEventHandler("np-polyzone:exit", function(zone, data)
  if zone == "np-fx:audio:stage" then
    MumbleSetAudioInputIntent(`speech`)
    if data.filter then
      TriggerServerEvent("np:voice:transmission:state", -1, data.filter, false, data.filter)
    end
    TriggerEvent('np:voice:proximity:override', data.id, data.ranges, -1, -1)
  end
end)
