diag_log format["createEnemySquad called, _this: %1", _this];
_centrePos = _this select 0;
_includeAA = this select 1;

_centreX = _centrePos select 0;
_centrePos set [0, _centreX + 100 + (floor random 300)];

_position = _centrePos findEmptyPosition [0,100];

// TODO: check if we want to create multiple enemy squads

_groupEnemy = createGroup east;
"O_Soldier_F" createUnit [_position, _groupEnemy,"",0.6, "CORPORAL"];
"O_Soldier_F" createUnit [_position, _groupEnemy,"",0.1, "PRIVATE"];
"O_soldier_M_F" createUnit [_position, _groupEnemy,"",0.3, "PRIVATE"];
"O_soldier_AR_F" createUnit [_position, _groupEnemy,"",0.3, "PRIVATE"];
"O_soldier_M_F" createUnit [_position, _groupEnemy,"",0.3, "PRIVATE"];
"O_soldier_AR_F" createUnit [_position, _groupEnemy,"",0.3, "PRIVATE"];
"O_soldier_M_F" createUnit [_position, _groupEnemy,"",0.3, "PRIVATE"];
"O_soldier_AR_F" createUnit [_position, _groupEnemy,"",0.3, "PRIVATE"];
"O_soldier_M_F" createUnit [_position, _groupEnemy,"",0.3, "PRIVATE"];
"O_soldier_AR_F" createUnit [_position, _groupEnemy,"",0.3, "PRIVATE"];

if (_includeAA) then
{
    "O_soldier_AA_F" createUnit [_position, _groupEnemy,"",0.75, "CORPORAL"];
}

[_groupEnemy]