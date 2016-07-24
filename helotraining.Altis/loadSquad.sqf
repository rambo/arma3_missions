
_vehicle = _this select 0;
_group = _this select 1;
_playerno = _this select 2;
diag_log format["loadSquad called, _this: %1", _this];


if ((ferryingArray select _playerno)) exitWith {};

if ({alive _x} count units _group == 0)
then
{
	hint "They're all dead!";
	squadLoadedArray set [_playerno, true];
	publicVariable "squadLoadedArray";
	diag_log format["squadLoadedArray: %1, ferryingArray: %2, _playerno: %3", squadLoadedArray, ferryingArray, _playerno];
	exit;
};

{_x assignAsCargo _vehicle} foreach units _group;
{[_x] ordergetin true} foreach units _group;
{_x disableAI "TARGET"; _x disableAI "AUTOTARGET";} foreach units _group;

wp = _group addwaypoint [_vehicle,5,1];
wp setwaypointType "GETIN";

while {not (squadLoadedArray select _playerno)} do
{
	diag_log format["Squad %1 is loading to %2", _group, _vehicle];
	if ({alive _x} count units _group == {_x in _vehicle} count units _group)
	then 
	{
		diag_log format["Squad %1 is DONE loading to %2", _group, _vehicle];
		squadLoadedArray set [_playerno, true];
		publicVariable "squadLoadedArray";
	};
	sleep 2;
};
ferryingArray set [_playerno, true];
publicVariable "ferryingArray";
diag_log format["squadLoadedArray: %1, ferryingArray: %2, _playerno: %3", squadLoadedArray, ferryingArray, _playerno];
