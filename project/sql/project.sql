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

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- //////////////////////////////////////////////////////
--                     DDL SCRIPTS
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- STADIUMS INSERTIONS --
insert into football.stadiums (stadium_id, full_nm, capacity_no) values(1, 'San Siro', 80018);
insert into football.stadiums (stadium_id, full_nm, capacity_no) values(2, 'Camp Nou', 99354);
insert into football.stadiums (stadium_id, full_nm, capacity_no) values(3, 'Allianz Arena', 75000);
insert into football.stadiums (stadium_id, full_nm, capacity_no) values(4, 'Signal Iduna Park', 81365);
insert into football.stadiums (stadium_id, full_nm, capacity_no) values(5, 'Parc des Princes', 48712);
insert into football.stadiums (stadium_id, full_nm, capacity_no) values(6, 'Allianz Stadium', 41507);
insert into football.stadiums (stadium_id, full_nm, capacity_no) values(7, 'Anfield', 54074);
insert into football.stadiums (stadium_id, full_nm, capacity_no) values(8, 'Estadio Santiago Bernabéu', 81044);
insert into football.stadiums (stadium_id, full_nm, capacity_no) values(9, 'Gazprom Arena', 45360);
insert into football.stadiums (stadium_id, full_nm, capacity_no) values(10, 'Etihad Stadium', 55097);

-- TEAMS INSERTIONS --
insert into football.teams (team_id, stadium_id, club_desc, shorthand_desc, team_country_desc) values(
    1, 1, 'AC Milan', 'ACM', 'Italy');
insert into football.teams (team_id, stadium_id, club_desc, shorthand_desc, team_country_desc) values(
    2, 2, 'Barcelona', 'BAR', 'Spain');
insert into football.teams (team_id, stadium_id, club_desc, shorthand_desc, team_country_desc) values(
    3, 3, 'Bayern Munich', 'MUN', 'Germany');
insert into football.teams (team_id, stadium_id, club_desc, shorthand_desc, team_country_desc) values(
    4, 4, 'Borussia Dortmund', 'DOR', 'Germany');
insert into football.teams (team_id, stadium_id, club_desc, shorthand_desc, team_country_desc) values(
    5, 5, 'Paris Saint-Germain', 'PSG', 'France');
insert into football.teams (team_id, stadium_id, club_desc, shorthand_desc, team_country_desc) values(
    6, 6, 'Juventus', 'JUV', 'Italy');
insert into football.teams (team_id, stadium_id, club_desc, shorthand_desc, team_country_desc) values(
    7, 7, 'Liverpool', 'LIV', 'England');
insert into football.teams (team_id, stadium_id, club_desc, shorthand_desc, team_country_desc) values(
    8, 8, 'Real Madrid', 'RMD', 'Spain');
insert into football.teams (team_id, stadium_id, club_desc, shorthand_desc, team_country_desc) values(
    9, 9, 'Zenit', 'ZEN', 'Russia');
insert into football.teams (team_id, stadium_id, club_desc, shorthand_desc, team_country_desc) values(
    10, 10, 'Manchester City', 'MNC', 'England');

-- PLAYERS INSERTIONS --
-- AC MILAN --
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  1, 1, 'Mike Maignan', 16, 'Goalkeeper', 'France');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  2, 1, 'Davide Calabria', 2, 'Defender', 'Italy');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  3, 1, 'Pierre Kalulu', 20, 'Defender', 'France');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  4, 1, 'Fikayo Tomori', 23, 'Defender', 'England');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  5, 1, 'Theo Hernandez', 19, 'Defender', 'France');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  6, 1, 'Sandro Tonali', 8, 'Midfielder', 'Italy');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  7, 1, 'Franck Kessie', 79, 'Midfielder', 'Ivory Coast');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  8, 1, 'Brahim Diaz', 10, 'Midfielder', 'Spain');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  9, 1, 'Alexis Saelemaekers', 56, 'Midfielder', 'Belgium');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  10, 1, 'Rafael Leao', 17, 'Forward', 'Portugal');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  11, 1, 'Zlatan Ibrahimovic', 11, 'Forward', 'Sweden');

-- BARCELONA --
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  12, 2, 'Marc-Andre ter Stegen', 1, 'Goalkeeper', 'Germany');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  13, 2, 'Gerard Pique', 3, 'Defender', 'Spain');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  14, 2, 'Ronald Araujo', 4, 'Defender', 'Uruguay');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  15, 2, 'Dani Alves', 8, 'Defender', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  16, 2, 'Jordi Alba', 18, 'Defender', 'Spain');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  17, 2, 'Sergi Busquets', 5, 'Midfielder', 'Spain');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  18, 2, 'Pedri', 16, 'Midfielder', 'Spain');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  19, 2, 'Frenkie De Jong', 21, 'Midfielder', 'Netherlands');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  20, 2, 'Ousmane Dembele', 7, 'Forward', 'France');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  21, 2, 'Ferran Torres', 19, 'Forward', 'Spain');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  22, 2, 'Pierre-Emerick Aubameyang', 25, 'Forward', 'Gabon');

-- BAYERN MUNICH --
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  23, 3, 'Manuel Neuer', 1, 'Goalkeeper', 'Germany');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  24, 3, 'Dayot Upamecano', 2, 'Defender', 'France');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  25, 3, 'Benjamin Pavard', 5, 'Defender', 'France');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  26, 3, 'Alphonso Davies', 19, 'Defender', 'Canada');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  27, 3, 'Lucas Hernandez', 21, 'Defender', 'France');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  28, 3, 'Leon Goretzka', 8, 'Midfielder', 'Germany');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  29, 3, 'Joshua Kimmich', 6, 'Midfielder', 'Germany');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  30, 3, 'Thomas Muller', 25, 'Forward', 'Germany');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  31, 3, 'Serge Gnabry', 7, 'Forward', 'Germany');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  32, 3, 'Kingsley Coman', 11, 'Forward', 'Germany');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  33, 3, 'Robert Lewandowski', 9, 'Forward', 'Poland');

-- BORUSSIA DORTMUND --
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  34, 4, 'Marwin Hitz', 35, 'Goalkeeper', 'Switzerland');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  35, 4, 'Manuel Akanji', 16, 'Defender', 'Switzerland');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  36, 4, 'Dan-Axel Zagadou', 5, 'Defender', 'France');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  37, 4, 'Mats Hummels', 15, 'Defender', 'Germany');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  38, 4, 'Raphael Guerreiro', 13, 'Defender', 'Portugal');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  39, 4, 'Jude Bellingham', 22, 'Midfielder', 'England');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  40, 4, 'Emre Can', 23, 'Midfielder', 'Germany');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  41, 4, 'Julian Brandt', 19, 'Midfielder', 'Germany');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  42, 4, 'Thorgan Hazard', 10, 'Midfielder', 'Belgium');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  43, 4, 'Marco Reus', 11, 'Forward', 'Germany');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  44, 4, 'Erling Braut Haaland', 9, 'Forward', 'Norway');

-- PARIS SAINT-GERMAIN --
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  45, 5, 'Gianluigi Donnarumma', 50, 'Goalkeeper', 'Italy');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  46, 5, 'Sergio Ramos', 4, 'Defender', 'Spain');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  47, 5, 'Marquinhos', 5, 'Defender', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  48, 5, 'Achraf Hakimi', 2, 'Defender', 'Morocco');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  49, 5, 'Nuno Mendes', 25, 'Defender', 'Portugal');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  50, 5, 'Georginio Wijnaldum', 18, 'Midfielder', 'Netherlands');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  51, 5, 'Marco Verratti', 6, 'Midfielder', 'Italy');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  52, 5, 'Idrissa Gueye', 27, 'Midfielder', 'Senegal');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  53, 5, 'Neymar', 10, 'Forward', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  54, 5, 'Kylian Mbappe', 7, 'Forward', 'France');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  55, 5, 'Lionel Messi', 30, 'Forward', 'Argentina');

-- JUVENTUS --
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  56, 6, 'Wojciech Szczesny', 1, 'Goalkeeper', 'Poland');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  57, 6, 'Matthijs de Ligt', 4, 'Defender', 'Netherlands');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  58, 6, 'Giorgio Chiellini', 3, 'Defender', 'Italy');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  59, 6, 'Alex Sandro', 12, 'Defender', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  60, 6, 'Danilo', 6, 'Defender', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  61, 6, 'Juan Guillermo Cuadrado', 11, 'Defender', 'Colombia');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  62, 6, 'Adrien Rabiot', 25, 'Midfielder', 'France');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  63, 6, 'Manuel Locatelli', 27, 'Midfielder', 'Italy');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  64, 6, 'Paulo Dybala', 10, 'Forward', 'Argentina');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  65, 6, 'Alvaro Morata', 9, 'Forward', 'Spain');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  66, 6, 'Dusan Vlahovic', 7, 'Forward', 'Serbia');

-- LIVERPOOL --
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  67, 7, 'Alisson', 1, 'Goalkeeper', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  68, 7, 'Virgil van Dijk', 4, 'Defender', 'Netherlands');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  69, 7, 'Ibrahima Konate', 5, 'Defender', 'France');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  70, 7, 'Trent Alex-Arnold', 66, 'Defender', 'England');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  71, 7, 'Andrew Robertson', 26, 'Defender', 'Scotland');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  72, 7, 'Thiago', 6, 'Midfielder', 'Spain');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  73, 7, 'Jordan Henderson', 14, 'Midfielder', 'England');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  74, 7, 'Fabinho', 3, 'Midfielder', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  75, 7, 'Mohamed Salah', 11, 'Forward', 'Egypt');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  76, 7, 'Sadio Mane', 10, 'Forward', 'Senegal');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  77, 7, 'Luis Diaz', 23, 'Forward', 'Colombia');

-- REAL MADRID --
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  78, 8, 'Thibaut Courtois', 1, 'Goalkeeper', 'Belgium');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  79, 8, 'David Alaba', 4, 'Defender', 'Austria');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  80, 8, 'Eder Militao', 3, 'Defender', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  81, 8, 'Marcelo', 12, 'Defender', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  82, 8, 'Daniel Carvajal', 2, 'Defender', 'Spain');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  83, 8, 'Toni Kroos', 8, 'Midfielder', 'Germany');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  84, 8, 'Casemiro', 14, 'Midfielder', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  85, 8, 'Luka Modric', 10, 'Midfielder', 'Croatia');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  86, 8, 'Karim Benzema', 9, 'Forward', 'France');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  87, 8, 'Vinicius Junior', 20, 'Forward', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  88, 8, 'Gareth Bale', 18, 'Forward', 'Wales');

-- ZENIT --
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  89, 9, 'Mikhail Kerzhakov', 41, 'Goalkeeper', 'Russia');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  90, 9, 'Douglas Santos', 3, 'Defender', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  91, 9, 'Dmitriy Chistyakov', 2, 'Defender', 'Russia');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  92, 9, 'Yaroslav Rakitskiy', 44, 'Defender', 'Ukraine');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  93, 9, 'Vyacheslav Karavayev', 15, 'Defender', 'Russia');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  94, 9, 'Wendel', 8, 'Midfielder', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  95, 9, 'Malcom', 10, 'Midfielder', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  96, 9, 'Wilmar Barrios', 5, 'Midfielder', 'Colombia');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  97, 9, 'Claudinho', 11, 'Midfielder', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  98, 9, 'Daler Kuzyaev', 14, 'Midfielder', 'Russia');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  99, 9, 'Artem Dzyuba', 22, 'Forward', 'Russia');

-- MANCHESTER CITY --
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  100, 10, 'Ederson Moraes', 31, 'Goalkeeper', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  101, 10, 'Ruben Dias', 3, 'Defender', 'Portugal');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  102, 10, 'John Stones', 5, 'Defender', 'England');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  103, 10, 'Joao Cancelo', 27, 'Defender', 'Portugal');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  104, 10, 'Kyle Walker', 2, 'Defender', 'England');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  105, 10, 'Bernardo Silva', 20, 'Midfielder', 'Portugal');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  106, 10, 'Kevin De Bruyne', 17, 'Midfielder', 'Belgium');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  107, 10, 'Rodri', 16, 'Midfielder', 'Spain');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  108, 10, 'Gabriel Jesus', 9, 'Midfielder', 'Brazil');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  109, 10, 'Riyad Mahrez', 26, 'Forward', 'Algeria');
insert into football.players (player_id, team_id, player_nm, kit_no, position_desc, country_desc) values (
  110, 10, 'Raheem Sterling', 7, 'Forward', 'England');

-- PLAYERS CONTRACT INSERTIONS --
-- AC MILAN --
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  1, 'Lille', '2021-05-27', '2026-07-01');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  2, 'Milan Academy', '2013-06-18', '2025-06-01');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  3, 'Lyon', '2020-09-01', '2025-05-13');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  4, 'Derby', '2021-06-17', '2024-03-26');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  5, 'Real Sociedad', '2019-07-19', '2026-02-11');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  6, 'Brescia', '2017-08-01', '2023-04-16');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  7, 'Atalanta', '2015-04-17', '2024-10-23');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  8, 'Real Madrid', '2019-01-06', '2023-02-18');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  9, 'Anderlecht', '2020-01-31', '2026-06-30');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  10, 'Lille', '2019-08-01', '2024-08-19');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  11, 'LA Galaxy', '2020-01-02', '2023-09-23');

-- BARCELONA --
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  12, 'B Munichgladbach', '2010-08-01', '2025-06-30');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  13, 'Zaragoza', '2006-07-01', '2024-06-20');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  14, 'Barcelona Academy', '2019-07-20', '2023-08-29');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  15, 'Sao Paulo', '2022-01-05', '2024-09-28');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  16, 'Valencia', '2012-06-28', '2024-03-11');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  17, 'Barcelona Academy', '2008-06-01', '2023-06-13');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  18, 'Las Palmas', '2020-08-01', '2025-11-09');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  19, 'Ajax', '2019-07-01', '2024-07-01');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  20, 'Borussia Dortmund', '2017-08-25', '2022-08-30');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  21, 'Manchester City', '2022-01-11', '2027-06-14');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  22, 'Arsenal', '2022-02-02', '2025-06-30');

-- BAYERN MUNICH --
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  23, 'Schalke', '2011-06-08', '2023-05-23');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  24, 'RB Leipzig', '2021-07-16', '2026-09-22');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  25, 'Stuttgart', '2019-07-01', '2024-06-30');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  26, 'Vancouver W', '2019-01-01', '2025-04-21');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  27, 'Atl Madrid', '2019-07-01', '2024-03-29');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  28, 'Schalke', '2018-07-01', '2026-09-16');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  29, 'RB Leipzig', '2015-07-01', '2025-12-17');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  30, 'Bayern Munich Academy', '2008-07-01', '2023-04-08');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  31, 'Hoffenheim', '2017-07-17', '2023-03-05');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  32, 'Juventus', '2014-07-01', '2023-06-30');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  33, 'Borussia Dortmund', '2014-07-01', '2023-08-29');

-- BORUSSIA DORTMUND --
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  34, 'Augsburg', '2018-07-01', '2023-09-27');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  35, 'Basel', '2018-01-15', '2022-06-21');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  36, 'Paris Saint-Germain', '2017-07-01', '2022-06-13');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  37, 'Bayern Munich', '2019-07-01', '2024-09-11');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  38, 'Lorient', '2016-07-01', '2022-10-06');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  39, 'Birmingham', '2020-07-23', '2026-12-25');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  40, 'Juventus', '2018-07-01', '2022-02-18');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  41, 'Bayern Leverkusen', '2019-05-19', '2024-05-22');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  42, 'Borussia Munichgladbach', '2019-05-22', '2024-05-19');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  43, 'Borussia Munichgladbach', '2012-07-01', '2023-06-30');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  44, 'RB Salzburg', '2020-01-01', '2024-12-30');

-- PARIS SAINT-GERMAIN --
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  45, 'AC Milan', '2021-07-14', '2026-06-16');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  46, 'Real Madrid', '2021-07-08', '2023-07-08');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  47, 'Roma', '2013-05-30', '2023-09-24');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  48, 'Inter Milan', '2021-07-06', '2026-07-29');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  49, 'Sporting', '2019-07-01', '2024-07-31');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  50, 'Liverpool', '2021-06-21', '2024-06-07');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  51, 'Pescara', '2012-06-01', '2023-10-12');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  52, 'Everton', '2019-07-30', '2023-11-29');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  53, 'Barcelona', '2017-08-03', '2025-05-08');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  54, 'Monaco', '2018-07-01', '2024-06-25');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  55, 'Barcelona', '2021-08-10', '2023-06-30');

-- JUVENTUS --
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  56, 'Roma', '2017-07-19', '2022-10-26');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  57, 'Ajax Amsterdam', '2019-07-18', '2024-07-27');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  58, 'Fiorentina', '2005-08-01', '2023-06-15');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  59, 'Porto', '2015-08-20', '2022-09-11');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  60, 'Manchester City', '2019-08-07', '2024-06-22');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  61, 'Chelsea', '2017-05-22', '2022-09-30');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  62, 'Paris Saint-Germain', '2019-07-01', '2024-01-19');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  63, 'Sassuolo', '2021-08-18', '2023-06-21');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  64, 'Palermo', '2015-06-04', '2022-06-25');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  65, 'Atletico Madrid', '2020-08-22', '2022-06-30');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  66, 'Fiorentina', '2022-01-18', '2026-12-17');

-- LIVERPOOL --
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  67, 'Roma', '2018-07-19', '2027-08-24');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  68, 'Southampton', '2018-01-18', '2025-10-19');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  69, 'RB Leipzig', '2021-07-01', '2026-08-08');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  70, 'Liverpool Academy', '2015-07-01', '2027-11-22');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  71, 'Hull City', '2017-07-21', '2024-12-24');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  72, 'Bayern Munich', '2020-09-18', '2024-10-19');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  73, 'Sunderland', '2011-06-11', '2023-03-31');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  74, 'Monaco', '2018-07-01', '2026-08-03');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  75, 'Roma', '2017-06-22', '2025-06-05');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  76, 'Southampton', '2016-06-28', '2023-11-20');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  77, 'Porto', '2022-01-30', '2027-02-16');

-- REAL MADRID --
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  78, 'Chelsea', '2018-08-08', '2024-08-31');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  79, 'Bayern Munich', '2021-07-01', '2026-07-31');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  80, 'Porto', '2019-07-01', '2025-04-29');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  81, 'Real Madrid Academy', '2007-01-01', '2022-08-15');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  82, 'Bayern Leverkusen', '2013-07-01', '2025-06-30');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  83, 'Bayern Munich', '2014-07-17', '2023-05-25');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  84, 'Porto', '2012-01-01', '2025-08-13');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  85, 'Tottenham', '2012-08-27', '2022-09-23');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  86, 'Lyon', '2009-01-10', '2023-12-05');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  87, 'Flamengo', '2018-07-12', '2027-09-04');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  88, 'Tottenham', '2013-09-01', '2022-08-10');

-- ZENIT --
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  89, 'Anzhi', '2015-06-17', '2022-06-29');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  90, 'Hamburg', '2019-07-01', '2026-12-01');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  91, 'Rostov', '2019-06-11', '2025-06-03');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  92, 'Shakhtar', '2019-09-02', '2022-10-18');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  93, 'Sparta Prague', '2019-08-07', '2024-06-22');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  94, 'Sporting', '2020-10-06', '2025-04-24');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  95, 'Barcelona', '2019-08-01', '2024-09-15');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  96, 'Boca Juniors', '2019-02-01', '2024-12-27');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  97, 'Red Bull FC', '2021-08-07', '2026-06-06');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  98, 'Terek Grozny', '2017-07-01', '2023-10-06');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  99, 'Spartak Moscow', '2015-07-01', '2022-08-13');

-- MANCHESTER CITY --
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  100, 'Benfica', '2017-06-08', '2024-03-13');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  101, 'Benfica', '2020-09-29', '2026-10-23');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  102, 'Everton', '2016-08-09', '2026-08-10');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  103, 'Juventus', '2019-08-07', '2025-08-07');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  104, 'Tottenham', '2017-07-14', '2025-07-13');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  105, 'Monaco', '2017-05-26', '2022-06-16');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  106, 'Wolfsburg', '2015-08-30', '2024-04-12');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  107, 'Atletico Madrid', '2019-07-04', '2024-07-03');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  108, 'Palmeiras', '2016-08-03', '2023-08-23');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  109, 'Leicester', '2018-07-10', '2023-08-10');
insert into football.players_contract (player_id, come_from_team_desc, subscription_dt, contract_end_dt) values (
  110, 'Liverpool', '2015-07-14', '2023-08-15');

-- MATCHES INSERTIONS --
insert into football.matches (match_id, home_id, away_id, stadium_id, time_dt, attendance_no) values (
    1, 1, 2, 1, '2022-02-03 16:30:00', 69454);
insert into football.matches (match_id, home_id, away_id, stadium_id, time_dt, attendance_no) values (
    2, 3, 4, 3, '2022-02-03 18:00:00', 59470);
insert into football.matches (match_id, home_id, away_id, stadium_id, time_dt, attendance_no) values (
    3, 5, 6, 5, '2022-02-03 20:30:00', 31263);
insert into football.matches (match_id, home_id, away_id, stadium_id, time_dt, attendance_no) values (
    4, 7, 8, 7, '2022-02-04 16:30:00', 32804);
insert into football.matches (match_id, home_id, away_id, stadium_id, time_dt, attendance_no) values (
    5, 9, 10, 9, '2022-02-04 18:00:00', 38592);

insert into football.matches (match_id, home_id, away_id, stadium_id, time_dt, attendance_no) values (
    6, 2, 4, 2, '2022-02-10 16:30:00', 85623);
insert into football.matches (match_id, home_id, away_id, stadium_id, time_dt, attendance_no) values (
    7, 3, 1, 3, '2022-02-10 18:00:00', 40087);
insert into football.matches (match_id, home_id, away_id, stadium_id, time_dt, attendance_no) values (
    8, 6, 8, 6, '2022-02-10 20:30:00', 28975);
insert into football.matches (match_id, home_id, away_id, stadium_id, time_dt, attendance_no) values (
    9, 7, 9, 7, '2022-02-11 16:30:00', 31047);
insert into football.matches (match_id, home_id, away_id, stadium_id, time_dt, attendance_no) values (
    10, 10, 5, 10, '2022-02-11 18:00:00', 44144);

-- RESULTS INSERTIONS --
insert into football.results (match_id, home_no, away_no)  values(1, 1, 0);
insert into football.results (match_id, home_no, away_no)  values(2, 2, 1);
insert into football.results (match_id, home_no, away_no)  values(3, 3, 1);
insert into football.results (match_id, home_no, away_no)  values(4, 3, 3);
insert into football.results (match_id, home_no, away_no)  values(5, 0, 4);

insert into football.results (match_id, home_no, away_no)  values(6, 2, 0);
insert into football.results (match_id, home_no, away_no)  values(7, 4, 1);
insert into football.results (match_id, home_no, away_no)  values(8, 1, 3);
insert into football.results (match_id, home_no, away_no)  values(9, 5, 2);
insert into football.results (match_id, home_no, away_no)  values(10, 1, 1);

-- SCORES INSERTIONS --
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(1, 1, 1, 11, 1, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(2, 1, 1, 7, 0, 1);

insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(3, 2, 3, 33, 2, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(4, 2, 3, 30, 0, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(5, 2, 3, 29, 0, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(6, 2, 4, 44, 1, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(7, 2, 4, 43, 0, 1);

insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(8, 3, 5, 55, 1, 2);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(9, 3, 5, 54, 1, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(10, 3, 5, 53, 1, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(11, 3, 6, 65, 1, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(12, 3, 6, 66, 0, 1);

insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(13, 4, 7, 75, 2, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(14, 4, 7, 76, 1, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(15, 4, 7, 77, 0, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(16, 4, 8, 87, 1, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(17, 4, 8, 88, 2, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(18, 4, 8, 85, 0, 2);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(19, 4, 8, 83, 0, 1);

insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(20, 5, 10, 106, 1, 3);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(21, 5, 10, 105, 1, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(22, 5, 10, 110, 1, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(23, 5, 10, 108, 1, 0);

insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(24, 6, 2, 22, 2, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(25, 6, 2, 18, 0, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(26, 6, 2, 19, 0, 1);

insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(27, 7, 3, 33, 2, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(28, 7, 3, 31, 1, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(29, 7, 3, 32, 1, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(30, 7, 3, 30, 0, 2);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(31, 7, 1, 11, 1, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(32, 7, 1, 8, 0, 1);

insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(33, 8, 8, 86, 1, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(34, 8, 8, 88, 1, 2);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(35, 8, 8, 87, 1, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(36, 8, 6, 64, 1, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(37, 8, 6, 63, 0, 1);

insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(38, 9, 7, 76, 2, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(39, 9, 7, 75, 2, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(40, 9, 7, 77, 1, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(41, 9, 7, 70, 0, 2);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(42, 9, 7, 71, 0, 2);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(43, 9, 7, 72, 0, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(44, 9, 9, 99, 2, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(45, 9, 9, 95, 0, 2);

insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(46, 10, 10, 110, 1, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(47, 10, 10, 107, 0, 1);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(48, 10, 5, 55, 1, 0);
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(49, 10, 5, 51, 0, 1);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- //////////////////////////////////////////////////////
--                   CHECKPOINT 5
--        UPDATE, SELECT, INSERT, DELETE queries
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- [CRUD] = {Create, Read, Update, Delete}
-- SQL equivalents:
-- [Create] : 	INSERT
-- [Read] 	: 	SELECT
-- [Update] : 	UPDATE
-- [Delete] : 	DELETE

-- ==================== Select =========================
select * from football.stadiums;
select * from football.teams;
select * from football.players;
select * from football.players_contract;
select * from football.matches;
select * from football.results;
select * from football.scores;

-- ==================== Update =========================
update football.players
    set player_nm = 'Phil Foden', kit_no = 47, country_desc = 'England'
where player_id = 109;
select * from football.players where player_id = 109;

/*
+---------+-------+----------+------+-------------+------------+
|player_id|team_id|player_nm |kit_no|position_desc|country_desc|
+---------+-------+----------+------+-------------+------------+
|109      |10     |Phil Foden|47    |Forward      |England     |
+---------+-------+----------+------+-------------+------------+
 */

update football.players_contract
    set come_from_team_desc = 'Manchester City Academy',
        subscription_dt = '2016-12-05', contract_end_dt = '2027-03-24'
where player_id = 109;
select * from football.players_contract where player_id = 109;

/*
+---------+-----------------------+---------------+---------------+
|player_id|come_from_team_desc    |subscription_dt|contract_end_dt|
+---------+-----------------------+---------------+---------------+
|109      |Manchester City Academy|2016-12-05     |2027-03-24     |
+---------+-----------------------+---------------+---------------+
 */

-- ==================== Insert and Delete =========================
delete from football.scores where score_id = 49;
insert into football.scores (score_id, match_id, team_id, player_id, goals_no, assists_no) values(49, 10, 5, 52, 0, 1);
select * from football.scores;

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

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- //////////////////////////////////////////////////////
--                         INDEX
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

create index if not exists players_index on football.players(player_id);
create index if not exists team_index on football.teams(team_id);
/*
 Индексы - это специальные объекты базы данных, предназначенные в основном для ускорения доступа к данным.
Я индексировал player_id, так как в каждой команде по 11 игроков, то у нас большое количество объём данных и для
ускорения доступа к данным это является весьма важным. Я ещё индексировал team_id так, как она связана 3 сущностями,
для быстрой связи между данными оно тоже является важным. Так как это вспомогательные структуры, то любой индекс можно
удалить и восстановить заново по информации в таблице.
 */

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
