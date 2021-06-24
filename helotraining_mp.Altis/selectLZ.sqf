params [["_excludeList", []]];

private _candidates = lzList;

if (_excludeList isEqualType []) then 
{ 
	_candidates = _candidates - _excludeList;
};

private _taskLocations = [west] call getSideActiveTasks apply { [_x] call BIS_fnc_taskDestination };

for "_i" from 0 to LZCOUNT do {
    private _candidate = selectRandom _candidates;
    if (_taskLocations findIf { _x distance _candidate < LZMinDistace } == -1 && { allPlayers findIf { _x distance _candidate > LZMaxDistace } == -1 } && { allPlayers findIf { _x distance _candidate < 200 } == -1 }) exitWith { _candidate };
    false
}
