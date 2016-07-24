diag_log format["playerspawn called, _this: %1", _this];
_evt = _this select 0;
_playerno = _this select 1;

ferryingArray set [_playerno, false];
landingCompleteArray set [_playerno, false];
publicVariable "ferryingArray";
publicVariable "landingCompleteArray";
null = [(playersArray select _playerno), lzList, [], _playerno] execVM "createObj.sqf";
(playersArray select _playerno) addItem "SatchelCharge_Remote_Mag";
(playersArray select _playerno) addweapon "NVGoggles";
