
_smokeLoc = _this select 0;


while {!landingComplete} do
{
	_hour = daytime;
	if (_hour > 5 && _hour < 19) then
	{
		_smoke= "SmokeShellGreen" createVehicle  _smokeLoc;
		sleep 40;
		deleteVehicle _smoke;
	}
	else
	{
		_chemlight= "Chemlight_green" createVehicle  _smokeLoc;
		_smoke= "SmokeShellGreen" createVehicle  _smokeLoc;
		sleep 40;
		deleteVehicle _chemlight;
		deleteVehicle _smoke;
	};

}
