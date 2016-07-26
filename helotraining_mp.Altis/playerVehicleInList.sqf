// TODO: Rename this function, since it checks for the landing status too
//diag_log format["playerVehicleInList called, _this: %1", _this];
private _triggerList = _this select 0;
private _returnValue = false;

scopeName "main";
{
    private _plr = _x;
    private _veh = vehicle _plr;
    if ( (_plr != _veh) && ([_veh] call isLanded) && (_veh in _triggerList) ) then
    {
        _returnValue = _veh;
        breakTo "main";
    }
} forEach ([] call getAlivePlayers);

//diag_log format["playerVehicleInList returning: %1", _returnValue];
_returnValue