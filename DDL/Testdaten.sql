------------------------------------------------------------------
----------------------- TESTDATEN EINFÜGEN -----------------------
------------------------------------------------------------------

-- Person
INSERT INTO Person (person_id, vorname, nachname, gebDat, email, wohnort, geschlecht)
VALUES (1001, 'Peter', 'Fischer', to_date('05.06.2001', 'DD.MM.YYYY'), 'peter@fischer.gmx.com', 'Vaihingen', 'm');
INSERT INTO Person (person_id, vorname, nachname, gebDat, email, wohnort, geschlecht)
VALUES (1002, 'Anna', 'Müller', to_date('12.04.1997', 'DD.MM.YYYY'), 'anna.m97@gmail.com', 'Erdmannhausen', 'w');
INSERT INTO Person (person_id, vorname, nachname, gebDat, email, wohnort, geschlecht)
VALUES (1003, 'Marco', 'Polo', to_date('17.09.1970', 'DD.MM.YYYY'), 'm.polo@hotmail.de', 'Esslingen', 'm');
INSERT INTO Person (person_id, vorname, nachname, gebDat, email, wohnort, geschlecht)
VALUES (1004, 'Thomas', 'Müller', to_date('13.09.1989', 'DD.MM.YYYY'), 't.mul@t-online.de', 'Vaihingen', 'm');
INSERT INTO Person (person_id, vorname, nachname, gebDat, email, wohnort, geschlecht)
VALUES (1005, 'Mona', 'Lisa', to_date('01.01.2000', 'DD.MM.YYYY'), 'mona.lisa@gmx.com', 'Plochingen', 'w');
INSERT INTO Person (person_id, vorname, nachname, gebDat, email, wohnort, geschlecht)
VALUES (1006, 'Kim', 'Possible', to_date('29.11.1999', 'DD.MM.YYYY'), 'kim.possible@gmail.com', 'Böblingen', 'd');
INSERT INTO Person (person_id, vorname, nachname, gebDat, email, wohnort, geschlecht)
VALUES (1007, 'Joao', 'Silva', to_date('23.12.2008', 'DD.MM.YYYY'), NULL, 'Stuttgart', 'm');
INSERT INTO Person (person_id, vorname, nachname, gebDat, email, wohnort, geschlecht)
VALUES (1008, 'Ingrid', 'Schmidt', to_date('25.11.1960', 'DD.MM.YYYY'), NULL, 'Aichwald', 'w');

-- Sportart
INSERT INTO Sportart (sport_id, bezeichnung, teamsport) VALUES (2001, 'Fussball', 'j');
INSERT INTO Sportart (sport_id, bezeichnung, teamsport) VALUES (2002, 'Basketball', 'j');
INSERT INTO Sportart (sport_id, bezeichnung, teamsport) VALUES (2003, 'Einrad', 'n');
INSERT INTO Sportart (sport_id, bezeichnung, teamsport) VALUES (2004, 'Klettern', 'n');
INSERT INTO Sportart (sport_id, bezeichnung, teamsport) VALUES (2005, 'Angeln', 'n');

-- Sportler
INSERT INTO Sportler (person_id, sport_id) VALUES (1001, 2005);
INSERT INTO Sportler (person_id, sport_id) VALUES (1002, 2003);
INSERT INTO Sportler (person_id, sport_id) VALUES (1004, 2001);
INSERT INTO Sportler (person_id, sport_id) VALUES (1004, 2002);
INSERT INTO Sportler (person_id, sport_id) VALUES (1006, 2004);
INSERT INTO Sportler (person_id, sport_id) VALUES (1007, 2002);

-- Coronatest
INSERT INTO coronatest (test_id,testOrt,kosten) VALUES (3001, 'Vaihingen',29.99);
INSERT INTO coronatest (test_id,testOrt,kosten) VALUES (3002, 'Stuttgart',09.99);
INSERT INTO coronatest (test_id,testOrt,kosten) VALUES (3003, 'Aichwald',99.99);
INSERT INTO coronatest (test_id,testOrt,kosten) VALUES (3004, 'Esslingen',29.99);
INSERT INTO coronatest (test_id,testOrt,kosten) VALUES (3005, 'Erdmannhausen',85.99);

-- Coronatyp
INSERT INTO coronatyp (corona_id, virusMut) VALUES (4000,NULL);
INSERT INTO coronatyp (corona_id, virusMut) VALUES (4001,'alpha');
INSERT INTO coronatyp (corona_id, virusMut) VALUES (4002,'beta');
INSERT INTO coronatyp (corona_id, virusMut) VALUES (4003,'gamma');
INSERT INTO coronatyp (corona_id, virusMut) VALUES (4004,'delta');

-- Infizierte
INSERT INTO Infizierte (person_id, corona_id, test_id, symptome) VALUES (1004, 4004, 3001, 'Geruchsverlust');
INSERT INTO Infizierte (person_id, corona_id, test_id, symptome) VALUES (1007, 4001, 3002, NULL);
INSERT INTO Infizierte (person_id, corona_id, test_id, symptome) VALUES (1008, 4003, 3003, 'Atemnot');
INSERT INTO Infizierte (person_id, corona_id, test_id, symptome) VALUES (1003, 4000, 3004, NULL);
INSERT INTO Infizierte (person_id, corona_id, test_id, symptome) VALUES (1002, 4004, 3005, 'Geschmacksverlust');

-- Haustier
INSERT INTO Haustier (haustier_id, tierart)VALUES (5001, 'Hund');
INSERT INTO Haustier (haustier_id, tierart)VALUES (5002, 'Katze');
INSERT INTO Haustier (haustier_id, tierart)VALUES (5003, 'Fische');
INSERT INTO Haustier (haustier_id, tierart)VALUES (5004, 'Hase');

-- Haustierbesitzer
INSERT INTO Haustierbesitzer (person_id, haustier_id) VALUES (1002, 5001);
INSERT INTO Haustierbesitzer (person_id, haustier_id) VALUES (1004, 5003);
INSERT INTO Haustierbesitzer (person_id, haustier_id) VALUES (1007, 5004);
INSERT INTO Haustierbesitzer (person_id, haustier_id) VALUES (1008, 5002);
INSERT INTO Haustierbesitzer (person_id, haustier_id) VALUES (1008, 5002);
INSERT INTO Haustierbesitzer (person_id, haustier_id) VALUES (1008, 5002);
INSERT INTO Haustierbesitzer (person_id, haustier_id) VALUES (1008, 5002);
INSERT INTO Haustierbesitzer (person_id, haustier_id) VALUES (1008, 5002);
INSERT INTO Haustierbesitzer (person_id, haustier_id) VALUES (1008, 5002);
INSERT INTO Haustierbesitzer (person_id, haustier_id) VALUES (1008, 5002);

-- Krankheit
INSERT INTO Krankheit (krankheit_id, krankBeschreibung) VALUES (6001, 'Asthma');
INSERT INTO Krankheit (krankheit_id, krankBeschreibung) VALUES (6002, 'Hautkrebs');
INSERT INTO Krankheit (krankheit_id, krankBeschreibung) VALUES (6003, 'Adipositas');
INSERT INTO Krankheit (krankheit_id, krankBeschreibung) VALUES (6004, 'Diabetes');

-- Vorerkrankte
INSERT INTO Vorerkrankte (person_id, krankheit_id) VALUES (1002, 6001);
INSERT INTO Vorerkrankte (person_id, krankheit_id) VALUES (1004, 6003);
INSERT INTO Vorerkrankte (person_id, krankheit_id) VALUES (1008, 6002);

------------------------------------------------------------------
-------------------- TESTDATEN AKTUALISIEREN ---------------------
------------------------------------------------------------------

UPDATE Coronatest SET kosten=11.99 WHERE test_id=3001;
UPDATE Coronatest SET kosten=11.99 WHERE test_id=3002;

------------------------------------------------------------------
------------------------- INDEX ANLEGEN --------------------------
------------------------------------------------------------------

CREATE INDEX i_person_1 ON Person (vorname);