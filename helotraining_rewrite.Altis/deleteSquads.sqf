diag_log format["deleteSquads called, _this: %1", _this];
_squads = _this select 0;

{
    _squad = _x;
    {deleteVehicle _x} forEach units _squad;
} forEach _squads;
