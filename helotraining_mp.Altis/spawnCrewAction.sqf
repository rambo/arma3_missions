//diag_log format["spawnCrewAction called, _this: %1", _this];
private _vehicle = _this select 0;
private _caller = _this select 1;
private _returnValue = [];
private _group = group _caller;
private _tmpGroup = createGroup civilian;
_returnValue = [ _vehicle, _tmpGroup, false, typeof _vehicle] call BIS_fnc_spawnCrew;
// a bit of twiddling to get the units to the correct side
_returnValue joinSilent grpNull;
_returnValue joinSilent _group;
deleteGroup _tmpGroup;

//diag_log format["spawnCrewAction returning: %1", _returnValue];
_returnValue