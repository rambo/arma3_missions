//diag_log format["vehicleIinit called, _this: %1", _this];

_vehicle = _this select 0;
_vehicle setDamage 0;

_vehicle remoteExec ["removeAllActions", 0, "rmall" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["<t color='#0CF400'>Spawn crew</t>", { _this remoteExec ["spawnCrewAction", _this select 0]; },nil,0.25,true,true,"","true",5,false,"",""]] remoteExec ["addAction", 0, "addcrew" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["<t color='#0CF400'>Remove crew</t>", { _this remoteExec ["deleteCrewAction", _this select 0]; },nil,0.2,true,true,"","true",5,false,"",""]] remoteExec ["addAction", 0, "removecrew" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["<t color='#FFFF00>Repair vehicle"</t>, { [_this select 0] remoteExec ["xenoRepair", _this select 0]; },nil,0.0.19,true,true,"","true",5,false,"",""]] remoteExec ["addAction", 0, "addrepair" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["<t color='#FF0000'>Respawn vehicle</t>", { _this remoteExec ["destroyVehicleAction", _this select 0]; },nil,0.05,true,true,"","true",5,false,"",""]] remoteExec ["addAction", 0, "destroy" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["<t color='#FF9200'>Destroy main rotor</t>", { _this remoteExec ["destroyMainrotorAction", _this select 0]; },nil,0.15,true,true,"","true",5,false,"",""]] remoteExec ["addAction", 0, "mrotdestroy" + (_vehicle call BIS_fnc_netId)];
[_vehicle, ["<t color='#FF9200'>Destroy tail rotor</t>", { _this remoteExec ["destroyTailrotorAction", _this select 0]; },nil,0.1,true,true,"","true",5,false,"",""]] remoteExec ["addAction", 0, "atrotdestroy" + (_vehicle call BIS_fnc_netId)];
