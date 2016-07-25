diag_log format["selectLZ called, _this: %1", _this];
private _excludeList = _this select 0;
private _returnValue = false;

private _candidates = lzList - _excludeList;
private _tasks = [west] call getSideActiveTasks;

scopeName "main";
while {true};


diag_log format["selectLZ returning: %1", _returnValue];
_returnValue