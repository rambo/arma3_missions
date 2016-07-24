_vehicle = _this select 0;
_target = _this select 1;

_respawnPos = missionNamespace getVariable ("respawn" + format["%1", _vehicle]);


if (alive _vehicle)
then
{
	_vehicle setPos (getPos _respawnPos);
	_vehicle setDamage 0;
	_target setPos (getPos _respawnPos);
}