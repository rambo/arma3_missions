diag_log "taskSpawner called";
private _lzexclude = _this select 0;
private _respawn = missionNamespace getVariable ("respawn_west");
private _tryAssignPlr = true;


scopeName "main";
while {true} do
{
    scopeName "mainloop";
    private _justPlayers = (call BIS_fnc_listPlayers) - entities "HeadlessClient_F";
    private _alivePlayers = [];
    {
        if (alive _x) then
        {
            _alivePlayers = _alivePlayers + [_x];
        };
    } forEach _justPlayers;
    while {count ([west] call getSideActiveTasks) < count _alivePlayers} do
    {
        scopename "spawnloop";
        diag_log format["taskSpawner: active tasks: %1 players: %2", (count ([west] call getSideActiveTasks)), (count _alivePlayers)];
        // TODO: Filter the list so that locations near currently active tasks are not considered
        private _newLZLocation = [_lzexclude] call selectLZ;
        private _plrAssigned = false;
        if (_tryAssignPlr) then
        {
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
            } forEach _alivePlayers;
        };
        if (!_plrAssigned) then
        {
            [_newLZLocation, false] spawn createPickupLZ;
        };
        // rate limit
        sleep 10;
    };
    sleep 5;
};
