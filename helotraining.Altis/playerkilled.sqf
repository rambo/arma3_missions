diag_log format["playerkilled called, _this: %1", _this];
_evt = _this select 0;
_target = _evt select 0;
_playerno = _this select 1;

if (!((taskIdsArray select _playerno) isEqualTo player)) exitWith { diag_log format["playerkilled: %1 != %2", (taskIdsArray select _playerno), player] };

if (!((taskIdsArray select _playerno) isEqualTo false)) then
{
    _taskid = taskIdsArray select _playerno;
    null = [_taskid, "FAILED", False] spawn BIS_fnc_taskSetState;
    [_taskid] call BIS_fnc_deleteTask;
};
taskIdsArray set [_playerno, false];

// for some reason this either like so or with !! causes compile error
if (!((trigIdsArray select _playerno) isEqualTo false)) then
{
    deleteVehicle (trigIdsArray select _playerno);
};
trigIdsArray set [_playerno, false];

publicVariable "taskIdsArray";
publicVariable "trigIdsArray";

_squadArray = squadMDArray select _playerno;
_enemyArray = enemyMDArray select _playerno;

{
    [_x, "east", _playerno] execVM "deleteSquad.sqf";
} foreach _enemyArray;
publicVariable "enemyMDArray";

{
    [_x, "west", _playerno] execVM "deleteSquad.sqf";
} foreach _squadArray;
publicVariable "squadMDArray";
