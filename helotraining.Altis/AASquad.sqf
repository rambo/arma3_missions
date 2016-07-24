
_centrePos = _this select 0;

_centreX = _centrePos select 0;
_centrePos set [0, _centreX - 1000 + (floor random 500)];

_position = _centrePos findEmptyPosition [0,100];

_groupEnemy = createGroup east;
"O_soldier_AA_F" createUnit [_position, _groupEnemy,"",0.9, "CORPORAL"];


AAArray = AAArray + [_groupEnemy];


_enemyCount = count AAArray;
if (_enemyCount > 5) then
{
	null = [(AAArray select 0), "aa"] execVM "deleteSquad.sqf";
};