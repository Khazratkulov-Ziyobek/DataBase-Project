-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- //////////////////////////////////////////////////////
--                      COMPLEX VIEWS
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Creating Complex views --

-- Getting players from Academy their own clubs --
create or replace view academy_players_view as
    select
        football.players.player_id,
        player_nm as name,
        position_desc as position,
        club_desc as club
    from football.players
    inner join football.teams on football.players.team_id = football.teams.team_id
    left join football.players_contract on football.players.player_id = football.players_contract.player_id
    where football.players_contract.come_from_team_desc like '%Academy%';

select * from academy_players_view;
/*
+---------+-----------------+----------+---------------+
|player_id|name             |position  |club           |
+---------+-----------------+----------+---------------+
|2        |Davide Calabria  |Defender  |AC Milan       |
|14       |Ronald Araujo    |Defender  |Barcelona      |
|17       |Sergi Busquets   |Midfielder|Barcelona      |
|30       |Thomas Muller    |Forward   |Bayern Munich  |
|70       |Trent Alex-Arnold|Defender  |Liverpool      |
|81       |Marcelo          |Defender  |Real Madrid    |
|109      |Phil Foden       |Forward   |Manchester City|
+---------+-----------------+----------+---------------+
*/

-- Getting players which their contract lasts this year --
create or replace view contract_view as
    select
           football.players.player_id,
           player_nm as name,
           position_desc as position,
           club_desc as club,
           contract_end_dt
    from football.players
    left join football.players_contract on football.players_contract.player_id = football.players.player_id
    inner join football.teams on football.players.team_id = football.teams.team_id
    where extract(year from contract_end_dt) = 2022
    order by contract_end_dt;

select * from contract_view;
/*
+---------+-----------------------+----------+-----------------+---------------+
|player_id|name                   |position  |club             |contract_end_dt|
+---------+-----------------------+----------+-----------------+---------------+
|40       |Emre Can               |Midfielder|Borussia Dortmund|2022-02-18     |
|36       |Dan-Axel Zagadou       |Defender  |Borussia Dortmund|2022-06-13     |
|105      |Bernardo Silva         |Midfielder|Manchester City  |2022-06-16     |
|35       |Manuel Akanji          |Defender  |Borussia Dortmund|2022-06-21     |
|64       |Paulo Dybala           |Forward   |Juventus         |2022-06-25     |
|89       |Mikhail Kerzhakov      |Goalkeeper|Zenit            |2022-06-29     |
|65       |Alvaro Morata          |Forward   |Juventus         |2022-06-30     |
|88       |Gareth Bale            |Forward   |Real Madrid      |2022-08-10     |
|99       |Artem Dzyuba           |Forward   |Zenit            |2022-08-13     |
|81       |Marcelo                |Defender  |Real Madrid      |2022-08-15     |
|20       |Ousmane Dembele        |Forward   |Barcelona        |2022-08-30     |
|59       |Alex Sandro            |Defender  |Juventus         |2022-09-11     |
|85       |Luka Modric            |Midfielder|Real Madrid      |2022-09-23     |
|61       |Juan Guillermo Cuadrado|Defender  |Juventus         |2022-09-30     |
|38       |Raphael Guerreiro      |Defender  |Borussia Dortmund|2022-10-06     |
|92       |Yaroslav Rakitskiy     |Defender  |Zenit            |2022-10-18     |
|56       |Wojciech Szczesny      |Goalkeeper|Juventus         |2022-10-26     |
+---------+-----------------------+----------+-----------------+---------------+
 */

-- Results of matches after second tour --
create or replace view results_view as
    select
           club_desc as club,
           SUM(points) as total_points
    from (
        select club_desc,
            CASE
                WHEN home_no > away_no THEN 3
                WHEN home_no = away_no THEN 1
                ELSE 0
            END AS points
        from football.matches
        left join football.teams on football.matches.home_id = football.teams.team_id
        inner join football.results using(match_id)
        UNION ALL
        select club_desc,
            CASE
                WHEN home_no < away_no THEN 3
                WHEN home_no = away_no THEN 1
                ELSE 0
            END AS points
        from football.matches
        left join football.teams on football.matches.away_id = football.teams.team_id
        inner join football.results using(match_id)
    ) as result
    group by club_desc
    order by total_points desc;

select * from results_view;
/*
+-------------------+------------+
|club               |total_points|
+-------------------+------------+
|Bayern Munich      |6           |
|Manchester City    |4           |
|Real Madrid        |4           |
|Paris Saint-Germain|4           |
|Liverpool          |4           |
|AC Milan           |3           |
|Barcelona          |3           |
|Juventus           |0           |
|Borussia Dortmund  |0           |
|Zenit              |0           |
+-------------------+------------+
*/
