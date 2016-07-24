diag_log format["playerkilled called, _this: %1", _this];
_evt = _this select 0;
_playerno = _this select 1;

_taskid = taskIdsArray select _playerno;
null = [_taskid, "FAILED", False] spawn BIS_fnc_taskSetState;
taskIdsArray set [_playerno, null];
publicVariable "taskIdsArray";

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
