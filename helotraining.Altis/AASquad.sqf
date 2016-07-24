
_centrePos = _this select 0;
_playerno = _this select 1;


_centreX = _centrePos select 0;
_centrePos set [0, _centreX - 1000 + (floor random 500)];

_position = _centrePos findEmptyPosition [0,100];

_groupEnemy = createGroup east;
"O_soldier_AA_F" createUnit [_position, _groupEnemy,"",0.9, "CORPORAL"];


AAMDArray set [_playerno, (AAMDArray select _playerno) + [_groupEnemy]];
publicVariable "AAMDArray";


_enemyCount = count (AAMDArray select _playerno);
if (_enemyCount > 5) then
{
	null = [((AAMDArray select _playerno) select 0), "aa", _playerno] execVM "deleteSquad.sqf";
};

