WITH occ_1 AS (
  SELECT
  Doctor,
  ROW_NUMBER() OVER(ORDER BY Doctor IS NULL, Doctor) AS doc
FROM (
  SELECT 
    CASE WHEN occupation = 'Doctor' THEN name END AS Doctor 
  FROM occupations
  ) AS temp_1
),
occ_2 AS (
    SELECT
    Professor,
    ROW_NUMBER() OVER(ORDER BY Professor IS NULL, Professor) AS prof
FROM (
  SELECT 
    CASE WHEN occupation = 'Professor' THEN name END AS Professor FROM occupations
  ) AS temp_2
),
occ_3 AS (
    SELECT
    Singer,
    ROW_NUMBER() OVER(ORDER BY Singer IS NULL, Singer) AS sing
FROM (
  SELECT 
    CASE WHEN occupation = 'Singer' THEN name END AS Singer FROM occupations
  ) AS temp_3
),
occ_4 AS (
    SELECT
    Actor,
    ROW_NUMBER() OVER(ORDER BY Actor IS NULL, Actor) AS act
FROM (
  SELECT CASE WHEN occupation = 'Actor' THEN name END AS Actor FROM occupations
  ) AS temp_4
)
SELECT 
    occ_1.Doctor,
    occ_2.Professor,
    occ_3.Singer,
    occ_4.Actor
FROM occ_1
JOIN occ_2 ON occ_1.doc=occ_2.prof
JOIN occ_3 ON occ_1.doc=occ_3.sing
JOIN occ_4 ON occ_1.doc=occ_4.act
WHERE NOT(
    occ_1.Doctor IS NULL AND
    occ_2.Professor IS NULL AND
    occ_3.Singer IS NULL AND
    occ_4.Actor IS NULL
)
