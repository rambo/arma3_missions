waitUntil {!(isNil "missionInitComplete")};
diag_log format["initPlayer called, _this: %1", _this];

_target = _this select 0;
_playerno = _this select 1;

_target addMPEventHandler ["mpkilled", {Null = _this, _playerno execVM "playerkilled.sqf";}]; 
_target addMPEventHandler ["respawn", {Null = unit, _playerno execVM "playerspawn.sqf";}]; 


[_target, _playerno] execVM "playerspawn.sqf";
