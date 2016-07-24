//null = [(playersArray select _playerno), [positionA, positionB, positionC...], previousLocation] execVM "createObj.sqf";
diag_log format["createObj called, _this: %1", _this];

waitUntil {!(isNil "missionInitComplete")};


_target = _this select 0;
_prevLZ = _this select 2;
_playerno = _this select 3;
_player = playersArray select _playerno;

if (!!(taskIdsArray select _playerno)) exitWith { diag_log format["createObj: Task %1 already exists for %2", (taskIdsArray select _playerno), _playerno] };


_lzLoc = (lzList - [_prevLZ]) call BIS_fnc_SelectRandom;



_handle = [(getPos _lzLoc), (playersArray select _playerno), _playerno] execVM 'createSquad.sqf';
waitUntil {isNull _handle};
_squadArray = squadMDArray select _playerno;
_squad = _squadArray select (count _squadArray - 1);

_lzhot = false;
//Make the LZ hot if the roll demands it
if ((random 1) < hotLZChance) then
{
	null = [(getPos _lzLoc), _playerno] execVM 'enemySquad.sqf';
    _lzhot = true;
};
_lzAA = false;
if ((random 1) < AAChance) then
{
	null = [(getPos _lzLoc), _playerno] execVM 'AASquad.sqf';
    _lzAA = true;
};

landingCompleteArray set [_playerno, false];
publicVariable "landingCompleteArray";

if (bSmoke) then
{
	null = [(getPos _lzLoc), _playerno] execVM 'spawnSmoke.sqf';
};

_shortestDesc = format["LZ %1", lzCounter];
_shortdesc = _shortestDesc;
_longdesc = _shortdesc;
if (!!(ferryingArray select _playerno)) then
{
    diag_log format["creating ferry task for %1 (player %2)", _squad, _playerno];
    _longdesc = format["%1 wants to fly to this location", _squad];
    _shortdesc = format["Drop off %1", _squad];
} else {
    diag_log format["creating pickup task for %1 (player %2)", _squad, _playerno];
    _longdesc = format["%1 is requesting airlift from this location", _squad];
    _shortdesc = format["Pick up %1", _squad];
};

_taskid = format["p%1_lz%2", _playerno, _lzLoc];
[[_player, west],[_taskid],[_longdesc, _shortdesc, _shortestDesc],(getPos _lzLoc),"AUTOASSIGNED",1,true, "move", true] call BIS_fnc_taskCreate;
taskIdsArray set [_playerno, _taskid];

lzCounter = lzCounter + 1;
publicVariable "lzCounter";


_trg = createTrigger["EmptyDetector",getPos _lzLoc, true];
_trg setTriggerArea[lzSize,lzSize,0,false];
_trg setTriggerActivation["WEST","PRESENT",false];
_trg setTriggerTimeout [2.5, 2.5, 2.5, true];
_trgaction = format["null = [thisTrigger, '%2', (playersArray select %1), %3, %1] execVM 'landingComplete.sqf'", _playerno, _taskid, _lzLoc];
_trgcond = "[thisList] call lzlanded";
diag_log format["LZ trigger condition: %1", _trgcond];
diag_log format["LZ trigger action: %1", _trgaction];
_trg setTriggerStatements[_trgcond, _trgaction, ""];
trigIdsArray set [_playerno, _trg];
