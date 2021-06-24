//diag_log format["deleteCrewAction called, _this: %1", _this];
params ["_caller"];
_group = group _caller;
{deleteVehicle _x} forEach units _group;
