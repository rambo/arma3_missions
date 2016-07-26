//diag_log format["spawnSmokeBySquad called, _this: %1", _this];
private _bindToSquad = _this select 0;
private _smokeTgt = _this select 1;
private _smokeLocation = getPos _smokeTgt;
private _smokeColor = _this select 2;

private _trg = createTrigger["EmptyDetector", _smokeLocation, false];
_trg setTriggerArea[50,50,0,false];
_trg setTriggerActivation["WEST","PRESENT",false];
private _keepSpawning = true;

// TODO: switch color based on arguments
while {_keepSpawning} do
{
    //diag_log format["spawnSmokeBySquad: spawning smoke to %1", _smokeLocation];
	_hour = daytime;
	if (_hour > 5 && _hour < 19) then
	{
		_smoke= "SmokeShellGreen" createVehicle  _smokeLocation;
		sleep 40;
		deleteVehicle _smoke;
	}
	else
	{
		_chemlight= "Chemlight_green" createVehicle  _smokeLocation;
		_smoke= "SmokeShellGreen" createVehicle  _smokeLocation;
		sleep 40;
		deleteVehicle _chemlight;
		deleteVehicle _smoke;
	};
    _keepSpawning = false;
    {
        if (_x inArea _trg && alive _x) then
        {
            _keepSpawning = true;
        };
    } forEach (units _bindToSquad);
};
//diag_log format["spawnSmokeBySquad done, _this: %1", _this];
deleteVehicle _trg;
