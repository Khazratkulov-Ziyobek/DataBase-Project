-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- //////////////////////////////////////////////////////
--                    SELECT QUERIES
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- first example: getting all dutchmen players --
select player_nm, club_desc, country_desc
    from football.players
inner join football.teams on football.players.team_id = football.teams.team_id
    where country_desc = 'Netherlands'
    order by player_nm;

/*
+-------------------+-------------------+------------+
|player_nm          |club_desc          |country_desc|
+-------------------+-------------------+------------+
|Frenkie De Jong    |Barcelona          |Netherlands |
|Georginio Wijnaldum|Paris Saint-Germain|Netherlands |
|Matthijs de Ligt   |Juventus           |Netherlands |
|Virgil van Dijk    |Liverpool          |Netherlands |
+-------------------+-------------------+------------+
*/

-- second example: getting at least two assists in one match --
select player_nm, assists_no
    from football.players
inner join football.scores on football.players.player_id = football.scores.player_id
    where assists_no >= 2
    order by assists_no desc, player_nm;

/*
+-----------------+----------+
|player_nm        |assists_no|
+-----------------+----------+
|Kevin De Bruyne  |3         |
|Andrew Robertson |2         |
|Gareth Bale      |2         |
|Lionel Messi     |2         |
|Luka Modric      |2         |
|Malcom           |2         |
|Thomas Muller    |2         |
|Trent Alex-Arnold|2         |
+-----------------+----------+
 */

-- third example: getting goals of the team --
select sum(goals_no) as total, club_desc
    from football.players
left join football.teams on football.players.team_id = football.teams.team_id
right join football.scores on football.players.player_id = football.scores.player_id
    group by club_desc
    order by sum(goals_no) desc, club_desc;

/*
+-----+-------------------+
|total|club_desc          |
+-----+-------------------+
|8    |Liverpool          |
|6    |Bayern Munich      |
|6    |Real Madrid        |
|5    |Manchester City    |
|4    |Paris Saint-Germain|
|2    |AC Milan           |
|2    |Barcelona          |
|2    |Juventus           |
|2    |Zenit              |
|1    |Borussia Dortmund  |
+-----+-------------------+
 */

 -- fourth example: getting liverpool matches' results
select home.club_desc as home, home_no as " ", away_no as " ", away.club_desc as away
    from football.matches as match
left join football.teams as home on match.home_id = home.team_id
left join football.teams as away on match.away_id = away.team_id
inner join football.results using (match_id)
where home_id = 7 or away_id = 7;

/*
+---------+-+-+-----------+
|home     | | |away       |
+---------+-+-+-----------+
|Liverpool|3|3|Real Madrid|
|Liverpool|5|2|Zenit      |
+---------+-+-+-----------+
 */

-- fifth example: getting sum of all players' goals --
select player_nm, sum(goals_no) as total, club_desc
    from football.players
left join football.teams on football.players.team_id = teams.team_id
right join football.scores on football.players.player_id = scores.player_id
group by player_nm, club_desc
having sum(goals_no) > 1
order by sum(goals_no) desc, player_nm;

/*
+-------------------------+-----+-------------------+
|player_nm                |total|club_desc          |
+-------------------------+-----+-------------------+
|Mohamed Salah            |4    |Liverpool          |
|Robert Lewandowski       |4    |Bayern Munich      |
|Gareth Bale              |3    |Real Madrid        |
|Sadio Mane               |3    |Liverpool          |
|Artem Dzyuba             |2    |Zenit              |
|Lionel Messi             |2    |Paris Saint-Germain|
|Pierre-Emerick Aubameyang|2    |Barcelona          |
|Raheem Sterling          |2    |Manchester City    |
|Vinicius Junior          |2    |Real Madrid        |
|Zlatan Ibrahimovic       |2    |AC Milan           |
+-------------------------+-----+-------------------+
 */

-- sixth example: getting home's won matches --
select home.shorthand_desc as home, home_no as " ", away_no as " ", away.shorthand_desc as away, stadiums.full_nm
    from football.matches as match
left join football.teams as home on match.home_id = home.team_id
left join football.teams as away on match.away_id = away.team_id
inner join football.results using(match_id)
inner join football.stadiums on football.stadiums.stadium_id = match.stadium_id
    where home_no > away_no;

/*
+----+-+-+----+----------------+
|home| | |away|full_nm         |
+----+-+-+----+----------------+
|ACM |1|0|BAR |San Siro        |
|MUN |2|1|DOR |Allianz Arena   |
|PSG |3|1|JUV |Parc des Princes|
|BAR |2|0|DOR |Camp Nou        |
|MUN |4|1|ACM |Allianz Arena   |
|LIV |5|2|ZEN |Anfield         |
+----+-+-+----+----------------+
 */
