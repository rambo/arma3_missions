//if (!ferrying) exitWith {};
_group = _this select 0;
_side = _this select 1;


switch (_side) do
{
	case "west": {squadArray = squadArray - [_group]};
	case "east": {enemyArray = enemyArray - [_group]};
	case "aa": {AAArray = AAArray - [_group]};
};

{deleteVehicle _x} forEach units _group;