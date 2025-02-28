local function setup_airboss()
    local carriername = "CVN"

    local airboss = AIRBOSS:New(carriername, "CVN-75 Truman")

    airboss:SetMenuSingleCarrier(true)
    airboss:SetMenuRecovery(30, 20, false)
    airboss:SetDespawnOnEngineShutdown()
    -- airboss:SetRespawnAI()
    airboss:SetMenuMarkZones(false)
    airboss:SetMenuSmokeZones(false)
    airboss:SetPatrolAdInfinitum(true)
    airboss:SetSoundfilesFolder("Airboss Soundfiles/")

    airboss:SetTACAN(32, "X", "TRU")
    airboss:SetICLS(10, "TRU")
    airboss:SetLSORadio(264, "AM")
    airboss:SetMarshalRadio(305, "AM")

    airboss:AddRecoveryWindow("2:30", "3:00", 3, nil, true)
    airboss:AddRecoveryWindow("8:30", "9:00", 1, nil, true)
    airboss:AddRecoveryWindow("11:30", "12:00", 1, nil, true)
    airboss:AddRecoveryWindow("17:00", "17:30", 1, nil, true)
    airboss:AddRecoveryWindow("23:30", "00:00+1", 3, nil, true)

    -- airboss:Load()
    -- airboss:SetAutoSave()

    airboss:Start()

    local rescue = RESCUEHELO:New(carriername, "Rescue")
    rescue:SetTakeoffHot()
    rescue:SetRespawnInAir()
    rescue:__Start(1)

    function rescue:OnAfterStart(From, Event, To)
        airboss:SetRadioRelayLSO(self:GetUnitName())
    end


    local tanker = RECOVERYTANKER:New(carriername, "Texaco")
    tanker:SetTakeoffHot()
    tanker:SetRadio(250)
    tanker:SetModex(511)
    tanker:SetCallsign(CALLSIGN.Tanker.Texaco)
    tanker:SetTACAN(11, "TKR")
    tanker:SetUnlimitedFuel(true)
    tanker:__Start(1)

    function tanker:OnAfterStart(From, Event, To)
        airboss:SetRecoveryTanker(tanker)  
        airboss:SetRadioRelayLSO(self:GetUnitName())
    end


    local awacs = RECOVERYTANKER:New(carriername, "Wizard")
    awacs:SetAWACS()
    awacs:SetTakeoffHot()
    -- awacs:SetRespawnInAir()
    -- awacs:SetRespawnOn()
    awacs:SetRadio(221)
    awacs:SetModex(611)
    awacs:SetCallsign(CALLSIGN.AWACS.Wizard)
    awacs:SetTACAN(14, "WIZ")
    awacs:SetAltitude(20000)
    awacs:SetRacetrackDistances(30, 15)
    awacs:SetUnlimitedFuel(true)
    awacs:__Start(1)

    function awacs:OnAfterStart(From, Event, To)
        airboss:SetRecoveryTanker(awacs)
    end

    return airboss
end


return setup_airboss()