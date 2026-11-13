# FailSafe IT – SQL


## Normalisering (1NF – 3NF)

* **Första normalformen (1NF):** Varje tabell har en unik primärnyckel, varje cell innehåller ett atomärt värde och inga kolumngrupper upprepas.
* **Andra normalformen (2NF):** Databasen uppfyller 1NF. Många-till-många-relationen mellan kunder och konsulter har lösts upp via en kopplingstabell (`Assignments`). Alla kolumner i tabellerna beror på hela primärnyckeln (`Id`).
* **Tredje normalformen (3NF):** Databasen uppfyller 2NF. All information om kunder ligger i `Customers`, all information om konsulter ligger i `Consultants` och allt som gäller uppdragen finns i `Assignments`. Ändringar behöver bara göras på ett ställe. Det finns inga transitiva beroenden då tabellerna kopplas ihop med främmande nycklar.

---

## DevSecOps-reflektion (Sec/Ops)

* **Sec:** Genom att använda parametriserade frågor, så att användarens inmatning används som ren text och inte som en körbar SQL-kod. Man bör även använda sig av ett begränsat konto som inte har behörighet att radera data.
* **Ops:** Genom att skapa ett Non-clustered index på kolumnen `OrganizationNumber` i tabellen `Customers` så att servern inte behöver leta igenom hela tabellen efter ett specifikt nummer. Detta skapas av SQL servern tack vare nyckelordet `UNIQUE`.
