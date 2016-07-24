diag_log "taskSpawner called";
scopeName "main";
while {true} do
{
    scopeName "mainloop";
    private _justPlayers = (call BIS_fnc_listPlayers) - entities "HeadlessClient_F";
    _result = [([west] call getSideTasks), {_this call BIS_fnc_taskCompleted}] call CBA_fnc_reject;
    diag_log format["taskSpawner: active tasks: %1 players: ", (count _result), (count _justPlayers)];
    while {count _result != count _justPlayers} do
    {
        scopename "spawnloop";
        private _newLZLocation = lzList call BIS_fnc_SelectRandom;
        {
            scopename "playerloop";
            private _plr = _x;
            diag_log format["taskSpawner: checking if %1 is free to take a pickup", _plr];
            if (count (_plr call BIS_fnc_tasksUnit) == 0) then
            {
                [_newLZLocation, [_plr]] spawn createPickupLZ;
                breakTo "spawnloop";
            };
        } forEach _justPlayers;
        [_newLZLocation, false] spawn createPickupLZ;
    };
    sleep 10;
};
