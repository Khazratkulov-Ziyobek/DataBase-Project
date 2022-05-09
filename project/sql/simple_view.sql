-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- //////////////////////////////////////////////////////
--                      SIMPLE VIEWS
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- View for the table stadiums --
create or replace view stadiums_view as
    select
           stadium_id,
           'Название: ' || full_nm as full_name,
           'Вместимость: ' || capacity_no as capacity
    from football.stadiums;

select * from stadiums_view;

-- View for the table teams --
create or replace view teams_view as
    select
           team_id,
           'Команда: ' || club_desc as club,
           'Страна: ' || team_country_desc as country
    from football.teams;

select * from teams_view;

-- View Real Madrid Players --
create or replace view players_view as
    select
           'Игрок: ' || player_nm as player,
           'Номер: ' || kit_no as kit,
           'Позиция: ' || players.position_desc as position
    from football.players
        where player_id between 78 and 88;

select * from players_view;
