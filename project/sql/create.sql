-- CREATING SCHEMA --
create schema football;

set search_path to football, public;

-- CREATING TABLE STADIUMS --
create table if not exists football.stadiums (
    stadium_id smallint primary key,
    full_nm varchar(32) not null,
    capacity_no integer not null
);

-- CREATING TABLE TEAMS --
create table if not exists football.teams (
    team_id smallint primary key,
    stadium_id smallint,
    club_desc varchar(25) not null,
    shorthand_desc varchar(3) unique not null check (length(shorthand_desc) = 3),
    team_country_desc varchar(32) not null,

    foreign key(stadium_id) references football.stadiums(stadium_id) on delete cascade on update cascade
);

-- CREATING TABLE PLAYERS --
create table if not exists football.players (
    player_id smallint primary key,
    team_id smallint,
    player_nm varchar(25),
    kit_no smallint not null check(kit_no between 1 and 99),
    position_desc varchar(10) not null check (
            position_desc = 'Goalkeeper' or position_desc = 'Defender' or
            position_desc = 'Midfielder' or position_desc = 'Forward'),
    country_desc varchar(32) not null,

    foreign key(team_id) references football.teams(team_id) on delete cascade on update cascade
);

-- CREATING TABLE PLAYERS_CONTRACT --
create table if not exists football.players_contract (
    player_id smallint,
    come_from_team_desc varchar(25) not null,
    subscription_dt date not null,
    contract_end_dt date not null,

    foreign key(player_id) references football.players(player_id) on delete cascade on update cascade
);

-- CREATING TABLE MATCHES --
create table if not exists football.matches (
    match_id smallint primary key,
    home_id smallint not null,
    away_id smallint not null,
    stadium_id smallint not null,
    time_dt timestamp not null,
    attendance_no integer not null,

    foreign key(home_id) references football.teams(team_id) on delete cascade on update cascade,
    foreign key(away_id) references football.teams(team_id) on delete cascade on update cascade,
    foreign key(stadium_id) references football.stadiums(stadium_id) on delete cascade on update cascade
);

-- CREATING TABLE RESULTS --
create table if not exists football.results (
    match_id smallint primary key,
    home_no smallint not null check(home_no >= 0),
    away_no smallint not null check(away_no >= 0),

    foreign key(match_id) references football.matches(match_id) on delete cascade on update cascade
);

-- CREATING TABLE SCORES --
create table if not exists football.scores (
    score_id smallint primary key,
    match_id smallint not null,
    team_id  smallint not null,
    player_id smallint not null,
    goals_no smallint not null check (goals_no >= 0),
    assists_no smallint not null check (assists_no >= 0),

    foreign key(match_id) references football.matches(match_id) on delete cascade on update cascade,
    foreign key(team_id) references football.teams(team_id) on delete cascade on update cascade,
    foreign key(player_id) references football.players(player_id) on delete cascade on update cascade
);
