_vehicle = _this select 0;
_pilot = _this select 1;
diag_log format["vehicleIinit called, _this: %1", _this];

_vehicle addAction ["Repair", "repair.sqf"];
_vehicle addAction ["Respawn", "manualRespawn.sqf", [_vehicle, _pilot]];
_pilot addRating 9999;