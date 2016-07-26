//diag_log format["spawnCrewAction called, _this: %1", _this];
private _vehicle = _this select 0;
private _caller = _this select 1;
private _returnValue = [];

_returnValue = [ _vehicle, group _caller, false, typeof _vehicle ] call BIS_fnc_spawnCrew;


//diag_log format["spawnCrewAction returning: %1", _returnValue];
_returnValue