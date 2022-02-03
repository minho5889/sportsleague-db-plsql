-- *************************************************
-- Group Name: 
----------------------------------------------------
-- Student Name: B P
-- Student Name: C J
-- Student Name: Minho Lee

--EXCEPTION (errcode)
-- -1 : NO_DATA_FOUND
-- -2 : TOO_MANY_ROWS
-- -3 : OTHERS
-- -4 : Not in condition
--------------------------------------------------
SET SERVEROUTPUT ON;
-------------------------------------------------------------------[Q1. Table: Games - CRUD]
--------------------------------------------------
-- Q1.
-- Table1 : Games | Create 
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spGamesInsert(
    gameid out number,
    divid in number,
    gamenum in number,
    gamedatetime in date,
    hometeam in number,
    homescore in number,
    visitteam in number,
    visitscore in number,
    locationid in number,
    isplayed in number,
    notes in varchar2,
    errcode out number
)AS 
BEGIN     
    INSERT INTO games
            VALUES (null, divid, gamenum, gamedatetime, hometeam, homescore, visitteam, visitscore, locationid, isplayed, notes);
            
    SELECT g.gameid
        INTO gameid
    FROM games g
    WHERE rownum = 1
    ORDER BY gameid DESC;             
    commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spGamesInsert;
--------------------------------------------------
-- Q1.
-- Table1 : Games | Select
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spGamesSelect (
    gameid_ in out number,
    divid out number,
    gamenum out number,
    gamedatetime out date,
    hometeam out number,
    homescore out number,
    visitteam out number,
    visitscore out number,
    locationid out number,
    isplayed out number,
    notes out varchar2,    
    errcode in out varchar2
) AS
BEGIN
     SELECT gameid, divid, gamenum, gamedatetime, hometeam, homescore, visitteam, visitscore, locationid, isplayed, notes
        INTO gameid_, divid, gamenum, gamedatetime, hometeam, homescore, visitteam, visitscore, locationid, isplayed, notes
    FROM games
    WHERE gameid = gameid_;    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spGamesSelect;
--------------------------------------------------
-- Q1.
-- Table1 : Games | Update
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spGamesUpdate (
    gameid_ IN NUMBER,
    divid_ NUMBER,
    gamenum_ NUMBER,
    gamedatetime_ date,
    hometeam_ NUMBER,
    homescore_ NUMBER,
    visitteam_ NUMBER,
    visitscore_ NUMBER,
    locationid_ NUMBER,
    isplayed_ NUMBER,
    notes_ VARCHAR2,
    errcode OUT NUMBER
) AS
   cnt number := 0;
BEGIN
    SELECT count(*) INTO cnt
    FROM games
    WHERE gameid = gameid_; 
    
    IF cnt = 1 THEN
    UPDATE games
        SET divid=divid_, 
            gamenum=gamenum_, 
            gamedatetime=gamedatetime_, 
            hometeam=hometeam_, 
            homescore=homescore_,
            visitteam=visitteam_,
            visitscore=visitscore_,
            locationid=locationid_,
            isplayed=isplayed_, 
            notes=notes_
        WHERE gameid = gameid_;
    ELSE
      errcode := -1;
    END IF;
    commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spGamesUpdate;
--------------------------------------------------
-- Q1.
-- Table1 : Games | Delete
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spGamesDelete(
    gameid_ in number,
    errcode in out number
) AS
    cnt number := 0;
BEGIN
    --check how many data in db
    SELECT count(*) INTO cnt
    FROM games
    WHERE gameid = gameid_; 
    
    IF cnt = 1 THEN
        DELETE FROM games
        WHERE gameid = gameid_;
    ELSE
        errcode := -1;
    END IF;    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spGamesDelete;
-------------------------------------------------------------------[Q1. Table: GoalScorers - CRUD]
--------------------------------------------------
-- Q1.
-- Table1 : GoalScorers | Create
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spGoalscorersInsert(
    goalid in out number,
    gameid in number,
    playerid in number,
    teamid in number,
    numgoals in number,
    numassists in number,
    errcode out number
)AS 
BEGIN     
    INSERT INTO Goalscorers
        VALUES (null, gameid, playerid, teamid, numgoals, numassists);
        
    SELECT g.goalid
        INTO goalid
    FROM goalscorers g
    WHERE rownum = 1
    ORDER BY goalid DESC;
    commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spGoalscorersInsert;
--------------------------------------------------
-- Q1.
-- Table2 : GoalScorers | Select
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spGoalscorersSelect (
    goalid_ in out number,
    gameid out number,
    playerid out number,
    teamid out number,
    numgoals out number,
    numassists out number,
    errcode in out varchar2
) AS
BEGIN
     SELECT goalid, gameid, playerid, teamid, numgoals, numassists
        INTO goalid_, gameid, playerid, teamid, numgoals, numassists
    FROM goalscorers
    WHERE goalid = goalid_; 

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spGoalscorersSelect;
--------------------------------------------------
-- Q1.
-- Table2 : GoalScorers | Update
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spGoalscorersUpdate (
    goal_id IN NUMBER,
    game_id NUMBER,
    player_id NUMBER,
    team_id NUMBER,
    numgoals_ NUMBER,
    numassists_ NUMBER,
    errcode OUT NUMBER
    )AS
    cnt number := 0;
BEGIN
    SELECT count(*) INTO cnt
    FROM goalScorers
    WHERE goalid = goal_id;

    IF cnt = 1 THEN
        UPDATE goalscorers 
        SET gameid=game_id, playerid=player_id, 
            teamid=team_id, numgoals=numgoals_, numassists=numassists_
        WHERE goalid=goal_id;
    ELSE
        errcode := -1;
    END IF;
    commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spGoalscorersUpdate;
--------------------------------------------------
-- Q1.
-- Table2 : GoalScorers | Delete
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spGoalscorersDelete(
    goalid_ in number,
    errcode in out number
) AS
    cnt number := 0;
BEGIN
    --check how many data in db
    SELECT count(*) INTO cnt
    FROM goalscorers
    WHERE goalid = goalid_;
    
    IF cnt = 1 THEN
        DELETE FROM goalscorers 
        WHERE goalid = goalid_;
    ELSE
        errcode := -1;
    END IF;    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spGoalscorersDelete;
-------------------------------------------------------------------[Q1. Table: Players - CRUD]
--------------------------------------------------
-- Q1.
-- Table3 : Players | Create
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spPlayersInsert(
    playerid in out number,
    regnumber in varchar2,
    lastname in varchar2,
    firstname in varchar2,
    isactive in number,
    errcode out number
)AS 
BEGIN     
    INSERT INTO players
        VALUES (playerid, regnumber, lastname, firstname, isactive);
    commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN TOO_MANY_ROWS THEN
        errcode := -2;
    WHEN OTHERS THEN
        errcode := -3;
END spPlayersInsert;
--------------------------------------------------
-- Q1.
-- Table3 : Players | Select
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spPlayersSelect (
    playerid_ in out number,
    regnumber out varchar2,
    lastname out varchar2,
    firstname out varchar2,
    isactive out number,
    errcode in out varchar2
) AS
BEGIN
     SELECT playerid, regnumber, lastname, firstname, isactive
        INTO playerid_, regnumber, lastname, firstname, isactive
    FROM players
    WHERE playerid = playerid_;  
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spPlayersSelect;
--------------------------------------------------
-- Q1.
-- Table3 : Players | Update
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spPlayersUpdate (
    playerid_ in number,
    regnumber_ in varchar2,
    lastname_ in varchar2,
    firstname_ in varchar2,
    isactive_ in number,
    errcode out varchar2    
)AS
    cnt number := 0;
BEGIN
    --check how many data in db
    SELECT count(*)INTO cnt
    FROM players
    WHERE playerid = playerid_;

    IF cnt = 1 THEN
        UPDATE players
            SET regnumber = regnumber_,
                lastname = lastname_,
                firstname = firstname_,
                isactive = isactive_
            WHERE playerid = playerid_;
        commit;
    ELSE 
        errcode := -1;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spPlayersUpdate;
--------------------------------------------------
-- Q1.
-- Table3 : Players | Delete
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spPlayersDelete(
    playerid_ in number,
    errcode out number
) AS
    cnt number := 0;
BEGIN
    --check how many data in db
    SELECT count(*) INTO cnt
    FROM players
    WHERE playerid = playerid_;
    
    IF cnt = 1 THEN
        DELETE FROM players
        WHERE playerid = playerid_;
        errcode := 0;
    ELSE
        errcode := -1;
    END IF;    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spPlayersDelete;
-------------------------------------------------------------------[Q1. Table: Teams - CRUD]
CREATE OR REPLACE PROCEDURE spTeamsInsert(
    teamid in out number,
    teamname in varchar2,
    isactive in number,
    jerseycolour in varchar2,
    errcode out number
)AS 
BEGIN     
    INSERT INTO teams
            VALUES (teamid, teamname, isactive, jerseycolour);
            
    SELECT t.teamid
        INTO teamid
    FROM teams t
    WHERE rownum = 1
    ORDER BY teamid DESC;
    commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN TOO_MANY_ROWS THEN
        errcode := -2;
    WHEN OTHERS THEN
        errcode := -3;
END spTeamsInsert;
--------------------------------------------------
-- Q1.
-- Table4 : Teams | Select
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spTeamsSelect (
    teamid_ in out number,
    teamname out varchar2,
    isactive out number,
    jerseycolour out varchar2,
    errcode in out varchar2
) AS
BEGIN
     SELECT teamid, teamname, isactive, jerseycolour
        INTO teamid_, teamname, isactive, jerseycolour
    FROM teams
    WHERE teamid = teamid_;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spTeamsSelect;
--------------------------------------------------
-- Q1.
-- Table4 : Teams | Update
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spTeamsUpdate (
    teamid_ in number,
    teamname_ in varchar2,
    isactive_ in number,
    jerseycolour_ in varchar2,
    errcode out varchar2    
)AS
    cnt number := 0;
BEGIN
    --check how many data in db
    SELECT count(*)INTO cnt
    FROM teams
    WHERE teamid = teamid_;

    IF cnt = 1 THEN
        UPDATE teams 
            SET teamname = teamname_,
                isactive = isactive_,
                jerseycolour = jerseycolour_
            WHERE teamid = teamid_;
        commit;
    ELSE 
        errcode := -1;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spTeamsUpdate;
--------------------------------------------------
-- Q1.
-- Table4 : Teams | Delete
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spTeamsDelete(
    teamid_ in number,
    errcode in out number
) AS
    cnt number := 0;
BEGIN
    --check how many data in db
    SELECT count(*) INTO cnt
    FROM teams
    WHERE teamid = teamid_;
    
    IF cnt = 1 THEN
        DELETE FROM teams 
        WHERE teamid = teamid_;
    ELSE
        errcode := -1;
    END IF;    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spTeamsDelete;
-------------------------------------------------------------------[Q1. Table: 	Rosters - CRUD]
--------------------------------------------------
-- Q1.
-- Table5 : Rosters | Create 
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spRostersInsert(
    rosterid in out number,    
    playerid in number,
    teamid in number,
    isactive in number,
    jerseynumber in number,
    errcode out number
)AS 
BEGIN     
    INSERT INTO rosters
        VALUES (null, playerid, teamid, isactive, jerseynumber);
        
    SELECT r.rosterid
        INTO rosterid
    FROM rosters r
    WHERE rownum = 1
    ORDER BY rosterid DESC;
    commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spRostersInsert;
--------------------------------------------------
-- Q1.
-- Table5 : Rosters | Select
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spRostersSelect (
    rosterid_ in out number,
    playerid out number,
    teamid out number,
    isactive out number,
    jerseynumber out number,
    errcode in out varchar2
) AS
BEGIN
     SELECT rosterid, playerid, teamid, isactive, jerseynumber
        INTO rosterid_, playerid, teamid, isactive, jerseynumber
    FROM rosters
    WHERE rosterid = rosterid_;    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spRostersSelect;
--------------------------------------------------
-- Q1.
-- Table5 : Rosters | Update
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spRostersUpdate (
    rosterid_ in number,
    playerid_ in number,
    teamid_ in number,
    isactive_ in number,
    jerseynumber_ in number,
    errcode out varchar2    
)AS
    cnt number := 0;
BEGIN
    --check how many data in db
    SELECT count(*)INTO cnt
    FROM rosters
    WHERE rosterid = rosterid_;

    IF cnt = 1 THEN
        UPDATE rosters
            SET playerid = playerid_,
                teamid = teamid_,
                isactive = isactive_,
                jerseynumber = jerseynumber_
            WHERE rosterid = rosterid_;
        commit;
    ELSE 
        errcode := -1;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spRostersUpdate;
--------------------------------------------------
-- Q1.
-- Table5 : Rosters | Delete
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spRostersDelete(
    rosterid_ in number,
    errcode in out number
) AS
    cnt number := 0;
BEGIN
    --check how many data in db
    SELECT count(*) INTO cnt
    FROM rosters
    WHERE rosterid = rosterid_;
    
    IF cnt = 1 THEN
        DELETE FROM rosters 
        WHERE rosterid = rosterid_;
    ELSE
        errcode := -1;
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spRostersDelete;
-------------------------------------------------------------------[Q1. Table: slLocations - CRUD]
--------------------------------------------------
-- Q1.
-- Table6 : SlLocations | Create
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spSllocationsInsert(
    locationid in out number,
    locationname in varchar2,
    fieldlength in number,
    isactive in number,
    errcode out number
)AS 
BEGIN     
    IF fieldlength BETWEEN 90 AND 110 THEN
        INSERT INTO sllocations
            VALUES (locationid, locationname, fieldlength, isactive);
        ELSE
            errcode := -4;
    END IF;
    commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN TOO_MANY_ROWS THEN
        errcode := -2;
    WHEN OTHERS THEN
        errcode := -3;
END spSllocationsInsert;
--------------------------------------------------
-- Q1.
-- Table6 : SlLocations | Select
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spSllocationsSelect (
    locationid_ in out number,
    locationname out varchar2,
    fieldlength out number,
    isactive out number,
    errcode in out varchar2
) AS
BEGIN
     SELECT locationid, locationname, fieldlength, isactive
        INTO locationid_, locationname, fieldlength, isactive
    FROM sllocations
    WHERE locationid = locationid_;    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spSllocationsSelect;
--------------------------------------------------
-- Q1.
-- Table6 : SlLocations | Update
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spSllocationsUpdate (
    locationid_ in number,
    locationname_ in varchar2,
    fieldlength_ in number,
    isactive_ in number,
    errcode out varchar2    
)AS
    cnt number := 0;
BEGIN
    --check how many data in db
    SELECT count(*)INTO cnt
    FROM sllocations
    WHERE locationid = locationid_;

    IF fieldlength_ BETWEEN 90 AND 110 THEN
        IF cnt = 1 THEN
            UPDATE sllocations
                SET locationname = locationname_,
                    fieldlength = fieldlength_,
                    isactive = isactive_
                WHERE locationid = locationid_;
            commit;
        ELSE 
            errcode := -1;
        END IF;
    ELSE
        errcode := -4;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spSllocationsUpdate;
--------------------------------------------------
-- Q1.
-- Table6 : SlLocations | Delete
--------------------------------------------------
CREATE OR REPLACE PROCEDURE spSllocationsDelete(
    locationid_ in number,
    errcode out number
) AS
    cnt number := 0;
BEGIN
    --check how many data in db
    SELECT count(*) INTO cnt
    FROM sllocations
    WHERE locationid = locationid_;
    
    IF cnt = 1 THEN
        DELETE FROM sllocations
        WHERE locationid = locationid_;
    ELSE
        errcode := -1;
    END IF;    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spSllocationsDelete;
----------------------------------------------------------------------------------------
-------------------------------------------------------------------[Q2. Table: Games]
CREATE OR REPLACE PROCEDURE spGamesSelectAll (
    errcode out number
)AS
    cgames games%ROWTYPE;
    CURSOR c IS
        SELECT * FROM games;
BEGIN
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('GameID  DivID  GameNum  GameDateTime  HomeTeam  HomeScore  VisitTeam  VisitScore  LocationID  IsPlayed  Notes');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------------------------------------');
    OPEN c;
        LOOP
            FETCH c INTO cgames;
                DBMS_OUTPUT.PUT_LINE(
                                    RPAD(cgames.gameid, 8)||
                                    RPAD(cgames.divid, 7)||
                                    RPAD(cgames.gamenum, 9)||
                                    RPAD(cgames.gamedatetime, 14)||
                                    RPAD(cgames.hometeam, 10)||
                                    RPAD(cgames.homescore, 11)||
                                    RPAD(cgames.visitteam, 11)||
                                    RPAD(cgames.visitscore, 12)||
                                    RPAD(cgames.locationid, 12)||
                                    RPAD(cgames.isplayed, 10)||
                                    RPAD(nvl(cgames.notes, 'Not Given'), 50)
                                    );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
    CLOSE c;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spGamesSelectAll ;
-------------------------------------------------------------------[Q2. Table: GoalScorers]
CREATE OR REPLACE PROCEDURE spGoalScorersSelectAll (
    errcode out number
)AS
    cgoalscorers goalScorers%ROWTYPE;
    CURSOR c IS
        SELECT * FROM goalScorers;
BEGIN
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('GoalID  GameID  PlayerID  TeamID  NumGoals  NumAssists');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
    OPEN c;
        LOOP
            FETCH c INTO cgoalscorers;
                DBMS_OUTPUT.PUT_LINE(
                                    RPAD(cgoalscorers.goalid, 8)||
                                    RPAD(cgoalscorers.gameid, 8)||
                                    RPAD(cgoalscorers.playerid, 10)||
                                    RPAD(cgoalscorers.teamid, 8)||
                                    RPAD(cgoalscorers.numgoals, 10)||
                                    RPAD(cgoalscorers.numassists, 12)
                                    );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
    CLOSE c;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spGoalScorersSelectAll;
-------------------------------------------------------------------[Q2. Table: Players]
CREATE OR REPLACE PROCEDURE spPlayersSelectAll (
    errcode out number
)AS
    cplayers players%ROWTYPE;
    CURSOR c IS
        SELECT * FROM players;
BEGIN
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('PlayerID  RegNumber  LastName                 FirstName                IsActive');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
    OPEN c;
        LOOP
            FETCH c INTO cplayers;
                DBMS_OUTPUT.PUT_LINE(
                                    RPAD(cplayers.playerid, 10)||
                                    RPAD(cplayers.regnumber, 11)||
                                    RPAD(cplayers.lastname, 25)||
                                    RPAD(cplayers.firstname, 25)||
                                    RPAD(cplayers.isactive, 10)
                                    );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
    CLOSE c;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spPlayersSelectAll;
-------------------------------------------------------------------[Q2. Table: Teams]
CREATE OR REPLACE PROCEDURE spTeamsSelectAll (
    errcode out number
)AS
    cteams teams%ROWTYPE;
    CURSOR c IS
        SELECT * FROM teams;
BEGIN
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('TeamID  TeamName  IsActive  JerseyColour');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    OPEN c;
        LOOP
            FETCH c INTO cteams;
                DBMS_OUTPUT.PUT_LINE(
                                    RPAD(cteams.teamid, 8)||
                                    RPAD(cteams.teamname, 10)||
                                    RPAD(cteams.isactive, 10)||
                                    RPAD(cteams.jerseycolour, 14)
                                    );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
    CLOSE c;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spTeamsSelectAll;
-------------------------------------------------------------------[Q2. Table: Rosters]
CREATE OR REPLACE PROCEDURE spRostersSelectAll (
    errcode out number
)AS
    crosters rosters%ROWTYPE;
    CURSOR c IS
        SELECT * FROM rosters;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('RosterID  PlayerID  TeamID  IsActive  JerseyNumber');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    OPEN c;
        LOOP
            FETCH c INTO crosters;
                DBMS_OUTPUT.PUT_LINE(
                                    RPAD(crosters.rosterid, 10)||
                                    RPAD(crosters.playerid, 10)||
                                    RPAD(crosters.teamid, 8)||
                                    RPAD(crosters.isactive, 10)||
                                    RPAD(crosters.jerseynumber, 14)
                                    );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
    CLOSE c;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spRostersSelectAll;
-------------------------------------------------------------------[Q2. Table: slLocations]
CREATE OR REPLACE PROCEDURE spslLocationsSelectAll (
    errcode out number
)AS
    cslLocations slLocations%ROWTYPE;
    CURSOR c IS
        SELECT * FROM slLocations;
BEGIN
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('LocationID  LocationName                                      FieldLength  IsActive');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------------');
    OPEN c;
        LOOP
            FETCH c INTO cslLocations;
                DBMS_OUTPUT.PUT_LINE(
                                    RPAD(cslLocations.locationid, 12)||
                                    RPAD(cslLocations.locationname, 50)||
                                    RPAD(cslLocations.fieldlength, 13)||
                                    RPAD(cslLocations.isactive, 10)
                                    );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
    CLOSE c;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spslLocationsSelectAll;
----------------------------------------------------------------------------------------
-------------------------------------------------------------------[Q3. view: vwPlayerRosters]
CREATE OR REPLACE VIEW vwPlayerRosters  AS
    SELECT p.playerid, 
        regnumber, 
        lastname, 
        firstname, 
        jerseynumber, 
        t.teamid, 
        teamname, 
        jerseycolour, 
        p.isactive
  FROM players p INNER JOIN rosters r ON p.playerid=r.playerid
      INNER JOIN teams t ON r.teamid=t.teamid;
-------------------------------------------------------------------[Q4. sp: spTeamRosterByID]
CREATE OR REPLACE PROCEDURE spTeamRosterByID (
    tid in number,
    errcode out number
)AS
    playerid vwPlayerRosters.playerid%type;
    lastname vwPlayerRosters.lastname%type;
    firstname vwPlayerRosters.firstname%type;
CURSOR c IS
    SELECT playerid, lastname, firstname
    FROM vwPlayerRosters v
    WHERE v.teamid = tid;    
BEGIN
    OPEN c;
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('TeamID  PlayerID  LastName                 FirstName');
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
        LOOP
            FETCH c INTO playerid, lastname, firstname;
            EXIT WHEN c%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(
                                RPAD(tid, 8)|| 
                                RPAD(playerid, 10)|| 
                                RPAD(lastname,25)||
                                RPAD(firstname,25)
                                );
        END LOOP;
    CLOSE c;    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;    
END spTeamRosterByID;
-------------------------------------------------------------------[Q5. sp: spTeamRosterByName]
CREATE OR REPLACE PROCEDURE spTeamRosterByName (
    tname in varchar2,
    errcode out number
) AS
    teamname varchar2(10);
    playerid number;
    lastname varchar2(25);
    firstname varchar2(25);
    
    CURSOR c IS
        SELECT teamname, playerid, lastname, firstname
        FROM vwPlayerRosters
        WHERE UPPER(teamname) LIKE ('%'||UPPER(tname)||'%');
BEGIN
    OPEN c;
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('TeamName  PlayerID  LastName                 FirstName');
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
        LOOP
            FETCH c INTO teamname, playerid, lastname, firstname;
            DBMS_OUTPUT.PUT_LINE(
                                 RPAD(teamname, 10)||
                                 RPAD(playerid, 10)||
                                 RPAD(lastname,25)||
                                 RPAD(firstname,25)
                                 );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
    CLOSE c;    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3; 
END spTeamRosterByName;
-------------------------------------------------------------------[Q6. vw: vwTeamsNumPlayers]
CREATE OR REPLACE VIEW vwTeamsNumPlayers AS
SELECT
    r.teamid AS teamid,
    COUNT(r.playerid) AS numPlayers
FROM rosters r
    INNER JOIN players p ON r.playerid = p.playerid 
WHERE r.isactive = 1
GROUP BY r.teamid
ORDER BY r.teamid;
-------------------------------------------------------------------[Q7. fnc: fncNumPlayersByTeamID]
CREATE OR REPLACE FUNCTION fncNumPlayersByTeamID (tid number) RETURN number IS
    nPlayers number;
BEGIN
    SELECT v.numPlayers
        INTO nPlayers
    FROM vwTeamsNumPlayers v
    WHERE v.teamid = tid;    
    RETURN nPlayers;    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        nPlayers := -1;
        RETURN nPlayers;
    WHEN OTHERS THEN
        nPlayers := -3;
        RETURN nPlayers;
END fncNumPlayersByTeamID;
-------------------------------------------------------------------[Q8. vw: vwSchedule]
CREATE OR REPLACE VIEW vwSchedule AS
SELECT 
    g.gameid, 
    g.gamedatetime, 
    ht.teamname AS hometeam,
    g.homescore, 
    vt.teamname AS visitteam,
    g.visitscore, 
    l.locationname
FROM games g
    INNER JOIN sllocations l ON l.locationid = g.locationid
    LEFT OUTER JOIN teams ht ON ht.teamid = g.hometeam
    LEFT OUTER JOIN teams vt ON vt.teamid = g.visitteam
ORDER BY gameid;
-------------------------------------------------------------------[Q9. sp: spSchedUpcomingGames]
CREATE OR REPLACE PROCEDURE spSchedUpcomingGames (
    ndays in number,
    errcode out number
) AS
    --curdate date := '2021-11-01'; --sysdate
    upcomingdate date := sysdate + ndays;
    gamedatetime date;
    hometeam varchar2(10);
    visitteam varchar2(10);
    locationname varchar2(50);
    
    CURSOR c IS
        SELECT 
            gamedatetime, 
            hometeam, 
            visitteam, 
            locationname
        FROM vwSchedule
        WHERE gamedatetime BETWEEN sysdate AND upcomingdate
        ORDER BY gamedatetime;
BEGIN 
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('GameDateTime  HomeTeam  VisitTeam  LocationName');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
    OPEN c;
        LOOP
            FETCH c INTO gamedatetime, hometeam, visitteam, locationname;
                DBMS_OUTPUT.PUT_LINE(
                                    RPAD(gamedatetime, 14)||
                                    RPAD(hometeam, 10)||
                                    RPAD(visitteam, 11)||
                                    RPAD(locationname, 14)
                                    );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
    CLOSE c;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spSchedUpcomingGames;
-------------------------------------------------------------------[Q10. sp: spSchedPastGames]
CREATE OR REPLACE PROCEDURE spSchedPastGames (
    ndays in number,
    errcode out number
) AS
    --curdate date := '2021-11-01'; --sysdate
    pastdate date := sysdate - ndays;
    gamedatetime date;
    hometeam varchar2(10);
    visitteam varchar2(10);
    locationname varchar2(50);
    
    CURSOR c IS
        SELECT 
            gamedatetime, 
            hometeam, 
            visitteam, 
            locationname
        FROM vwSchedule
        WHERE gamedatetime BETWEEN pastdate AND sysdate
        ORDER BY gamedatetime DESC;
BEGIN 
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('GameDateTime  HomeTeam  VisitTeam  LocationName');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
    OPEN c;
        LOOP
            FETCH c INTO gamedatetime, hometeam, visitteam, locationname;
                DBMS_OUTPUT.PUT_LINE(
                                    RPAD(gamedatetime, 14)||
                                    RPAD(hometeam, 10)||
                                    RPAD(visitteam, 11)||
                                    RPAD(locationname, 50)
                                    );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
    CLOSE c;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        errcode := -1;
    WHEN OTHERS THEN
        errcode := -3;
END spSchedPastGames;
----------------------------------------------------------------------------------------
-------------------------------------------------------------------[Q11. fnc: fncWinningRateByTeam]
CREATE OR REPLACE FUNCTION fncWinningRateByTeam (tname varchar2) RETURN number IS
    winAtHome number := 0;
    winAtVisit number := 0;
    totalWins number := 0;

    loseAtHome number := 0;
    loseAtVisit number := 0;
    totalLoses number := 0;
    
    totalgames number := totalWins + totalLoses;
    rate number := 0;
BEGIN
    
    -- calculate wins
    SELECT count(homescore)
        INTO winAtHome
    FROM vwSchedule
    WHERE TRIM(UPPER(hometeam)) = TRIM(UPPER(tname))
        AND homescore > visitscore;
    
    SELECT count(visitscore)
        INTO winAtVisit
    FROM vwSchedule 
    WHERE TRIM(UPPER(visitteam)) = TRIM(UPPER(tname))
        AND visitscore > homescore;
    totalWins := winAtHome + winAtVisit;
    
    -- calculate loses (including evens)
    SELECT count(homescore)
        INTO loseAtHome
    FROM vwSchedule
    WHERE TRIM(UPPER(hometeam)) = TRIM(UPPER(tname))
        AND homescore <= visitscore;
    
    SELECT count(visitscore)
        INTO loseAtVisit
    FROM vwSchedule 
    WHERE TRIM(UPPER(visitteam)) = TRIM(UPPER(tname))
        AND visitscore <= homescore;
    totalLoses := loseAtHome + loseAtVisit;
       
    -- calculate rate (totalwins/totalgames)
    rate := (totalWins / (totalWins + totalLoses)) * 100;
    RETURN ROUND(rate, 2);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        rate := -1;
        RETURN rate;
    WHEN OTHERS THEN
        rate := -3;
        RETURN rate;
END fncWinningRateByTeam;
--------------------------------------------------------------
-- end of file
--------------------------------------------------------------