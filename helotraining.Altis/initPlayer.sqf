waitUntil {!(isNil "missionInitComplete")};
diag_log format["initPlayer called, _this: %1", _this];

_target = _this select 0;
_playerno = _this select 1;

_killhandler = compile(format["{Null = [_this, %1] execVM 'playerkilled.sqf';}", _playerno]);
_spawnhandler = compile(format["{Null = [_this, %1] execVM 'playerspawn.sqf';}", _playerno]);

// To pass the _playerno we must compile the value into the expression instead of passing variable as pointer
//_target addEventHandler ["Killed", call _killhandler]; 
_target addMPEventHandler ["MPKilled", call _killhandler]; 
//_target addEventHandler ["Respawn", call _spawnhandler]; 
_target addMPEventHandler ["MPRespawn", call _spawnhandler]; 

[[_target], _playerno] execVM "playerspawn.sqf";
