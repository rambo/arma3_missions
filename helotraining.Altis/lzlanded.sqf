_triggerList = _this select 0;
_returnValue = false;

{
    _plr = _x;
    _veh = vehicle _plr;
    systemChat format["_plr: %1 _veh: %2 (isTouchingGround _veh): %3 _triggerList: %4", _plr, _veh, (isTouchingGround _veh), _triggerList];
    if ( (_plr != _veh) && (isTouchingGround _veh) && (_veh in _triggerList) ) then
    {
        _returnValue = true;
    }
} forEach playableUnits;

_returnValue