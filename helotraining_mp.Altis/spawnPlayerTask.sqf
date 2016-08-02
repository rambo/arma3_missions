//diag_log format["spawnPlayerTask called, _this: %1", _this];
private _player = _this select 0;
private _returnValue = false;

private _newLZLocation = [EXLUDESPAWNLZS] call selectLZ;

_returnValue = [_newLZLocation, [_player]] spawn createPickupLZ;

//diag_log format["spawnPlayerTask returning: %1", _returnValue];
_returnValue