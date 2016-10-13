#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	Edit: Avka - Distrikt41
	Description:
	
*/
private["_value"];
_value = parseNumber(ctrlText 2702);

//Series of stupid checks
if(_value > 999999) exitWith {hint localize "STR_ATM_GreaterThan";};
if(_value < 0) exitWith {};
if(!([str(_value)] call life_fnc_isnumeric)) exitWith {hint localize "STR_ATM_notnumeric"};
_gFund = grpPlayer getVariable ["gang_bank",0];
if(_value > _gFund) exitWith {hint localize "STR_NOTF_NotEnoughFunds"};

__SUB__(_gFund,_value);
D41_atmGeld = D41_atmGeld + _value;
grpPlayer setVariable ["gang_bank",_gFund,true];

hint format[localize "STR_ATM_WithdrawGang",[_value] call life_fnc_numberText];
closeDialog 0;
[] call life_fnc_atmMenu;
[6] call SOCK_fnc_updatePartial; //Silent Sync
[[1,grpPlayer],"TON_fnc_updateGang",false,false] call life_fnc_MP;
