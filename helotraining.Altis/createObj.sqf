//null = [(playersArray select _playerno), [positionA, positionB, positionC...], previousLocation] execVM "createObj.sqf";
diag_log format["createObj called, _this: %1", _this];

waitUntil {!(isNil "missionInitComplete")};


_target = _this select 0;
_lzLocs = _this select 1;
_prevLZ = _this select 2;
_playerno = _this select 3;
_player = playersArray select _playerno;

if (!!(taskIdsArray select _playerno)) exitWith { diag_log format["createObj: Task %1 already exists for %2", (taskIdsArray select _playerno), _playerno] };


_lzLoc = (_lzLocs - [_prevLZ]) call BIS_fnc_SelectRandom;


_taskid = format["p%1_lz%2", _playerno, _lzLoc];
[west,[_taskid],[format["Player %2: Fly to and land within %1m of the LZ", lzSize, _playerno], format["p%1 LZ", _playerno], "LZ"],(getPos _lzLoc),"CREATED",1,true, "move", true] call BIS_fnc_taskCreate;
taskIdsArray set [_playerno, _taskid];


_trg = createTrigger["EmptyDetector",getPos _lzLoc];
_trg setTriggerArea[lzSize,lzSize,0,false];
_trg setTriggerActivation["WEST","PRESENT",false];
_trg setTriggerTimeout [2.5, 2.5, 2.5, true];
_trgcond = "{ _plr = _x; _veh = vehicle _plr; if ((_plr != _veh) && (_veh in thisList) && (isTouchingGround _veh)) then { True } } forEach playableUnits; False;";
_trgaction = format["null = [thisTrigger, '%2', (playersArray select %1), %3, %4, %1] execVM 'landingComplete.sqf'", _playerno, _taskid, _lzLoc, _lzLocs];
diag_log format["LZ trigger condition: %1", _trgcond];
diag_log format["LZ trigger action: %1", _trgaction];
_trg setTriggerStatements[_trgcond, _trgaction, ""]; 


null = [(getPos _lzLoc), (playersArray select _playerno), _playerno] execVM 'createSquad.sqf';

//Make the LZ hot if the roll demands it
if ((random 1) < hotLZChance) then
{
	null = [(getPos _lzLoc), _playerno] execVM 'enemySquad.sqf';
	hintSilent "LZ is hot";
};
if ((random 1) < AAChance) then
{
	null = [(getPos _lzLoc), _playerno] execVM 'AASquad.sqf';
	hint "LZ has AA!";
};

landingCompleteArray set [_playerno, false];
publicVariable "landingCompleteArray";

if (bSmoke) then
{
	null = [(getPos _lzLoc), _playerno] execVM 'spawnSmoke.sqf';
};
