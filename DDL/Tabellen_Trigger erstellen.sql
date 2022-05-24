------------------------------------------------------------------
-------------------- TABELLEN/INDIZES LÖSCHEN --------------------
------------------------------------------------------------------

DROP INDEX i_person_1;
DROP TABLE Vorerkrankte;
DROP TABLE Krankheit;
DROP TABLE Haustierbesitzer;
DROP TABLE Haustier;
DROP TABLE Infizierte;
DROP TABLE Coronatyp;
DROP TABLE Coronatest;
DROP TABLE Sportler;
DROP TABLE Sportart;
DROP TABLE Person;

------------------------------------------------------------------
----------------------- TABELLEN ERSTELLEN -----------------------
------------------------------------------------------------------

CREATE TABLE Person (
     person_id		INTEGER		    NOT NULL
    ,vorname		VARCHAR(30)		NOT NULL
    ,nachname 		VARCHAR(30) 	NOT NULL
    ,gebDat		    DATE			NOT NULL
    ,email		    VARCHAR(30) 
    ,wohnort 		VARCHAR(30)     NOT NULL
    ,geschlecht		CHAR(1)		    NOT NULL
    ,inf_risiko     INTEGER         DEFAULT 0
);

ALTER TABLE Person ADD (
     CONSTRAINT pk_person_id PRIMARY KEY (person_id)
    ,CONSTRAINT cc_person_geschlecht CHECK (geschlecht IN ('m', 'w', 'd'))
    ,CONSTRAINT cc_person_email CHECK (email LIKE '__%@__%.__%') 
);

CREATE TABLE Sportart (
	 sport_id 		INTEGER	        NOT NULL
	,bezeichnung	VARCHAR(30)	    NOT NULL
	,teamsport		CHAR(1)	        NOT NULL
);

ALTER TABLE Sportart ADD (
    CONSTRAINT pk_sport_id PRIMARY KEY (sport_id)
);

CREATE TABLE Sportler (
	 person_id		INTEGER 	NOT NULL
	,sport_id		INTEGER	    NOT NULL
);

ALTER TABLE Sportler ADD (
     CONSTRAINT fk_sport_id_sportart FOREIGN KEY(sport_id) REFERENCES Sportart(sport_id)
    ,CONSTRAINT fk_person_id_person FOREIGN KEY(person_id)REFERENCES Person(person_id)
    ,CONSTRAINT uk_person_sportler UNIQUE (person_id, sport_id)
);


CREATE TABLE Coronatest (
	 test_id		INTEGER	    NOT NULL
    ,testDat		DATE		NOT NULL
    ,testOrt		VARCHAR(30)	NOT NULL
    ,kosten         NUMBER(4,2)
    ,aenderungsDat  DATE        NOT NULL
);

ALTER TABLE Coronatest ADD (
    CONSTRAINT pk_test_id PRIMARY KEY(test_id)
);

CREATE TABLE Coronatyp (
	 corona_id		INTEGER	    NOT NULL
	,virusMut		VARCHAR(30)
);

ALTER TABLE Coronatyp ADD (
    CONSTRAINT pk_corona_id PRIMARY KEY(corona_id)
);

CREATE TABLE Infizierte (
	person_id		INTEGER	    NOT NULL
	,corona_id		INTEGER	    NOT NULL
	,test_id		INTEGER	    NOT NULL
	,symptome		VARCHAR(30)
);

ALTER TABLE Infizierte ADD (
     CONSTRAINT fk_person_id_infizierte FOREIGN KEY(person_id) REFERENCES person(person_id)
    ,CONSTRAINT fk_corona_id_infizierte FOREIGN KEY (corona_id) REFERENCES coronatyp(corona_id)
    ,CONSTRAINT fk_test_id_infizierte FOREIGN KEY(test_id) REFERENCES coronatest(test_id)
    ,CONSTRAINT uk_person_inf_test_symp UNIQUE (person_id, corona_id, test_id, symptome)
    ,CONSTRAINT uk_person_test UNIQUE (test_id)
);

CREATE TABLE Haustier (
	 haustier_id    INTEGER     NOT NULL
	,tierart        VARCHAR(30) NOT NULL
);

ALTER TABLE Haustier ADD (
     CONSTRAINT pk_haustier_id PRIMARY KEY (haustier_id)
    ,CONSTRAINT uk_tierart_haustier UNIQUE (tierart)
);

CREATE TABLE Haustierbesitzer (
     person_id      INTEGER     NOT NULL
    ,haustier_id    INTEGER     NOT NULL
);

ALTER TABLE Haustierbesitzer ADD (
     CONSTRAINT fk_person_id_htbesitzer FOREIGN KEY(person_id) REFERENCES person(person_id)
    ,CONSTRAINT fk_haustier_id_htbesitzer FOREIGN KEY(haustier_id) REFERENCES haustier(haustier_id)
);

CREATE TABLE Krankheit (
	 krankheit_id		    INTEGER	    NOT NULL
	,krankBeschreibung		VARCHAR(50)	NOT NULL
);

ALTER TABLE Krankheit ADD (
     CONSTRAINT pk_krankheit_id PRIMARY KEY (krankheit_id)
    ,CONSTRAINT uk_krankBeschreibung_krankheit UNIQUE (krankBeschreibung)
);

CREATE TABLE Vorerkrankte (
	 person_id	    INTEGER	    NOT NULL
	,krankheit_id	INTEGER	    NOT NULL
);

ALTER TABLE Vorerkrankte ADD (
     CONSTRAINT fk_person_id_vorerkrankte FOREIGN KEY(person_id) REFERENCES person(person_id)
    ,CONSTRAINT fk_krankheit_id_vorerkrankte FOREIGN KEY(krankheit_id) REFERENCES Krankheit(krankheit_id)
    ,CONSTRAINT uk_person_krankheit UNIQUE (person_id, krankheit_id)
);

------------------------------------------------------------------
----------------------------- TRIGGER ----------------------------
------------------------------------------------------------------

-- INSERT/UPDATE TRIGGER SPORTLER --
CREATE OR REPLACE TRIGGER TRIG_Sportler_INS_UPD
    AFTER INSERT OR UPDATE OF person_id, sport_id ON Sportler
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
DECLARE
    istTeamsport char(1);
BEGIN
    SELECT teamsport INTO istTeamsport FROM Sportart WHERE :NEW.sport_id=Sportart.sport_id;
    IF istTeamsport = 'j'
    THEN
        UPDATE Person SET inf_risiko=inf_risiko+2 WHERE Person.person_id=:NEW.person_id;
    ELSE
        UPDATE Person SET inf_risiko=inf_risiko+1 WHERE Person.person_id=:NEW.person_id;
    END IF;
END;
/

-- INSERT/UPDATE TRIGGER Haustierbesitzer --
CREATE OR REPLACE TRIGGER TRIG_Haustierbesitzer_INS_UPD
    AFTER INSERT OR UPDATE OF person_id, haustier_id ON Haustierbesitzer
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    UPDATE Person SET inf_risiko=inf_risiko+1 WHERE Person.person_id=:NEW.person_id;
END;
/

-- INSERT TRIGGER CORONATEST DATUM --
CREATE OR REPLACE TRIGGER TRIG_Coronatest_INS
    BEFORE INSERT
    ON Coronatest
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    :NEW.testDat := SYSDATE;
    :NEW.aenderungsDat := SYSDATE;
END;
/

-- UPDATE TRIGGER CORONATEST DATUM --
CREATE OR REPLACE TRIGGER TRIG_Coronatest_UPD
    BEFORE UPDATE
    ON Coronatest
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    :NEW.aenderungsDat := SYSDATE-1;
END;
/