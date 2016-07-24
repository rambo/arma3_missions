_group = _this select 0;
_vehicle = _this select 1;
_playerno = _this select 2;

diag_log format["ejectSquad called, _this: %1", _this];

if (!(ferryingArray select _playerno)) exitWith {};


deleteWaypoint [_group,1];

{_x action["eject", vehicle _x]} forEach units _group;
{unAssignVehicle _x} forEach units _group;
{_x enableAI "TARGET"; _x enableAI "AUTOTARGET";} foreach units _group;

wp = _group addwaypoint [lz1,5,1];
wp setwaypointType "MOVE";

ferryingArray set [_playerno, false];
publicVariable "ferryingArray";
