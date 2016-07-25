// Config constant globals
LZCOUNT = 86;
STARTPRIORITY = 1000;

// Precompile code
execVM "precompile.sqf";

// We can't run this before
if (isServer) then
{
    //Handle MP parameters
    _handle = execVM "readparams.sqf";
    waitUntil {isNull _handle};
    execVM "taskSpawner.sqf";
};

// Flag init complete
missionInitComplete = true;
publicVariable "missionInitComplete";
