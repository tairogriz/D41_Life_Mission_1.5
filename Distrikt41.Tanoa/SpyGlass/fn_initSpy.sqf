#define GVAR_UINS uiNamespace getVariable
#define CONST(var1,var2) var1 = compileFinal (if(typeName var2 == "STRING") then {var2} else {str(var2)})
#define steamid getPlayerUID player
/*
	File: fn_initSpy.sqf
	
	Description:
	Does some things that I made over-complicated / un-needed but blah.
	Will eventually include server-side checks but it's blah at this point.
	
	Will also become a standalone system which is why it's setup like this.
*/
private["_binConfigPatches","_cfgPatches","_endM"];
if(isServer && !hasInterface) exitWith {}; //Server doesn't need to know.

CONST(W_O_O_K_I_E_ANTI_ANTI_HAX,"false");
CONST(W_O_O_K_I_E_FUD_ANTI_ANTI_HAX,"false");
CONST(E_X_T_A_S_Y_ANTI_ANTI_HAX,"false");
CONST(E_X_T_A_S_Y_Pro_RE,"false");
CONST(E_X_T_A_S_Y_Car_RE,"false");
CONST(DO_NUKE,"false");
CONST(JxMxE_spunkveh,"false");
CONST(JxMxE_spunkveh2,"false");
CONST(JxMxE_spunkair,"false");
CONST(JJJJ_MMMM___EEEEEEE_LLYYSSTTIICCC_SHIT_RE,"false");
CONST(JJJJ_MMMM___EEEEEEE_LLYYSSTTIICCC_SHIT_RE_OLD,"false");
CONST(JJJJ_MMMM___EEEEEEE_SPAWN_VEH,"false");
CONST(JJJJ_MMMM___EEEEEEE_SPAWN_WEAPON,"false");
CONST(GGGG_EEEE_FFFF__PLAYERs,"false");
CONST(GGGG_EEEE_FFFF___DISPLAYID,"false");

/*
	Compile our list of allowed addon patches, by default this DOES NOT ALLOW ANY ADDONS.
	
	If you want to white-list addons such as JSRS or Blastcore you need to start a test instance (Host locally and not the mission) and first fill the SPY_cfg_patchList array, once you executed it (Filled it)
	Run the following code and it will copy the list of addons / patches not in the list to your clipboard (Ctrl + V) and then add it to the array.
	
	_cfgPatches = [];
	_binConfigPatches = configFile >> "CfgPatches";
	for "_i" from 0 to count (_binConfigPatches)-1 do {
		_patchEntry = _binConfigPatches select _i;
		if(isClass _patchEntry) then {
				_cfgPatches set[count _cfgPatches,(configName _patchEntry)];
		};
	};

	copyToClipboard str(_cfgPatches);
	
	i.e
	["cba_xeh","Extended_EventHandlers","CBA_Extended_EventHandlers","JSRS_Environment","WarFXPE","cba_common","cba_events","cba_hashes","cba_network","cba_strings","cba_ui","cba_vectors","JSRS2_120mm_Cannon","JSRS2_127","JSRS2_155mm_AMOS",
	"JSRS2_230mm_Titan","JSRS2_30mm_Cannon","JSRS2_35mm_Autocannon","JSRS2_4Five45","JSRS2_ACPC","JSRS2_Autocannon","JSRS2_Bullethits","JSRS2_DAGR","JSRS2_DAR","JSRS2_EBR","JSRS2_Explosions","JSRS2_Explosives","JSRS2_Filters","JSRS2_FS2000",
	"JSRS2_Gatling","JSRS2_GMG20","JSRS2_GMG40","JSRS2_Khaybar","JSRS2_LMGRCWS","JSRS2_M134","JSRS2_M200","JSRS2_M320R","JSRS2_M6","JSRS2_Minigun","JSRS2_MX","JSRS2_NLAW","JSRS2_P07","JSRS2_PDW","JSRS2_Rahim","JSRS2_Rook40","JSRS2_RPG32",
	"JSRS2_Scorpian","JSRS2_SDAR","JSRS2_Skalpel_ATGM","JSRS2_Skyfire","JSRS2_Sonic_Cracks","JSRS2_Titan","JSRS2_TRG20","JSRS2_Vector","JSRS2_Veh_Titan","JSRS2_Zafir","JSRS2_Zubr45","Blastcore_VEP","cba_ai","cba_arrays","cba_diagnostic","cba_help",
	"cba_ui_helper","cba_versioning","JSRS2_Movement","JSRS2_Silencers","cba_main","cba_main_a3","JSRS2_2S9_Sorcher","JSRS2_AFV4_Gorgon","JSRS2_AH99_Blackfoot","JSRS2_AH9_Pawnee","JSRS2_AMV7_Marshal","JSRS2_BTRK_Kamysh","JSRS2_CH49_Mohawk","JSRS2_Distance",
	"JSRS2_FighterPlane3","JSRS2_FV720_Mora","JSRS2_Hunter","JSRS2_Ifrit","JSRS2_IFV6a_Cheetah","JSRS2_IFV6c_Panther","JSRS2_M2A1_Slammer","JSRS2_M4_Scorcher","JSRS2_M5_Sandstorm","JSRS2_MBT52_Kuma","JSRS2_Mi48_Kajman","JSRS2_MSE3_Marid","JSRS2_Offroad",
	"JSRS2_Po30_Orca","JSRS2_Strider","JSRS2_SUV","JSRS2_T100_Varsuk","JSRS2_Truck1","JSRS2_Truck2","JSRS2_UAV_1","JSRS2_UH80_GhostHawk","JSRS2_Van","JSRS2_WY55_Hellcat","JSRS2_ZSU39_Tigris","cba_xeh_a3"]
*/

_patchList = ["A3Data","A3_BaseConfig_F","rhsusf_marks_fix","A3_Dubbing_Radio_F","A3_Functions_F","A3_Functions_F_EPA","A3_Functions_F_EPC","A3_Language_F_MP_Mark","A3_LanguageMissions_F_MP_Mark","Map_VR","A3_Map_VR_Scenes","AiA_CA_Data","AiA_CA_Data_Data_ParticleEffects","CUP_Creatures_People_Core","CUP_TrackedVehicles_Sounds","CUP_Weapons_WeaponsData","Distrikt41_V1_3_D41_S","D41_Lichtleisten","BornholmLayers","US_ESS_Glasses_tryk","cba_EE","jbad_Defines","jbad_CfgVehicleClasses","Jbad_Vehicle_controls","jbad_misc","Misc_Cases","Misc_Chairs","Misc_Decorations","Misc_Tables","doors","light_switches","Jbad_Sounds_misc","Ind","jbad_walls","Jonzie_Sounds","Kio_Balaclava","mgsr_beret","mgsr_headbag","PG_Services_PMC_Goggles","PMC_Items","rhs_c_radio","rhs_mtlb","rhs_s_radio","rhsusf_c_identity","rhsusf_c_radio","rhsusf_hemtt_a2","rhsusf_hemtt_a4","rhsusf_s_radio","TRYK_Shemaghs","maa_Uniform","A3_Data_F","A3_Data_F_Hook","A3_Data_F_ParticleEffects","A3_Data_F_Bootcamp","A3_Data_F_Exp_A","A3_Data_F_Kart_ParticleEffects","A3_Data_F_Mark","A3_Editor_F","A3_Functions_F_Bootcamp","A3_Functions_F_Curator","A3_Functions_F_Exp_A","A3_Functions_F_Heli","A3_Functions_F_Mark","A3_Functions_F_MP_Mark","A3_Language_F","A3_Language_F_Beta","A3_Language_F_Curator","A3_Language_F_EPA","A3_Language_F_EPB","A3_Language_F_EPC","A3_Language_F_Gamma","A3_Language_F_Heli","A3_Language_F_Kart","A3_Language_F_Mark","A3_LanguageMissions_F","A3_LanguageMissions_F_Beta","A3_LanguageMissions_F_Gamma","A3_LanguageMissions_F_Kart","A3_Misc_F","A3_Misc_F_Helpers","A3_Modules_F","A3_Modules_F_DynO","A3_Modules_F_Effects","A3_Modules_F_Events","A3_Modules_F_GroupModifiers","A3_Modules_F_HC","A3_Modules_F_Intel","A3_Modules_F_LiveFeed","A3_Modules_F_Marta","A3_Modules_F_Misc","A3_Modules_F_Multiplayer","A3_Modules_F_ObjectModifiers","A3_Modules_F_Sites","A3_Modules_F_Skirmish","A3_Modules_F_StrategicMap","A3_Modules_F_Supports","A3_Modules_F_UAV","A3_Modules_F_Beta","A3_Modules_F_Beta_FiringDrills","A3_Modules_F_EPB","A3_Modules_F_EPB_Misc","A3_Modules_F_Heli","A3_Modules_F_Heli_SpawnAi","A3_Modules_F_Mark","A3_Modules_F_Mark_FiringDrills","A3_Modules_F_MP_Mark","A3_Modules_F_Mark_Objectives","A3_Music_F","A3_Music_F_Bootcamp","A3_Music_F_EPA","A3_Music_F_EPB","A3_Music_F_EPC","A3_Music_F_Heli","A3_Music_F_Mark","A3_Roads_F","A3_Rocks_F","A3_Sounds_F","A3_Sounds_F_Bootcamp","A3_Sounds_F_EPB","A3_Sounds_F_EPC","A3_Sounds_F_Exp_A","A3_Structures_F","A3_Structures_F_Bridges","A3_Structures_F_Civ","A3_Structures_F_Civ_Accessories","A3_Structures_F_Civ_Ancient","A3_Structures_F_Civ_BellTowers","A3_Structures_F_Civ_Calvaries","A3_Structures_F_Civ_Camping","A3_Structures_F_Civ_Chapels","A3_Structures_F_Civ_Constructions","A3_Structures_F_Civ_Dead","A3_Structures_F_Civ_Garbage","A3_Structures_F_Civ_Graffiti","A3_Structures_F_Civ_InfoBoards","A3_Structures_F_Civ_Kiosks","A3_Structures_F_Civ_Lamps","A3_Structures_F_Civ_Market","A3_Structures_F_Civ_Offices","A3_Structures_F_Civ_Pavements","A3_Structures_F_Civ_PlayGround","A3_Structures_F_Civ_SportsGrounds","A3_Structures_F_Civ_Statues","A3_Structures_F_Civ_Tourism","A3_Structures_F_Dominants","A3_Structures_F_Dominants_Amphitheater","A3_Structures_F_Dominants_Castle","A3_Structures_F_Dominants_Church","A3_Structures_F_Dominants_Hospital","A3_Structures_F_Dominants_Lighthouse","A3_Structures_F_Dominants_WIP","A3_Structures_F_Furniture","A3_Structures_F_Households","A3_Structures_F_Households_Addons","A3_Structures_F_Households_House_Big01","A3_Structures_F_Households_House_Big02","A3_Structures_F_Households_House_Shop01","A3_Structures_F_Households_House_Shop02","A3_Structures_F_Households_House_Small01","A3_Structures_F_Households_House_Small02","A3_Structures_F_Households_House_Small03","A3_Structures_F_Households_Slum","A3_Structures_F_Households_Stone_Big","A3_Structures_F_Households_Stone_Shed","A3_Structures_F_Households_Stone_Small","A3_Structures_F_Households_WIP","A3_Structures_F_Ind","A3_Structures_F_Ind_AirPort","A3_Structures_F_Ind_Cargo","A3_Structures_F_Ind_CarService","A3_Structures_F_Ind_ConcreteMixingPlant","A3_Structures_F_Ind_Crane","A3_Structures_F_Ind_DieselPowerPlant","A3_Structures_F_Ind_Factory","A3_Structures_F_Ind_FuelStation","A3_Structures_F_Ind_FuelStation_Small","A3_Structures_F_Ind_Pipes","A3_Structures_F_Ind_PowerLines","A3_Structures_F_Ind_ReservoirTank","A3_Structures_F_Ind_Shed","A3_Structures_F_Ind_SolarPowerPlant","A3_Structures_F_Ind_Tank","A3_Structures_F_Ind_Transmitter_Tower","A3_Structures_F_Ind_WavePowerPlant","A3_Structures_F_Ind_Windmill","A3_Structures_F_Ind_WindPowerPlant","A3_Structures_F_Items","A3_Structures_F_Items_Documents","A3_Structures_F_Items_Electronics","A3_Structures_F_Items_Cans","A3_Structures_F_Items_Gadgets","A3_Structures_F_Items_Luggage","A3_Structures_F_Items_Medical","A3_Structures_F_Items_Military","A3_Structures_F_Items_Stationery","A3_Structures_F_Items_Tools","A3_Structures_F_Items_Valuables","A3_Structures_F_Items_Vessels","A3_Structures_F_Mil","A3_Structures_F_Mil_BagBunker","A3_Structures_F_Mil_BagFence","A3_Structures_F_Mil_Barracks","A3_Structures_F_Mil_Bunker","A3_Structures_F_Mil_Cargo","A3_Structures_F_Mil_Flags","A3_Structures_F_Mil_Fortification","A3_Structures_F_Mil_Helipads","A3_Structures_F_Mil_Offices","A3_Structures_F_Mil_Radar","A3_Structures_F_Mil_Shelters","A3_Structures_F_Mil_TentHangar","A3_Structures_F_Naval","A3_Structures_F_Naval_Buoys","A3_Structures_F_Naval_Fishing","A3_Structures_F_Naval_Piers","A3_Structures_F_Naval_RowBoats","A3_Structures_F_Research","A3_Structures_F_System","A3_Structures_F_Training","A3_Structures_F_Training_InvisibleTarget","A3_Structures_F_Walls","A3_Structures_F_Bootcamp_Ind_Cargo","A3_Structures_F_Bootcamp_Items_Sport","A3_Structures_F_Bootcamp_System","A3_Structures_F_Bootcamp_Training","A3_Structures_F_Bootcamp_VR_Blocks","A3_Structures_F_Bootcamp_VR_CoverObjects","A3_Structures_F_Bootcamp_VR_Helpers","A3_Structures_F_EPA_Civ_Camping","A3_Structures_F_EPA_Civ_Constructions","A3_Structures_F_EPA_Items_Electronics","A3_Structures_F_EPA_Items_Food","A3_Structures_F_EPA_Items_Medical","A3_Structures_F_EPA_Items_Tools","A3_Structures_F_EPA_Items_Vessels","A3_Structures_F_EPA_Walls","A3_Structures_F_EPB_Civ_Accessories","A3_Structures_F_EPB_Civ_Camping","A3_Structures_F_EPB_Civ_Dead","A3_Structures_F_EPB_Civ_Garbage","A3_Structures_F_EPB_Civ_Graffiti","A3_Structures_F_EPB_Civ_PlayGround","A3_Structures_F_EPB_Furniture","A3_Structures_F_EPB_Items_Documents","A3_Structures_F_EPB_Items_Luggage","A3_Structures_F_EPB_Items_Military","A3_Structures_F_EPB_Items_Vessels","A3_Structures_F_EPB_Naval_Fishing","A3_Structures_F_EPC_Civ_Accessories","A3_Structures_F_EPC_Civ_Camping","A3_Structures_F_EPC_Civ_Garbage","A3_Structures_F_EPC_Civ_InfoBoards","A3_Structures_F_EPC_Civ_Kiosks","A3_Structures_F_EPC_Civ_PlayGround","A3_Structures_F_EPC_Civ_Tourism","A3_Structures_F_EPC_Dominants_GhostHotel","A3_Structures_F_EPC_Dominants_Stadium","A3_Structures_F_EPC_Furniture","A3_Structures_F_EPC_Items_Documents","A3_Structures_F_EPC_Items_Electronics","A3_Structures_F_EPC_Walls","A3_Structures_F_Exp_A","A3_Structures_F_Exp_A_VR_Blocks","A3_Structures_F_Exp_A_VR_Helpers","A3_Structures_F_Heli_Civ_Accessories","A3_Structures_F_Heli_Civ_Constructions","A3_Structures_F_Heli_Civ_Garbage","A3_Structures_F_Heli_Civ_Market","A3_Structures_F_Heli_Furniture","A3_Structures_F_Heli_Ind_AirPort","A3_Structures_F_Heli_Ind_Cargo","A3_Structures_F_Heli_Ind_Machines","A3_Structures_F_Heli_Items_Airport","A3_Structures_F_Heli_Items_Luggage","A3_Structures_F_Heli_Items_Sport","A3_Structures_F_Heli_Items_Tools","A3_Structures_F_Heli_VR_Helpers","A3_Structures_F_Kart_Civ_SportsGrounds","A3_Structures_F_Kart_Mil_Flags","A3_Structures_F_Mark_Items_Military","A3_Structures_F_Mark_Items_Sport","A3_Structures_F_Mark_Mil_Flags","A3_Structures_F_Mark_Training","A3_Structures_F_Mark_VR_Helpers","A3_Structures_F_Mark_VR_Shapes","A3_Structures_F_Mark_VR_Targets","A3_UIFonts_F","CUP_AirVehicles_Core","CUP_AirVehicles_UH1H","CUP_BaseConfigs","CUP_BaseData","CUP_Vehicles_cfgGroups","CUP_WaterVehicles_Fishing_Boat","CUP_WaterVehicles_Seafox","CUP_WheeledVehicles_M1030","D41_CUP_AirVehciles_AW159","D41_ReDefinedStructures","D41_Buildings_dingens","D41_CUP_AirVehicles_C130J","D41_CUP_C_Fishing_Boat_Chernarus","D41_A3_Trees","D41_A3_Bush","D41_A3_Plants","D41_A3_Stones","D41_Tanke","D41_TankeKlein","D41_SchilderZeugs","Jbad_Misc_A_BuildingWIP","Jbad_Misc_AirCondition","Jbad_Misc_Cables","case_d","metalcrate","ch_office_b","kitchen_chair_a","lobby_chair","Jbad_Misc_Com","Jbad_Misc_Construction","Pc","radio_b","tv_a","vending_machine","Flowers","Jbad_Misc_Garbage","Jbad_misc_generalstore","Jbad_misc_interior","Jbad_misc_interior_Firestation","Jbad_Misc_Lamp","Jbad_misc_market","Jbad_Misc_Powerline","kitchen_table_a","Lobby_Table","Jbad_Misc_Well","jbad_Rocks","jbad_sounds","jbad_Structures","A_BuildingWIP","A_Minaret","A_Minaret_Porto","A_Mosque_small","A_stationhouse","A_Villa","afghan_houses","afghan_houses_c","afghan_houses_old","bridges","Cargo_Cont","Generalstore","hangar_2","Ind_Coltan_Mine","Ind_Conveyer","Ind_FuelStation","Ind_Garage01","Ind_PowerStation","Ind_Shed","mil","hanger","mosque_big","Wall","Wall_k","Wall_L","jbad_Veg","Jbad_Veg_plants_tree","Jonzie_Code","PG_SERVICES_PMC_HEADER","A3_Animals_F","A3_Animals_F_AnimConfig","A3_Animals_F_Fishes","A3_Animals_F_Kestrel","A3_Animals_F_Rabbit","A3_Animals_F_Seagull","A3_Animals_F_Snakes","A3_Animals_F_Turtle","A3_Animals_F_Chicken","A3_Animals_F_Dog","A3_Animals_F_Goat","A3_Animals_F_Sheep","A3_Anims_F","A3_Anims_F_Config_Sdr","A3_Anims_F_EPA","A3_Anims_F_EPC","A3_Anims_F_Exp_A","A3_Anims_F_Kart","A3_Anims_F_Mark_Deployment","A3_Language_F_Bootcamp","A3_Language_F_Exp_A","A3_Map_Data","A3_Map_Stratis","A3_Map_Stratis_Scenes","A3_Plants_F_Bush","A3_Props_F_Exp_A","A3_Props_F_Exp_A_Military","A3_Signs_F","A3_Signs_F_AD","A3_Structures_F_Signs_Companies","A3_Structures_F_Bootcamp_Civ_Camping","A3_Structures_F_Bootcamp_Civ_SportsGrounds","A3_Structures_F_Bootcamp_Items_Electronics","A3_Structures_F_Bootcamp_Items_Food","A3_Structures_F_Heli_Items_Electronics","A3_Structures_F_Heli_Items_Food","A3_Structures_F_Kart_Signs_Companies","A3_UI_F","A3_UI_F_Curator","A3_UI_F_Kart","A3_UI_F_Mark","A3_UI_F_MP_Mark","A3_Weapons_F","A3_Weapons_F_NATO","A3_Weapons_F_CSAT","A3_Weapons_F_AAF","A3_weapons_F_FIA","A3_Weapons_F_ItemHolders","A3_Weapons_F_Headgear","A3_Weapons_F_Uniforms","A3_Weapons_F_Vests","A3_Weapons_F_Ammoboxes","A3_Weapons_F_DummyWeapons","A3_Weapons_F_Explosives","A3_Weapons_F_Items","A3_Weapons_F_Launchers_NLAW","A3_Weapons_F_Launchers_LAW","A3_Weapons_F_Launchers_Titan","A3_Weapons_F_EPA_LongRangeRifles_DMR_01","A3_Weapons_F_EBR","A3_Weapons_F_LongRangeRifles_GM6","A3_Weapons_F_LongRangeRifles_M320","A3_Weapons_F_Machineguns_M200","A3_Weapons_F_Machineguns_Zafir","A3_Weapons_F_Pistols_ACPC2","A3_Weapons_F_Pistols_P07","A3_Weapons_F_Pistols_Pistol_heavy_01","A3_Weapons_F_Pistols_Pistol_heavy_02","A3_Weapons_F_Pistols_Rook40","A3_Weapons_F_Rifles_Khaybar","A3_Weapons_F_Rifles_Mk20","A3_Weapons_F_Rifles_MX","A3_Weapons_F_EPB_Rifles_MX_Black","A3_Weapons_F_Rifles_SDAR","A3_Weapons_F_Rifles_TRG20","A3_Weapons_F_Pistols_PDW2000","A3_Weapons_F_Rifles_Vector","a3_weapons_f_rifles_SMG_02","A3_Weapons_F_beta","A3_Weapons_F_Beta_Ammoboxes","A3_Weapons_F_beta_EBR","A3_Weapons_F_EPA_LongRangeRifles_GM6","A3_Weapons_F_EPB_LongRangeRifles_M320","A3_Weapons_F_beta_Rifles_Khaybar","A3_Weapons_F_beta_Rifles_MX","A3_Weapons_F_beta_Rifles_TRG20","A3_Weapons_F_Bootcamp_LongRangeRifles_GM6","A3_Weapons_F_Bootcamp_LongRangeRifles_M320","A3_Weapons_F_EPB_LongRangeRifles_GM3","A3_Weapons_F_gamma","A3_Weapons_F_Gamma_Ammoboxes","A3_Weapons_F_EPA_EBR","A3_Weapons_F_EPA_Rifles_MX","A3_Weapons_F_Kart_Pistols_Pistol_Signal_F","A3_Weapons_F_Mark_LongRangeRifles_DMR_01","A3_Weapons_F_Mark_EBR","A3_Weapons_F_Mark_LongRangeRifles_GM6","A3_Weapons_F_Mark_LongRangeRifles_GM6_camo","A3_Weapons_F_Mark_LongRangeRifles_M320","A3_Weapons_F_Mark_LongRangeRifles_M320_camo","A3_Weapons_F_Mark_Machineguns_M200","A3_Weapons_F_Mark_Machineguns_Zafir","A3_Weapons_F_Mark_Rifles_Khaybar","A3_Weapons_F_Mark_Rifles_Mk20","A3_Weapons_F_Mark_Rifles_MX","A3_Weapons_F_Mark_Rifles_SDAR","A3_Weapons_F_Mark_Rifles_TRG20","CUP_AirVehicles_C130J","CUP_AirVehicles_F35","CUP_WaterVehicles_Weapons","Distrikt41_V1_3_D41","Distrikt41_V1_31_D41","Distrikt41_V1_33_D41","Distrikt41_V1_4_D41","D41_Blitze_peng","D41_A3_UI_F","Distrikt41_V1_3_D41_B","D41_B_BuildingsAndObjects","D41_B_Hospital","D41_B_Office01","D41_B_Office02","D41_B_Bodenplatten","D41_B_D41_Hangar_2","D41_B_Ind_Quarry","D41_B_Ind_SawMill","D41_B_Panelak2","D41_B_Panelak3","D41_B_Podesta","Bornholm","bornholmobjects","PG_Services_PMC_Ammoboxes","PG_Services_PMC_Bags","pmc_weapons","RH_de_cfg","rhs_main","RHS_Missions_Pack","rhs_optics","rhsusf_c_uav","rhsusf_main","rhsusf_optics","rhsusf_radio","rhsusf_uav","task_force_radio_items","TRYK_BackPack","A3_Anims_F_Heli","A3_Characters_F","A3_Characters_F_BLUFOR","A3_Characters_F_Civil","A3_Characters_F_Heads","A3_Characters_F_OPFOR","A3_Characters_F_Proxies","A3_Characters_F_Beta","A3_Characters_F_INDEP","A3_Characters_F_Bootcamp","A3_Characters_F_EPB_Heads","A3_Characters_F_Gamma","A3_Characters_F_Mark","A3_Data_F_Curator","A3_Data_F_Curator_Eagle","A3_Data_F_Curator_Intel","A3_Data_F_Curator_Misc","A3_Data_F_Curator_Respawn","3DEN","A3_Data_F_Kart","A3_UAV_F_Characters_F_Gamma","A3_UAV_F_Weapons_F_Gamma_Ammoboxes","A3_Weapons_F_gamma_Items","A3_Map_Altis","A3_Map_Altis_Scenes","A3_Missions_F","A3_Missions_F_Beta","A3_Missions_F_Gamma","A3_Missions_F_Kart","A3_Modules_F_Bootcamp","A3_Modules_F_Curator","A3_Modules_F_Curator_Animals","A3_Modules_F_Curator_CAS","A3_Modules_F_Curator_Curator","A3_Modules_F_Curator_Effects","A3_Modules_F_Curator_Environment","A3_Modules_F_Curator_Flares","A3_Modules_F_Curator_Intel","A3_Modules_F_Curator_Lightning","A3_Modules_F_Curator_Mines","A3_Modules_F_Curator_Misc","A3_Modules_F_Curator_Multiplayer","A3_Modules_F_Curator_Objectives","A3_Modules_F_Curator_Ordnance","A3_Modules_F_Curator_Respawn","A3_Modules_F_Curator_Smokeshells","A3_Modules_F_Exp_A","A3_Modules_F_Kart","A3_Modules_F_Kart_TimeTrials","A3_Props_F_Exp_A_Military_Equipment","A3_Static_F","A3_Static_F_Mortar_01","A3_Static_F_Beta_Mortar_01","A3_Static_F_Gamma","A3_Static_F_Gamma_Mortar_01","A3_Static_F_Mark_Designator_01","A3_Static_F_Mark_Designator_02","A3_Supplies_F_Heli","A3_Supplies_F_Heli_Bladders","A3_Supplies_F_Heli_CargoNets","A3_Supplies_F_Heli_Fuel","A3_Supplies_F_Heli_Slingload","A3_Supplies_F_Mark","A3_UI_F_Bootcamp","A3_UI_F_Exp_A","A3_UI_F_Heli","A3_Weapons_F_Acc","A3_Weapons_F_Beta_Acc","A3_Weapons_F_Bootcamp_Ammoboxes","A3_Weapons_F_EPA","A3_Weapons_F_EPA_Acc","A3_Weapons_F_EPA_Ammoboxes","A3_Weapons_F_EPB","A3_Weapons_F_EPB_Acc","A3_Weapons_F_EPB_Ammoboxes","A3_Weapons_F_EPC","A3_Weapons_F_gamma_Acc","A3_Weapons_F_Kart","A3_Weapons_F_Mark_Acc","Bowman_headsets","CUP_Creatures_People_Civil_Chernarus","CUP_Creatures_Military_ACR","CUP_Creatures_Military_BAF","CUP_Creatures_Military_Germany","CUP_Creatures_Military_NAPA","CUP_Creatures_Military_Napa_Soldier","CUP_Creatures_Military_PMC","CUP_Creatures_Military_RACS","CUP_Creatures_Military_SLA","CUP_Creatures_Military_Taki","CUP_Creatures_Military_TakiInsurgents","CUP_Creatures_Military_USMC","CUP_Weapons_NVG","D41_I_Items","D41_Modified_task_force_radio_items","D41_Weapons_Ammo","D41_Weapons_Pistols","D41_Weapons_Rifles","D41_Weapons_Shotguns","D41_Saftpresse","FEMAL3_v1","Identizee_CustomModels","More_Heads","PG_Services_PMC_CLIENT","PG_Services_PMC_Gear","PG_SERVICES_PMC_UNDERWEAR","PG_SERVICES_PMC_UNIFORMS","PG_Services_PMC_Patches","rhs_air","rhs_airweapons","rhs_aps","rhs_c_airweapons","rhs_c_heavyweapons","rhs_c_identity","rhs_c_radars","rhs_c_weapons","rhs_decals","rhs_heavyweapons","rhs_identity","rhs_radars","rhs_sounds","rhs_weapons2","rhs_weapons","rhsusf_a2port_car","rhsusf_airweapons","rhsusf_c_a2port_car","rhsusf_decals","Zee_Glasses","A3_Air_F","A3_Air_F_Heli_Light_01","A3_Air_F_Heli_Light_02","A3_Air_F_Beta","A3_Air_F_Beta_Heli_Attack_01","A3_Air_F_Beta_Heli_Attack_02","A3_Air_F_Beta_Heli_Transport_01","A3_Air_F_Beta_Heli_Transport_02","A3_Air_F_Beta_Parachute_01","A3_Air_F_Beta_Parachute_02","A3_Air_F_EPB_Heli_Light_03","A3_Air_F_EPC_Plane_CAS_01","A3_Air_F_EPC_Plane_CAS_02","A3_Air_F_Gamma_Plane_Fighter_03","A3_Air_F_Heli","A3_Air_F_Heli_Heli_Attack_01","A3_Air_F_Heli_Heli_Attack_02","A3_Air_F_Heli_Heli_Light_01","A3_Air_F_Heli_Heli_Light_02","A3_Air_F_Heli_Heli_Light_03","A3_Air_F_Heli_Heli_Transport_01","A3_Air_F_Heli_Heli_Transport_02","A3_Air_F_Heli_Heli_Transport_03","A3_Air_F_Heli_Heli_Transport_04","A3_Armor_F","A3_armor_f_beta","A3_Armor_F_Panther","A3_armor_f_beta_APC_Tracked_02","A3_Armor_F_EPB_APC_tracked_03","A3_Armor_F_EPB_MBT_03","A3_Armor_F_Slammer","A3_Armor_F_T100K","A3_Boat_F","A3_Boat_F_Boat_Armed_01","A3_Boat_F_Boat_Transport_01","A3_Boat_F_Beta_Boat_Armed_01","A3_Boat_F_Beta_Boat_Transport_01","A3_Boat_F_SDV_01","A3_Boat_F_EPC_Submarine_01_F","A3_Boat_F_Civilian_Boat","A3_Boat_F_Trawler","A3_Boat_F_Gamma_Boat_Transport_01","A3_Boat_F_Heli_Boat_Armed_01","A3_Boat_F_Heli_SDV_01","A3_Characters_F_Common","A3_Characters_F_Bootcamp_Common","A3_Characters_F_EPA","A3_Characters_F_EPB","A3_Characters_F_EPC","A3_Characters_F_Kart","A3_Data_F_Curator_Characters","A3_Data_F_Curator_Virtual","A3_Data_F_Exp_A_Virtual","A3_Data_F_Heli","A3_Air_F_Gamma_UAV_01","A3_Air_F_Gamma_UAV_02","A3_Missions_F_Bootcamp","A3_Missions_F_Curator","A3_Missions_F_EPA","A3_Missions_F_EPB","A3_Missions_F_EPC","A3_Missions_F_Exp_A","A3_Missions_F_Heli","A3_Missions_F_Mark","A3_Missions_F_MP_Mark","A3_Modules_F_Bootcamp_Misc","A3_Modules_F_Curator_Chemlights","A3_Soft_F","A3_Soft_F_MRAP_01","A3_Soft_F_MRAP_02","A3_Soft_F_Offroad_01","A3_Soft_F_Quadbike","A3_Soft_F_MRAP_03","A3_Soft_F_Beta_Quadbike","A3_Soft_F_HEMTT","A3_Soft_F_TruckHeavy","A3_Soft_F_EPC_Truck_03","A3_Soft_F_Car","A3_Soft_F_Gamma_Offroad","A3_Soft_F_Gamma_Quadbike","A3_Soft_F_SUV","A3_Soft_F_Gamma_HEMTT","A3_Soft_F_Gamma_TruckHeavy","A3_Soft_F_Truck","A3_Soft_F_Heli_Car","A3_Soft_F_Heli_MRAP_01","A3_Soft_F_Heli_MRAP_02","A3_Soft_F_Heli_MRAP_03","A3_Soft_F_Heli_Quadbike","A3_Soft_F_Heli_SUV","A3_Soft_F_Heli_Truck","A3_Soft_F_Kart_Kart_01","A3_Static_F_Gamma_AA","A3_Static_F_Gamma_AT","A3_Structures_F_Mil_Scrapyard","A3_Structures_F_Wrecks","A3_Structures_F_EPA_Mil_Scrapyard","A3_Weapons_F_Bootcamp","A3_Weapons_F_Mark","A3_Weapons_F_Mark_LongRangeRifles_DMR_02","A3_Weapons_F_Mark_LongRangeRifles_DMR_03","A3_Weapons_F_Mark_LongRangeRifles_DMR_04","A3_Weapons_F_Mark_LongRangeRifles_DMR_05","A3_Weapons_F_Mark_LongRangeRifles_DMR_06","A3_Weapons_F_Mark_Machineguns_MMG_01","A3_Weapons_F_Mark_Machineguns_MMG_02","CUP_AirVehicles_SU34","CUP_TrackedVehicles_BMP","CUP_WaterVehicles_Zodiac","CUP_Weapons_WeaponsCore","CUP_WheeledVehicles_BRDM2","CUP_WheeledVehicles_Dingo","CUP_WheeledVehicles_LR","CUP_wheeledvehicles_Octaiva","CUP_WheeledVehicles_Skoda","CUP_WheeledVehicles_TowingTractor","D41_Sig_77","D41_Iveco4x4","D41_RVE_civic","D41_RVE_wildcat","D41_HEMTT","D41_MD500","D41_Huron","D41_RVE_punisher","D41_RVE_ka60","D41_RVE_KamAZ_1","D41_RVE_merlin","D41_RVE_motorboat","D41_IsuzuDMAX","D41_honda_trx500","D41_Sig_Roadrunner","D41_Schlauchboot","D41_Hupen","D41_RVE_fennek","D41_Sig_SuperBee","D41_BMW","D41_Taru","D41_Typhoon","D41_Trawler","D41_ADAC_mod","D41_a2port_cman","D41_AnhaengerFahrer_mod","D41_Medic_mod","D41_Sounds","Distrikt41_V1_3_D41_T","D41_Trailer","D41_KamAZ_Zugmaschine_V13","D41_Oil_Mine","TRYK_HRP","Jonzie_Carpack","Jonzie_Ceed","Jonzie_Corolla","Jonzie_Datsun_510","Jonzie_Datsun_Z432","Jonzie_Escalade","Jonzie_Forklift","Jonzie_Galant","Jonzie_Lightbar","Jonzie_Mini_Cooper","Jonzie_Quattroporte","Jonzie_Raptor","Jonzie_STI","Jonzie_Superliner","Jonzie_Trucks","Jonzie_Trailer_Pack","Jonzie_Transit","Jonzie_VE","Jonzie_Viper","Jonzie_Western","Jonzie_XB","STOP_BLUFOR_Config","MNP_MIXR_Config","MNP_OPFOR_CONFIG","rhs_c_cars","rhs_c_troops","rhs_infantry","rhs_tigr","rhsusf_c_hemtt_a2","rhsusf_c_hemtt_a4","Sig_Roadrunner","sab_An2","TRYK_Uniform","cba_jr","asdg_jointrails","asdg_jointmuzzles","cba_xeh","Extended_EventHandlers","CBA_Extended_EventHandlers","A3_Air_F_EPC_Plane_Fighter_03","A3_Armor_F_AMV","A3_Armor_F_Marid","A3_Armor_F_EPC_MBT_01","A3_Armor_F_APC_Wheeled_03","A3_CargoPoses_F","A3_CargoPoses_F_Heli","A3_Soft_F_Crusher_UGV","A3_Soft_F_Bootcamp_Offroad_01","A3_Soft_F_Bootcamp_Quadbike","A3_Soft_F_Bootcamp_Truck","A3_Soft_F_Heli_Crusher_UGV","ADM_1964_Impala","ADM_1969_Camaro","ADM_1969_Charger","ADM_Ford_F100","ADM_GMC_Vandura","ADM_Monte_Carlo","CPC_TRYK_patch","CUP_AirVehicles_A10","CUP_AirVehicles_AV8B","CUP_AirVehicles_Ka50","CUP_AirVehicles_Su25","CUP_AirVehicles_UH60","CUP_TrackedVehicles_Core","CUP_TrackedVehicles_T72","CUP_WaterVehicles_Core","CUP_WaterVehicles_LHD","CUP_Weapons_Ammunition","CUP_Weapons_Backpacks","CUP_Weapons_Compact","CUP_Weapons_CZ750","CUP_Weapons_CZ805","CUP_Weapons_DMR","CUP_Weapons_Duty","CUP_Weapons_East_Attachments","CUP_Weapons_Glock17","CUP_Weapons_GrenadeLaunchers","CUP_Weapons_Grenades","CUP_Weapons_HuntingRifle","CUP_Weapons_IGLA","CUP_Weapons_Items","CUP_Weapons_Javelin","CUP_Weapons_KSVK","CUP_Weapons_LeeEnfield","CUP_Weapons_M1014","CUP_Weapons_M110","CUP_Weapons_M136","CUP_Weapons_M14","CUP_Weapons_M14_DMR","CUP_Weapons_M24","CUP_Weapons_M47","CUP_Weapons_M9","CUP_Weapons_MAAWS","CUP_Weapons_Makarov","CUP_Weapons_Metis_AT_13","CUP_Weapons_MicroUZI","CUP_Weapons_MP5","CUP_Weapons_NLAW","CUP_Weapons_PB_6P9","CUP_Weapons_Phantom","CUP_Weapons_PK","CUP_Weapons_Pods","CUP_Weapons_Put","CUP_Weapons_Revolver","CUP_Weapons_RPG18","CUP_Weapons_RPG7","CUP_Weapons_Sa58","CUP_Weapons_SA61","CUP_Weapons_Saiga12k","CUP_Weapons_SMAW","CUP_Weapons_StaticWeapons","CUP_Weapons_Stinger","CUP_Weapons_Strela_2","CUP_Weapons_SVD","CUP_Weapons_UK59","CUP_Weapons_VehicleWeapons","CUP_Weapons_VSS","CUP_Weapons_West_Attachments","CUP_WheeledVehicles_BTR60","CUP_WheeledVehicles_BTR90","CUP_WheeledVehicles_Core","CUP_WheeledVehicles_Datsun","CUP_WheeledVehicles_Jackal","CUP_WheeledVehicles_LAV25","CUP_WheeledVehicles_RG31","CUP_WheeledVehicles_Stryker","CUP_WheeledVehicles_UAZ","CUP_WheeledVehicles_Ural","CUP_Wheeledvehicles_VWGolf","D41_sab_An2","D41_CUP_C_C47_CIV","D41_RHS_Vehicles_GAZ66","D41_CUP_Wheeleds_VWGolf","D41_Hunter","D41_CUP_WheeledVehicles_Jackal","D41_ADM_1969_Charger","D41_Jonzie_30CSL","D41_Jonzie_Ambulance","D41_ADM_1969_Camaro","D41_Jonzie_Ceed","D41_Jonzie_Corolla","D41_Jonzie_Datsun_510","D41_Jonzie_Datsun_Z432","D41_Jonzie_Escalade","D41_ADM_Ford_F100","D41_Jonzie_Galant","D41_Jonzie_Highway","D41_ADM_1964_Impala","D41_Jonzie_Mini_Cooper","D41_ADM_Monte_Carlo","D41_Jonzie_Quattroporte","D41_Jonzie_Raptor","D41_Jonzie_STI","D41_Jonzie_Transit","D41_Jonzie_Trucks","D41_ADM_GMC_Vandura","D41_Jonzie_VE","D41_Jonzie_Viper","D41_Jonzie_XB","D41_CUP_WheeledVehicles_LR","D41_CUP_wheeleds_Octaiva","D41_CUP_B_MV22_USMC","D41_CUP_Wheeleds_RG31","D41_CUP_WaterVehicles_RHIB","D41_CUP_Wheeleds_Skoda","D41_CUP_Wheeled_SUV","D41_RHS_Vehicles_TIGR","D41_CUP_WheeledVehicles_UAZ","D41_RHS_Vehicles_UAZ","D41_police_mod","D41_A2_Golf","D41_A2_Ikarus","D41_A2_Lada","D41_A2_S1203","D41_A2_GAZ","FHQ_Accessories","hlcweapons_core","hlcweapons_aks","hlcweapons_ar15","hlcweapons_AUG","hlcweapons_falpocalypse","hlcweapons_FHAWCovert","hlcweapons_G36","hlcweapons_g3","hlcweapons_m14","hlcweapons_m60e4","hlcweapons_mp5","hlcweapons_SAW","hlcweapons_Springfield1903","Jonzie_30CSL","Jonzie_Ambulance","Jonzie_Highway","PG_Services_PMC_vehicles","RH_acc","RH_m4_cfg","rhs_c_2s3","rhs_c_a2port_air","RHS_A2_AirImport","rhs_c_a2port_car","RHS_A2_CarsImport","rhs_c_a3retex","rhs_c_air","rhs_c_bmd","rhs_c_bmp3","rhs_c_bmp","rhs_c_btr","rhs_c_pts","rhs_c_rva","rhs_c_sprut","rhs_c_t72","rhs_c_tanks","rhs_c_trucks","rhs_gaz66","rhs_infantry2","rhs_pts","rhs_sprut","rhs_ss21","rhs_t72","rhs_t80","rhs_t80u","rhs_vehiclesounds","rhsusf_c_heavyweapons","rhsusf_c_weapons","rhsusf_heavyweapons","rhsusf_sounds","rhsusf_weapons","cba_common","cba_events","cba_hashes","cba_keybinding","cba_network","cba_strings","cba_ui_helper","cba_vectors","CUP_AirVehicles_AH1Z","CUP_AirVehciles_AH1Z","CUP_AirVehicles_AH64","CUP_AirVehciles_AH64","CUP_AirVehciles_AW159","CUP_AirVehicles_CH47","CUP_AirVehciles_Merlin","CUP_AirVehicles_MH60S","CUP_AirVehicles_Mi24","CUP_AirVehicles_MI6","CUP_AirVehicles_Mi8","CUP_AirVehicles_MQ9","CUP_AirVehicles_MV22","CUP_TrackedVehicles_AAV","CUP_TrackedVehicles_M113","CUP_TrackedVehicles_T34","CUP_TrackedVehicles_T55","CUP_WaterVehicles_RHIB","CUP_Weapons_AA12","CUP_Weapons_AK","CUP_Weapons_AS50","CUP_Weapons_AWM","CUP_Weapons_Bizon","CUP_Weapons_C7","CUP_Weapons_Colt1911","CUP_Weapons_EVO","CUP_Weapons_FNFAL","CUP_Weapons_G36","CUP_Weapons_L110","CUP_Weapons_L7A2","CUP_Weapons_L85","CUP_Weapons_M107","CUP_Weapons_M16","CUP_Weapons_M240","CUP_Weapons_M249","CUP_Weapons_M60E4","CUP_Weapons_Mk48","CUP_Weapons_SCAR","CUP_Weapons_XM8","CUP_WheeledVehicles_HMMWV","CUP_Wheeled_SUV","D41_HMMWV_CUP","D41_MI8","D41_RHS_Vehicles","HLC_COMPAT_CUP_AK","HLC_COMPAT_CUP_AR15","HLC_COMPAT_CUP_AWC","HLC_COMPAT_CUP_FAL","HLC_COMPAT_CUP_G3","HLC_COMPAT_CUP_M14","HLC_COMPAT_CUP_M60E4","HLC_COMPAT_CUP_MP5","HLC_COMPAT_CUP_SAW","HLC_COMPAT_RHS_AK","HLC_COMPAT_RHS_AR15","HLC_COMPAT_RHS_AWC","HLC_COMPAT_RHS_FAL","HLC_COMPAT_RHS_G3","HLC_COMPAT_RHS_M14","HLC_COMPAT_RHS_M60E4","HLC_COMPAT_RHS_MP5","HLC_COMPAT_RHS_SAW","PG_SERVICES_PMC_UNITS","rhs_2s3","rhs_a2port_air","rhs_a2port_car","rhs_a3retex","rhs_bmd","rhs_bmd_34","rhs_bmp3","rhs_bmp","rhs_btr70","rhs_btr80","rhs_c_a2port_armor","rhs_cti_insurgents","rhs_servicemenu","rhsusf_c_airweapons","rhsusf_c_f22","rhsusf_c_troops","rhsusf_infantry2","rhsusf_infantry","rhsusf_weapons2","cba_ai","cba_arrays","cba_diagnostic","cba_diagnostics_xeh_disabled","cba_help","cba_ui","cba_versioning","CUP_AirVehicles_CH53E","CUP_AirVehicles_DC3","CUP_TrackedVehicles_Bradley","CUP_TrackedVehicles_M1_Abrams","CUP_TrackedVehicles_M270","CUP_TrackedVehicles_ZSU23","CUP_Weapons_AmmoBoxes","CUP_Weapons_Compatibility","CUP_Weapons_Curator","D41_CUP_B_UH1Y_UNA_F","rhs_a2port_armor","RHS_US_A2_AirImport","RHS_US_A2Port_Armor","rhsusf_c_ch53","rhsusf_c_fmtv","rhsusf_vehicles","rhsusf_c_hmmwv","rhsusf_c_m109","rhsusf_c_m113","rhsusf_c_m1a1","rhsusf_c_m1a2","rhsusf_c_rg33","rhsusf_c_statics","rhsusf_cars","rhsusf_ch53","rhsusf_f22","rhsusf_fmtv","rhsusf_hmmwv","rhsusf_m109","rhsusf_m113","rhsusf_m1a1","rhsusf_m1a2","rhsusf_rg33","cba_main","cba_main_a3","cba_xeh_a3","CUP_AirVehciles_SA330","CUP_AirVehciles_UH1Y","CUP_Creatures_People_Military_DummyInfantrySet","D41_HMMWV_RHS","D41_RHS_Vehicles_UH60","rhsusf_a2port_air2","rhsusf_a2port_air","rhsusf_a2port_armor","task_force_radio","A3_Sounds_F_Mark","A3_Data_F_Exp_B"];

uiNamespace setVariable["RscDisplayRemoteMissions",displayNull]; //For Spy-Glass..
uiNamespace setVariable["RscDisplayMultiplayer",displayNull];

// _binConfigPatches = configFile >> "CfgPatches";
// for "_i" from 0 to count (_binConfigPatches)-1 do
// {
	// _patchEntry = _binConfigPatches select _i;
	// if(isClass _patchEntry) then
	// {
		// if(!((configName _patchEntry) in _patchList)) exitWith
		// { 
			// [[profileName,steamid,(configName _patchEntry)],"SPY_fnc_cookieJar",false,false] spawn life_fnc_MP;
			// [[profileName,format["Unknown Addon Patch: %1",(configName _patchEntry)]],"SPY_fnc_notifyAdmins",true,false] spawn life_fnc_MP;
			// sleep 0.5;
			// failMission "SpyGlass";
		// };
	// };
// };

//Check for copy-pasters of Dev-Con styled execution.
//Because I am nice, add these to the following below to allow CBA; "CBA_CREDITS_CONT_C","CBA_CREDITS_M_P
private["_children","_allowedChildren"];
_children = [configFile >> "RscDisplayMPInterrupt" >> "controls",0] call BIS_fnc_returnChildren;
_allowedChildren = [
"Title","MissionTitle","PlayersName","ButtonCancel","ButtonSAVE","ButtonSkip","ButtonRespawn","ButtonOptions",
"ButtonVideo","ButtonAudio","ButtonControls","ButtonGame","ButtonTutorialHints","ButtonAbort","DebugConsole",
"Version","TraffLight","Feedback","MessageBox","CBA_CREDITS_CONT_C","CBA_CREDITS_M_P","RHS_Options","RscDisplayMainMap","MpMarkDisplays"
];

{
	if(!((configName _x) in _allowedChildren)) exitWith
	{
		[[profileName,steamid,"Modified_MPInterrupt"],"SPY_fnc_cookieJar",false,false] spawn life_fnc_MP;
		[[profileName,"Devcon like executor detected"],"SPY_fnc_notifyAdmins",true,false] spawn life_fnc_MP;
		sleep 0.5;
		failMission "SpyGlass";
	};
} foreach _children;

/*
	Display Validator
	Loops through and makes sure none of the displays were modified..
	
	TODO: Run check every x minutes and validate all displays.
*/
{
	_onLoad = getText(configFile >> (_x select 0) >> "onLoad");
	_onUnload = getText(configFile >> (_x select 0) >> "onUnload");
	if(_onLoad != (_x select 1) OR _onUnload != (_x select 2)) exitWith
	{
		diag_log format ["::::::: SPYGLASS: X0 = Modified_Method_ = %1",(_x select 0)];
		diag_log format ["::::::: SPYGLASS: X1 = %1",(_x select 1)];
		diag_log format ["::::::: SPYGLASS: X2 = %1",(_x select 2)];
		diag_log format ["::::::: SPYGLASS: X = %1",_x];
		[[profileName,steamid,format["Modified_Method_%1",_x select 0]],"SPY_fnc_cookieJar",false,false] call life_fnc_MP;
		[[profileName,format["Modified Display Method %1 (Memory Edit)",_x select 0]],"SPY_fnc_notifyAdmins",true,false] call life_fnc_MP;
		sleep 0.5;
		vehicle player setVelocity[1e10,1e14,1e18]; //It's a surprise.
		sleep 3;
		preProcessFile "SpyGlass\endoftheline.sqf";
		sleep 2.5;
		failMission "SpyGlass";
	};
} foreach [
	["RscDisplayMainMap","[""onLoad"",_this,""RscDiary"",'MpMarkDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDiary"",'MpMarkDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayGetReady","[""onLoad"",_this,""RscDiary"",'MpMarkDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDiary"",'MpMarkDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayInventory","[""onLoad"",_this,""RscDisplayInventory"",'IGUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayInventory"",'IGUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayLoadMission","[""onLoad"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayInterrupt","[""onLoad"",_this,""RscDisplayInterrupt"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayInterrupt"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayOptionsVideo","[""onLoad"",_this,""RscDisplayOptionsVideo"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayOptionsVideo"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayOptions","[""onLoad"",_this,""RscDisplayOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayAVTerminal","[""onLoad"",_this,""RscDisplayAVTerminal"",'IGUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayAVTerminal"",'IGUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayConfigureAction","[""onLoad"",_this,""RscDisplayConfigureAction"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayConfigureAction"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayConfigureControllers","[""onLoad"",_this,""RscDisplayConfigureControllers"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayConfigureControllers"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayControlSchemes","[""onLoad"",_this,""RscDisplayControlSchemes"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayControlSchemes"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayCustomizeController","[""onLoad"",_this,""RscDisplayCustomizeController"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayCustomizeController"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayDebriefing","[""onLoad"",_this,""RscDisplayDebriefing"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayDebriefing"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayDiary","[""onLoad"",_this,""RscDiary"",'MpMarkDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDiary"",'MpMarkDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayGameOptions","[""onLoad"",_this,""RscDisplayGameOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayGameOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayJoystickSchemes","[""onLoad"",_this,""RscDisplayJoystickSchemes"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayJoystickSchemes"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayLoading","[""onLoad"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayMicSensitivityOptions","[""onLoad"",_this,""RscDisplayMicSensitivityOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayMicSensitivityOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayOptionsAudio","[""onLoad"",_this,""RscDisplayOptionsAudio"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayOptionsAudio"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayOptionsLayout","[""onLoad"",_this,""RscDisplayOptionsLayout"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayOptionsLayout"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayStart","[2] call compile preprocessfilelinenumbers gettext (configfile >> 'CfgFunctions' >> 'init'); ['onLoad',_this,'RscDisplayLoading','Loading'] call (uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayInsertMarker","[""onLoad"",_this,""RscDisplayInsertMarker"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayInsertMarker"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"]
];

/* Forgot to include this but this is also also a popular method for "unreleased" stuff */
if(getText(configFile >> "CfgFunctions" >> "init") != "A3\functions_f\initFunctions.sqf") then
{
	[[profileName,steamid,"Modified_Functions_Init"],"SPY_fnc_cookieJar",false,false] call life_fnc_MP;
	[[profileName,"Modified_Functions_Init"],"SPY_fnc_notifyAdmins",true,false] call life_fnc_MP;
	sleep 0.5;
	vehicle player setVelocity[1e10,1e14,1e18]; //It's a surprise.
	sleep 3;
	preProcessFile "SpyGlass\endoftheline.sqf";
	sleep 2.5;
	failMission "SpyGlass";
};

[] execVM "SpyGlass\fn_cmdMenuCheck.sqf";
//[] execVM "SpyGlass\fn_variableCheck.sqf"; //Ausgeschalten - Performancefresser
[] execVM "SpyGlass\fn_menuCheck.sqf";