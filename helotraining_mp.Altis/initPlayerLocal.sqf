// Load the briefing (it will wait for the player object)
execVM "briefing.sqf";
player addRating 9999;

// it seems onPlayerRespawn is called also on the first spawn.
//player addAction ["Request mission", { {[player] call spawnPlayerTask;} remoteExecCall ["bis_fnc_call", 2]; } ];
