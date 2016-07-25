diag_log format["vehicleIinit called, _this: %1", _this];

_vehicle = _this select 0;
_pilot = _this select 1;
diag_log format["vehicleIinit called, _this: %1", _this];

[_vehicle, ["Repair", "xenoRepair.sqf"]] remoteExec ["addAction", 0, netId _vehicle];

_pilot addRating 9999;