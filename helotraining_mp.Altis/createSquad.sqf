//diag_log format["createSquad called, _this: %1", _this];
private _spawnPos = _this select 0;
private _sog13 = "";
private _sog16 = "";
private _sog05 = "";

posMan = createVehicle ["B_Soldier_F",_lzLocation];

KK_fnc_setPosAGLS = {
	params ["_obj", "_pos", "_offset"];
	_offset = _pos select 2;
	if (isNil "_offset") then {_offset = 0};
	_pos set [2, worldSize]; 
	_obj setPosASL _pos;
	_pos set [2, vectorMagnitude (_pos vectorDiff getPosVisual _obj) + _offset];
	_obj setPosASL _pos;
};

[posMan, [getPos posMan select 0,getPos posMan select 1,0]] call KK_fnc_setPosAGLS;


private _groupTaxi = createGroup west;
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
		_sog13 = _groupTaxi createUnit ["B_Soldier_F", [0, 0, 0], [], 0, "NONE"];
		_sog13 setPosASL getPosASL posMan;
		_sog13 setUnitRank "COLONEL";
		_sog13 setSkill 0.8;

deleteVehicle posMan;

    // if we have space after the corporal spawn the autorifleman
    if (_cargoSeats > 1) then
    {
		_sog16 = _groupTaxi createUnit ["B_soldier_AR_F", [0, 0, 0], [], 0, "NONE"]; 
		_sog16 setPosASL (getPosASL _sog13 vectorAdd [random[1,2,3],random[1,2,3],0]);
		_sog16 setUnitRank "PRIVATE";
		_sog16 setSkill 0.5;
    };

    // For rest of the spots spawn basic units
    for "_i" from 1 to (_cargoSeats - 2) do
    {
        	_sog05 = _groupTaxi createUnit ["B_Soldier_F", [0, 0, 0], [], 0, "NONE"];
		_sog05 setPosASL (getPosASL _sog16 vectorAdd [random[1,2,3],random[1,2,3],0]);
		_sog05 setUnitRank "PRIVATE";
		_sog05 setSkill 0.6;
    };

_groupTaxi
