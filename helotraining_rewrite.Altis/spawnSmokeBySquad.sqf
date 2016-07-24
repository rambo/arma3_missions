diag_log format["spawnSmokeBySquad called, _this: %1", _this];
private _bindToSquad = _this select 0;
private _smokeLozation = _this select 1;
private _smokeColor = _this select 2;

private _trg = createTrigger["EmptyDetector",getPos _smokeLozation, true];
_trg setTriggerArea[50,50,0,false];
_trg setTriggerActivation["WEST","PRESENT",false];
private _trgCond = format["count (%1 arrayIntersect thisList) > 0", units _squad];
diag_log format["spawnSmokeBySquad _trgCond: %1", _trgCond];
_trg setTriggerStatements[_trgCond, "",  ""];

// TODO: switch color based on arguments
while {triggerActivated _trg} do
{
	_hour = daytime;
	if (_hour > 5 && _hour < 19) then
	{
		_smoke= "SmokeShellGreen" createVehicle  _smokeLozation;
		sleep 40;
		deleteVehicle _smoke;
	}
	else
	{
		_chemlight= "Chemlight_green" createVehicle  _smokeLozation;
		_smoke= "SmokeShellGreen" createVehicle  _smokeLozation;
		sleep 40;
		deleteVehicle _chemlight;
		deleteVehicle _smoke;
	};
    diag_log format["spawnSmokeBySquad: spawned smoke to %1", _smokeLoc];
};
diag_log format["spawnSmokeBySquad done, _this: %1", _this];
deleteVehicle _trg;
