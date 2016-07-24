diag_log format["playerspawn called, _this: %1", _this];
_target = (_this select 0) select 0;
_playerno = _this select 1;
playersArray set [_playerno, _target];

ferryingArray set [_playerno, false];
landingCompleteArray set [_playerno, false];

null = [(playersArray select _playerno), null, [], _playerno] execVM "createObj.sqf";

(playersArray select _playerno) addItem "SatchelCharge_Remote_Mag";
(playersArray select _playerno) addweapon "NVGoggles";

publicVariable "playersArray";
publicVariable "ferryingArray";
publicVariable "landingCompleteArray";
