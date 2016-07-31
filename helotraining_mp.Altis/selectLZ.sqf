//diag_log format["selectLZ called, _this: %1", _this];
private _excludeList = _this select 0;
private _returnValue = false;

private _candidates = lzList;
if (!(_excludeList isEqualTo false)) then
{
   _candidates = _candidates - _excludeList;
};
private _taskLocations = [];
{
    [_taskLocations, ([_x] call BIS_fnc_taskDestination)] call BIS_fnc_arrayPush;
} forEach ([west] call getSideActiveTasks);

scopeName "main";
private _i = 0;
while {true} do
{
    scopeName "selectloop";
    private _usable = true;
    private _candidate = _candidates call BIS_fnc_SelectRandom;
    {
        scopeName "checkloop";
        private _dist = _candidate distance _x;
        if (_dist < LZMinDistace) then
        {
            _usable = false;
            breakOut "checkloop";
        };
    } forEach _taskLocations;
    if (_usable) then
    {
        _returnValue = _candidate;
        breakOut "selectloop";
    };
    _i = _i + 1;
    if (_i > LZCOUNT) then
    {
        _returnValue = false;
        breakOut "selectloop";
    }
};

//diag_log format["selectLZ returning: %1", _returnValue];
_returnValue