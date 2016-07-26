//diag_log format["isLanded called, _this: %1", _this];
private _vehicle = _this select 0;
private _returnValue = false;

private _altitude =  (getPosATL _vehicle) select 2;
private _isSlow = true;
{
    if (_x > 0.5) then
    {
        _isSlow = false;
    }
} forEach (velocity _vehicle);

if (_isSlow && (_altitude < 1)) then
{
    _returnValue = true;
};

//diag_log format["isLanded returning: %1", _returnValue];
_returnValue