//diag_log format["vehicleIinit called, _this: %1", _this];

_vehicle = _this select 0;

[_vehicle, ["Repair", { [_this select 0] spawn xenoRepair; }]] remoteExec ["addAction", 0, netId _vehicle];
