private _vehicle = _this select 0;
private _caller = _this select 1;
private _returnValue = [];

_vehicle setDamage 1;
sleep 1;
_vehicle setDamage 0;

_returnValue
