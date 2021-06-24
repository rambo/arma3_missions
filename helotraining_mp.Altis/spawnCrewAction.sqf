//diag_log format["spawnCrewAction called, _this: %1", _this];
params ["_vehicle", "_caller"];
_group = group _caller;
_newGroup = createVehicleCrew _vehicle; 
_vehicle deleteVehicleCrew driver _vehicle;
units _newGroup joinSilent _group;
{_x setSkill 1} forEach units _group;
deleteGroup _newGroup;
