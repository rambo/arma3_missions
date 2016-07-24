//null = [trigger, task, player, previousLocation, locations] execVM "landingComplete.sqf";

_trg = _this select 0;
_tsk = _this select 1;
landedTarget = _this select 2;
prevLZ = _this select 3;
locs = _this select 4;

vehiclePlayer = vehicle landedTarget;

deletevehicle _trg;
_tsk setTaskState "SUCCEEDED";
hint 'Landing successful!';

_squadCount = count squadArray;
_enemyCount = count enemyArray;
null = [(squadArray select _squadCount - 1), vehiclePlayer] execVM 'ejectSquad.sqf';

if (_enemyCount > 1) then
{
	null = [(enemyArray select 0), "east"] execVM "deleteSquad.sqf";
};
if (_squadCount > 1) then
{
	null = [(squadArray select 0), "west"] execVM "deleteSquad.sqf";
};

landingComplete = true;
landedTarget removeSimpleTask _tsk;

null = [vehiclePlayer, (squadArray select _squadCount -1)] execVM "loadSquad.sqf";

trgLoaded = createTrigger["EmptyDetector",getPos lzLoc]; 
trgLoaded setTriggerArea[40,5,0,false];
trgLoaded setTriggerActivation["NONE","PRESENT",false];
trgLoaded setTriggerTimeout [3, 3, 3, true];
trgLoaded setTriggerStatements["squadLoaded", "null = [landedTarget, locs, prevLZ] execVM 'createObj.sqf'; hint 'Fly to the next LZ!';", ""]; 
