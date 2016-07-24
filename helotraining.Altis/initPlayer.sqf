waitUntil {!(isNil "missionInitComplete")};
diag_log format["initPlayer called, _this: %1", _this];

_target = _this select 0;
_playerno = _this select 1;

player addEventHandler ["Killed", {Null = _this, _playerno execVM "playerkilled.sqf";}]; 
player addMPEventHandler ["MPKilled", {Null = _this, _playerno execVM "playerkilled.sqf";}]; 
player addEventHandler ["Respawn", {Null = unit, _playerno execVM "playerspawn.sqf";}]; 
player addMPEventHandler ["MPRespawn", {Null = unit, _playerno execVM "playerspawn.sqf";}]; 
_target addEventHandler ["Killed", {Null = _this, _playerno execVM "playerkilled.sqf";}]; 
_target addMPEventHandler ["MPKilled", {Null = _this, _playerno execVM "playerkilled.sqf";}]; 
_target addEventHandler ["Respawn", {Null = unit, _playerno execVM "playerspawn.sqf";}]; 
_target addMPEventHandler ["MPRespawn", {Null = unit, _playerno execVM "playerspawn.sqf";}]; 



[_target, _playerno] execVM "playerspawn.sqf";
