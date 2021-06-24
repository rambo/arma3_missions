params ["_newUnit", "_oldUnit"];


_newUnit addRating 20000;

if (_oldUnit != objNull) then {
	removeAllActions _oldUnit;
	hideBody _oldUnit;
	sleep 1;
	deleteVehicle _oldUnit;
}; 

_newUnit addAction ["<t color='#FFFF00'>Request mission</t>", {[player] remoteExecCall ["spawnPlayerTask", 2]},nil,10 ];
