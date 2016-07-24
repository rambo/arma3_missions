//null = [trigger, task, player, previousLocation, locations, player_number] execVM "landingComplete.sqf";

_trg = _this select 0;
_taskid = _this select 1;
_target = _this select 2;
_prevLZ = _this select 3;
_playerno = _this select 4;

diag_log format["landingComplete called, _this: %1", _this];


_vehiclePlayer = vehicle (playersArray select _playerno);

deletevehicle _trg;
null = [_taskid, "SUCCEEDED", False] spawn BIS_fnc_taskSetState;
hint 'Landing successful!';

_squadArray = squadMDArray select _playerno;
_enemyArray = enemyMDArray select _playerno;
_squadCount = count _squadArray;
_enemyCount = count _enemyArray;
null = [(_squadArray select _squadCount - 1), _vehiclePlayer, _playerno] execVM 'ejectSquad.sqf';

if (_enemyCount > 1) then
{
	null = [(_enemyArray select 0), "east", _playerno] execVM "deleteSquad.sqf";
};
if (_squadCount > 1) then
{
	null = [(_squadArray select 0), "west", _playerno] execVM "deleteSquad.sqf";
};

landingCompleteArray set [_playerno,  true];
publicVariable "landingCompleteArray";
[_taskid] call BIS_fnc_deleteTask;
taskIdsArray set [_playerno, false];
publicVariable "taskIdsArray";


null = [_vehiclePlayer, (_squadArray select _squadCount -1), _playerno] execVM "loadSquad.sqf";

_trgLoaded = createTrigger["EmptyDetector",getPos _prevLZ]; 
_trgLoaded setTriggerArea[lzSize,lzSize,0,false];
_trgLoaded setTriggerActivation["WEST","PRESENT",false];
_trgLoaded setTriggerTimeout [3, 3, 3, true];
_trgcond = format["(squadLoadedArray select %1)", _playerno];
_trgaction = format["null = [(playersArray select %1), %2, %3, %1] execVM 'createObj.sqf'; hint 'Fly to the next LZ!';", _playerno, null, _prevLZ];
diag_log format["load condition: %1", _trgcond];
diag_log format["load action: %1", _trgaction];
_trgLoaded setTriggerStatements[_trgcond, _trgaction, ""]; 
// TODO: should we delete _trgLoaded somewhere ??

