//ag_log format["playerVehicleInListBool called, _this: %1", _this];
private _triggerList = _this select 0;
private _returnValue = false;

if (!(([_triggerList] call playerVehicleInList) isEqualTo false)) then
{
    _returnValue = true;
};

//ag_log format["playerVehicleInListBool returning: %1", _returnValue];
_returnValue