/*
	File: fn_spawnConfirm.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Spawns the player where he selected.
*/
private["_spCfg","_sp","_spawnPos"];
closeDialog 0;
cutText ["","BLACK IN"];
if(count life_spawn_point == 0) then
{
	private["_sp","_spCfg"];
	_spCfg = [playerSide] call life_fnc_spawnPointCfg;
	_sp = _spCfg select 0;
	
	if(playerSide == civilian) then
	{
		if(isNil {(call compile format["%1", _sp select 0])}) then {
			player setPos (getMarkerPos (_sp select 0));
		} else {
			_spawnPos = (call compile format["%1", _sp select 0]) call BIS_fnc_selectRandom;
			_spawnPos = _spawnPos buildingPos 1;
			player setPos _spawnPos;
		};
	}
		else
	{
		player setPos (getMarkerPos (_sp select 0));
	};
	titleText[format["%2 %1",_sp select 1,localize "STR_Spawn_Spawned"],"BLACK IN"];
}
	else
{
	if(playerSide == civilian) then
	{
		if(isNil {(call compile format["%1",life_spawn_point select 0])}) then
		{
			if((["house",life_spawn_point select 0] call BIS_fnc_inString)) then
			{
				private["_bPos","_house","_pos"];
				_house = nearestObjects [getMarkerPos (life_spawn_point select 0), D41_HausArray, 10] select 0;
				_pos = _house buildingPos 1;
				if(isNil "_pos")then{_pos = getPosATL _house;};
				player setPosATL _pos;
			}
			else
			{
				player setPos (getMarkerPos (life_spawn_point select 0));
			};
		}
		else
		{
			_spawnPos = (call compile format["%1", life_spawn_point select 0]) call BIS_fnc_selectRandom;
			_spawnPos = _spawnPos buildingPos 1;
			if(isNil "_spawnPos")then{_spawnPos = getPosATL _spawnPos;};
			player setPos _spawnPos;
		};
	}
		else
	{
		player setPos (getMarkerPos (life_spawn_point select 0));
	};
	titleText[format["%2 %1",life_spawn_point select 1,localize "STR_Spawn_Spawned"],"BLACK IN"];
};
//Gerade oder vor reconnect gestorben?
if(D41_DiedTimer == 1)then {[] spawn life_fnc_D41_15MinTimer };

if(life_firstSpawn) then {
	life_firstSpawn = false;
	[] call life_fnc_welcomeNotification;
};
[] call life_fnc_hudSetup;
[[player,life_sidechat,playerSide],"TON_fnc_managesc",false,false] call life_fnc_MP;