if (ferrying) exitWith {};

_vehicle = _this select 0;
_group = _this select 1;

if (ferrying) exitWith {};

squadLoaded = false;
if ({alive _x} count units _group == 0)
then
{
	squadLoaded = true;
	exit;
};

{_x assignAsCargo _vehicle} foreach units _group;
{[_x] ordergetin true} foreach units _group;
{_x disableAI "TARGET"; _x disableAI "AUTOTARGET";} foreach units _group;

wp = _group addwaypoint [_vehicle,5,1];
wp setwaypointType "GETIN";

while {not squadLoaded} do
{
	if ({alive _x} count units _group == {_x in _vehicle} count units _group)
	then 
	{
		squadLoaded=true;
	};
	sleep 2;
};
ferrying = true;

