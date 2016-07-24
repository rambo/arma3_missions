if (!ferrying) exitWith {};

_group = _this select 0;
_vehicle = _this select 1;

deleteWaypoint [_group,1];

{_x action["eject", vehicle _x]} forEach units _group;
{unAssignVehicle _x} forEach units _group;
{_x enableAI "TARGET"; _x enableAI "AUTOTARGET";} foreach units _group;

wp = _group addwaypoint [lz1,5,1];
wp setwaypointType "MOVE";

ferrying = false;