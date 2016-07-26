//diag_log format["getSideActiveTasks called, _this: %1", _this];
private _side = _this select 0;
private _returnValue = [];

{
    if (!(_x call BIS_fnc_taskCompleted)) then
    {
        [_returnValue, _x] call BIS_fnc_arrayPush;
    };
} forEach ([_side] call getSideTasks);

//diag_log format["getSideActiveTasks returning: %1", _returnValue];
_returnValue