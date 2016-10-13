//::::::::::::  ::::::::::::\\
//  Filename: life_server/Functions/D41/PVPAreaMissions.sqf
//  Author: Distrikt41 - Dscha
//
//  Beschreibung: Erzeugt innerhalb des PVP Gebietes an einer Random Position eine Kiste inkl. Inhalt (Beschäftigungstherapie)
// Format:  _return =   ["ITEM/WAFFENNAME",ANZAHL];
// Multi:   _return =   ["ITEM/WAFFENNAME",ANZAHL,"ITEM/WAFFENNAME",ANZAHL,];
//::::::::::::  ::::::::::::\\
private["_D41_fnc_D41_AddMissonBoxCargo","_CreateMission","_MarkerPos","_marker","_return"];


_CreateMission =
{
    _addMode = "Fehler";
    _return = [];
    //Create Items / Inhalt erzeugen
    _D41_fnc_D41_AddMissonBoxCargo =
    {
        _Rndm = round(random 100);
        switch(true)do
        {
            // ~ nix
            case (_Rndm >= 0 && _Rndm < 10) :   {_return =  ["D41_Nagelband",3,"D41_Apfelschnaps",5];};
            // ~ nüx
            case (_Rndm >= 10 && _Rndm < 20):   {_return =  ["D41_Hasenfleisch",20,"D41_Apfelsaft",20];};
            // ~ auch wenig
            case (_Rndm >= 20 && _Rndm < 30):   {_return =  ["D41_BeefJerky",20,"D41_EnergyDrink",20];};
            // ~ verarscht!
            case (_Rndm >= 30 && _Rndm < 40):   {_return =  ["D41_Donuts",1,"D41_Kaffee",1];};
            // ~ Net viel wert, aber nützlich!
            case (_Rndm >= 40 && _Rndm < 50):   {_return =  ["optic_LRPS",1,"optic_DMS",1];};
            // ~ Net viel wert, aber nützlich!
            case (_Rndm >= 50 && _Rndm < 55):   {_return =  ["D41_Mauer",2];};
            // ~ Longrange Scopes sind Mangelware
            case (_Rndm >= 55 && _Rndm < 60):   {_return =  ["optic_KHS_old",1,"optic_SOS",1];};
            // Desert Eagle Modern - In keinem Shop verfügbar
            case (_Rndm >= 60 && _Rndm < 65):   {_return =  ["RH_7Rnd_50_AE",4,"RH_Deaglem",1];};
            // Schalldämpfer 5.56 - In keinem Shop verfügbar
            case (_Rndm >= 65 && _Rndm < 70):   {_return =  ["muzzle_snds_M",1,"muzzle_snds_acp",1,"RH_gemtech9",1];};
            //~ 99.000
            case (_Rndm >= 70 && _Rndm < 75):   {_return =  ["D41_Kokain",125];};
            // LA86 gibts auch in keinem Shop
            case (_Rndm >= 75 && _Rndm < 80):   {_return =  ["CUP_30Rnd_556x45_Stanag",4,"CUP_arifle_L86A2",1];};
            // Hier kann noch Methrohstoff rein der sonst geklaut werden muss
            case (_Rndm >= 80 && _Rndm < 85):   {_return =  ["Rangefinder",2];};
            // ~ 120.000
            case (_Rndm >= 85 && _Rndm < 90):   {_return =  ["D41_Diamanten",60];};
            // ~ unbezahlbar! Da in keinem Shop verfügbar.
            case (_Rndm >= 90 && _Rndm < 95):   {_return =  ["hlc_20rnd_762x51_b_fal",4,"hlc_rifle_STG58F",1];};
            // ~200.000
            case (_Rndm >= 95)              :   {_return =  ["D41_GoldBarren",20];};
        };
        diag_log format [":::::::::::: MISSION BOX RNDM = %1 || INHALT: %2", _Rndm, _return];
    };
    
    //Mission Box erstellen
	_RandomBox = ["Box_NATO_WpsSpecial_F","D41_gaz66_msv","D41_Gaz24_Civ_03","D41_S1203_Civ_Rot"] call BIS_fnc_selectRandom;
    D41_MissionBox = createVehicle [_RandomBox, getMarkerPos "pvpgebiet", ["pvpgebiet"], 2000, "NONE"]; //Große Box

    D41_MissionBoxPos = getPos D41_MissionBox;

    D41_MissionBox setFuel 0;  
    //D41_MissionBox allowDamage false;
    clearWeaponCargoGlobal D41_MissionBox;
    clearMagazineCargoGlobal D41_MissionBox;
    clearItemCargoGlobal D41_MissionBox;
    clearBackpackCargoGlobal D41_MissionBox;
    _MarkerPos = createVehicle ["GroundWeaponHolder", getPos D41_MissionBox, [], 200, "NONE"];
    _marker = createMarker ["TreasureZone", (getPos _MarkerPos) ];
    "TreasureZone" setMarkerColor "ColorBlack";
    "TreasureZone" setMarkerSize [200, 200];
    "TreasureZone" setMarkerText "Treasure Zone";
    "TreasureZone" setMarkerShape "ELLIPSE";
    
    //Missonbox füllen
    [] call _D41_fnc_D41_AddMissonBoxCargo;
    _cnt = 0;
    for "_i" from 1 to (count(_return)/2)do
    {
        _AddItem = _return select _cnt;
        _cnt = _cnt + 1;
        _AddCount = _return select _cnt;
        if(isClass (configFile >> "CfgWeapons"      >> _AddItem))then   {   if(_AddItem in ["muzzle_snds_M"])exitWith{D41_MissionBox addItemCargoGlobal [_AddItem,_AddCount];}; //muzzle = CfgWeapons -> Muß aber via addItem hinzugefügt werden -.-
																			if(_AddItem in ["muzzle_snds_acp"])exitWith{D41_MissionBox addItemCargoGlobal [_AddItem,_AddCount];};
																			if(_AddItem in ["RH_gemtech9"])exitWith{D41_MissionBox addItemCargoGlobal [_AddItem,_AddCount];};
                                                                            D41_MissionBox addWeaponCargoGlobal [_AddItem,_AddCount];
                                                                        };
        if(isClass (configFile >> "CfgMagazines"    >> _AddItem))then   {D41_MissionBox addMagazineCargoGlobal [_AddItem,_AddCount];};
        if(isClass (configFile >> "CfgVehicles"     >> _AddItem))then   {D41_MissionBox addItemCargoGlobal [_AddItem,_AddCount];};
        _cnt = _cnt + 1;
    };
	
    deleteVehicle _MarkerPos;
};

_DeleteMission = 
{
	//Missionbox löschen
	deleteMarker "TreasureZone";
	
	if(!isNull D41_MissionBox)then
	{
		if(((getPos D41_MissionBox) distance D41_MissionBoxPos) < 10)then
		{
			deleteVehicle D41_MissionBox;
		};
	};
};

hideout1 = (nearestObjects[getMarkerPos "Ganghideout01",["FlagPole_F"],25]) select 0;
hideout2 = (nearestObjects[getMarkerPos "Ganghideout02",["FlagPole_F"],25]) select 0;
hideout3 = (nearestObjects[getMarkerPos "Ganghideout03",["FlagPole_F"],25]) select 0;


while{true}do
{
	hideoutOwner1 = hideout1 getVariable ["gangOwner",grpNull];
	hideoutOwner2 = hideout2 getVariable ["gangOwner",grpNull];
	hideoutOwner3 = hideout3 getVariable ["gangOwner",grpNull];
	if((((hideoutOwner1 isEqualTo hideoutOwner2) && !(isNull hideoutOwner1)) OR ((hideoutOwner1 isEqualTo hideoutOwner3) && !(isNull hideoutOwner1)) OR ((hideoutOwner2 isEqualTo hideoutOwner3) && !(isNull hideoutOwner2))) && ({side _x == civilian} count playableUnits > 10)) then {
	sleep round(random 900);
	[] spawn _CreateMission;
	sleep 1200;
	sleep round(random 2400);
	[] spawn _DeleteMission;
	};
	sleep 180;

};