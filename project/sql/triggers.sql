-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- //////////////////////////////////////////////////////
--                      TRIGGERS
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Trigger on insert in table teams --
create or replace function notice_new_teams()
    returns trigger as $$
    declare
    begin
        raise notice 'New team was added';
        return new;
    end;
$$ language plpgsql;

create trigger notice_new_team
    after insert on football.teams
    for each row
    execute procedure notice_new_teams();

-- Trigger on delete in table teams --
create or replace function notice_delete_teams()
    returns trigger as $$
    declare
    begin
        raise notice 'Team was deleted';
        return new;
    end;
$$ language plpgsql;

create trigger notice_delete_team
    after delete on football.teams
    for each row
    execute procedure notice_delete_teams();

insert into football.stadiums (stadium_id, full_nm, capacity_no) values(11, 'Emirates Stadium', 60260);
insert into football.teams (team_id, stadium_id, club_desc, shorthand_desc, team_country_desc) values(
    11, 11, 'Arsenal', 'ARS', 'England');
delete from football.teams where club_desc = 'Arsenal';
delete from football.stadiums where stadium_id = 11;
