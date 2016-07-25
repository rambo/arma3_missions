// Config constant globals
LZCOUNT = 86;

// Precompile code
execVM "precompile.sqf";

//Handle MP parameters
execVM "readparams.sqf";

// We can't run this before
if (isServer) then
{
    execVM "taskSpawner.sqf";
};

// Flag init complete
missionInitComplete = true;
publicVariable "missionInitComplete";