if (ferrying) exitWith {};

_spawnPos = _this select 0;
_target = _this select 1;

_groupTaxi = createGroup west;
"B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.5, "CORPORAL"];
"B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.5, "PRIVATE"];
"B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.5, "PRIVATE"];
"B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.5, "PRIVATE"];

squadArray = squadArray + [_groupTaxi];