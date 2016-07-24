diag_log "taskSpawner called";
scopeName "main";
while {true} do
{
    scopeName "mainloop";
    private _justPlayers = (call BIS_fnc_listPlayers) - entities "HeadlessClient_F";
    diag_log format["taskSpawner: active tasks: %1 players: %2", (count ([west] call getSideActiveTasks)), (count _justPlayers)];
    while {count ([west] call getSideActiveTasks) < count _justPlayers} do
    {
        scopename "spawnloop";
        private _newLZLocation = lzList call BIS_fnc_SelectRandom;
        private _plrAssigned = false;
        {
            scopename "playerloop";
            private _plr = _x;
            diag_log format["taskSpawner: checking if %1 is free to take a pickup", _plr];
            if (count (_plr call BIS_fnc_tasksUnit) == 0) then
            {
                [_newLZLocation, [_plr]] spawn createPickupLZ;
                _plrAssigned = true;
                breakTo "spawnloop";
            };
        } forEach _justPlayers;
        if (!_plrAssigned) then
        {
            [_newLZLocation, false] spawn createPickupLZ;
        };
        // rate limit
        sleep 1;
    };
    sleep 10;
};
