//diag_log format["createSquad called, _this: %1", _this];
private _spawnPos = _this select 0;

private _groupTaxi = createGroup west;
if (vehicle player == player) then
{
    // Player is not in vehicle, create default fireteam
    // TODO: use some preconfigured fireteam setup
    "B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.6, "CORPORAL"];
    "B_soldier_AR_F" createUnit [_spawnPos, _groupTaxi,"",0.3, "PRIVATE"];
    "B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.5, "PRIVATE"];
    "B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.5, "PRIVATE"];
    "B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.5, "PRIVATE"];
}
else
{
    // Player is in vehicle, spawn as many passengers as it can hold
    _veh = typeOf (vehicle player);
    _totalSeats = [_veh, true] call BIS_fnc_crewCount;
    _crewSeats = [_veh, false] call BIS_fnc_crewCount;
    _cargoSeats = _totalSeats - _crewSeats;
    // limit to a sane number of units in a squad
    if (_cargoSeats > 8) then
    {
        _cargoSeats = 8;
    };

    "B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.6, "CORPORAL"];

    // if we have space after the corporal spawn the autorifleman
    if (_cargoSeats > 1) then
    {
        "B_soldier_AR_F" createUnit [_spawnPos, _groupTaxi,"",0.3, "PRIVATE"];
    };

    // For rest of the spots spawn basic units
    for "_i" from 1 to (_cargoSeats - 2) do
    {
        "B_Soldier_F" createUnit [_spawnPos, _groupTaxi,"",0.5, "PRIVATE"];
    };
};

_groupTaxi