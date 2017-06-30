# RI - Remote it

Består utav bash, python samt Appleskript som tillsammans blir ett digital signage program.

Skripten kontrollerar så att Google Chrome är igång, om inte följs en kedjereaktion. Först, starta Google Chrome, sedan gå till fullskärm och läs sedan in hemsidan som ska visas.

För tillfället stöds bara hemsidor i visning, men är tänkt att bilder m.m ska kunna visas i webbläsaren.

## Installation
Hämta hem RI-scripts.OSX.pkg. Detta paketet innehåller alla skripts som behövs och lägger sig under "/usr/local/bin/*".

Öppna upp en terminal och skriv "install_OSX.sh" (användaren som kör skriptet måste vara admin). 

När skriptet är klart, startas Google Chrome och visar 2st hemsidor som standard. (I nuläget är det hd.se och sydsvenskan.se).

## Appen RI - Remote it
Appen är till för att det ska underlätta att skicka konfiguration (hemsidor), och att kontrollera datorerna som kör programvaran.
Allt sker över ssh (secure shell) och använder sig utav användarnamn och lösenord.

