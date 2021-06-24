//diag_log format["createDropoffLZ called, _this: %1", _this];
private _lzLocation = _this select 0;
private _bindToVehicle = _this select 1;
private _bindToSquad = _this select 2;
private _fromTaskId = _this select 3;
private _assignToPlayer = driver _bindToVehicle;

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
private _taskType = "move";
if (_lzhot) then
{
    _taskType = "attack";
    _enemies = _enemies + ([_lzLocation, _lzAA] call createEnemySquads);
};

lzCounter = lzCounter + 1;
publicVariable "lzCounter";

private _shortestDesc = format["LZ %1", lzCounter];
private _longdesc = format["%1 wants to fly to this location", _bindToSquad];
private _shortdesc = format["Drop off %1", _bindToSquad];
if (_lzAA and _lzhot) then
{
    _longdesc = _longdesc + "<br/><strong>Be advised:</strong> Intel reports heavy enemy activity with AA assets at the location";
};
if (!_lzAA and _lzhot) then
{
    _longdesc = _longdesc + "<br/><strong>Be advised:</strong> Intel reports enemy activity at the location";
};

_longdesc = _longdesc + format["<br/>Created for %1", _assignToPlayer];
private _assignTo = [_assignToPlayer, west];

private _taskid = format["dropoff_%1", lzCounter];
// Create the task for everyone
[_assignTo,[_taskid],[_longdesc, _shortdesc, _shortestDesc],getPosATL _lzLocation,"CREATED",(STARTPRIORITY-lzCounter),true, _taskType, true] call BIS_fnc_taskCreate;
// Assign to the player
[_taskid,[_assignToPlayer],[_longdesc, _shortdesc, _shortestDesc],getPosATL _lzLocation,"ASSIGNED"] call BIS_fnc_setTask;
taskIds pushBackUnique _taskid;
publicVariable "taskIds";

private _trg = createTrigger["EmptyDetector",getPosATL _lzLocation, false];
_trg setTriggerArea[lzSize,lzSize,0,false,50];
_trg setTriggerActivation["WEST","PRESENT",false];
_trg setTriggerTimeout [2.0, 2.0, 2.0, true];
private _trgCond = format["((%1 in thisList) && ([%1] call isLanded))", _bindToVehicle];
//diag_log format["createDropoffLZ: _trgCond %s", _trgCond];
_trg setTriggerStatements[_trgCond , "", ""];

// TODO: implement deadline so the task doesn't linger forever
scopeName "main";
while {true} do
{
    scopeName "mainloop";
    //diag_log format["createDropoffLZ: ticking %1", _this];

    if (( _taskid call BIS_fnc_taskCompleted)) then
    {
        diag_log format["createPickupLZ: task %1 was marked complete", _taskid];
        breakOut "mainloop";
    };

    private _squadAliveCount = {alive _x} count units _bindToSquad;
    if ((_squadAliveCount < 1)) then
    {
        diag_log format["createDropoffLZ: Everyone from %1 is dead!", _bindToSquad];
        // Everybody died before getting there :(
        [_taskid, "FAILED" ,true] spawn BIS_fnc_taskSetState;
        breakOut "mainloop";
    };

    if (triggerActivated _trg) then
    {
        diag_log format["createDropoffLZ: triggered, unloading %1", _bindToSquad];
        private _veh = [list _trg] call playerVehicleInList;
        private _handle = [_lzLocation, _veh, _bindToSquad, _taskid] spawn ejectSquad;
        waitUntil {isNull _handle};
        breakOut "mainloop";
    };
	sleep 1;
};

deleteVehicle _trg;

sleep squadsLinger;
// Make sure there are no lingering enemy or own units
[_enemies + [_bindToSquad]] call deleteSquads;
