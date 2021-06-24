//diag_log format["loadSquad called, _this: %1", _this];
private _vehicle = _this select 0;
private _squad = _this select 1;
private _fromTaskId = _this select 2;
private _pilot = driver _vehicle;
private _side = side _squad;
private _squadCmdr = (units _squad) select 0;
private _vertical = getPosATL leader _squad select 2;

{
  _x assignAsCargo _vehicle; 
  _x disableAI "TARGET"; 
  _x disableAI "AUTOTARGET";
} foreach units _squad;

if (_vertical > 3) then 
{
	[_squadCmdr, format["%1, please standby as we're loading up.", name _pilot]] remoteExec ["sideChat", _side];
	sleep 2.3;
	{
	sleep 1.4;
	_x moveInCargo _vehicle;
	} forEach units _squad;
} 
else 
{
	{
	[_x] ordergetin true;
	} forEach units _squad;

	private _wp = _squad addwaypoint [_vehicle, 5, 1];
	_wp setwaypointType "GETIN";
	[_squadCmdr, format["%1, please standby as we're loading up.", name _pilot]] remoteExec ["sideChat", _side];
};

scopeName "main";
while {true} do
{
    scopeName "loadingLoop";
    //diag_log format["loadSquad: ticking %1", _this];
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

[_squadCmdr, format["%1, everyone is onboard, you're clear to lift off", name _pilot]] remoteExec ["sideChat", _side];

//diag_log format["loadSquad done, _this: %1", _this];
