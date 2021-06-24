//diag_log format["createPickupLZ called, _this: %1", _this];
private _lzLocation = _this select 0;
private _assignExtra = _this select 1;
private _squad = [_lzLocation] call createSquad;

private _enemies = [];
private _lzhot = false;
private _lzAA = false;

//Make the LZ hot if the roll demands it
if ((random 1) < hotLZChance) then
{
    _lzhot = true
};
if (_lzhot) then
{
	if ((random 1) < AAChance) then
	{
    	_lzAA = true;
	};
};
private _taskType = "meet";
if (_lzhot) then
{
    _taskType = "defend";
    _enemies = _enemies + ([_lzLocation, _lzAA] call createEnemySquads);
};

lzCounter = lzCounter + 1;
publicVariable "lzCounter";

private _side = side _squad;
private _squadCmdr = (units _squad) select 0;
private _lzLocationName = text ((nearestLocations [getPosATL _lzLocation, ["NameCityCapital", "NameCity", "NameVillage"], 1500]) select 0);
[[_side, "HQ"], format["%1 is requesting pickup for %2 operators near %3", groupId _squad, count units _squad, _lzLocationName]] remoteExec ["sideChat", _side];


private _shortestDesc = format["LZ %1", lzCounter];
private _longdesc = format["%1 wants a pickup from this location", _squad];
private _shortdesc = format["Pick up %1", _squad];
if (_lzAA and _lzhot) then
{
    _longdesc = _longdesc + "<br/><strong>Be advised:</strong> Intel reports heavy enemy activity with AA assets at the location";
    [_squadCmdr, "Be advised, LZ is very hot with AA assets present"] remoteExec ["sideChat", _side];
};
if (!_lzAA and _lzhot) then
{
    _longdesc = _longdesc + "<br/><strong>Be advised:</strong> Intel reports enemy activity at the location";
    [_squadCmdr, "Be advised, LZ is hot"] remoteExec ["sideChat", _side];
};

private _taskState = "AUTOASSIGNED";
private _assignTo = [west];
if (!(_assignExtra isEqualTo false)) then
{
    _longdesc = _longdesc + format["<br/>Created for %1", _assignExtra];
    _assignTo = _assignTo + _assignExtra;
    _taskState = "CREATED";
};



// PONDER: make a parent task "ferry squad X" ??
private _taskid = format["pickup_%1", lzCounter];
[_assignTo,[_taskid],[_longdesc, _shortdesc, _shortestDesc],getPosATL _lzLocation,_taskState,(STARTPRIORITY-lzCounter),true, _taskType, true] call BIS_fnc_taskCreate;
if (!(_assignExtra isEqualTo false)) then
{
    [_taskid,_assignExtra,[_longdesc, _shortdesc, _shortestDesc],getPosATL _lzLocation,"ASSIGNED"] call BIS_fnc_setTask;
};
taskIds pushBackUnique _taskid;
publicVariable "taskIds";


if (bSmoke) then
{
    [_squad, _lzLocation, 'green'] spawn spawnSmokeBySquad;
};

private _trg = createTrigger["EmptyDetector",getPosATL _lzLocation, false];
_trg setTriggerArea[lzSize,lzSize,0,false,50];
_trg setTriggerActivation["WEST","PRESENT",false];
_trg setTriggerTimeout [2.5, 2.5, 2.5, true];
_trg setTriggerStatements["([thisList] call playerVehicleInListBool)", "", ""];


// TODO: implement deadline so the task doesn't linger forever
scopeName "main";
while {true} do
{
    scopeName "mainloop";
    //diag_log format["createPickupLZ: ticking %1", _this];

    if (( _taskid call BIS_fnc_taskCompleted)) then
    {
        diag_log format["createPickupLZ: task %1 was marked complete", _taskid];
        breakOut "mainloop";
    };

    if ({alive _x} count units _squad == 0) then
    {
        diag_log format["createPickupLZ: Everyone from %1 is dead!", _squad];
        // Everybody died before we got there :(
        [_taskid, "FAILED" ,true] spawn BIS_fnc_taskSetState;
        breakOut "mainloop";
    };

    if (triggerActivated _trg) then
    {
        diag_log format["createPickupLZ: triggered, loading up %1", _squad];

        private _veh = [list _trg] call playerVehicleInList;
        private _handle = [_veh, _squad, _taskid] spawn loadSquad;
        waitUntil {isNull _handle};

        // TODO check that the return value is not false (could not choose LZ due to constraints)
        private _newLZLocation = [[_lzLocation]] call selectLZ;

        private _handle = [_newLZLocation, _veh, _squad, _taskid] spawn createDropoffLZ;
        waitUntil {isNull _handle};
        breakOut "mainloop";
    };
	sleep 2;
};

deleteVehicle _trg;

sleep squadsLinger;
// Make sure there are no lingering enemy or own units
[_enemies + [_squad]] call deleteSquads;
