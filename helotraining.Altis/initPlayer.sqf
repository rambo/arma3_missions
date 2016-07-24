waitUntil {!(isNil "missionInitComplete")};
diag_log format["initPlayer called, _this: %1", _this];

_target = _this select 0;
_playerno = _this select 1;
playersArray set [_playerno, _target];
_target addMPEventHandler ["mpkilled", {Null = _this, _playerno execVM "playerkilled.sqf";}]; 
_target addMPEventHandler ["respawn", {Null = _this, _playerno execVM "playerspawn.sqf";}]; 


[null, _playerno] execVM "playerspawn.sqf";
