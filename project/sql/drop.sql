-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- //////////////////////////////////////////////////////
--                      DELETE
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drop table if exists football.stadiums cascade;
drop table if exists football.teams cascade;
drop table if exists football.players cascade;
drop table if exists football.players_contract cascade;
drop table if exists football.matches cascade;
drop table if exists football.results cascade;
drop table if exists football.scores cascade;
drop schema if exists football;