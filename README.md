# Gesundheitsamt-Corona-Management

- Agustin Crea
- Samuel Kreutzmann
- Moritz Dallendörfer


## 1. Systembeschreibung

### 1.1. Abgrenzung

Das System wird überwiegend in der dritten Normalform modelliert und nur zu geringen Anteilen liegt noch die zweite Normalform vor. Dies könnte aber durch das Einfügen von neuen Tabellen weiter normalisiert werden. In der hier beschriebenen Version ist kein datenbankbasiertes Rollenkonzept vorgesehen, d.h. jeder Benutzer, der eine Zugangsberechtigung zum System besitzt, hätte vollen Zugriff auf alle Daten. Unsere Modellierung ist also für den Single-User-Betrieb modelliert worden. Im Fall der Erweiterung auf ein Mehrbenutzersystem, muss mit der der Entwicklung im weiteren Verlauf ein entsprechendes Berechtigungssystem eingefügt werden. Im einfachsten Fall könnte dies durch Ergänzung der Entitäten um eine Benutzerkennung auf Datensatzebene erreicht werden. In einem nächsten Schritt könnten über eine ausgereifte Benutzersteuerung auch Gruppenberechtigungen umgesetzt werden.

### 1.2 Grundlegender Entwurf

Zentraler Entitätstyp ist “Person”. Hier werden alle Personen angelegt, mit welchen dann die anderen Entitätstypen weiterarbeiten können. Zu “Person” gehören alle persönlichen Daten einer natürlichen Person, sowie das Risiko, an einer Corona-Infektion zu erkranken.
Des Weiteren gibt es die Entitätstypen “Sportler” und “Haustierbesitzer”. Diese beiden Entitätstypen sind sich von ihrer Struktur sehr ähnlich. In “Sportler” werden alle Personen, welche eine Sportart ausüben erfasst. Die ausgeübte Sportart ist mit der jeweiligen Person in dem Entitätstyp “Sportart” verknüpft. Hier wird zusätzlich zwischen Teamsport und Einzelsport unterschieden. In dem Entitätstyp “Haustierbesitzer” befinden sich ähnlich zu “Sportler” Verknüpfungen zu Personen, welche ein Haustier besitzen. Personen können mehrere Haustiere derselben Art besitzen. Auch hier wird die spezifische Tierart in dem Entitätstyp “Haustier” mit einer Person, also dem Haustierbesitzer verknüpft.

Ein weiterer Entitätstyp ist “Vorerkrankte”. Der wesentliche Unterschied zu “Haustierbesitzer” und “Sportler” besteht darin, dass sich Vorerkrankungen nicht auf das Infektions-Risiko der jeweiligen Person auswirken. Aber auch hier sind “Personen” mit Vorerkrankungen in dem “Vorerkrankte” Entitätstyp verknüpft. Die jeweiligen Vorerkrankungen sind dann wiederum in dem Entitätstyp “Krankheit” genauer spezifiziert und mit “Vorerkrankte” verknüpft.

Das Infektionsrisiko von “Person” hängt von mehreren Faktoren ab. Das ist zum einen die Anzahl und Art der ausgeübten Sportarten, hier spielt es eine Rolle ob es sich um eine Team-, bzw. Einzelsportart handelt. Zum anderen aber auch die Anzahl von eventuell vorhandenen Haustieren.
 
Mit dem Corona Virus infizierte Personen werden dem Entitätstyp “Infizierte” zugeordnet. Ist dies der Fall, wird der Entitätstyp “Infizierte” mit zwei weiteren Entitätstypen verknüpft. Das ist zum einen “Coronatyp”, in welchem bereits bekannte Corona Virus Mutationen aufgeführt werden und zum anderen “Coronatest”. In diesem Entitätstyp werden das Testdatum, Ort, kosten, sowie das letzte Änderungsdatum von dem jeweiligen Coronatest vermerkt. Zusätzlich zu den Verknüpfungen in “Infizierte” können noch Symptome jeder einzelnen Infektion vermerkt werden.

Ziel dieser Datenerfassung ist herauszufinden wie das ausüben von Sport und das halten von Haustieren zum Infektionsgeschehen beitragen. Gerade im Teamsport kommt man mit vielen Personen unvermeidlich in Kontakt und ist damit konstant dem Risiko einer Infektion ausgesetzt. Auch bei Haustieren kann man annehmen, dass diese zur Übertragung des Virus beitragen, denn diese sind verständlicherweise bei den Hygieneprotokollen nicht berücksichtigt obwohl bekannt ist, dass sie den Corona übertragen können.


## 2. Dokumentation der Entitätstypen

### 2.1 Bewegungsdaten

**Entität Person:** Beschreibt eine Person, die Teil der Datenerfassung ist.

- person_id (Pflicht, Zahl): Eindeutige Identifizierungsnummer einer Person
- vorname (Pflicht, Text): Vorname einer Person
- nachname (Pflicht, Text): Nachname einer Person
- gebDat (Pflicht, Datum): Geburtsdatum einer Person
- email (optional, Text): E-Mail Adresse einer Person
- wohnort (Pflicht, Text): Wohnort einer Person
- geschlecht (Pflicht, Text): Geschlecht einer Person
- inf_risiko (Pflicht, Zahl): Zahl zur Einstufung des Infektionsrisikos einer Person

**Index:** Zum beschleunigen des Suchvorgangs von Vornamen bei den Personen.

Uns ist bewusst, dass dies wenig sinnvoll ist, da man auch über die ID Personen suchen könnte und allgemein eine Indexierung von Vornamen in den seltensten Fällen nützlich ist. Zumal eine Indexierung hier voraussetzt, dass die Tabelle viel mehr Datensätze hat und sich diese nicht stark verändern, da der Index ansonsten immer wieder neu erstellt werden muss. Bei den Normierungsdaten war es uns nicht möglich zu indexieren, da eine Spalte ein Primary Key ist, und die andere Unique. Dadurch haben diese Spalten bereits einen Index. Man könnte natürlich auch eine Absteigenden Index erstellen über DESC, aber wir haben uns dagegen entschieden, und für die Vollständigkeit einen Index erstellt.

**Entität Infizierte:** Beschreibung und Zuordnung einer infizierten Person

- person_id (Pflicht, Zahl): Eindeutige Zuordnung einer Person
- corona_id (Pflicht, Zahl): Eindeutige Zuordnung einer Infektion
- test_id (Pflicht, Zahl): Eindeutige Zuordnung eines Coronatests
- symptome (optional, Text): Symptome einer Infizierten Person

**Entität Coronatest:** Beschreibung der unterschiedlichen Corona Tests

- test_id (Pflicht, Zahl): Eindeutige Zuordnung eines Tests
- testDat (Pflicht, Datum): Datum an dem Test durchgeführt wurde
- testOrt (Pflicht, Text): Ort an dem Test durchgeführt wurde
- kosten (optional, Fließkommazahl): Kosten des Tests
- aenderungsDat (Pflicht, Datum): Aktualisiert sich sobald mal etwas an der Tabelle ändert, wie beispielsweise die Kosten der Tests, denn diese werden mit der Zeit immer billiger.

**Trigger:**

- Insert-Trigger:Wenn ein neuer Coronatest Datensatz hinzugefügt wird, müssen nur die Spalten testOrt und kosten angegeben werden. Der Trigger füllt die Spalte testDat und aenderungsDat automatisch mit dem aktuellen Systemdatum.
- Update-Trigger: Wenn ein Coronatest Datensatz geupdated wird, ändert der Trigger die Spalte aenderungsDat automatisch mit dem aktuellen Systemdatum.

**Entität Vorerkrankte:** Beinhaltet Personen mit Vorerkrankungen
- person_id (Pflicht, Zahl): Zuordnung einer Person
- krankheit_id (Pflicht,Zahl): Zuordnung einer Krankheit

**Entität Haustierbesitzer:** Beinhaltet Personen, die Haustiere besitzen
- person_id (Pflicht, Zahl): Zuordnung einer Person
- haustier_id (Pflicht, Zahl): Zuordnung eines Haustieres

**Trigger:**
- Insert or Update: Pro Haustier welches eine Person besitzt, erhöht sich das Infektionsrisiko in dem Entitätstyp “Person” um jeweils eins.
- Entität Sportler: Beinhaltet Personen, die Sport treiben
    - person_id (Pflicht, Zahl): Zuordnung einer Person
    - sport_id (Pflicht, Zahl): Zuordnung der Sportart

**Trigger:**
- Insert or Update: Pro Teamsportart welche eine Person ausübt, erhöht sich das Infektionsrisiko in dem Entitätstyp “Person” um jeweils zwei. Pro Einzelsportart welche eine Person ausübt, erhöht sich das Infektionsrisiko in dem Entitätstyp “Person” um jeweils eins.

### 2.2 Normierungsdaten

**Entität Krankheit:** Nennung und Zuordnung von existierenden Krankheiten
- krankheit_id (Pflicht, Zahl): Eindeutige Zuordnung einer Krankheit
- krankBeschreibung (Pflicht, Text): Name der Krankheit

**Entität Haustier:** Nennung und Zuordnung von existierenden Haustieren
- haustier_id (Pflicht, Zahl): Eindeutige Zuordnung eines Haustieres
- tierart (Pflicht, Text): Tierarten, die zugeordnet 

**Entität Sportart:** Beschreibung und Zuordnung von ausgeübten Sportarten
- sport_id (Pflicht, Zahl): Eindeutige Zuordnung einer Sportart
- bezeichnung (Pflicht, Text): Name der Sportart
- teamsport (Pflicht, Text): Gibt an, ob es sich um teamsport handelt oder nicht

**Entität Coronatyp:** Beschreibung und Zuordnung einer Virusmutation
- corona_id (Pflicht, Zahl): Eindeutige Zuordnung und Nennung einer Mutation
- virusMut (optional, Text): auftretende Virusmutationen


## 3. Entity Relationship Modelle

### 3.1 ER-Modell (logisch)

![ER-Modell (logisch)](/ER/ER-Diagramm_logisch.png?raw=true "ER-Modell (logisch)")

### 3.1 ER-Modell (physisch)

![ER-Modell (physisch)](/ER/ER-Diagramm_physisch.png?raw=true "ER-Modell (physisch)")


## 4. DDL-Skripte

[Tabellen/Trigger](/DDL/Tabellen_Trigger_erstellen.sql)


## 5. Testdaten


[Testdaten](/DDL/Testdaten.sql)


## 6. Beispielhafte Select Abfragen

[Beispielhafte Abfragen](/DDL/Beispielhafte_Abfragen.sql)
