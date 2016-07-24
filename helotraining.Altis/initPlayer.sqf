_target = _this select 0;
_lzCount = _this select 1;

lzList = [];


_x = 0;
while {(_x < _lzCount)} do
{
	_lz = missionNamespace getVariable ("lz" + format["%1", _x + 1]);
	lzList = lzList + [_lz];
	_x = _x + 1;
};

null = [_target, lzList, []] execVM "createObj.sqf";
ferrying = false;
_target allowDamage false;
_target addItem "SatchelCharge_Remote_Mag";
_target addweapon "NVGoggles";