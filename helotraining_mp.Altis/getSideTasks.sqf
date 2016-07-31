diag_log format["getSideTasks called, _this: %1", _this];
private _side = _this select 0;
private _returnValue = [];
// This does not work on dedicated server for whatever reason
{
    _unit = _x;
    diag_log format["getSideTasks unit: %1 side %2", _unit, (side _unit)];
    if (side _unit == _side) then
    {
        _tasks = _x call BIS_fnc_tasksUnit;
        diag_log format["getSideTasks unit: %1 side %2 tasks %3", _unit, (side _unit), _tasks];
        {
            _returnValue pushBackUnique _x;
        } foreach _tasks;
    };
} foreach allUnits;

diag_log format["getSideTasks returning: %1", _returnValue];
_returnValue