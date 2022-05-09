-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- //////////////////////////////////////////////////////
--                      PROCEDURES
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

create or replace procedure update_real_madrid_player (
    c_player_id smallint,
    c_player_nm varchar(25),
    c_kit_no smallint,
    c_country_desc varchar(32)
)
language plpgsql as
$$
begin
    update football.players set
    player_nm = c_player_nm,
    kit_no = c_kit_no,
    country_desc = c_country_desc
    where player_id = c_player_id;
end
$$;

call update_real_madrid_player(
    smallint '80',
    'Nacho Fernandez',
    smallint'6',
    'Spain');

create or replace procedure update_real_madrid_player_contract (
    c_player_id smallint,
    c_come_from_team_desc varchar(25),
    c_subscription_dt date,
    c_contract_end_dt date
)
language plpgsql as
$$
begin
    update football.players_contract set
    come_from_team_desc = c_come_from_team_desc,
    subscription_dt = c_subscription_dt,
    contract_end_dt = c_contract_end_dt
    where player_id = c_player_id;
end
$$;

call update_real_madrid_player_contract(
    smallint '80',
    'Real Madrid B',
    '2012-07-01',
    '2023-07-29');

select club_desc, player_nm, kit_no,
       position_desc, country_desc, come_from_team_desc, subscription_dt, contract_end_dt
from football.players
    inner join football.teams on football.players.team_id = football.teams.team_id
    inner join football.players_contract on football.players.player_id = football.players_contract.player_id
where football.players.player_id = 80;

/*
+-----------+---------------+------+-------------+------------+-------------------+---------------+---------------+
|club_desc  |player_nm      |kit_no|position_desc|country_desc|come_from_team_desc|subscription_dt|contract_end_dt|
+-----------+---------------+------+-------------+------------+-------------------+---------------+---------------+
|Real Madrid|Nacho Fernandez|6     |Defender     |Spain       |Real Madrid B      |2012-07-01     |2023-07-29     |
+-----------+---------------+------+-------------+------------+-------------------+---------------+---------------+
*/
