------------------------------------------------------------------
--------------------- BEISPIELHAFTE ABFRAGEN ---------------------
------------------------------------------------------------------

-- Email aller Infizierte Personen 
SELECT email AS Email_Infizierter_Personen FROM Person p JOIN Infizierte i ON p.person_id=i.person_id WHERE email IS NOT NULL;

-- Übersicht der Personen geordnet nach Infektionsrisiko inklusive Alter
SELECT person_id, vorname, nachname, gebDat As Geburtsdatum, TRUNC(months_between(sysdate, gebDat) / 12)
AS "Alter", email, wohnort, inf_risiko AS Infektionsrisiko
FROM Person
ORDER BY inf_risiko DESC;

-- Sportler mit Sportart
SELECT p.vorname, p.nachname, sa.bezeichnung
FROM Person p, Sportart sa, Sportler s
WHERE p.person_id=s.person_id AND s.sport_id=sa.sport_id;

-- Vorerkrankte mit Krankheit
SELECT p.vorname, p.nachname, k.krankBeschreibung
FROM Person p, Vorerkrankte v, Krankheit k
WHERE p.person_id=v.person_id AND v.krankheit_id=k.krankheit_id;

-- Haustierbesitzer mit Anzahl der Haustiere
SELECT p.vorname, p.nachname, h.tierart, COUNT(hb.haustier_id) anzahl
FROM Person p, Haustier h, Haustierbesitzer hb
WHERE p.person_id=hb.person_id AND h.haustier_id=hb.haustier_id GROUP BY p.vorname, p.nachname, h.tierart ORDER BY anzahl DESC;
