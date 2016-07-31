// Config constant globals
LZCOUNT = 86;
STARTPRIORITY = 1000;
EXLUDESPAWNLZS = [(missionNamespace getVariable "lz33")]; // Exclude the airport location near spawn marker

// Precompile code
execVM "precompile.sqf";

// We can't run this before
if (isServer) then
{
    // Keep track of how many LZ we have created, used to give tasks unique names and priorities
    lzCounter = 0;
    publicVariable "lzCounter";
    taskIds = [];
    publicVariable "taskIds";

    //Handle MP parameters
    _handle = execVM "readparams.sqf";
    waitUntil {isNull _handle};
    [EXLUDESPAWNLZS] spawn taskSpawner;
};

// Flag init complete
missionInitComplete = true;
publicVariable "missionInitComplete";
