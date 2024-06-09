-- 1.Es de interés saber el porcentaje de personas mayores de 18 años para el año 2014 por estado. (Michelle Mosqueda) --
CREATE VIEW "Porcentaje de personas mayores de 18 por estado para el año 2014" AS 
SELECT area_name AS Estado, (100-AGE295214) || "%" AS "Personas mayores de 18"
FROM county_facts
WHERE fips LIKE ("%000")
GROUP BY area_name;
SELECT * FROM "Porcentaje de personas mayores de 18 por estado para el año 2014";

--2.Se quiere saber los 10 estados en los cuales los republicanos recibieron más votos que los demócratas. (Arturo Figuera) --
CREATE VIEW "Vista de los Votos" AS
WITH votes AS (
  SELECT 
    state, 
    party, 
    SUM(votes) as total_votes
  FROM primary_results
  GROUP BY state, party
),
republican_votes AS (
  SELECT 
    state, 
    total_votes as republican_votes
  FROM votes
  WHERE party = 'Republican'
),
democrat_votes AS (
  SELECT 
    state, 
    total_votes as democrat_votes
  FROM votes
  WHERE party = 'Democrat'
)
SELECT 
  r.state AS "Estados", 
  r.republican_votes AS "Votos Republicanos", 
  d.democrat_votes AS "Votos Democratas"
FROM republican_votes r
JOIN democrat_votes d ON r.state = d.state
WHERE r.republican_votes > d.democrat_votes
ORDER BY r.republican_votes DESC
LIMIT 10;

SELECT * FROM "Vista de los Votos"; 
-- 3.Del total de votos cuanto representan los votos de Donald Trump y Hillary Clinton. (Alberto Carvajal) --
CREATE VIEW "Porcenaje de votos recibidos por Donald Trump y Hillary CLinton"  AS
SELECT
    ROUND((SUM(CASE WHEN candidate = 'Donald Trump' THEN votes ELSE 0 END) * 100.0) / SUM(votes), 2) AS Porcentaje_de_votos_de_Trump,
    ROUND((SUM(CASE WHEN candidate = 'Hillary Clinton' THEN votes ELSE 0 END) * 100.0) / SUM(votes), 2) AS Porcentaje_de_votos_de_Clinton
FROM primary_results;

SELECT * FROM "Porcenaje de votos recibidos por Donald Trump y Hillary CLinton";

-- 4.Indicar la cantidad y el porcentaje de hombres y mujeres por estado para las elecciones según la base del 2014. (Luis Pereira) --
CREATE VIEW "Cantidad y porcentaje hombres y mujeres 2014 por estado" AS 
SELECT area_name,
	ROUND(SEX255214*PST045214) AS "Cantidad de mujeres por estado", 
	ROUND((100-SEX255214)*PST045214) AS "Cantidad de hombres por estado",
	SEX255214 || "%" AS "Porcentaje de mujeres por estado",
	(100-SEX255214) || "%" AS "Porcentaje de hombres por estado"
FROM county_facts
WHERE fips LIKE "%000";

SELECT * FROM "Cantidad y porcentaje hombres y mujeres 2014 por estado";

-- 5.Se desean saber las estadísticas descriptivas básicas de los votos dado al partido y los estados (Todos los integrantes).
CREATE VIEW "Estadísticas descriptivas básicas de los votos dado el partido y los estados"
SELECT
    party AS Partido,
    state AS Estado,
    SUM(votes) AS Total_Votos,
    ROUND(AVG(votes),2) AS Promedio_Votos,
    MAX(votes) AS Max_Votos,
    MIN(votes) AS Min_Votos,
	MAX(votes)-MIN(votes) AS Rango,
	ROUND(SUM((votes - (SELECT AVG(votes) FROM primary_results)) * (votes - (SELECT AVG(votes) FROM primary_results)))
    / (COUNT(votes)),2) AS Varianza
FROM primary_results
GROUP BY party, state;
