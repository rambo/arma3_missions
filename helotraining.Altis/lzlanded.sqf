_triggerList = _this select 0;
_returnValue = false;

{
    _plr = _x;
    _veh = vehicle _plr;
    if ( (_plr != _veh) && (isTouchingGround _veh) && (_veh in _triggerList) ) then
    {
        _returnValue = true;
    }
} forEach playableUnits;

_returnValue