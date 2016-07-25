diag_log format["loadSquad called, _this: %1", _this];
private _vehicle = _this select 0;
private _squad = _this select 1;
private _fromTaskId = _this select 2;

{_x assignAsCargo _vehicle} foreach units _squad;
{[_x] ordergetin true} foreach units _squad;
{_x disableAI "TARGET"; _x disableAI "AUTOTARGET";} foreach units _squad;

private _wp = _squad addwaypoint [_vehicle,5,1];
_wp setwaypointType "GETIN";

scopeName "main";
while {true} do
{
    scopeName "loadingLoop";
    diag_log format["loadSquad: ticking %1", _this];
    if ({alive _x} count units _squad == 0) then
    {
        // Everybody died before boarding :(
        [_fromTaskId, "FAILED" ,true] spawn BIS_fnc_taskSetState;
        breakOut "loadingLoop";
    };
    if ({alive _x} count units _squad == {(_x in _vehicle) && (alive _x)} count units _squad) then
    {
        // Boarded
        [_fromTaskId, "SUCCEEDED" ,true] spawn BIS_fnc_taskSetState;
        breakOut "loadingLoop";        
    };
    sleep 2;
};
diag_log format["loadSquad done, _this: %1", _this];
