player addRating 9999;

player addAction ["Request mission", { {[player] call spawnPlayerTask;} remoteExecCall ["bis_fnc_call", 2]; } ];
