diag_log format["playerspawn called, _this: %1", _this];
_target = _this select 0;
_playerno = _this select 1;
playersArray set [_playerno, _target];
(playersArray select _playerno) addEventHandler ["killed", {Null = _this, _playerno execVM "playerkilled.sqf";}]; 
(playersArray select _playerno) addMPEventHandler ["mpkilled", {Null = _this, _playerno execVM "playerkilled.sqf";}]; 
(playersArray select _playerno) addEventHandler ["respawn", {Null = unit, _playerno execVM "playerspawn.sqf";}]; 
(playersArray select _playerno) addMPEventHandler ["mprespawn", {Null = unit, _playerno execVM "playerspawn.sqf";}]; 

ferryingArray set [_playerno, false];
landingCompleteArray set [_playerno, false];

null = [(playersArray select _playerno), lzList, [], _playerno] execVM "createObj.sqf";

(playersArray select _playerno) addItem "SatchelCharge_Remote_Mag";
(playersArray select _playerno) addweapon "NVGoggles";

publicVariable "playersArray";
publicVariable "ferryingArray";
publicVariable "landingCompleteArray";
