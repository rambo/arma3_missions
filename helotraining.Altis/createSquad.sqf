
_spawnPos = _this select 0;
_target = _this select 1;
_playerno = _this select 2;
diag_log format["createSquad called, _this: %1", _this];

if (ferryingArray select _playerno) exitWith {};


_groupTaxi = createGroup west;
"B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.5, "CORPORAL"];
"B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.5, "PRIVATE"];
"B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.5, "PRIVATE"];
"B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.5, "PRIVATE"];

squadMDArray set [_playerno, (squadMDArray select _playerno) + [_groupTaxi]];
publicVariable "squadMDArray";
