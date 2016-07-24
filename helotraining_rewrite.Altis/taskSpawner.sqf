diag_log format["taskSpawner called, _this: %1", _this];
scopeName "main";
while {true} do
{
    scopeName "mainloop";
    private _justPlayers = BIS_fnc_listPlayers - entities "HeadlessClient_F";
    private _result = [(west BIS_fnc_tasksUnit), {[_this] call BIS_fnc_taskCompleted}] call CBA_fnc_reject;
    diag_log format["taskSpawner: active tasks: %1 players: ", (count _result), (count _justPlayers)];
    while (count _result != count _justPlayers) do
    {
        scopename "spawnloop";
        private _newLZLocation = lzList call BIS_fnc_SelectRandom;
        {
            scopename "playerloop";
            private _plr = _x
            diag_log format["taskSpawner: checking if %1 is free to take a pickup", _plr];
            if (count (_plr call BIS_fnc_tasksUnit) == 0) then
            {
                [_newLZLocation, [_plr]] execVM "createPickupLZ.sqf";
                breakTo "spawnloop";
            }
        } forEach _justPlayers;
        [_newLZLocation, false] execVM "createPickupLZ.sqf";
    }
    sleep 10;
};
