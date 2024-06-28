-- Crea Tabla Hechos Por Estado
CREATE TABLE state_facts AS 
SELECT * 
FROM county_facts
WHERE fips LIKE("%000");

-- Crea Tabla Resultados Primarios por Estado
CREATE TABLE state_primary_result AS 
SELECT state, state_abbreviation, party, SUM(votes) AS Votos_Totales
FROM  primary_results
GROUP BY state, party

ALTER TABLE state_primary_result
ADD COLUMN fips INTEGER;

UPDATE state_primary_result
SET fips = (SELECT state_facts.fips
  FROM state_facts 
  WHERE state_facts.area_name = state_primary_result.state);