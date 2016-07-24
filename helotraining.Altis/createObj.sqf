//null = [(playersArray select _playerno), [positionA, positionB, positionC...], previousLocation] execVM "createObj.sqf";

waitUntil {!(isNil "missionInitComplete")};


_target = _this select 0;
_lzLocs = _this select 1;
_prevLZ = _this select 2;
_playerno = _this select 3;
_player = playersArray select _playerno;

_lzLoc = (_lzLocs - [_prevLZ]) call BIS_fnc_SelectRandom;

diag_log format["createObj called, _target: %1, _playerno: %2, _player: %3", _target, _playerno, _player];

// TODO: handle the case of player crash/death, reset the task etc



//_tsk1 = (playersArray select _playerno) createSimpleTask ["NextLZ"];
//_tsk1 setSimpleTaskDescription [format["Fly to and land within %1m of the next LZ", lzSize], "Next LZ", "LZ"];
//_tsk1 setSimpleTaskDestination (getPos _lzLoc);
//(playersArray select _playerno) setCurrentTask _tsk1;
_taskid = format["p%1_lz%2", _playerno, _lzLoc];
[west,[_taskid],[format["Fly to and land within %1m of the next LZ", lzSize], "Next LZ", "LZ"],(getPos _lzLoc),true,5,true, "move", true] call BIS_fnc_taskCreate;



_trg = createTrigger["EmptyDetector",getPos _lzLoc]; 
_trg setTriggerArea[lzSize,lzSize,0,false];
_trg setTriggerActivation["WEST","PRESENT",false];
_trg setTriggerTimeout [2.5, 2.5, 2.5, true];
_trgcond = format["(vehicle (playersArray select %1) != (playersArray select %1)) && (vehicle ((playersArray select %1)) in thislist) && (isTouchingGround (vehicle (playersArray select %1)))", _playerno];
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
