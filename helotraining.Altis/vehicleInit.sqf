_vehicle = _this select 0;
_pilot = _this select 1;

_vehicle addAction ["Repair", "repair.sqf"];
_vehicle addAction ["Respawn", "manualRespawn.sqf", [_vehicle, _pilot]];
_pilot addRating 9999;