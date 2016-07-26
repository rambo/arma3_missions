//diag_log format["getSideTasks called, _this: %1", _this];
private _side = _this select 0;
private _returnValue = [];
{
    _unit = _x;
    if (side _unit == _side) then
    {
        _tasks = _x call BIS_fnc_tasksUnit;
        {
            _returnValue pushBackUnique _x;
        } foreach _tasks;
    };
} foreach allUnits;

//diag_log format["getSideTasks returning: %1", _returnValue];
_returnValue