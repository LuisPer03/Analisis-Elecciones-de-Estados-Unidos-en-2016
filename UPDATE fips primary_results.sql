UPDATE primary_results
SET fips = 
  CASE
    WHEN county = "Belknap" THEN "33001"
    WHEN county = "Coos" THEN "33007"
	WHEN county = "Sullivan" THEN "33019"
	WHEN county = "Carroll" THEN "33003"
	WHEN county = "Cheshire" THEN "33005"
	WHEN county = "Grafton" THEN "33009"
	WHEN county = "Strafford" THEN "33017"
	WHEN county = "Merrimack" THEN "33013"
	WHEN county = "Rockingham" THEN "33015"
	WHEN county = "Hillsborough" THEN "33011"
    ELSE fips
  END
WHERE county IN ("Belknap", "Coos", "Sullivan", "Carroll", 
"Cheshire", "Grafton", "Strafford", "Merrimack", "Rockingham", "Hillsborough");