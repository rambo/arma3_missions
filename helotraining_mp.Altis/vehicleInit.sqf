//diag_log format["vehicleIinit called, _this: %1", _this];

_vehicle = _this select 0;
_vehicle setDamage 0;

_vehicle remoteExec ["removeAllActions", 0, "rmall" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["Repair", { [_this select 0] remoteExec ["xenoRepair", _this select 0]; }]] remoteExec ["addAction", 0, "addrepair" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["Spawn crew", { _this remoteExec ["spawnCrewAction", _this select 0]; }]] remoteExec ["addAction", 0, "addcrew" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["Respawn vehicle", { _this remoteExec ["destroyVehicleAction", _this select 0]; }]] remoteExec ["addAction", 0, "destroy" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["Destroy main rotor", { _this remoteExec ["destroyMainrotorAction", _this select 0]; }]] remoteExec ["addAction", 0, "mrotdestroy" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["Destroy tail rotor", { _this remoteExec ["destroyTailrotorAction", _this select 0]; }]] remoteExec ["addAction", 0, "atrotdestroy" + (_vehicle call BIS_fnc_netId)];
