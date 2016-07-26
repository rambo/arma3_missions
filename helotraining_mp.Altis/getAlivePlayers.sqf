//diag_log format["getAlivePlayers called, _this: %1", _this];
private _returnValue = [];

private _justPlayers = (call BIS_fnc_listPlayers) - entities "HeadlessClient_F";
{
    if (alive _x) then
    {
        [_returnValue, _x] call BIS_fnc_arrayPush;
    };
} forEach _justPlayers;

//diag_log format["getAlivePlayers returning: %1", _returnValue];
_returnValue