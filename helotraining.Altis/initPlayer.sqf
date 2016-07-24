waitUntil {!(isNil "missionInitComplete")};

_target = _this select 0;
_playerno = _this select 1;
playersArray set [_playerno, _target];

diag_log format["initPlayer called, _target: %1, _playerno: %2", _target, _playerno];

ferryingArray set [_playerno, false];
landingCompleteArray set [_playerno, false];
publicVariable "ferryingArray";
publicVariable "landingCompleteArray";
null = [_target, lzList, [], _playerno] execVM "createObj.sqf";
(playersArray select _playerno) addItem "SatchelCharge_Remote_Mag";
(playersArray select _playerno) addweapon "NVGoggles";
