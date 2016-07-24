//null = [target, [positionA, positionB, positionC...], previousLocation] execVM "createObj.sqf";

waitUntil {!(isNil "missionInitComplete")};


target = _this select 0;
lzLocs = _this select 1;
prevLZ = _this select 2;

lzLoc = (lzLocs - [prevLZ]) call BIS_fnc_SelectRandom;



tsk1 = target createSimpleTask ["NextLZ"];
tsk1 setSimpleTaskDescription ["Fly to and land at the next LZ", "Next LZ", "LZ"];
tsk1 setSimpleTaskDestination (getPos lzLoc);
target setCurrentTask tsk1;

trg = createTrigger["EmptyDetector",getPos lzLoc]; trg setTriggerArea[2000,300,0,false];
trg setTriggerActivation["WEST","PRESENT",false];
trg setTriggerTimeout [2.5, 2.5, 2.5, true];
trg setTriggerStatements["(vehicle target != target) && ((vehicle target) in thislist) && (isTouchingGround (vehicle target))", "null = [trg, tsk1, target, lzLoc, lzLocs] execVM 'landingComplete.sqf'", ""]; 

null = [(getPos lzLoc), target] execVM 'createSquad.sqf';

//Make the LZ hot if the roll demands it
if ((random 1) < hotLZChance) then
{
	null = [(getPos lzLoc)] execVM 'enemySquad.sqf';
};
if ((random 1) < AAChance) then
{
	null = [(getPos lzLoc)] execVM 'AASquad.sqf';
};

landingComplete = false;

if (bSmoke) then
{
	null = [(getPos lzLoc)] execVM 'spawnSmoke.sqf';
};