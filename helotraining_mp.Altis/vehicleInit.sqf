//diag_log format["vehicleIinit called, _this: %1", _this];

_vehicle = _this select 0;

[_vehicle ] remoteExec ["removeAllActions", 0, "rmall" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["Repair", { [_this select 0] spawn xenoRepair; }]] remoteExec ["addAction", 0, "addrepair" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["Spawn crew", { _this spawn spawnCrewAction; }]] remoteExec ["addAction", 0, "addcrew" + (_vehicle call BIS_fnc_netId)];
