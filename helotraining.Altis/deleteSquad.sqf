//if (!ferrying) exitWith {};
_group = _this select 0;
_side = _this select 1;
_playerno = _this select 2;
diag_log format["deleteSquad called, _this: %1", _this];


switch (_side) do
{
	case "west": { squadMDArray set [_playerno, (squadMDArray select _playerno) - [_group]] };
	case "east": { enemyMDArray set [_playerno, (enemyMDArray select _playerno) - [_group]] };
	case "aa":   {    AAMDArray set [_playerno, (AAMDArray    select _playerno) - [_group]] };
};

{deleteVehicle _x} forEach units _group;

publicVariable "squadMDArray";
publicVariable "enemyMDArray";
publicVariable "AAMDArray";
