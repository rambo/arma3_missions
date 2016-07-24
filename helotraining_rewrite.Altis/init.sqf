// Config constant globals
_lzCount = 86;

// Compile helpers
//createDropoffLZ = compile preProcessfile "createDropoffLZ.sqf";
//createPickupLZ = compile preProcessfile "createPickupLZ.sqf";

//createSquad = compile preProcessfile "createSquad.sqf";
createEnemySquads = compile preProcessfile "createEnemySquads.sqf";

deleteSquads = compile preProcessfile "deleteSquads.sqf";
playerVehicleInList = compile preProcessfile "playerVehicleInList.sqf";
playerVehicleInListBool = compile preProcessfile "playerVehicleInListBool.sqf";
//getSideTasks = compile preProcessfile "getSideTasks.sqf";


execVM "briefing.sqf";

//Handle MP parameters

//Time of day
_time = paramsArray select 0;
if (_time != 1) then
{
	skipTime (_time - daytime + 24 ) % 24;
}
else
{
	skiptime (floor random 24);
};

//LZ size
lzSize = paramsArray select 1;
publicVariable "lzSize";

//Smoke setting
bSmoke = if ((paramsArray select 2) == 1) then {true} else {false};
publicVariable "bSmoke";

//Hot LZ chance
_hotLZParam = paramsArray select 3;
hotLZChance = if (_hotLZParam > 0) then {_hotLZParam / 100} else {0.0};
publicVariable "hotLZChance";

//Anti air chance
_AAParam = paramsArray select 4;
AAChance = if (_AAParam > 0) then {_AAParam / 100} else {0.0};
publicVariable "AAChance";

lzList = [];
_x = 0;
while {_x < _lzCount} do
{
	_lz = missionNamespace getVariable ("lz" + format["%1", _x + 1]);
	lzList = lzList + [_lz];
	_x = _x + 1;
};

publicVariable "lzList";

lzCounter = 0;
publicVariable "lzCounter";


missionInitComplete = true;
publicVariable "missionInitComplete";

if (isServer) then
{
//    execVM "taskSpawner.sqf";
};
